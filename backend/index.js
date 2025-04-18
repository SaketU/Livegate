require('dotenv').config();
const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const express = require('express');
const cors = require('cors');
const jwt = require('jsonwebtoken');
const { authenticateToken } = require('./utils/utilities');
const User = require('./models/user.model');
const validator = require('validator');
const http = require('http');

// Connect to MongoDB
const uri = process.env.MONGO_URI;
if (!uri) {
  console.error('MONGO_URI not set in environment!');
  process.exit(1);
}
mongoose.connect(uri, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
.then(() => console.log('MongoDB connected'))
.catch(err => {
  console.error('MongoDB connection error:', err);
  process.exit(1);
});

// Models for NBA games
const NBAgameDefault = require('./models/NBAgame.model');
const NBAgameSchema = NBAgameDefault.schema;
const leaguesDb = mongoose.connection.useDb('leagues');
const NBAgameLeagues = leaguesDb.models.NBAgame || leaguesDb.model('NBAgame', NBAgameSchema, 'NBA');

// Express setup
const app = express();
app.use(express.json());
app.use(cors({ origin: '*' }));

// Routes
app.post('/set-email', async (req, res) => {
  const { fullName, email } = req.body;
  if (!fullName || !email) {
    return res.status(400).json({ error: true, message: 'Please enter all fields' });
  }
  if (!validator.isEmail(email)) {
    return res.status(400).json({ error: true, message: 'Invalid email' });
  }
  const isUser = await User.findOne({ email });
  if (isUser) {
    return res.status(400).json({ error: true, message: 'User already exists' });
  }
  return res.status(200).json({ error: false, message: 'Email is valid and available.' });
});

app.post('/set-password', async (req, res) => {
  const { fullName, email, username, password, confirmPassword } = req.body;
  if (!fullName || !email || !username || !password || !confirmPassword) {
    return res.status(400).json({ error: true, message: 'Missing required fields' });
  }
  if (!validator.isEmail(email)) {
    return res.status(400).json({ error: true, message: 'Invalid email' });
  }
  if (password !== confirmPassword) {
    return res.status(400).json({ error: true, message: 'Passwords do not match' });
  }
  const existingUsername = await User.findOne({ username });
  if (existingUsername) {
    return res.status(400).json({ error: true, message: 'Username is already taken' });
  }
  const existingEmail = await User.findOne({ email });
  if (existingEmail) {
    return res.status(400).json({ error: true, message: 'Email is already in use' });
  }

  try {
    const hashedPassword = await bcrypt.hash(password, 10);
    const user = new User({ fullName, email, username, password: hashedPassword });
    await user.save();
    const accessToken = jwt.sign(
      { userId: user._id },
      process.env.ACCESS_TOKEN_SECRET,
      { expiresIn: '72h' }
    );
    return res.status(200).json({
      error: false,
      message: 'Account created successfully',
      user: { fullName: user.fullName, email: user.email, username: user.username },
      accessToken,
    });
  } catch (error) {
    console.error('Error creating account:', error);
    return res.status(500).json({ error: true, message: 'Server error' });
  }
});

app.post('/login', async (req, res) => {
  const { email, password } = req.body;
  if (!email || !password) {
    return res.status(400).json({ message: 'Email and Password are required' });
  }
  const query = validator.isEmail(email) ? { email } : { username: email };
  const user = await User.findOne(query);
  if (!user) {
    return res.status(400).json({ message: 'User not found' });
  }
  const isPasswordValid = await bcrypt.compare(password, user.password);
  if (!isPasswordValid) {
    return res.status(400).json({ message: 'Invalid Password' });
  }
  const accessToken = jwt.sign(
    { userId: user._id },
    process.env.ACCESS_TOKEN_SECRET,
    { expiresIn: '72h' }
  );
  return res.json({
    error: false,
    message: 'Login Successful',
    user: { fullName: user.fullName, email: user.email, username: user.username },
    accessToken,
  });
});

app.get('/get-user', authenticateToken, async (req, res) => {
  const { userId } = req.user;
  const isUser = await User.findOne({ _id: userId });
  if (!isUser) return res.sendStatus(401);
  return res.json({ user: isUser, message: '' });
});

app.post('/set-leagues', authenticateToken, async (req, res) => {
  const { leagues } = req.body;
  if (!Array.isArray(leagues)) {
    return res.status(400).json({ error: true, message: 'Leagues must be an array.' });
  }
  try {
    const updatedUser = await User.findByIdAndUpdate(
      req.user.userId,
      { $push: { leaguePreferences: { $each: leagues } } },
      { new: true }
    );
    if (!updatedUser) return res.status(404).json({ error: true, message: 'User not found.' });
    return res.status(200).json({
      error: false,
      message: 'Leagues added successfully.',
      leaguePreferences: updatedUser.leaguePreferences,
    });
  } catch (error) {
    console.error('Error updating league preferences:', error);
    return res.status(500).json({ error: true, message: 'Server error' });
  }
});

app.post('/nba-message', async (req, res) => {
  try {
    const { gameId, message, sender } = req.body;
    const chatMessage = { sender, message };
    const updatedGame = await NBAgameLeagues.findByIdAndUpdate(
      gameId,
      { $push: { chat: chatMessage } },
      { new: true }
    );
    if (!updatedGame) return res.status(404).json({ success: false, message: 'Game not found' });
    io.to(gameId).emit('new message', chatMessage);
    return res.json({ success: true, game: updatedGame });
  } catch (error) {
    console.error('Error updating chat array:', error);
    return res.status(500).json({ success: false, error: error.message });
  }
});

app.get('/api/nba-games', async (req, res) => {
  try {
    const games = await NBAgameLeagues.find({}).sort({ createdAt: -1 }).lean();
    const formattedGames = games.map(game => ({
      id: game._id,
      home_team: game.home_team,
      away_team: game.away_team,
      home_team_logo: game.home_team_logo,
      away_team_logo: game.away_team_logo,
      venue: game.venue || 'TBD',
      status: game.status || 'Scheduled',
    }));
    console.log('gameId:', formattedGames[0]?.id);
    return res.json(formattedGames);
  } catch (error) {
    console.error('Error retrieving NBA games:', error);
    return res.status(500).json({ error: true, message: 'Server error' });
  }
});

app.get('/nba-chat/:gameId', async (req, res) => {
  try {
    const { gameId } = req.params;
    const game = await NBAgameLeagues.findById(gameId);
    if (!game) return res.status(404).json({ success: false, message: 'Game not found' });
    return res.json({ success: true, chat: game.chat });
  } catch (error) {
    console.error('Error retrieving chat:', error);
    return res.status(500).json({ success: false, error: error.message });
  }
});

app.get('/api/user/profile', authenticateToken, async (req, res) => {
  try {
    const { userId } = req.user;
    const user = await User.findById(userId).select('-password');
    if (!user) return res.status(404).json({ error: true, message: 'User not found' });
    return res.status(200).json({
      fullName: user.fullName,
      username: user.username,
      email: user.email,
      leaguePreferences: user.leaguePreferences,
    });
  } catch (error) {
    console.error('Error fetching user profile:', error);
    return res.status(500).json({ error: true, message: 'Server error' });
  }
});

app.post('/api/user/update-profile', authenticateToken, async (req, res) => {
  try {
    const { userId } = req.user;
    const { fullName, username, bio, leaguePreferences } = req.body;
    if (username) {
      const existingUser = await User.findOne({ username, _id: { $ne: userId } });
      if (existingUser) return res.status(400).json({ error: true, message: 'Username is already taken' });
    }
    const updateData = {};
    if (fullName) updateData.fullName = fullName;
    if (username) updateData.username = username;
    if (bio) updateData.bio = bio;
    if (leaguePreferences) updateData.leaguePreferences = leaguePreferences;
    const updatedUser = await User.findByIdAndUpdate(userId, { $set: updateData }, { new: true }).select('-password');
    if (!updatedUser) return res.status(404).json({ error: true, message: 'User not found' });
    return res.status(200).json({
      error: false,
      message: 'Profile updated successfully',
      user: {
        fullName: updatedUser.fullName,
        username: updatedUser.username,
        bio: updatedUser.bio,
        leaguePreferences: updatedUser.leaguePreferences,
      }
    });
  } catch (error) {
    console.error('Error updating profile:', error);
    return res.status(500).json({ error: true, message: 'Server error' });
  }
});

const server = http.createServer(app);
const io = require('socket.io')(server, { cors: { origin: '*' } });

// Bind to the port provided by Cloud Run or default to 8080
const PORT = Number(process.env.PORT) || 8080;
server.listen(PORT, () => {
  console.log(`🚀 Server listening on port ${PORT}`);
});

io.on('connection', socket => {
  const origin = socket.handshake.headers.origin;
  console.log(`New client connected: ${socket.id}, Origin: ${origin}`);

  socket.on('join game', gameId => {
    socket.join(gameId);
    console.log(`Socket ${socket.id} joined game ${gameId}`);
    io.in(gameId).allSockets()
      .then(sockets => console.log(`Sockets in room ${gameId}:`, Array.from(sockets)))
      .catch(err => console.error('Error retrieving sockets in room:', err));
  });

  socket.on('leave game', gameId => {
    socket.leave(gameId);
    console.log(`Socket ${socket.id} left game ${gameId}`);
  });

  socket.on('send message', async data => {
    try {
      const { gameId, message, sender } = data;
      const chatMessage = { sender, message };
      const updatedGame = await NBAgameLeagues.findByIdAndUpdate(gameId, { $push: { chat: chatMessage } }, { new: true });
      if (!updatedGame) {
        socket.emit('error', { message: 'Game not found' });
        return;
      }
      console.log(`Broadcasting message from ${sender} to room ${gameId}:`, chatMessage);
      socket.broadcast.to(gameId).emit('new message', chatMessage);
    } catch (err) {
      console.error('Error processing message:', err);
      socket.emit('error', { message: 'Server error' });
    }
  });

  socket.on('disconnect', () => console.log('Client disconnected: ' + socket.id));
});

module.exports = app;

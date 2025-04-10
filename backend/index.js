require('dotenv').config();
const config = require('./config.json');
const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const express = require('express');
const cors = require('cors');
const jwt = require('jsonwebtoken');
const { authenticateToken } = require('./utils/utilities');
const User = require('./models/user.model');
const validator = require('validator');

const http = require('http');
const socketIo = require('socket.io');
// const sendVerificationEmail = require('./utils/emailVerification');

mongoose.connect(config.connectionString);

const NBAgameDefault = require('./models/NBAgame.model');
const NBAgameSchema = NBAgameDefault.schema;

const leaguesDb = mongoose.connection.useDb('leagues');
const NBAgameLeagues =
  leaguesDb.models.NBAgame || leaguesDb.model('NBAgame', NBAgameSchema, 'NBA');

const app = express();
app.use(express.json());
app.use(cors({ origin: "*" }));

app.post('/set-email', async (req, res) => {
  const { fullName, email } = req.body;

  if (!fullName || !email) {
    return res.status(400).json({ error: true, message: "Please enter all fields" });
  }

  if (!validator.isEmail(email)) {
    return res.status(400).json({ error: true, message: "Invalid email" });
  }

  const isUser = await User.findOne({ email });
  if (isUser) {
    return res.status(400).json({ error: true, message: "User already exists" });
  }

  return res.status(200).json({
    error: false,
    message: "Email is valid and available."
  });
});

app.post('/set-password', async (req, res) => {
  const { fullName, email, username, password, confirmPassword } = req.body;

  if (!fullName || !email || !username || !password || !confirmPassword) {
    return res.status(400).json({ error: true, message: "Missing required fields" });
  }

  if (!validator.isEmail(email)) {
    return res.status(400).json({ error: true, message: "Invalid email" });
  }

  if (password !== confirmPassword) {
    return res.status(400).json({ error: true, message: "Passwords do not match" });
  }

  const existingUsername = await User.findOne({ username });
  if (existingUsername) {
    return res.status(400).json({ error: true, message: "Username is already taken" });
  }

  const existingEmail = await User.findOne({ email });
  if (existingEmail) {
    return res.status(400).json({ error: true, message: "Email is already in use" });
  }

  try {
    const hashedPassword = await bcrypt.hash(password, 10);

    const user = new User({
      fullName,
      email,
      username,
      password: hashedPassword,
    });

    await user.save();

    const accessToken = jwt.sign(
      { userId: user._id },
      process.env.ACCESS_TOKEN_SECRET,
      { expiresIn: "72h" }
    );

    return res.status(200).json({
      error: false,
      message: "Account created successfully",
      user: { fullName: user.fullName, email: user.email, username: user.username },
      accessToken,
    });
  } catch (error) {
    console.error("Error creating account:", error);
    return res.status(500).json({ error: true, message: "Server error" });
  }
});

app.post('/login', async (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({ message: "Email and Password are requiured" });
  }

  const query = validator.isEmail(email) ? { email: email } : { username: email };

  const user = await User.findOne(query);
  if (!user) {
    return res.status(400).json({ message: "User not found" });
  }

  const isPasswordValid = await bcrypt.compare(password, user.password);
  if (!isPasswordValid) {
    return res.status(400).json({ message: "Invalid Password" });
  }

  const accessToken = jwt.sign(
    { userId: user._id },
    process.env.ACCESS_TOKEN_SECRET,
    { expiresIn: "72h" }
  );

  return res.json({
    error: false,
    message: "Login Successful",
    user: {
      fullName: user.fullName,
      email: user.email,
      username: user.username
    },
    accessToken,
  });
});

app.get('/get-user', authenticateToken, async (req, res) => {
  const { userId } = req.user;

  const isUser = await User.findOne({ _id: userId });

  if (!isUser) {
    return res.sendStatus(401);
  }

  return res.json({
    user: isUser,
    message: "",
  });
});

app.post('/set-leagues', authenticateToken, async (req, res) => {
  const { leagues } = req.body;
  if (!Array.isArray(leagues)) {
    return res.status(400).json({ error: true, message: "Leagues must be an array." });
  }
  try {
    const updatedUser = await User.findByIdAndUpdate(
      req.user.userId,
      { $push: { leaguePreferences: { $each: leagues } } },
      { new: true }
    );
    if (!updatedUser) {
      return res.status(404).json({ error: true, message: "User not found." });
    }
    return res.status(200).json({
      error: false,
      message: "Leagues added successfully.",
      leaguePreferences: updatedUser.leaguePreferences
    });
  } catch (error) {
    console.error("Error updating league preferences:", error);
    return res.status(500).json({ error: true, message: "Server error" });
  }
});

app.post('/nba-message', async (req, res) => {
  try {
    const { gameId, message, sender } = req.body;
    const chatMessage = { sender: sender, message: message };
    const updatedGame = await NBAgameLeagues.findByIdAndUpdate(
      gameId,
      { $push: { chat: chatMessage } },
      { new: true }
    );
    if (!updatedGame) {
      return res.status(404).json({ success: false, message: 'Game not found' });
    }
    // Broadcast the "new message" event to all sockets in the room except the sender.
    socket.broadcast.to(gameId).emit('new message', chatMessage);
    res.json({ success: true, game: updatedGame });
  } catch (error) {
    console.error('Error updating chat array:', error);
    res.status(500).json({ success: false, error: error.message });
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
      venue: game.venue || "TBD",
      status: game.status || "Scheduled"
    }));
    console.log("gameId:", formattedGames[0] && formattedGames[0].id);
    res.json(formattedGames);
  } catch (error) {
    console.error("Error retrieving NBA games:", error);
    res.status(500).json({ error: true, message: "Server error" });
  }
});

app.get('/nba-chat/:gameId', async (req, res) => {
  try {
    const { gameId } = req.params;
    const game = await NBAgameLeagues.findById(gameId);
    if (!game) {
      return res.status(404).json({ success: false, message: 'Game not found' });
    }
    res.json({ success: true, chat: game.chat });
  } catch (error) {
    console.error('Error retrieving chat:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

const server = http.createServer(app);
const io = socketIo(server, {
  cors: { origin: "*" }
});

io.on('connection', (socket) => {
  console.log('New client connected: ' + socket.id);

  socket.on('join game', (gameId) => {
    socket.join(gameId);
    console.log(`Socket ${socket.id} joined game ${gameId}`);

    // Print all sockets currently in the room
    io.in(gameId).allSockets()
      .then((sockets) => {
        console.log(`Sockets in room ${gameId}:`, Array.from(sockets));
      })
      .catch((err) => {
        console.error('Error retrieving sockets in room:', err);
      });
  });

  // New event: leave game
  socket.on('leave game', (gameId) => {
    socket.leave(gameId);
    console.log(`Socket ${socket.id} left game ${gameId}`);
  });

  socket.on('send message', async (data) => {
    try {
      const { gameId, message, sender } = data;
      const chatMessage = { sender: sender, message: message };
      const updatedGame = await NBAgameLeagues.findByIdAndUpdate(
        gameId,
        { $push: { chat: chatMessage } },
        { new: true }
      );
      if (!updatedGame) {
        socket.emit('error', { message: 'Game not found' });
        return;
      }
      // Broadcast the new message to all sockets in the room except the sender.
      console.log(`Broadcasting message from ${sender} to room ${gameId}:`, chatMessage);
      socket.broadcast.to(gameId).emit('new message', chatMessage);
    } catch (err) {
      console.error('Error processing message: ', err);
      socket.emit('error', { message: 'Server error' });
    }
  });

  socket.on('disconnect', () => {
    console.log('Client disconnected: ' + socket.id);
  });
});

server.listen(8000, () => {
  console.log('Server listening on port 8000');
});

module.exports = app;

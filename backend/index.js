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

// const http = require('http');
// const socketIo = require('socket.io');
//const sendVerificationEmail = require('./utils/emailVerification');

mongoose.connect(config.connectionString);

const NBAgameDefault = require('./models/NBAgame.model');
const NBAgameSchema = NBAgameDefault.schema;



const leaguesDb = mongoose.connection.useDb('leagues');

const NBAgameLeagues = leaguesDb.models.NBAgame || leaguesDb.model('NBAgame', NBAgameSchema, 'NBA');

const app = express();
app.use(express.json());
app.use(cors({ origin: "*"}));

app.post('/set-email', async (req, res) => {
    const { fullName, email } = req.body;

    //validate required fields
    if (!fullName || !email) {
        return res.status(400).json({ error: true, message: "Please enter all fields" });
    }

    //validate email format
    if (!validator.isEmail(email)) {
        return res.status(400).json({ error: true, message: "Invalid email" });
    }

    //check if the email is already in use
    const isUser = await User.findOne({ email });
    if (isUser) {
        return res.status(400).json({ error: true, message: "User already exists" });
    }

    //since we're only validating, return success without creating a new user
    return res.status(200).json({
        error: false,
        message: "Email is valid and available."
    });
});



app.post('/set-password', async (req, res) => {
    const { fullName, email, username, password, confirmPassword } = req.body;

    //check for required fields
    if (!fullName || !email || !username || !password || !confirmPassword) {
      return res.status(400).json({ error: true, message: "Missing required fields" });
    }

    //validate email format
    if (!validator.isEmail(email)) {
      return res.status(400).json({ error: true, message: "Invalid email" });
    }

    //ensure both password fields match
    if (password !== confirmPassword) {
      return res.status(400).json({ error: true, message: "Passwords do not match" });
    }

    //check if the username is already taken
    const existingUsername = await User.findOne({ username });
    if (existingUsername) {
      return res.status(400).json({ error: true, message: "Username is already taken" });
    }

    //check if the email is already in use (if needed)
    const existingEmail = await User.findOne({ email });
    if (existingEmail) {
      return res.status(400).json({ error: true, message: "Email is already in use" });
    }

    try {
      //hash the password
      const hashedPassword = await bcrypt.hash(password, 10);

      //create a new user
      const user = new User({
        fullName,
        email,
        username,
        password: hashedPassword,
      });

      await user.save();

      //create the JWT token for the new user
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





// //verification endpoint to update isVerified to true
// app.get('/verify-email', async (req, res) => {
//     const token = req.query.token;
//     if (!token) {
//       return res.status(400).json({ message: "Invalid token" });
//     }

//     try {
//       //verify token
//       const payload = jwt.verify(token, process.env.EMAIL_SECRET);
//       const userId = payload.userId;

//       //find the user and update verification status
//       const user = await User.findById(userId);
//         if (!user) {
//             console.error("User not found for userId:", userId);
//             return res.status(400).json({ message: "User not found" });
//         }
//         // Then update
//         const updatedUser = await User.findByIdAndUpdate(userId, { isVerified: true }, { new: true });

//       //redirect or send a success message
//       return res.status(200).json({ message: "Email verified successfully!", user });
//     } catch (error) {
//       return res.status(400).json({ message: "Invalid or expired token" });
//     }
//   });


//handles login
app.post('/login', async (req, res) => {
    const { email, password } = req.body;

    if (!email || !password) {
        return res.status(400).json({ message: "Email and Password are requiured" });
    }

    const query = validator.isEmail(email) ? { email: email } : { username: email };

    //looks for user email
    const user = await User.findOne(query);
    if (!user) {
        return res.status(400).json({ message: "User not found" });
    }

    // if (!user.isVerified) {
    //     return res.status(403).json({ message: "Please verify your email before logging in." });
    // }

    //validates password
    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
        return res.status(400).json({ message: "Invalid Password" });
    }

    //gets access token from login
    const accessToken = jwt.sign(
        { userId: user._id },
        process.env.ACCESS_TOKEN_SECRET,
        {
            expiresIn: "72h"
        }
    );

    //successful login
    return res.json({
        error: false,
        message: "Login Successful",
        user: { fullName: user.fullName, email: user.email },
        accessToken,
    });
});

//gets user with valid authetication token
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
    const gameId = req.params.id;
    const { message } = req.body;

    //update the document by pushing the new message to the chat array.
    const updatedGame = await NBAgame.findByIdAndUpdate(
      gameId,
      { $push: { chat: message } },
      { new: true } //return the updated document.
    );

    if (!updatedGame) {
      return res.status(404).json({ success: false, message: 'Game not found' });
    }

    res.json({ success: true, game: updatedGame });
  } catch (error) {
    console.error('Error updating chat array:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

// get NBA games from database
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
    res.json(formattedGames);
  } catch (error) {
    console.error("Error retrieving NBA games:", error);
    res.status(500).json({ error: true, message: "Server error" });
  }
});





app.listen(8000);
module.exports = app;
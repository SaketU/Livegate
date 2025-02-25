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
const sendVerificationEmail = require('./utils/emailVerification');

mongoose.connect(config.connectionString);

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
  




//verification endpoint to update isVerified to true
app.get('/verify-email', async (req, res) => {
    const token = req.query.token;
    if (!token) {
      return res.status(400).json({ message: "Invalid token" });
    }

    try {
      //verify token
      const payload = jwt.verify(token, process.env.EMAIL_SECRET);
      const userId = payload.userId;

      //find the user and update verification status
      const user = await User.findById(userId);
        if (!user) {
            console.error("User not found for userId:", userId);
            return res.status(400).json({ message: "User not found" });
        }
        // Then update
        const updatedUser = await User.findByIdAndUpdate(userId, { isVerified: true }, { new: true });

      //redirect or send a success message
      return res.status(200).json({ message: "Email verified successfully!", user });
    } catch (error) {
      return res.status(400).json({ message: "Invalid or expired token" });
    }
  });


//handles login
app.post('/login', async (req, res) => {
    const { email, password } = req.body;

    if (!email || !password) {
        return res.status(400).json({ message: "Email and Password are requiured" });
    }

    //looks for user email
    const user = await User.findOne({ email });
    if (!user) {
        return res.status(400).json({ message: "User not found" });
    }

    if (!user.isVerified) {
        return res.status(403).json({ message: "Please verify your email before logging in." });
    }

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


app.listen(8000);
module.exports = app;
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

//creates account
app.post('/create-account', async (req, res) => {
    const { fullName, email, password } = req.body;

    //handles incorrect sign up info
    if (!fullName || !email || !password) {
        return res.status(400).json({ error: true, message: "Please enter all fields" });
    }

    //validates email
    if (!validator.isEmail(email)) {
        return res.status(400).json({ error: true, message: "Invalid email" });
    }

    //makes sure user doesn't already exist
    const isUser = await User.findOne({ email });
    if (isUser) {
        return res.status(400).json({ error: true, message: "User already exists" });
    }

    //securely hashes password
    const hashedPassword = await bcrypt.hash(password, 10);

    //user info to sign up
    const user = new User({
        fullName,
        email,
        password: hashedPassword,
        isVerified: false
    });

    await user.save();

    //send verification email
    try {
        await sendVerificationEmail(user);
    } catch (error) {
        console.error("Error sending verification email:", error);
    }

    //gets access token from sign up
    const accessToken = jwt.sign(
        { userId: user._id },
        process.env.ACCESS_TOKEN_SECRET,
        {
            expiresIn: "72h"
        }
    );

    //successful sign up
    return res.status(201).json({
        error: false,
        user: { fullName: user.fullName, email: user.email, isVerified: user.isVerified },
        accessToken,
        message: "Registration Successful. Please verify your email.",
    });
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
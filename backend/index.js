require('dotenv').config();
const config = require('./config.json');
const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const express = require('express');
const cors = require('cors');
const jwt = require('jsonwebtoken');
const { authenticateToken } = require('./utilities');
const User = require('./models/user.model');

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
    });

    await user.save();

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
        user: { fullName: user.fullName, email: user.email },
        accessToken,
        message: "Registration Successful",
    });
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
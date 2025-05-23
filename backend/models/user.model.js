const mongoose = require('mongoose');
const Schema = mongoose.Schema;

// User schema
const userSchema = new Schema({
    fullName: { type: String, required: true },
    username: { type: String, unique: true, sparse: true },
    email: { type: String, unique: true, required: true },
    password: { type: String, default: null },
    leaguePreferences: { type: Array, default: [] },
    createdOn: { type: Date, default: Date.now }
});

module.exports = mongoose.model('User', userSchema);
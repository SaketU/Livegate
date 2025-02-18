const mongoose = require('mongoose');
const Schema = mongoose.Schema;

//MLB game schema
const MLBgameSchema = new Schema({
    homeTeam: { type: String, required: true },
    awayTeam: { type: String, required: true },

    // if needed
    homeScore: { type: Number, required: true },
    awayScore: { type: Number, required: true },
    date: { type: Date, required: true },
    location: { type: String, required: true },
    period: { type: Number, required: true },
});

module.exports = mongoose.model('MLBgame', MLBgameSchema);
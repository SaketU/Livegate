const mongoose = require('mongoose');
const Schema = mongoose.Schema;

//NBA game schema
const NBAgameSchema = new Schema({
    homeTeam: { type: String, required: true },
    awayTeam: { type: String, required: true },

    // if needed
    homeScore: { type: Number, required: true },
    awayScore: { type: Number, required: true },
    date: { type: Date, required: true },
    location: { type: String, required: true },
    quarter: { type: Number, required: true },
    timeLeft: { type: String, required: true },
});

module.exports = mongoose.model('NBAgame', NBAgameSchema);
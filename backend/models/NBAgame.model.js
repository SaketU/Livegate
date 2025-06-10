const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const NBAgameSchema = new Schema({
  home_team: { type: String, required: true },
  away_team: { type: String, required: true },
  home_team_logo: { type: String, required: true },
  away_team_logo: { type: String, required: true },
  chat: [{
    sender: { type: String, required: true },
    message: { type: String, required: true },
    messageType: { type: String, default: 'receiver' },
    replyTo: {
      name: String,
      message: String
    },
    reactions: { type: Map, of: Number, default: new Map() },
    createdAt: { type: Date, default: Date.now }
  }],
  venue: { type: String, required: true },
  status: { type: String, required: true }
});

module.exports = mongoose.model('NBAgame', NBAgameSchema, 'NBA');

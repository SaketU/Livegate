const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const NBAgameSchema = new Schema({
  home_team: { type: String, required: true },
  away_team: { type: String, required: true },
  home_team_logo: { type: String, required: true },
  away_team_logo: { type: String, required: true },
  chat: [{ type: String }], // an array of message strings
  venue: { type: String, required: true },
  status: { type: String, required: true }
});

module.exports = mongoose.model('NBAgame', NBAgameSchema, 'NBA');

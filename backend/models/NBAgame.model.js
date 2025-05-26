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
    createdAt: { type: Date, default: Date.now }
  }],
  venue: { type: String, required: true },
  status: { type: String, required: true },
  scheduled_time: { type: Date, required: true },
  is_live: { type: Boolean, default: false },
  league: { type: String, default: 'NBA' },
  sport: { type: String, default: 'assets/basketball-icon.svg' },
  people: { type: String, default: '1.2k' },
  remain: { type: String, default: 'Chat' }
});

// Method to calculate current game status
NBAgameSchema.methods.getCurrentStatus = function() {
  const now = new Date();
  const gameEndTime = new Date(this.scheduled_time.getTime() + (3 * 60 * 60 * 1000)); // 3 hours after start

  if (now < this.scheduled_time) {
    return 'Scheduled';
  } else if (now >= this.scheduled_time && now <= gameEndTime) {
    return 'Live now';
  } else {
    return 'Finished';
  }
};

module.exports = mongoose.model('NBAgame', NBAgameSchema, 'NBA');

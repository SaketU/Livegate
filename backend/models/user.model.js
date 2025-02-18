const mongoose = require('mongoose');
const Schema = mongoose.Schema;

//User schema
const userSchema = new Schema({
    fullName: { type: String, required: true },
    email: { type: String, unique: true },
    password: { type: String, required: true },
    isVerified: { type: Boolean, default: false },
    createdOn: { type: Date, default: Date.now },
    verificationExpires: {
        type: Date,
        default: () => new Date(Date.now() + 60 * 1000)
    }
});

userSchema.index(
    { verificationExpires: 1 },
    { expireAfterSeconds: 0, partialFilterExpression: { isVerified: false } }
  );

module.exports = mongoose.model('User', userSchema);
const nodemailer = require('nodemailer');
const jwt = require('jsonwebtoken');

const transporter = nodemailer.createTransport({
  service: 'Gmail',
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS
  }
});

async function sendVerificationEmail(user) {
  const token = jwt.sign(
    { userId: user._id },
    process.env.EMAIL_SECRET,
    { expiresIn: '1m' }
  );

  const verificationUrl = `https://yourapp.com/verify-email?token=${token}`;

  const mailOptions = {
    from: process.env.EMAIL_USER,
    to: user.email,
    subject: 'Verify Your Email',
    html: `
      <p>Please click the following link to verify your email address:</p>
      <a href="${verificationUrl}">Verify Email</a>
    `
  };

  try {
    // send the email
    const info = await transporter.sendMail(mailOptions);
    console.log('Verification email sent: %s', info.messageId);
    return info;
  } catch (error) {
    console.error('Error sending verification email:', error);
    throw error;
  }
}

module.exports = sendVerificationEmail;

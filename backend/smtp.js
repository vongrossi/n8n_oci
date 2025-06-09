const nodemailer = require('nodemailer');
const twilio = require('twilio');

function createTransporter() {
  if (!process.env.SMTP_HOST) {
    throw new Error('SMTP configuration missing');
  }
  return nodemailer.createTransport({
    host: process.env.SMTP_HOST,
    port: parseInt(process.env.SMTP_PORT || '587', 10),
    secure: process.env.SMTP_SECURE === 'true',
    auth: {
      user: process.env.SMTP_USER,
      pass: process.env.SMTP_PASS,
    },
  });
}

async function sendEmail({ to, subject, text }) {
  const transporter = createTransporter();
  await transporter.sendMail({
    from: process.env.SMTP_FROM,
    to,
    subject,
    text,
  });
}

function createTwilioClient() {
  if (!process.env.TWILIO_SID) {
    throw new Error('Twilio configuration missing');
  }
  return twilio(process.env.TWILIO_SID, process.env.TWILIO_TOKEN);
}

async function sendSMS({ to, message }) {
  const client = createTwilioClient();
  await client.messages.create({
    from: process.env.TWILIO_NUMBER,
    to,
    body: message,
  });
}

module.exports = { sendEmail, sendSMS };

const express = require('express');
const cors = require('cors');
const { sendEmail, sendSMS } = require('./smtp');

const app = express();
app.use(cors());
app.use(express.json());

app.post('/api/notify', async (req, res) => {
  const { email, phone, subject, message, cloudflareAccessKey } = req.body;
  if (process.env.CLOUDFLARE_ACCESS_KEY &&
      process.env.CLOUDFLARE_ACCESS_KEY !== cloudflareAccessKey) {
    return res.status(403).json({ error: 'Invalid Cloudflare access key' });
  }

  try {
    if (email) await sendEmail({ to: email, subject, text: message });
    if (phone) await sendSMS({ to: phone, message });
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Notification server listening on port ${port}`);
});

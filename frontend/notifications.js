export async function sendNotification({ email, phone, subject, message }) {
  const cloudflareAccessKey = localStorage.getItem('CloudflareAccessKey');
  const res = await fetch('/api/notify', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ email, phone, subject, message, cloudflareAccessKey })
  });

  if (!res.ok) {
    const error = await res.json();
    throw new Error(error.error || 'Notification failed');
  }
  return res.json();
}

const functions = require("firebase-functions");
const sgMail = require("@sendgrid/mail");

const SENDGRID_API_KEY = "YOUR_SENDGRID_API_KEY"; // Replace with your API key
sgMail.setApiKey(SENDGRID_API_KEY);

exports.sendConfirmationEmail = functions.https.onCall(async (data, context) => {
  const email = data.email;
  const link = data.link;

  const msg = {
    to: email,
    from: "no-reply@yourapp.com", // Replace with a verified SendGrid sender
    subject: "Confirm Your Email for Newsletter",
    html: `
      <p>Thank you for signing up!</p>
      <p>Click the link below to confirm your email:</p>
      <a href="${link}">${link}</a>
    `,
  };

  try {
    await sgMail.send(msg);
    return { success: true };
  } catch (error) {
    console.error("Error sending email:", error);
    return { success: false, error: error.message };
  }
});

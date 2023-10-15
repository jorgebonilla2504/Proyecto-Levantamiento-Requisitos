const nodemailer = require('nodemailer');

const createTransporter = () => {
  return nodemailer.createTransport({
    host: 'smtp.gmail.com',
    port: 2525,
    service: 'gmail',
    auth: {
      user: 'LevantamientosITCR@gmail.com',
      pass: 'wbmzqfivkyvzcxak',
    },
  });
};

const sendEmail = (Student, email, subject, text) => {
  // This is for read the img
  const imageAttachments = [
    {
      filename: 'Head.png',
      path: `src\\IMG\\Header.png`,
      cid: 'Head',
    },
    {
      filename: 'Footer.png',
      path: `src\\IMG\\Footer.png`,
      cid: 'Footer',
    },
  ];

  const htmlContent = `
    <img src="cid:Head" alt="Head" />
     <h1> Estimado ${Student}, se le informa: </h1>
     <h1> </h1>
       ${text} 
    <img src="cid:Footer" alt="Footer" />
  `;

  // After that if use to send the email

  const transporter = createTransporter();
  const mailOptions = {
    from: 'LevantamientosITCR@gmail.com',
    to: email,
    subject: subject,
    html: htmlContent,
    attachments: imageAttachments,
  };
  transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
      console.log(error);
      console.error('Error al enviar correo');
    } else {
      console.log('Correo enviado correctamente');
    }
  });
};

exports.sendEmail = (Student, email, subject, text) =>
  sendEmail(Student, email, subject, text);

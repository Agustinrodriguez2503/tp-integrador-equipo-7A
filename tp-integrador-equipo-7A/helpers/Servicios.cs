using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.Net.Mail;
using System.Threading.Tasks;

namespace helpers
{
    public class Servicios
    {
        public static void enviarMailRecupero(string correo, string nombre)
        {
            //Correo utilizado
            string remitente = "dres.madero@gmail.com";
            //Contraseña de aplicacion de Gmail
            string clave = "wxuf iztg zrlg mccn";

            MailMessage mensaje = new MailMessage();
            mensaje.From = new MailAddress(remitente);
            mensaje.To.Add(correo);
            mensaje.Subject = "Recupero de contraseña.";
            mensaje.IsBodyHtml = true;
            mensaje.Body = $@"
            <h3>Hola {nombre},</h3>
            <p>Recibimos una solicitud de recuperación de contraseña para su cuenta.</p>
            <p>Para restablecer tu contraseña, hacé clic en el siguiente botón:</p>
            <p>
                <a href='https://localhost:44396/Due%c3%b1o_RecuperoPassword' 
                   style='display: inline-block; padding: 10px 20px; font-size: 16px; 
                          color: white; background-color: #007BFF; text-decoration: none; 
                          border-radius: 5px;'>
                   Recuperar contraseña
                </a>
            </p>
            <br/>
            <p>Si no realizaste esta solicitud, podés desestimar este correo.<br/>
            Dres. Madero</p>";

            SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
            smtp.Credentials = new NetworkCredential(remitente, clave);
            smtp.EnableSsl = true;

            try
            {
                smtp.Send(mensaje);
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}

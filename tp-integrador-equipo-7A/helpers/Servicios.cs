using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.Net.Mail;
using System.Threading.Tasks;
using dominio;
using System.IO;
using System.Xml.Linq;
using iTextSharp.text;
using iTextSharp.text.pdf;

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

        public static void enviarMailTurnoEliminado(string correo, DateTime fechaturno)
        {
            //Correo utilizado
            string remitente = "dres.madero@gmail.com";
            //Contraseña de aplicacion de Gmail
            string clave = "wxuf iztg zrlg mccn";

            //hardcodeo mi mail para testear
            correo = "nahuepmartinez@gmail.com";

            MailMessage mensaje = new MailMessage();
            mensaje.From = new MailAddress(remitente);
            mensaje.To.Add(correo);
            mensaje.Subject = "Cancelación de turno.";
            mensaje.IsBodyHtml = true;
            mensaje.Body = $@"
            <h3>Estimado/a cliente,</h3>
            <p>Le informamos que su turno programado para el día <strong>{fechaturno.ToString("dd/MM/yyyy")} a las {fechaturno.ToString("HH:mm")} hs.</strong> ha sido cancelado.</p>
            <p>Disculpe las molestias ocasionadas.
            <br/><br/>
            Atentamente,<br/>
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

        public static byte[] GenerarPdfHistorialMascota(Mascota mascota, Dueño dueño, List<Ficha> historial)
        {
            using (MemoryStream memoryStream = new MemoryStream())
            {
                Document document = new Document(PageSize.A4, 40, 40, 60, 40);
                PdfWriter writer = PdfWriter.GetInstance(document, memoryStream);
                document.Open();

                //Título
                Font titleFont = FontFactory.GetFont("Arial", 18, Font.BOLD, new BaseColor(32, 201, 151)); // #20c997
                Paragraph title = new Paragraph("Historial de Visitas Veterinarias", titleFont)
                {
                    Alignment = Element.ALIGN_CENTER,
                    SpacingAfter = 20
                };
                document.Add(title);

                //Datos de la Mascota y Dueño
                PdfPTable infoTable = new PdfPTable(2) { WidthPercentage = 100, SpacingAfter = 25 };
                infoTable.DefaultCell.Border = Rectangle.NO_BORDER;

                Font boldFont = FontFactory.GetFont("Arial", 10, Font.BOLD);
                Font normalFont = FontFactory.GetFont("Arial", 10);

                // Columna Izquierda: Datos Mascota
                PdfPCell cellMascota = new PdfPCell { Border = Rectangle.NO_BORDER };
                cellMascota.AddElement(new Paragraph("Datos de la Mascota", boldFont));
                cellMascota.AddElement(new Paragraph($"Nombre: {mascota.Nombre}", normalFont));
                cellMascota.AddElement(new Paragraph($"Especie: {mascota.Tipo} - Raza: {mascota.Raza}", normalFont));
                cellMascota.AddElement(new Paragraph($"Sexo: {mascota.Sexo} - Edad: {mascota.Edad} años", normalFont));
                infoTable.AddCell(cellMascota);

                // Columna Derecha: Datos Dueño
                PdfPCell cellDueño = new PdfPCell { Border = Rectangle.NO_BORDER };
                cellDueño.AddElement(new Paragraph("Datos del Dueño", boldFont));
                cellDueño.AddElement(new Paragraph($"Nombre y Apellido: {dueño.Nombre} {dueño.Apellido}", normalFont));
                cellDueño.AddElement(new Paragraph($"Teléfono: {dueño.Telefono}", normalFont));
                cellDueño.AddElement(new Paragraph($"Email: {dueño.Correo}", normalFont));
                infoTable.AddCell(cellDueño);

                document.Add(infoTable);

                //Tabla con el Historial de Visitas
                PdfPTable historyTable = new PdfPTable(2);
                historyTable.WidthPercentage = 100;
                historyTable.SetWidths(new float[] { 1f, 4f });

                //Encabezados de la tabla
                Font headerFont = FontFactory.GetFont("Arial", 10, Font.BOLD, BaseColor.WHITE);
                string[] headers = { "Fecha", "Descripción de la Visita" };
                foreach (string header in headers)
                {
                    PdfPCell cell = new PdfPCell(new Phrase(header, headerFont))
                    {
                        BackgroundColor = new BaseColor(32, 201, 151),
                        HorizontalAlignment = Element.ALIGN_CENTER,
                        Padding = 5
                    };
                    historyTable.AddCell(cell);
                }

                //Filas con los datos
                if (historial.Any())
                {
                    foreach (var ficha in historial)
                    {
                        historyTable.AddCell(new Phrase(ficha.Turno.FechaHora.ToString("dd/MM/yyyy"), normalFont));
                        historyTable.AddCell(new Phrase(ficha.Descripcion, normalFont));
                    }
                }
                else
                {
                    PdfPCell noDataCell = new PdfPCell(new Phrase("No hay visitas registradas en el historial.", normalFont))
                    {
                        Colspan = 2,
                        HorizontalAlignment = Element.ALIGN_CENTER,
                        Padding = 10,
                        Border = Rectangle.NO_BORDER
                    };
                    historyTable.AddCell(noDataCell);
                }

                document.Add(historyTable);
                document.Close();
                writer.Close();

                return memoryStream.ToArray();
            }
        }

    }
}

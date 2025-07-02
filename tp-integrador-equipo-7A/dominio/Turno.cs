using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    public class Turno
    {
        public int IdTurno { get; set; }
        public string MatriculaVeterinario { get; set; }
        //public int IdMascota { get; set; }
        public Mascota Mascota { get; set; }
        public DateTime FechaHora { get; set; }
        public string Estado { get; set; }
        public bool Activo { get; set; }

        public string NombreVeterinario { get; set; }


        //Armé este para que se vean mejor los datos en la lista de turnos, eliminenlo si les rompe el código
        public string DescripcionTurno
        {
            get
            {
                CultureInfo culturaES = new CultureInfo("es-ES");

                // Hace que el día empiece con mayus
                string diaCapitalizado = culturaES.TextInfo.ToTitleCase(FechaHora.ToString("dddd", culturaES));

                string restoFecha = FechaHora.ToString("dd/MM/yyyy - ⏰ HH:mm", culturaES);

                return $"🗓️ {diaCapitalizado} {restoFecha}";
            }
        }

    }
}

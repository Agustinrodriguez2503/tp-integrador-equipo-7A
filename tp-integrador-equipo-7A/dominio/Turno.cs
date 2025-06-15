using System;
using System.Collections.Generic;
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

        public string DescripcionTurno
        {
            get
            {
                return $"🗓️ {FechaHora:dddd dd/MM/yyyy} - ⏰ {FechaHora:HH:mm}";
            }
        }

    }
}

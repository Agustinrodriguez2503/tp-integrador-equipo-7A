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
        public int MatriculaVeterinario { get; set; }
        public int IdMascota { get; set; }
        public DateTime FechaHora { get; set; }
        public bool Activo { get; set; }
    }
}

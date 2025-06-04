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
        public int IdDueño { get; set; }
        public int IdVeterinario { get; set; }
        public DateTime Fecha { get; set; }
        public bool Activo { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    public class Ficha
    {
        public int IdConsulta { get; set; }
        public int IdTurno { get; set; }
        public string Descripcion { get; set; }
        public bool Activo { get; set; }
    }
}

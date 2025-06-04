using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    public class Ficha
    {
        public int IdFicha { get; set; }
        public int IdMascota { get; set; }
        public int IdVeterinario { get; set; }
        public string Diagnostico { get; set; }
        public string Descripcion { get; set; }
        public DateTime Fecha { get; set; }
        public bool Activo { get; set; }
    }
}

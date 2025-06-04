using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    internal class Usuario
    {
        public int ID { get; set; }
        public int Rol { get; set; }
        public string User { get; set; }
        public string Pass { get; set; }
        public bool Estado { get; set; }
    }
}

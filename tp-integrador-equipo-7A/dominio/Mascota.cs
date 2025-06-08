using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    public class Mascota
    {
        public int IDMascota { get; set; }
        public string DniDueño { get; set; }
        public string Nombre { get; set; }
        public int Edad { get; set; }
        [DisplayName("Fecha de nacimiento")]
        public DateTime FechaNacimiento { get; set; }
        public decimal Peso { get; set; }
        public string Tipo { get; set; }
        public string Raza { get; set; }
        public string Sexo { get; set; }
        [DisplayName("Fecha de nacimiento")]
        public DateTime FechaRegistro { get; set; }
        public bool Activo { get; set; }
    }

}

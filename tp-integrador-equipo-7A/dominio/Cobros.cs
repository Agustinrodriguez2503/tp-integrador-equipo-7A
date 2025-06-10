using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    public class Cobros
    {
        public int IDCobro { get; set; }
        public int IDTurno { get; set; }
        public int LegajoRecepcionista { get; set; }
        public string FormaPago { get; set; }
        public string Comprobante { get; set; }
        public decimal Costo { get; set; }
        public bool Activo { get; set; }

    }
}

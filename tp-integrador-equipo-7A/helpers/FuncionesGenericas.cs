using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace helpers
{
    public class FuncionesGenericas
    {
        /*Genera un listado con Turnos*/
        public List<DateTime> generarTurnosPosibles(int dias = 7)
        {
            List<DateTime> turnos = new List<DateTime>();
            DateTime hoy = DateTime.Today;

            for (int i = 0; i < dias; i++)
            {
                DateTime dia = hoy.AddDays(i);

                // Solo lunes a sábado
                if (dia.DayOfWeek != DayOfWeek.Sunday)
                {
                    // Turnos de 9:00 a 18:00
                    for (int hora = 9; hora < 18; hora++)
                    {
                        turnos.Add(dia.AddHours(hora));
                    }

                }
            }

            return turnos;
        }

        public static bool validaTexto(string texto)
        {
            if (string.IsNullOrEmpty(texto))
            {
                return false;
            }
            return true;
        }
        public static bool validaClave(string clave)
        {
            if (clave.Length < 6)
            {
                return false;
            }
            return true;
        }
        public static bool validaInt(string numero)
        {
            if(int.TryParse(numero, out int val))
            {
                return true;
            }
            else
            { 
                return false; 
            }
        }
        public static bool validaDec(string numero)
        {
            if (decimal.TryParse(numero, out decimal val))
            {
                return true;
            }
            else
            { 
                return false;
            }
        }
        public static bool validaFecha(string fecha)
        {
            if (DateTime.TryParse(fecha, out DateTime val))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}

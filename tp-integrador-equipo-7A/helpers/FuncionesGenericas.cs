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
                    // Turnos de 8:00 a 14:00
                    for (int hora = 8; hora < 14; hora++)
                    {
                        turnos.Add(dia.AddHours(hora));
                        turnos.Add(dia.AddHours(hora).AddMinutes(30));
                    }

                    // Turnos de 14:00 a 20:00
                    for (int hora = 14; hora < 20; hora++)
                    {
                        turnos.Add(dia.AddHours(hora));
                        turnos.Add(dia.AddHours(hora).AddMinutes(30));
                    }
                }
            }

            return turnos;
        }

    }
}

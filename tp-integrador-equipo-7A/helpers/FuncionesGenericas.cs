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
        public List<DateTime> generarTurnosPosibles(int dias = 5)
        {
            List<DateTime> turnos = new List<DateTime>();
            DateTime hoy = DateTime.Today;       // Trae la fecha de hoy
            DateTime ahora = DateTime.Now;       // Trae la fecha y hora de este momento.

            int diasAgregados = 0;               // Contador de días hábiles procesados
            int i = 0;                            // Día relativo (0 = hoy, 1 = mañana, etc.)

            while (diasAgregados < dias)         // Repetir hasta generar turnos de "n" días hábiles
            {
                DateTime dia = hoy.AddDays(i);   // Día actual a evaluar
                i++;                              // Avanzar al siguiente día en cada vuelta

                // Solo lunes a viernes
                if (dia.DayOfWeek >= DayOfWeek.Monday && dia.DayOfWeek <= DayOfWeek.Friday)
                {
                    for (int hora = 9; hora < 18; hora++) // Horario de turnos: de 9 a 17 hs
                    {
                        DateTime turno = dia.AddHours(hora);

                        // Si es hoy, y la hora ya pasó, lo salta
                        if (dia == hoy && turno <= ahora)
                            continue;

                        turnos.Add(turno); // Agrega el turno válido a la lista
                    }

                    diasAgregados++; // Se contó un día hábil completo (aunque tenga pocos turnos)
                }
            }

            return turnos;
        }

        public static bool validaTexto(string texto)
        {
            if (string.IsNullOrEmpty(texto)) 
                return false;
            return true;
        }
    }
}

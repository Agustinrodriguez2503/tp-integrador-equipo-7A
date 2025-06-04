using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    public class DueñoNegocio
    {
        public List<Dueño> listar()
        {
            List<Dueño> lista = new List<Dueño>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Dueño aux = new Dueño();
                    aux.IDDueño = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.DNI = (string)datos.Lector["DNI"];

                    aux.Telefono = (string)datos.Lector["Telefono"];
                    aux.Correo = (string)datos.Lector["Correo"];
                    aux.Domicilio = (string)datos.Lector["Domicilio"];

                    aux.CantidadMascotas = (int)datos.Lector["CantMascotas"];
                    aux.Activo = (bool)datos.Lector["Activo"];

                    lista.Add(aux);
                }

                return lista;
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
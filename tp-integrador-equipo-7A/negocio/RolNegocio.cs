using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    internal class RolNegocio
    {
        public List<Rol> listar()
        {
            List<Rol> lista = new List<Rol>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT IDRol, Nombre FROM Rol");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Rol aux = new Rol();
                    aux.ID = (int)datos.Lector["Legajo"];
                    aux.Nombre = (string)datos.Lector["Usuario"];

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

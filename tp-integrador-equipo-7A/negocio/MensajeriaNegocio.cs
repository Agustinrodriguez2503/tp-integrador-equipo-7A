using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    public class MensajeriaNegocio
    {
        public List<Mensajeria> listarChats()
        {
            List<Mensajeria> lista = new List<Mensajeria>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT IDMensaje, Asunto, Usuario, UltimoMensaje, Fecha, Activo FROM Mensajeria");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Mensajeria aux = new Mensajeria();
                    aux.IDMensaje = (int)datos.Lector["IDMensaje"];
                    aux.Asunto = (string)datos.Lector["Asunto"];
                    aux.Usuario = (string)datos.Lector["Usuario"];
                    aux.UltimoMensaje = (string)datos.Lector["UltimoMensaje"];
                    aux.Fecha = (DateTime)datos.Lector["Fecha"];
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

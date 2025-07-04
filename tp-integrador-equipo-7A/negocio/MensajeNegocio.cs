using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    public class MensajeNegocio
    {
        public List<Mensaje> listarConversarionPorID(int idMensaje)
        {
            List<Mensaje> mensajes = new List<Mensaje>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT IDConversacion, IDMensaje, Emisor, Receptor, Contenido, Fecha, Activo FROM Mensajes WHERE IDMensaje = @idMensaje");
                datos.setearParametro("@idMensaje", idMensaje);
                datos.ejecutarLectura();


                while (datos.Lector.Read())
                {
                    Mensaje aux = new Mensaje();
                    aux.IDConversacion = (int)datos.Lector["IDConversacion"];
                    aux.IDMensaje = (int)datos.Lector["IDMensaje"];
                    aux.Emisor = (string)datos.Lector["Emisor"];
                    aux.Contenido = (string)datos.Lector["Contenido"];
                    aux.Fecha = (DateTime)datos.Lector["Fecha"];
                    aux.Activo = (bool)datos.Lector["Activo"];

                    mensajes.Add(aux);
                }

                return mensajes;
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

        public void mensajeNuevo(Mensaje nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("INSERT INTO Mensajes (IDMensaje, Emisor, Contenido) VALUES (@idMensaje, @emisor, @contenido)");
                datos.setearParametro("@idMensaje", nuevo.IDMensaje);
                datos.setearParametro("@emisor", nuevo.Emisor);
                datos.setearParametro("@contenido", nuevo.Contenido);

                datos.ejecutarAccion();

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


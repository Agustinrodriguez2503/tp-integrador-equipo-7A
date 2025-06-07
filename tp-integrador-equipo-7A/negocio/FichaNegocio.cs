using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    internal class FichaNegocio
    {
        public List<Ficha> listar()
        {
            List<Ficha> lista = new List<Ficha>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT IDConsulta, IDTurno, Descripcion, Activo FROM FichaConsulta");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Ficha aux = new Ficha();
                    aux.IdConsulta = (int)datos.Lector["IDConsulta"];
                    aux.IdTurno = (int)datos.Lector["IDTurno"];
                    aux.Descripcion = (string)datos.Lector["Descripcion"];
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

        public void Agregar(Ficha nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {

                datos.setearConsulta("INSERT INTO FichaConsulta (IDConsulta, IDTurno, Descripcion, Activo) VALUES (@IDConsulta, @IDTurno, @Descripcion, @Activo)");
                datos.setearParametro("@IDConsulta", nuevo.IdConsulta);
                datos.setearParametro("@IDTurno", nuevo.IdTurno);
                datos.setearParametro("@Descripcion", nuevo.Descripcion);
                datos.setearParametro("@Activo", 1);
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

        public void Modificar(Ficha modificar)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {

                datos.setearConsulta("UPDATE FichaConsulta SET IDTurno = @IDTurno, Descripcion = @Descripcion WHERE IDConsulta = @IDConsulta");

                datos.setearParametro("@IDTurno", modificar.IdTurno);
                datos.setearParametro("@Descripcion", modificar.Descripcion);
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

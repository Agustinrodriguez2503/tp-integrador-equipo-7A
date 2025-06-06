using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    internal class UsuarioNegocio
    {
        public List<Usuario> Listar()
        {
            List<Usuario> lista = new List<Usuario>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT Usuario, IDRol, Clave, Activa FROM Usuarios");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Usuario aux = new Usuario();
                    aux.User = (string)datos.Lector["Usuario"];
                    aux.Rol = (int)datos.Lector["IDRol"];
                    aux.Pass = (string)datos.Lector["Clave"];
                    aux.Estado = (bool)datos.Lector["Activa"];


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

        public void Agregar(Usuario nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                //Inserta en la Tabla Articulos
                datos.setearConsulta("INSERT INTO Usuarios (Usuario, IDRol, Clave) VALUES (@User, @IdRol, @Clave)");
                datos.setearParametro("@User", nuevo.User);
                datos.setearParametro("@IdRol", nuevo.Rol);
                datos.setearParametro("@Clave", nuevo.Pass);

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

        public void Modificar(Usuario modificar)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                // Modifica en tabla Articulos
                datos.setearConsulta("UPDATE Usuarios SET Clave = '' WHERE Usuario = @User");
                datos.setearParametro("@User", modificar.User);
                datos.setearParametro("@Clave", modificar.Pass);
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

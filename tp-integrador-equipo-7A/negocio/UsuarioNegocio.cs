using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    public class UsuarioNegocio
    {
        public List<Usuario> ListarUnoTodos(string usuario = "")
        {
            List<Usuario> lista = new List<Usuario>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                if (usuario != null)
                {
                    datos.setearConsulta("SELECT Usuario, IDRol, Clave, Activa FROM Usuarios WHERE Usuario = @usuario");
                    datos.setearParametro("@usuario", usuario);
                    datos.ejecutarLectura();
                }
                else
                {
                    datos.setearConsulta("SELECT Usuario, IDRol, Clave, Activa FROM Usuarios");
                    datos.ejecutarLectura();
                }

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
                //Inserta en la Tabla USUARIOS
                datos.setearConsulta("INSERT INTO Usuarios (Usuario, IDRol, Clave) VALUES (@User, @IdRol, @Clave)");
                datos.setearParametro("@User", nuevo.User);
                datos.setearParametro("@IdRol", nuevo.Rol);
                datos.setearParametro("@Clave", nuevo.Pass);
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
        public void Modificar(Usuario modificar)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                // Modifica en tabla Articulos
                datos.setearConsulta("UPDATE Usuarios SET Clave = @clave WHERE Usuario = @user");
                datos.setearParametro("@user", modificar.User);
                datos.setearParametro("@clave", modificar.Pass);
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
        public bool Loguear(Usuario usuario)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("Select Usuario, IDRol, Clave, Activa From Usuarios Where Usuario = @user AND Clave = @pass");
                datos.setearParametro("@user", usuario.User);
                datos.setearParametro("@pass", usuario.Pass);

                datos.ejecutarLectura();
                if (datos.Lector.Read())
                {
                    usuario.Rol = (int)datos.Lector["IDRol"];
                    usuario.Estado = (bool)datos.Lector["Activa"];
                    return true;
                }
                return false;
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

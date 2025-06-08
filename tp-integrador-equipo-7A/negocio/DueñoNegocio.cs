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
        public List<Dueño> listar(string dni = "")
        {
            List<Dueño> lista = new List<Dueño>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                if (dni == "")
                {
                    datos.setearConsulta("Select Dni, Usuario, Nombre, Apellido, Telefono, Correo, Domicilio, Activo From Dueños");
                }
                else
                {
                    datos.setearConsulta("Select Dni, Usuario, Nombre, Apellido, Telefono, Correo, Domicilio, Activo From Dueños WHERE Dni = @dni");
                    datos.setearParametro("@dni", dni);
                }

                    datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Dueño aux = new Dueño();
                    aux.Dni = (string)datos.Lector["Dni"];
                    aux.Usuario = (string)datos.Lector["Usuario"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.Telefono = (string)datos.Lector["Telefono"];
                    aux.Correo = (string)datos.Lector["Correo"];
                    aux.Domicilio = (string)datos.Lector["Domicilio"];
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

        public List<Dueño> listarPorUser(string usuario = "")
        {
            List<Dueño> lista = new List<Dueño>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                if (usuario != "")
                {
                    datos.setearConsulta("Select Dni, Usuario, Nombre, Apellido, Telefono, Correo, Domicilio, Activo From Dueños Where Usuario = @usuario");
                    datos.setearParametro("@usuario", usuario);
                }
                else
                {
                    datos.setearConsulta("Select Dni, Usuario, Nombre, Apellido, Telefono, Correo, Domicilio, Activo From Dueños");
                }

                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Dueño aux = new Dueño();
                    aux.Dni = (string)datos.Lector["Dni"];
                    aux.Usuario = (string)datos.Lector["Usuario"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.Telefono = (string)datos.Lector["Telefono"];
                    aux.Correo = (string)datos.Lector["Correo"];
                    aux.Domicilio = (string)datos.Lector["Domicilio"];
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

        public void Agregar(Dueño nuevoDueño, Usuario nuevoUsuario)
        {
            AccesoDatos datos = new AccesoDatos();
            UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
            try
            {
                usuarioNegocio.Agregar(nuevoUsuario);
                datos.setearConsulta("INSERT INTO Dueños (Dni, Usuario, Nombre, Apellido, Telefono, Correo, Domicilio) VALUES (@dni, @usuario, @nombre, @apellido, @telefono, @correo, @domicilio)");
                datos.setearParametro("@dni", nuevoDueño.Dni);
                datos.setearParametro("@usuario", nuevoDueño.Usuario);
                datos.setearParametro("@nombre", nuevoDueño.Nombre);
                datos.setearParametro("@apellido", nuevoDueño.Apellido);
                datos.setearParametro("@telefono" , nuevoDueño.Telefono);
                datos.setearParametro("@correo", nuevoDueño.Correo);
                datos.setearParametro("@domicilio", nuevoDueño.Domicilio);
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
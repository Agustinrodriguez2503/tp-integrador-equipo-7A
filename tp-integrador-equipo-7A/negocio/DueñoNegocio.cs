using System;
using System.Collections;
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
                    datos.setearConsulta("Select Dni, Usuario, Nombre, Apellido, Telefono, Correo, Domicilio, Activo From Dueños Where Usuario = @usuario OR Correo = @usuario");
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

        public void AgregarDueño(Dueño nuevoDueño)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("INSERT INTO Dueños (Dni, Usuario, Nombre, Apellido, Telefono, Correo, Domicilio) VALUES (@dni, @usuario, @nombre, @apellido, @telefono, @correo, @domicilio)");
                datos.setearParametro("@dni", nuevoDueño.Dni);
                datos.setearParametro("@usuario", nuevoDueño.Usuario);
                datos.setearParametro("@nombre", nuevoDueño.Nombre);
                datos.setearParametro("@apellido", nuevoDueño.Apellido);
                datos.setearParametro("@telefono", nuevoDueño.Telefono);
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

        public void Modificar(Dueño dueño)
        {
            {
                AccesoDatos datos = new AccesoDatos();
                try
                {
                    // Modifica en tabla Dueño
                    datos.setearConsulta("UPDATE Dueños SET Nombre = @nombre, Apellido = @apellido, Telefono = @telefono, Domicilio = @domicilio, Correo = @correo WHERE Dni = @dni");
                    datos.setearParametro("@dni", dueño.Dni);
                    datos.setearParametro("@nombre", dueño.Nombre);
                    datos.setearParametro("@apellido", dueño.Apellido);
                    datos.setearParametro("@telefono", dueño.Telefono);
                    datos.setearParametro("@domicilio", dueño.Domicilio);
                    datos.setearParametro("@correo", dueño.Correo);
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

        public void Habilitar_O_Eliminar(string dni, int estado = 0)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("UPDATE Dueños SET Activo = @estado WHERE Dni = @dni");
                datos.setearParametro("@estado", estado);
                datos.setearParametro("@dni", dni);
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
    
        public List<Dueño> Filtrar(string campo, string criterio, string filtro, string estado)
        {
            List<Dueño> dueños = new List<Dueño> ();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                string consulta = "Select Dni, Usuario, Nombre, Apellido, Telefono, Correo, Domicilio, Activo From Dueños Where ";
                if (campo == "DNI")
                {
                    switch (criterio)
                    {
                        case "Comienza con":
                            consulta += "Dni like '" + filtro + "%' ";
                            break;
                        case "Termina con":
                            consulta += "Dni like '%" + filtro + "'";
                            break;
                        default:
                            consulta += "Dni like '%" + filtro + "%'";
                            break;
                    }
                }
                else if (campo == "Nombre")
                {
                    switch (criterio)
                    {
                        case "Comienza con":
                            consulta += "Nombre like '" + filtro + "%' ";
                            break;
                        case "Termina con":
                            consulta += "Nombre like '%" + filtro + "'";
                            break;
                        default:
                            consulta += "Nombre like '%" + filtro + "%'";
                            break;
                    }
                }
                else if (campo == "Usuario")
                {
                    switch (criterio)
                    {
                        case "Comienza con":
                            consulta += "Usuario like '" + filtro + "%' ";
                            break;
                        case "Termina con":
                            consulta += "Usuario like '%" + filtro + "'";
                            break;
                        default:
                            consulta += "Usuario like '%" + filtro + "%'";
                            break;
                    }
                }
                if (estado == "Activo")
                    consulta += " AND Activo = 1";
                else if (estado == "Inactivo")
                    consulta += " AND Activo = 0";


                datos.setearConsulta(consulta);
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

                    dueños.Add(aux);
                }
                return dueños;
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
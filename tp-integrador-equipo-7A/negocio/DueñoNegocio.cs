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
                datos.setearConsulta("SELECT Dni, Usuario, Nombre, Apellido, Telefono, Correo, Domicilio, CantMascotas, Activo FROM Dueños");
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

        public void Agregar(Dueño nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("INSERT INTO DUEÑO (Dni, Usuario, Nombre, Apellido, Telefono, Correo, Domicilio, CantMascotas) VALUES (@dni, @Usuario, @nombre, @apellido, @telefono, @correo, @domicilio, @cantMasc)");
                datos.setearParametro("@dni", nuevo.Dni);
                datos.setearParametro("@usuario", nuevo.Usuario);
                datos.setearParametro("@nombre", nuevo.Nombre);
                datos.setearParametro("@apellido", nuevo.Apellido);
                datos.setearParametro("@telefono" , nuevo.Telefono);
                datos.setearParametro("@correo", nuevo.Correo);
                datos.setearParametro("@domicilio", nuevo.Domicilio);
                datos.setearParametro("@cantMasc", nuevo.CantidadMascotas);
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
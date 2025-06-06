using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    internal class RecepcionistaNegocio
    {
        public List<Recepcionista> listar()
        {
            List<Recepcionista> lista = new List<Recepcionista>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT Legajo, Usuario, Nombre, Apellido, Dni, Telefono, Correo, Activo FROM Recepcionistas");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Recepcionista aux = new Recepcionista();
                    aux.Legajo = (int)datos.Lector["Legajo"];
                    aux.Usuario = (string)datos.Lector["Usuario"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.DNI = (string)datos.Lector["Dni"];
                    aux.Telefono = (string)datos.Lector["Telefono"];
                    aux.Correo = (string)datos.Lector["Correo"];
                    aux.Estado = (bool)datos.Lector["Avtivo"];

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

        public void Agregar(Recepcionista nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                //Inserta en la Tabla Articulos
                datos.setearConsulta("INSERT INTO Recepcionistas (Usuario, Nombre, Apellido, Dni, Telefono, Correo) VALUES (@Usuario, @Nombre, @Apellido, @Dni, @Telefono, @Correo)");
                datos.setearParametro("@Usuario", nuevo.Usuario);
                datos.setearParametro("@Nombre", nuevo.Nombre);
                datos.setearParametro("@Apellido", nuevo.Apellido);
                datos.setearParametro("@Dni", nuevo.DNI);
                datos.setearParametro("@Telefono", nuevo.Telefono);
                datos.setearParametro("@Correo", nuevo.Correo);
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

        public void Modificar(Recepcionista modificar)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                // Modifica en tabla Articulos
                datos.setearConsulta("UPDATE Recepcionistas SET Usuario = @Usuario, Nombre = @Nombre, Apellido = @Apellido, Dni = @Dni, Telefono = @Telefono, Correo = @Correo WHERE Legajo = @Legajo");
                datos.setearParametro("@Legajo", modificar.Legajo);
                datos.setearParametro("@Usuario", modificar.Usuario);
                datos.setearParametro("@Nombre", modificar.Nombre);
                datos.setearParametro("@Apellido", modificar.Apellido);
                datos.setearParametro("@Dni", modificar.DNI);
                datos.setearParametro("@Telefono", modificar.Telefono);
                datos.setearParametro("@Correo", modificar.Correo);
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

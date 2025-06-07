using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    internal class VeterinarioNegocio
    {
        public List<Veterinario> listar()
        {
            List<Veterinario> lista = new List<Veterinario>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT Matricula, Usuario, Nombre, Apellido, Dni, Telefono, Correo, Activo FROM Veterinarios");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Veterinario aux = new Veterinario();
                    aux.Matricula = (string)datos.Lector["Matricula"];
                    aux.Usuario = (string)datos.Lector["Usuario"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.Dni = (string)datos.Lector["Dni"];
                    aux.Telefono = (string)datos.Lector["Telefono"];
                    aux.Correo = (string)datos.Lector["Correo"];
                    aux.Estado = (bool)datos.Lector["Activo"];

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

        public void Agregar(Veterinario nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {

                datos.setearConsulta("INSERT INTO Veterinarios (Matricula, Usuario, Nombre, Apellido, Dni, Telefono, Correo) VALUES (@Matricula, @Usuario, @Nombre, @Apellido, @Dni, @Telefono, @Correo)");
                datos.setearParametro("@Matricula", nuevo.Matricula);
                datos.setearParametro("@Usuario", nuevo.Usuario);
                datos.setearParametro("@Nombre", nuevo.Nombre);
                datos.setearParametro("@Apellido", nuevo.Apellido);
                datos.setearParametro("@Dni", nuevo.Dni);
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

        public void Modificar(Veterinario modificar)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {

                datos.setearConsulta("UPDATE Veterinarios SET Usuario = @Usuario, Nombre = @Nombre, Apellido = @Apellido, Dni = @Dni, Telefono = @Telefono, Correo = @Correo, Activo = @Activo WHERE Matricula = @Matricula");
                datos.setearParametro("@Matricula", modificar.Matricula);
                datos.setearParametro("@Usuario", modificar.Usuario);
                datos.setearParametro("@Nombre", modificar.Nombre);
                datos.setearParametro("@Apellido", modificar.Apellido);
                datos.setearParametro("@Dni", modificar.Dni);
                datos.setearParametro("@Telefono", modificar.Telefono);
                datos.setearParametro("@Correo", modificar.Correo);
                datos.setearParametro("@Activo", modificar.Estado);
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

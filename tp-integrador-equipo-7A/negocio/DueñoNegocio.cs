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
                datos.setearConsulta("SELECT IDDueño, Nombre, Apellido, DNI, Telefono, Correo, Domicilio, CantMascotas, Activo FROM DUEÑO ");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Dueño aux = new Dueño();
                    aux.IDDueño = (int)datos.Lector["IDDueño"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.DNI = (string)datos.Lector["DNI"];

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
                datos.setearConsulta("INSERT INTO DUEÑO (Nombre, Apellido, DNI, Telefono, Correo, Domicilio, CantMascotas) VALUES (@nombre, @apellido, @dni, @telefono, @correo, @domicilio, @cantMasc)");
                datos.setearParametro("@nombre", nuevo.Nombre);
                datos.setearParametro("@apellido", nuevo.Apellido);
                datos.setearParametro("@dni", nuevo.DNI);
                datos.setearParametro("@telefono" , nuevo.Telefono );
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
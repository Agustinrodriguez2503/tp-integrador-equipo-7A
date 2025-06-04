using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    public class MascotaNegocio
    {
        public List<Mascota> listar()
        {
            List<Mascota> lista = new List<Mascota>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("Select IDMascota, IDDueño, Nombre, Edad, FechaNacimiento, Peso, Tipo, Raza, Sexo, FechaRegistro, Activo From MASCOTA");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Mascota aux = new Mascota();
                    aux.IDMascota = (int)datos.Lector["IDMascota"];
                    aux.IDDueño = (int)datos.Lector["IDDueño"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Edad = (int)datos.Lector["Edad"];

                    aux.FechaNacimiento = (DateTime)datos.Lector["FechaNacimiento"];
                    aux.Peso = (float)datos.Lector["Peso"];
                    aux.Tipo = (string)datos.Lector["Tipo"];
                    aux.Raza = (string)datos.Lector["Raza"];
                    aux.Sexo = (string)datos.Lector["Sexo"];

                    aux.FechaRegistro = (DateTime)datos.Lector["FechaRegistro"];
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

        public void Agregar(Mascota nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("Insert into MASCOTA (IDDueño, Nombre, Edad, FechaNacimiento, Peso, Tipo,Raza,Sexo,FechaRegistro, Activo) values (@iddueño, @nombre, @edad, @fechaNacimiento, @peso, @tipo, @raza, @sexo, @fechaRegistro, @activo)");
                datos.setearParametro("@iddueño", nuevo.IDDueño);
                datos.setearParametro("@nombre", nuevo.Nombre);
                datos.setearParametro("@edad", nuevo.Edad);
                datos.setearParametro("@fechaNacimiento", nuevo.FechaNacimiento);
                datos.setearParametro("@peso", nuevo.Peso);
                datos.setearParametro("@tipo", nuevo.Tipo);
                datos.setearParametro("@raza", nuevo.Raza);
                datos.setearParametro("@sexo", nuevo.Sexo);
                datos.setearParametro("@fechaRegistro", nuevo.FechaRegistro);
                datos.setearParametro("@activo", nuevo.Activo);
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

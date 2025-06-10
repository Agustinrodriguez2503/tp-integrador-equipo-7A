using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    public class MascotaNegocio
    {
        public List<Mascota> listar(string dni)
        {
            List<Mascota> lista = new List<Mascota>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("Select IDMascota, DniDueño, Nombre, Edad, FechaNacimiento, Peso, Tipo, Raza, Sexo, FechaRegistro, Activo From Mascotas where DniDueño = @dni AND Activo = 1");
                datos.setearParametro("@dni", dni);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Mascota aux = new Mascota();
                    aux.IDMascota = (int)datos.Lector["IDMascota"];
                    aux.DniDueño = (string)datos.Lector["DniDueño"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Edad = (int)datos.Lector["Edad"];
                    aux.FechaNacimiento = (DateTime)datos.Lector["FechaNacimiento"];
                    aux.Peso = (decimal)datos.Lector["Peso"];
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

        public List<Mascota> listar_Uno_o_Todos(int idMascota = -1)
        {
            List<Mascota> lista = new List<Mascota>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                if (idMascota != -1)
                {
                    datos.setearConsulta("Select IDMascota, DniDueño, Nombre, Edad, FechaNacimiento, Peso, Tipo, Raza, Sexo, FechaRegistro, Activo From Mascotas where IDMascota = @idMascota");
                    datos.setearParametro("@idMascota", idMascota);

                }
                else
                {
                    datos.setearConsulta("Select IDMascota, DniDueño, Nombre, Edad, FechaNacimiento, Peso, Tipo, Raza, Sexo, FechaRegistro, Activo From Mascotas");

                }

                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Mascota aux = new Mascota();
                    aux.IDMascota = (int)datos.Lector["IDMascota"];
                    aux.DniDueño = (string)datos.Lector["DniDueño"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Edad = (int)datos.Lector["Edad"];
                    aux.FechaNacimiento = (DateTime)datos.Lector["FechaNacimiento"];
                    aux.Peso = (decimal)datos.Lector["Peso"];
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
                datos.setearConsulta("INSERT INTO Mascotas (DniDueño, Nombre, Edad, FechaNacimiento, Peso, Tipo, Raza, Sexo) VALUES (@dnidueño, @nombre, @edad, @fechaNacimiento, @peso, @tipo, @raza, @sexo)");
                datos.setearParametro("@dnidueño", nuevo.DniDueño);
                datos.setearParametro("@nombre", nuevo.Nombre);
                datos.setearParametro("@edad", nuevo.Edad);
                datos.setearParametro("@fechaNacimiento", nuevo.FechaNacimiento);
                datos.setearParametro("@peso", nuevo.Peso);
                datos.setearParametro("@tipo", nuevo.Tipo);
                datos.setearParametro("@raza", nuevo.Raza);
                datos.setearParametro("@sexo", nuevo.Sexo);

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

        public void Modificar(Mascota mascota)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("UPDATE Mascotas SET Nombre = @nombre, Edad = @edad, FechaNacimiento = @fechanacimiento, Peso = @peso, Tipo = @tipo, Raza = @raza, Sexo = @sexo WHERE IDMascota = @id");
                datos.setearParametro("@id", mascota.IDMascota);
                datos.setearParametro("@nombre", mascota.Nombre);
                datos.setearParametro("@edad", mascota.Edad);
                datos.setearParametro("@fechanacimiento", mascota.FechaNacimiento);
                datos.setearParametro("@peso", mascota.Peso);
                datos.setearParametro("@tipo", mascota.Tipo);
                datos.setearParametro("@raza", mascota.Raza);
                datos.setearParametro("@sexo", mascota.Sexo);
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

        public void Eliminar(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("UPDATE Mascotas SET Activo = 0 WHERE IDMascota = @id");
                datos.setearParametro("id", id);
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

        public string TraerDniUsuario(string usuario)
        {
            string dni;
            string mensaje = "No se encontro DNI.";
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("SELECT D.Dni FROM Dueños D Inner Join Usuarios U ON D.Usuario = U.Usuario Where U.Usuario = @usuario");
                datos.setearParametro("@usuario", usuario);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    dni = (string)datos.Lector["Dni"];
                    return dni;
                }
                else
                {
                    return mensaje;
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

    }
}

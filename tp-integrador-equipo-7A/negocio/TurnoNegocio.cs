using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    public class TurnoNegocio
    {
        public List<Turno> listar(string estado = "")
        {
            List<Turno> lista = new List<Turno>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                if(estado == "")
                {
                    datos.setearConsulta("SELECT IDTurno, MatriculaVeterinario, IDMascota, FechaHora, Estado, Activo FROM Turnos");

                }
                else
                {
                    datos.setearConsulta("SELECT IDTurno, MatriculaVeterinario, IDMascota, FechaHora, Estado, Activo FROM Turnos WHERE Estado = @estado" );
                    datos.setearParametro("@estado", estado);
                }

                    datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Turno aux = new Turno();
                    aux.IdTurno = (int)datos.Lector["IDTurno"];
                    aux.MatriculaVeterinario = (string)datos.Lector["MatriculaVeterinario"];
                    aux.IdMascota = (int)datos.Lector["IDMascota"];
                    aux.FechaHora = (DateTime)datos.Lector["FechaHora"];
                    aux.Estado = (string)datos.Lector["Estado"];
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

        public List<Turno> listar_turnosOcupados(string matricula)
        {
            List<Turno> lista = new List<Turno>();
            AccesoDatos datos = new AccesoDatos();

            try
            {

                datos.setearConsulta("SELECT IDTurno, MatriculaVeterinario, IDMascota, FechaHora, Estado, Activo FROM Turnos WHERE Estado = @estado");
                datos.setearParametro("@matricula", matricula);


                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Turno aux = new Turno();
                    aux.IdTurno = (int)datos.Lector["IDTurno"];
                    aux.MatriculaVeterinario = (string)datos.Lector["MatriculaVeterinario"];
                    aux.IdMascota = (int)datos.Lector["IDMascota"];
                    aux.FechaHora = (DateTime)datos.Lector["FechaHora"];
                    aux.Estado = (string)datos.Lector["Estado"];
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

        public void Agregar(Turno nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {

                datos.setearConsulta("INSERT INTO Turnos (IDTurno, MatriculaVeterinario, IDMascota, FechaHora) VALUES (@IDTurno, @MatriculaVeterinario, @IDMascota, @FechaHora)");
                datos.setearParametro("@IDTurno", nuevo.IdTurno);
                datos.setearParametro("@MatriculaVeterinario", nuevo.MatriculaVeterinario);
                datos.setearParametro("@IDMascota", nuevo.IdMascota);
                datos.setearParametro("@FechaHora", nuevo.FechaHora);
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

        public void Modificar(Turno modificar)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {

                datos.setearConsulta("UPDATE Turnos SET MatriculaVeterinario = @MatriculaVeterinario, IDMascota = @IDMascota, FechaHora = @FechaHora WHERE IDTurno = @IDTurno");

                datos.setearParametro("@MatriculaVeterinario", modificar.MatriculaVeterinario);
                datos.setearParametro("@IDMascota", modificar.IdMascota);
                datos.setearParametro("@FechaHora", modificar.FechaHora);
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

        public void EliminarLogico(Turno modificar)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("UPDATE Turnos SET Activo = @Activo WHERE IDTurno = @IDTurno");
                datos.setearParametro("@IDTurno", modificar.IdTurno);
                datos.setearParametro("@Activo", 0);
                datos.ejecutarAccion();
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}


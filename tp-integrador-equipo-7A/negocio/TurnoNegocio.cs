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
                if (estado == "")
                {
                    datos.setearConsulta("SELECT IDTurno, MatriculaVeterinario, IDMascota, FechaHora, Estado, Activo FROM Turnos");

                }
                else
                {
                    datos.setearConsulta("SELECT IDTurno, MatriculaVeterinario, IDMascota, FechaHora, Estado, Activo FROM Turnos WHERE Estado = @estado");
                    datos.setearParametro("@estado", estado);
                }

                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Turno aux = new Turno();
                    aux.IdTurno = (int)datos.Lector["IDTurno"];
                    aux.MatriculaVeterinario = (string)datos.Lector["MatriculaVeterinario"];
                    aux.Mascota = new Mascota();
                    aux.Mascota.IDMascota = (int)datos.Lector["IDMascota"];
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

        public List<Turno> listar_turnosOcupados(string matricula, string estado = "TODO")
        {
            List<Turno> lista = new List<Turno>();
            AccesoDatos datos = new AccesoDatos();
            
            try
            {
                if(estado != "TODO")
                {
                    datos.setearConsulta("SELECT IDTurno, MatriculaVeterinario, IDMascota, FechaHora, Estado, Activo FROM Turnos WHERE MatriculaVeterinario = @matricula AND Estado = @estado AND Activo = 1");
                    datos.setearParametro("@estado", estado);
                    datos.setearParametro("@matricula", matricula);

                }
                else
                {
                    datos.setearConsulta("SELECT IDTurno, MatriculaVeterinario, IDMascota, FechaHora, Estado, Activo FROM Turnos WHERE MatriculaVeterinario = @matricula AND Activo = 1");
                    datos.setearParametro("@matricula", matricula);

                }



                    datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Turno aux = new Turno();
                    aux.IdTurno = (int)datos.Lector["IDTurno"];
                    aux.MatriculaVeterinario = (string)datos.Lector["MatriculaVeterinario"];
                    aux.Mascota = new Mascota();
                    aux.Mascota.IDMascota = (int)datos.Lector["IDMascota"];
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

        public List<Turno> listarTurnosConMascotaYVeterinario(string dniDueño, string estado = "TODO")
        {
            List<Turno> lista = new List<Turno>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                string consulta = @"
            SELECT t.IDTurno, t.MatriculaVeterinario, t.IDMascota, t.FechaHora, t.Estado, t.Activo,
                   m.Nombre AS NombreMascota,
                   v.Apellido AS ApellidoVet
            FROM Turnos t
            INNER JOIN Mascotas m ON t.IDMascota = m.IDMascota
            INNER JOIN Dueños d ON m.DniDueño = d.Dni
            INNER JOIN Veterinarios v ON t.MatriculaVeterinario = v.Matricula
            WHERE d.Dni = @dniDueño AND t.Activo = 1 AND t.FechaHora > GETDATE()
        ";

                if (estado != "TODO")
                {
                    consulta += " AND t.Estado = @estado";
                }

                datos.setearConsulta(consulta);
                datos.setearParametro("@dniDueño", dniDueño);
                if (estado != "TODO")
                {
                    datos.setearParametro("@estado", estado);
                }

                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Turno aux = new Turno();
                    aux.IdTurno = (int)datos.Lector["IDTurno"];
                    aux.MatriculaVeterinario = datos.Lector["MatriculaVeterinario"].ToString();

                    aux.Mascota = new Mascota();
                    aux.Mascota.IDMascota = (int)datos.Lector["IDMascota"];
                    aux.Mascota.Nombre = datos.Lector["NombreMascota"].ToString();

                    aux.FechaHora = (DateTime)datos.Lector["FechaHora"];
                    aux.Estado = datos.Lector["Estado"].ToString();
                    aux.Activo = (bool)datos.Lector["Activo"];

                    aux.NombreVeterinario = "Dr. " + datos.Lector["ApellidoVet"].ToString();

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

                datos.setearConsulta("INSERT INTO Turnos (MatriculaVeterinario, IDMascota, FechaHora) VALUES (@MatriculaVeterinario, @IDMascota, @FechaHora)");
                datos.setearParametro("@MatriculaVeterinario", nuevo.MatriculaVeterinario);
                datos.setearParametro("@IDMascota", nuevo.Mascota.IDMascota);
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
                datos.setearParametro("@IDMascota", modificar.Mascota.IDMascota);
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

        public void modificarEstado(int idTurno, string estado)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {

                datos.setearConsulta("UPDATE Turnos SET Estado = @Estado WHERE IDTurno = @IDTurno");

                datos.setearParametro("@IDTurno", idTurno);
                datos.setearParametro("@Estado", estado);

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


        public string mailEliminacion(int idTurno)
        {
            AccesoDatos datos = new AccesoDatos();
            string correo = null;
            try
            {
                datos.setearConsulta("SELECT D.Correo FROM Turnos T, Mascotas M, Dueños D WHERE T.IDTurno = @IDTurno AND T.IDMascota = M.IDMascota AND M.DniDueño = D.Dni");
                datos.setearParametro("@IDTurno", idTurno);

                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    correo = (string)datos.Lector["Correo"];
                }

                return correo;
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


using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    public class FichaNegocio
    {
        //    public List<Ficha> listar()
        //    {
        //        List<Ficha> lista = new List<Ficha>();
        //        AccesoDatos datos = new AccesoDatos();

        //        try
        //        {
        //            datos.setearConsulta("SELECT IDConsulta, IDTurno, Descripcion, Activo FROM FichaConsulta");
        //            datos.ejecutarLectura();

        //            while (datos.Lector.Read())
        //            {
        //                Ficha aux = new Ficha();
        //                aux.IdConsulta = (int)datos.Lector["IDConsulta"];
        //                aux.IdTurno = (int)datos.Lector["IDTurno"];
        //                aux.Descripcion = (string)datos.Lector["Descripcion"];
        //                aux.Activo = (bool)datos.Lector["Activo"];

        //                lista.Add(aux);
        //            }

        //            return lista;

        //        }
        //        catch (Exception ex)
        //        {

        //            throw ex;
        //        }
        //        finally
        //        {
        //            datos.cerrarConexion();
        //        }
        //    }

        //    public void Agregar(Ficha nuevo)
        //    {
        //        AccesoDatos datos = new AccesoDatos();
        //        try
        //        {

        //            datos.setearConsulta("INSERT INTO FichaConsulta (IDConsulta, IDTurno, Descripcion, Activo) VALUES (@IDConsulta, @IDTurno, @Descripcion, @Activo)");
        //            datos.setearParametro("@IDConsulta", nuevo.IdConsulta);
        //            datos.setearParametro("@IDTurno", nuevo.IdTurno);
        //            datos.setearParametro("@Descripcion", nuevo.Descripcion);
        //            datos.setearParametro("@Activo", 1);
        //            datos.ejecutarAccion();

        //        }
        //        catch (Exception ex)
        //        {

        //            throw ex;
        //        }
        //        finally
        //        {
        //            datos.cerrarConexion();
        //        }
        //    }

        //    public void Modificar(Ficha modificar)
        //    {
        //        AccesoDatos datos = new AccesoDatos();
        //        try
        //        {

        //            datos.setearConsulta("UPDATE FichaConsulta SET IDTurno = @IDTurno, Descripcion = @Descripcion WHERE IDConsulta = @IDConsulta");

        //            datos.setearParametro("@IDTurno", modificar.IdTurno);
        //            datos.setearParametro("@Descripcion", modificar.Descripcion);
        //            datos.ejecutarAccion();

        //        }
        //        catch (Exception ex)
        //        {

        //            throw ex;
        //        }
        //        finally
        //        {
        //            datos.cerrarConexion();
        //        }
        //    }

        //Filtro por DNI del dueño y el ID de la mascota
        public List<Ficha> listarFichasPorMascota(string dni, int idMascota)
        {
            List<Ficha> lista = new List<Ficha>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                if (dni != "")
                {
                    datos.setearConsulta("SELECT IDConsulta, F.IDTurno IDTurno, F.Descripcion, F.Activo ActivoFicha, " +
                    "MatriculaVeterinario, FechaHora, T.Activo ActivoTurno, M.IDMascota IDMascota, DniDueño, Edad, " +
                    "FechaNacimiento, Estado, FechaRegistro, Nombre, Peso, Raza, Sexo, Tipo, M.Activo ActivoMascota " +
                    "FROM FichaConsulta F, Turnos T, Mascotas M " +
                    "WHERE F.IDTurno = T.IDTurno AND T.IDMascota = M.IDMascota AND DniDueño = @dni AND M.IDMascota = @idMascota");
                    datos.setearParametro("@dni", dni);
                    datos.setearParametro("@idMascota", idMascota);

                }
                else
                {
                    datos.setearConsulta("SELECT IDConsulta, F.IDTurno IDTurno, F.Descripcion, F.Activo ActivoFicha, " +
                    "MatriculaVeterinario, FechaHora, T.Activo ActivoTurno, M.IDMascota IDMascota, DniDueño, Edad, " +
                    "FechaNacimiento, Estado, FechaRegistro, Nombre, Peso, Raza, Sexo, Tipo, M.Activo ActivoMascota " +
                    "FROM FichaConsulta F, Turnos T, Mascotas M " +
                    "WHERE F.IDTurno = T.IDTurno AND T.IDMascota = M.IDMascota");

                }
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Ficha aux = new Ficha();
                    //Atributos propios de FICHA
                    aux.IdConsulta = (int)datos.Lector["IDConsulta"];
                    aux.Descripcion = (string)datos.Lector["Descripcion"];
                    aux.Activo = (bool)datos.Lector["ActivoFicha"];

                    //Objeto TURNO
                    aux.Turno = new Turno();
                    aux.Turno.IdTurno = (int)datos.Lector["IDTurno"];
                    aux.Turno.MatriculaVeterinario = (string)datos.Lector["MatriculaVeterinario"];
                    aux.Turno.FechaHora = (DateTime)datos.Lector["FechaHora"];
                    aux.Turno.Estado = (string)datos.Lector["Estado"];
                    aux.Turno.Activo = (bool)datos.Lector["ActivoTurno"];

                    //Objeto MASCOTA dentro del Objeto TURNO
                    aux.Turno.Mascota = new Mascota();
                    aux.Turno.Mascota.IDMascota = (int)datos.Lector["IDMascota"];
                    aux.Turno.Mascota.DniDueño = (string)datos.Lector["DniDueño"];
                    aux.Turno.Mascota.Nombre = (string)datos.Lector["Nombre"];
                    aux.Turno.Mascota.Edad = (int)datos.Lector["Edad"];
                    aux.Turno.Mascota.FechaNacimiento = (DateTime)datos.Lector["FechaNacimiento"];
                    aux.Turno.Mascota.Peso = (decimal)datos.Lector["Peso"];
                    aux.Turno.Mascota.Tipo = (string)datos.Lector["Tipo"];
                    aux.Turno.Mascota.Raza = (string)datos.Lector["Raza"];
                    aux.Turno.Mascota.Sexo = (string)datos.Lector["Sexo"];
                    aux.Turno.Mascota.FechaRegistro = (DateTime)datos.Lector["FechaRegistro"];
                    aux.Turno.Mascota.Activo = (bool)datos.Lector["ActivoMascota"];

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
    }
}

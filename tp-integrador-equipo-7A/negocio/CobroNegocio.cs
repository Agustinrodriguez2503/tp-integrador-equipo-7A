using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    public class CobroNegocio
    {
        public List<Cobros> listar()
        {
            List<Cobros> lista = new List<Cobros>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT IDCobro, IDTurno, LegajoRecepcionista, FormaPago, Costo, NroComprobante, Activo FROM Cobros");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Cobros aux = new Cobros();
                    aux.IDCobro = (int)datos.Lector["IDCobro"];
                    aux.IDTurno = (int)datos.Lector["IDTurno"];
                    aux.LegajoRecepcionista = (int)datos.Lector["LegajoRecepcionista"];
                    aux.FormaPago = (string)datos.Lector["FormaPago"];
                    aux.Costo = (decimal)datos.Lector["Costo"];
                    aux.Comprobante = (string)datos.Lector["NroComprobante"];
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

        public void Agregar(Cobros nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                //Inserta en la Tabla Articulos
                datos.setearConsulta("INSERT INTO Cobros (IDTurno, LegajoRecepcionista, FormaPago, Costo, NroComprobante) VALUES (@turno, @legajoRecep, @formaPago, @costo, @comprobante)");
                datos.setearParametro("@turno", nuevo.IDTurno);
                datos.setearParametro("@legajoRecep", nuevo.LegajoRecepcionista);
                datos.setearParametro("@formaPago", nuevo.FormaPago);
                datos.setearParametro("@costo", nuevo.Costo);
                datos.setearParametro("@comprobante", nuevo.Comprobante);
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

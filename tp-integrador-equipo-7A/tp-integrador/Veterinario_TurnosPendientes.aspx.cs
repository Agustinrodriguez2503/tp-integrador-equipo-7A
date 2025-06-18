using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
using negocio;

namespace tp_integrador
{
    public partial class Veterinario_TurnosPendientes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarTurnos();
            }
        }

        private void CargarTurnos()
        {
            TurnoNegocio negocio = new TurnoNegocio();
            try
            {
                List<Turno> listaTurnos = negocio.listar();

                gvTurnos.DataSource = listaTurnos;
                gvTurnos.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error al cargar los turnos: " + ex.Message + "');</script>");
            }
        }
        protected void gvTurnos_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EliminarTurno")
            {
                int idTurno = Convert.ToInt32(e.CommandArgument);
                Response.Write("<script>alert('Lógica para Eliminar el turno ID: " + idTurno + "');</script>");
            }

        }
    }
}
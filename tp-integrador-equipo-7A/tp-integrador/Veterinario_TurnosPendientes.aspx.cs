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
                txtFecha.Text = DateTime.Now.ToString("yyyy-MM-dd");
                CargarTurnos();

            }
        }

        private void CargarTurnos()
        {
            TurnoNegocio negocio = new TurnoNegocio();
            List<Turno> listaOriginal;
            List<Turno> listaFiltrada;

            try
            {
                // Obtener la matrícula del veterinario logueado
                // *** REEMPLAZA CON LA LÓGICA REAL PARA OBTENER LA MATRÍCULA ***
                string matriculaVeterinario = "VET001";

                listaOriginal = negocio.listar_turnosOcupados(matriculaVeterinario);
                listaFiltrada = listaOriginal; // Por defecto, si no hay filtro de fecha o es inválido

                // Aplicar filtro de fecha si txtFecha tiene valor y es válido
                if (!string.IsNullOrEmpty(txtFecha.Text))
                {
                    DateTime fechaFiltro;
                    if (DateTime.TryParse(txtFecha.Text, out fechaFiltro))
                    {
                        listaFiltrada = listaOriginal.Where(t => t.FechaHora.Date == fechaFiltro.Date).ToList();
                    }
                    else
                    {
                        // Mensaje de error si la fecha no es válida
                        // Puedes usar un control Label en tu ASPX para mostrarlo de forma más amigable
                        // lblMensajeError.Text = "Formato de fecha inválido.";
                        // lblMensajeError.Visible = true;
                        // O simplemente una alerta como antes:
                        Response.Write("<script>alert('Formato de fecha inválido. Mostrando todos los turnos.');</script>");
                        // No es necesario limpiar txtFecha.Text aquí, si el usuario la escribió mal, seguirá viéndola mal.
                    }
                }

                gvTurnos.DataSource = listaFiltrada;

                // Ocultar columnas (esta lógica ya la tenías)
                if (gvTurnos.Columns.Count > 0)
                {
                    foreach (DataControlField column in gvTurnos.Columns)
                    {
                        if (column.HeaderText == "Matrícula Veterinario")
                        {
                            column.Visible = false;
                        }
                    }
                }
                gvTurnos.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error al cargar los turnos: " + ex.Message + "');</script>");
                // Log.Error(ex);
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

        protected void txtFecha_TextChanged(object sender, EventArgs e)
        {
            // Cuando el texto del txtFecha cambia y AutoPostBack es true,
            // este método se ejecuta. Simplemente llamamos a CargarTurnos()
            // para que se aplique el filtro.
            CargarTurnos();
        }
    }
}
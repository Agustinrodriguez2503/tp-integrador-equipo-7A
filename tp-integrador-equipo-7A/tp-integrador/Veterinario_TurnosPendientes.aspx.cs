using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
using helpers;
using negocio;
using Newtonsoft.Json.Converters;

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

        protected void txtFecha_TextChanged(object sender, EventArgs e)
        {
            CargarTurnos();
        }

        private void CargarTurnos()
        {
            TurnoNegocio negocio = new TurnoNegocio();
            List<Turno> listaOriginal;
            Veterinario veterinario = (Veterinario)Session["veterinario"];
            try
            {
                string matriculaVeterinario = veterinario.Matricula;
                listaOriginal = negocio.listar_turnosOcupados(matriculaVeterinario, "PENDIENTE");
                List<Turno> listaFiltrada = listaOriginal;
                if (!string.IsNullOrEmpty(txtFecha.Text) && DateTime.TryParse(txtFecha.Text, out DateTime fechaFiltro))
                {
                    listaFiltrada = listaOriginal.Where(t => t.FechaHora.Date == fechaFiltro.Date).ToList();
                }

                if (listaFiltrada.Count == 0)
                {
                    DateTime fechaSeleccionada;
                    if (DateTime.TryParse(txtFecha.Text, out fechaSeleccionada))
                    {
                        gvTurnos.EmptyDataText = $"No se encontraron turnos pendientes para el día {fechaSeleccionada.ToString("dd/MM/yyyy")}.";
                    }
                    else
                    {
                        gvTurnos.EmptyDataText = "No hay turnos pendientes para mostrar.";
                    }
                }
                gvTurnos.DataSource = listaFiltrada;
                gvTurnos.DataKeyNames = new string[] { "IdTurno", "FechaHora" };
                gvTurnos.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error al cargar los turnos: " + ex.Message + "');</script>");
            }
        }

        protected string GetCommandArgument(object idTurnoObj, object fechaHoraObj, object idMascotaObj)
        {
            string idTurno = idTurnoObj?.ToString() ?? "0";
            string fechaHora = (fechaHoraObj is DateTime dt) ? dt.ToString("O") : DateTime.MinValue.ToString("O");
            string idMascota = idMascotaObj?.ToString() ?? "0";
            return $"{idTurno}|{fechaHora}|{idMascota}";
        }

        protected void gvTurnos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string[] args = e.CommandArgument.ToString().Split('|');
            int idTurno = Convert.ToInt32(args[0]);
            DateTime fechaTurno = Convert.ToDateTime(args[1]);
            int idMascota = Convert.ToInt32(args[2]);

            if (e.CommandName == "SeleccionarParaCancelar")
            {
                ViewState["IdTurnoParaCancelar"] = idTurno;
                ViewState["FechaTurnoParaCancelar"] = fechaTurno;

                // Muestra el modal de confirmación
                string script = $"$('#{modalConfirmacion.ClientID}').modal('show');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", script, true);
            }

            if (e.CommandName == "IniciarTurno")
            {
                Response.Redirect($"Veterinario_FichasMedicas.aspx?idTurno={idTurno}&idMascota={idMascota}");
            }
        }

        protected void btnConfirmarCancelacion_Click(object sender, EventArgs e)
        {
            try
            {
                if (ViewState["IdTurnoParaCancelar"] != null)
                {
                    int idTurno = (int)ViewState["IdTurnoParaCancelar"];
                    DateTime fechaTurno = (DateTime)ViewState["FechaTurnoParaCancelar"];
                    TurnoNegocio negocio = new TurnoNegocio();

                    string correoCliente = negocio.mailEliminacion(idTurno);
                    negocio.modificarEstado(idTurno, "CANCELADO");


                    //ENVIO DE MAIL
                    //if (!string.IsNullOrEmpty(correoCliente))
                    //{
                    //    try
                    //    {
                    //        Servicios.enviarMailTurnoEliminado(correoCliente, fechaTurno);
                    //    }
                    //    catch (Exception)
                    //    {
                    //    }
                    //}

                    ViewState["IdTurnoParaCancelar"] = null;
                    ViewState["FechaTurnoParaCancelar"] = null;

                    CargarTurnos();
                    upTurnosGrid.Update();

                    string scriptExito = $"$('#{modalConfirmacion.ClientID}').modal('hide'); " +
                                         "$('.modal-backdrop').remove(); " +
                                         "$('body').removeClass('modal-open'); ";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowSuccessModal", scriptExito, true);
                }
            }
            catch (Exception ex)
            {
                string scriptError = $"$('#{modalConfirmacion.ClientID}').modal('hide'); alert('Error en la operación de cancelación: {ex.Message}');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", scriptError, true);
            }
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("Veterinario_PagPrincipal.aspx");
        }
    }
}
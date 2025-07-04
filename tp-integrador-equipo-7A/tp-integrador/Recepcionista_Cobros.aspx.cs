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
    public partial class Recepcionista_Cobros : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    TurnoNegocio turnoNegocio = new TurnoNegocio();

                    List<Turno> turnosss = turnoNegocio.listar("REALIZADO");
                    Session["ListaTurnos"] = turnosss;

                    ddlTurnos.DataSource = turnosss;
                    ddlTurnos.DataTextField = "DescripcionTurno";
                    ddlTurnos.DataValueField = "IdTurno";
                    ddlTurnos.DataBind();

                    ddlTurnos.Items.Insert(0, new ListItem("-- Seleccionar un turno --", ""));

                    CobroNegocio negocioCobro = new CobroNegocio();
                    cargarCobros(negocioCobro.listarCobrosRealizado());
                    Session["CobrosRealizados"] = negocioCobro.listarCobrosRealizado();

                }


            }
            catch (Exception ex)
            {
                Session["Error"] = ex.Message.ToString();
                Response.Redirect("ErrorPage.aspx");
            }

        }

        protected void btnRegistrarCobro_Click(object sender, EventArgs e)
        {
            CobroNegocio negocioCobro = new CobroNegocio();
            RecepcionistaNegocio negocioRecep = new RecepcionistaNegocio();
            Cobros nuevo = new Cobros();
            try
            {
                Usuario recepcionista = (Usuario)Session["usuario"];
                if (recepcionista == null)
                {
                    Session["Error"] = "Debe estar registrado/a como recepcionista para realizar un cobro.";
                    Response.Redirect("ErrorPage.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                    return;

                }
                Recepcionista seleccionado = negocioRecep.buscarRecepcionista_Usuario(recepcionista.User);
                nuevo.IDTurno = (int)Session["turnoSeleccionado"];
                nuevo.LegajoRecepcionista = seleccionado.Legajo;
                nuevo.FormaPago = ddlFormaPago.SelectedItem.Value;
                nuevo.Costo = decimal.Parse(tbxImporte.Text);
                nuevo.Comprobante = tbxComprobante.Text;

                negocioCobro.Agregar(nuevo);

                //se le cambia el estado una vez cobrado el turno "REALIZADO"
                TurnoNegocio turno = new TurnoNegocio();
                turno.modificarEstado(nuevo.IDTurno, "COBRADO");

                string titulo = "¡Cobro exitoso!";
                string mensaje = "El cobro ha sido registrado exitosamente.";

                ScriptManager.RegisterStartupScript(this, this.GetType(), "cobroExito", $@"
                Swal.fire({{
                    title: '{titulo}',
                    text: '{mensaje}',
                    icon: 'success',
                    confirmButtonText: 'Aceptar'
                }}).then((result) => {{
                    if (result.isConfirmed) {{
                        window.location.href = 'Recepcionista_PagPrincipal.aspx';
                    }}
                }});", true);

            }
            catch (Exception ex)
            {
                Session["Error"] = ex.Message.ToString();
                Response.Redirect("ErrorPage.aspx");
            }


        }

        protected void ddlTurnos_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {

                List<Turno> turnosPendientes = Session["ListaTurnos"] as List<Turno>;
                int idTurno = int.Parse(ddlTurnos.SelectedItem.Value);
                Turno turno = turnosPendientes.Find(x => x.IdTurno == idTurno);

                VeterinarioNegocio negocioVeterinario = new VeterinarioNegocio();
                Veterinario veteSelecciondo = negocioVeterinario.listar(turno.MatriculaVeterinario)[0];

                MascotaNegocio negocioMascota = new MascotaNegocio();
                Mascota mascotaSeleccionada = negocioMascota.listar_Uno_o_Todos(turno.Mascota.IDMascota)[0];

                DueñoNegocio negocioDuenio = new DueñoNegocio();
                Dueño duenioSeleccionado = negocioDuenio.listar(mascotaSeleccionada.DniDueño)[0];

                lblNombreVete.Text = "Dr. " + veteSelecciondo.nombreCompleto();
                lblMatriculaVete.Text = veteSelecciondo.Matricula;

                lblNombreMascota.Text = mascotaSeleccionada.Nombre;
                lblDatoMascota.Text = mascotaSeleccionada.Raza;

                lblNombreDuenio.Text = duenioSeleccionado.nombreCompleto();
                lblDatoDuenio.Text = "📞" + duenioSeleccionado.Telefono;

                Session["turnoSeleccionado"] = idTurno;

            }
            catch (Exception ex)
            {
                Session["Error"] = ex.Message.ToString();
                Response.Redirect("ErrorPage.aspx");
            }

        }

        protected void ddlFormaPago_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (ddlFormaPago.SelectedItem.Value == "Tarjeta" || ddlFormaPago.SelectedItem.Value == "Transferencia")
                {
                    tbxComprobante.Enabled = true;
                }
                else
                {
                    tbxComprobante.Enabled = false;
                }

            }
            catch (Exception ex)
            {
                Session["Error"] = ex.Message.ToString();
                Response.Redirect("ErrorPage.aspx");
            }

        }

        protected void btnFiltrarCobros_Click(object sender, EventArgs e)
        {
            try
            {
                CobroNegocio negocioCobro = new CobroNegocio();
                lbl_ddlFiltro.Visible = false;
                lblFiltroValor.Visible = false;

                if (string.IsNullOrEmpty(txtValorFiltroCobros.Text))
                {
                    cargarCobros(negocioCobro.listarCobrosRealizado());
                    Session["CobrosRealizados"] = negocioCobro.listarCobrosRealizado();
                    return;
                }

                if (ddlFiltroCobros.SelectedValue == "Seleccione")
                {
                    lbl_ddlFiltro.Text = "Seleccione el criterio para filtar";
                    lbl_ddlFiltro.Visible = true;
                    return;
                }

                string criterio = ddlFiltroCobros.SelectedValue;
                string valor = txtValorFiltroCobros.Text;

                if (criterio == "Fecha")
                {
                    DateTime fechaBuscada;
                    if (!DateTime.TryParseExact(valor, "dd/MM/yyyy", null, System.Globalization.DateTimeStyles.None, out fechaBuscada))
                    {
                        lblFiltroValor.Text = "Ingrese una fecha válida en formato dd/MM/yyyy";
                        lblFiltroValor.Visible = true;
                        return;
                    }

                    valor = fechaBuscada.ToString("yyyy-MM-dd");
                }


                cargarCobros(negocioCobro.listarCobrosRealizado(criterio, valor));
                Session["CobrosRealizados"] = negocioCobro.listarCobrosRealizado(criterio, valor);



            }
            catch (Exception ex)
            {
                Session["Error"] = ex.Message.ToString();
                Response.Redirect("ErrorPage.aspx");
            }


        }

        protected void gvCobros_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                List<Cobros> cobros = Session["CobrosRealizados"] as List<Cobros>;
                if (cobros != null)
                {
                    gvCobros.PageIndex = e.NewPageIndex;
                    cargarCobros(cobros);
                }

            }
            catch (Exception ex)
            {
                Session["Error"] = ex.Message.ToString();
                Response.Redirect("ErrorPage.aspx");
            }

        }

        protected void cargarCobros(List<Cobros> listaCobros)
        {

            gvCobros.DataSource = listaCobros;
            gvCobros.DataBind();
            gvCobros.Visible = true;
        }
    }
}
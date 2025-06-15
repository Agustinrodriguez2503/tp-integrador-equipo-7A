//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Web;
//using System.Web.UI;
//using System.Web.UI.WebControls;
//using dominio;
//using negocio;

//namespace tp_integrador
//{
//    public partial class Recepcionista_Cobros : System.Web.UI.Page
//    {
//        protected void Page_Load(object sender, EventArgs e)
//        {
//            try
//            {
//                if (!IsPostBack)
//                {
//                    TurnoNegocio turnoNegocio = new TurnoNegocio();

//                    List<Turno> turnosss = turnoNegocio.listar("PENDIENTE");
//                    Session["ListaTurnos"] = turnosss;

//                    ddlTurnos.DataSource = turnosss;
//                    ddlTurnos.DataTextField = "DescripcionTurno";
//                    ddlTurnos.DataValueField = "IdTurno";
//                    ddlTurnos.DataBind();

//                    ddlTurnos.Items.Insert(0, new ListItem("-- Seleccionar un turno --", ""));
//                }

//            }
//            catch (Exception ex)
//            {

//                Session.Add("error", ex);
//            }

//        }

//        protected void btnRegistrarCobro_Click(object sender, EventArgs e)
//        {
//            CobroNegocio negocioCobro = new CobroNegocio();
//            RecepcionistaNegocio negocioRecep = new RecepcionistaNegocio();
//            Cobros nuevo = new Cobros();
//            try
//            {
//                Usuario recepcionista = (Usuario)Session["usuario"];
//                Recepcionista seleccionado = negocioRecep.buscarRecepcionista_Usuario(recepcionista.User);
//                nuevo.IDTurno = (int)Session["turnoSeleccionado"];
//                nuevo.LegajoRecepcionista = seleccionado.Legajo;
//                nuevo.FormaPago = ddlFormaPago.SelectedItem.Value;
//                nuevo.Costo = decimal.Parse(tbxImporte.Text);
//                nuevo.Comprobante = tbxComprobante.Text;

//                negocioCobro.Agregar(nuevo);



//            }
//            catch (Exception ex)
//            {

//                Session.Add("error", ex);
//            }


//        }

//        protected void ddlTurnos_SelectedIndexChanged(object sender, EventArgs e)
//        {
//            try
//            {

//                List<Turno> turnosPendientes = Session["ListaTurnos"] as List<Turno>;
//                int idTurno = int.Parse(ddlTurnos.SelectedItem.Value);
//                Turno turno = turnosPendientes.Find(x => x.IdTurno == idTurno);

//                VeterinarioNegocio negocioVeterinario = new VeterinarioNegocio();
//                Veterinario veteSelecciondo = negocioVeterinario.listar(turno.MatriculaVeterinario)[0];

//                MascotaNegocio negocioMascota = new MascotaNegocio();
//                Mascota mascotaSeleccionada = negocioMascota.listar_Uno_o_Todos(turno.IdMascota)[0];

//                DueñoNegocio negocioDuenio = new DueñoNegocio();
//                Dueño duenioSeleccionado = negocioDuenio.listar(mascotaSeleccionada.DniDueño)[0];

//                lblNombreVete.Text = "Dr. " + veteSelecciondo.nombreCompleto();
//                lblMatriculaVete.Text = veteSelecciondo.Matricula;

//                lblNombreMascota.Text = mascotaSeleccionada.Nombre;
//                lblDatoMascota.Text = mascotaSeleccionada.Raza;

//                lblNombreDuenio.Text = duenioSeleccionado.nombreCompleto();
//                lblDatoDuenio.Text = "📞" + duenioSeleccionado.Telefono;

//                Session["turnoSeleccionado"] = idTurno;

//            }
//            catch (Exception ex)
//            {

//                Session.Add("error", ex);
//            }

//        }

//        protected void ddlFormaPago_SelectedIndexChanged(object sender, EventArgs e)
//        {
//            try
//            {
//                if (ddlFormaPago.SelectedItem.Value == "Tarjeta" || ddlFormaPago.SelectedItem.Value == "Transferencia")
//                {
//                    tbxComprobante.Enabled = true;
//                }
//                else
//                {
//                    tbxComprobante.Enabled = false;
//                }

//            }
//            catch (Exception ex)
//            {

//                Session.Add("error", ex);
//            }

//        }
//    }
//}
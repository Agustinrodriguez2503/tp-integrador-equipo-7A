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

                    List<Turno> turnosss = turnoNegocio.listar("PENDIENTE");
                    Session["ListaTurnos"] = turnosss;

                    ddlTurnos.DataSource = turnosss;
                    ddlTurnos.DataTextField = "DescripcionTurno";
                    ddlTurnos.DataValueField = "IdTurno";
                    ddlTurnos.DataBind();
                }

            }
            catch (Exception ex)
            {

                Session.Add("error", ex);
            }

        }

        protected void btnRegistrarCobro_Click(object sender, EventArgs e)
        {

        }

        protected void ddlTurnos_SelectedIndexChanged(object sender, EventArgs e)
        {
            List<Turno> turnosPendientes = Session["ListaTurnos"] as List<Turno>;
            int idTurno = int.Parse(ddlTurnos.SelectedItem.Value);
            Turno turno = turnosPendientes.Find(x => x.IdTurno == idTurno);

            VeterinarioNegocio negocioVeterinario = new VeterinarioNegocio();
            Veterinario veteSelecciondo = negocioVeterinario.listar(turno.MatriculaVeterinario)[0];

            MascotaNegocio negocioMascota = new MascotaNegocio();
            Mascota mascotaSeleccionada = negocioMascota.listar_Uno_o_Todos(turno.IdMascota)[0];

            DueñoNegocio negocioDuenio = new DueñoNegocio();
            Dueño duenioSeleccionado = negocioDuenio.listar(mascotaSeleccionada.DniDueño)[0];

            lblNombreVete.Text = "Dr. " + veteSelecciondo.nombreCompleto();
            lblMatriculaVete.Text = veteSelecciondo.Matricula;

            lblNombreMascota.Text = mascotaSeleccionada.Nombre;
            lblDatoMascota.Text = mascotaSeleccionada.Raza;

            lblNombreDuenio.Text = duenioSeleccionado.nombreCompleto();
            lblDatoDuenio.Text = "📞" + duenioSeleccionado.Telefono;
        }
    }
}
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
using helpers;
using negocio;

namespace tp_integrador
{
    public partial class Recepcionista_PagPrincipal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //RecepcionistaNegocio negocioRecepcionista = new RecepcionistaNegocio();
            //Usuario usuario = (Usuario)Session["usuario"];
            //Recepcionista seleccionado = negocioRecepcionista.buscarRecepcionista_Usuario(usuario.User);
            //recepcionista.InnerText = seleccionado.nombreCompleto();

            //if (!(Seguridad.sesionActiva(Session["usuario"])))
            //    Response.Redirect("IniciarSesion.aspx", false);
        }

        protected void txtDueño_TextChanged(object sender, EventArgs e)
        {
            MascotaNegocio negocioMascota = new MascotaNegocio();
            try
            {
                string dniDueño = txtDueño.Text;
                List<Mascota> mascotas = new List<Mascota>();
                mascotas = negocioMascota.listar(dniDueño);

                if(mascotas != null && mascotas.Count > 0)
                {
                    ddlMascota.Enabled = true;
                    ddlMascota.DataSource = mascotas;
                    ddlMascota.DataTextField = "Nombre";
                    ddlMascota.DataValueField = "IdMascota";
                    ddlMascota.DataBind();
                    ddlMascota.Items.Insert(0, new ListItem("-- Seleccione una mascota --", ""));
                    lblDniNoValido.Visible = false;
                }
                else
                {
                    lblDniNoValido.Visible = true;
                }



            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        protected void btnTurnos_Click(object sender, EventArgs e)
        {
            upPanelTurnos.Visible = true;
        }

        protected void btnBuscarTurno_Click(object sender, EventArgs e)
        {
            int idMascota = int.Parse(ddlMascota.SelectedItem.Value);
            Session["IDMascota"] = idMascota;
            Response.Redirect("Turnos.aspx", false);
        }

        protected void ddlMascota_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnBuscarTurno.Enabled = true;

        }

        protected void btnRegistrarDueño_Click(object sender, EventArgs e)
        {

        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            panelRegistrar.Visible = true;
        }

        protected void btnAgregarMascota_Click(object sender, EventArgs e)
        {
            txtBuscarMascota.Visible = true;
            btnBuscarMascota.Visible = true;
        }
    }
}
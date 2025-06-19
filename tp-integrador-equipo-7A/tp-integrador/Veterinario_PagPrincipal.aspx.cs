using System;
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
    public partial class Veterinario_PagPrincipal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!(Seguridad.sesionActiva(Session["usuario"])))
                Response.Redirect("IniciarSesion.aspx", false);

            if (Session["usuario"] != null)
            {
                try
                {
                    VeterinarioNegocio veterinarioNegocio = new VeterinarioNegocio();
                    Veterinario veterinario = new Veterinario();

                    Usuario usuario = (Usuario)Session["usuario"];
                    veterinario = veterinarioNegocio.listarPorUser(usuario.User)[0];

                    lblBienvenidoVet.Text = veterinario.Nombre + " " + veterinario.Apellido;
                }
                catch (Exception ex)
                {

                    throw ex;
                }
            }
        }
    }
}
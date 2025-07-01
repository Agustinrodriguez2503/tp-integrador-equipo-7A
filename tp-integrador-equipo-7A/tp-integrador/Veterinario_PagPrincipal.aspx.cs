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
            Usuario usuario = (Usuario)Session["usuario"];

            if (!(Seguridad.sesionActiva(Session["usuario"])))
            {
                Response.Redirect("IniciarSesion.aspx", false);
            }
            else if (usuario.Rol == 3)
            {
                VeterinarioNegocio veterinarioNegocio = new VeterinarioNegocio();
                Veterinario veterinario = new Veterinario();


                veterinario = veterinarioNegocio.listarPorUser(usuario.User)[0];

                //Me guardo en session al veterinario logueado
                Session["veterinario"] = veterinario;

                lblBienvenidoVet.Text = veterinario.Nombre + " " + veterinario.Apellido;
            }
            else
            {
                Response.Redirect("ErrorPage.aspx");
            }
        }
    }
}

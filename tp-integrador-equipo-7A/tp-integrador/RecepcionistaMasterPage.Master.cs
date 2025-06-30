using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;

namespace tp_integrador
{
    public partial class RecepcionistaMasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string pagina = System.IO.Path.GetFileName(Request.Path);


            if (pagina == "Turnos")
            {
                contenedorLogin.Visible = false;
                contenedorReturn.Visible = true;

            }
            if (pagina == "Recepcionista_PagPrincipal")
            {
                contenedorLogin.Visible = true;
                contenedorReturn.Visible = false;
            }

        }

        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            Session.Abandon(); 
            Response.Redirect("IniciarSesion.aspx", false);
        }

        protected void btnReturn_Click(object sender, EventArgs e)
        {
            Usuario usuario = (Usuario)Session["usuario"];
            if (usuario.Rol == 1)
            {
                Response.Redirect("Dueño_PagPrincipal.aspx", false);
            }
            else
            {
                Response.Redirect("Recepcionista_PagPrincipal.aspx", false);

            }
        }
    }
}
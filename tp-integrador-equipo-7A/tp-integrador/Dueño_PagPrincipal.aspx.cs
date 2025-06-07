using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;

namespace tp_integrador
{
    public partial class Dueño_PagPrincipal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Usuario usuario = Session["usuario"] != null ? (Usuario)Session["usuario"] : null;
            if (!(usuario != null && usuario.User != null))
                Response.Redirect("IniciarSesion.aspx", false);
        }
    }
}
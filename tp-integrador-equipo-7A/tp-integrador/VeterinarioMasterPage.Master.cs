using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;

namespace tp_integrador
{
    public partial class VeterinarioMasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string pagina = System.IO.Path.GetFileName(Request.Path);

        }

        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("IniciarSesion.aspx", false);
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tp_integrador
{
    public partial class PaginaPrincipalMasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string pagina = System.IO.Path.GetFileName(Request.Path);

            Response.Write("<script>console.log('Página actual: " + pagina + "');</script>");

            if (pagina == "IniciarSesion") // reemplazá por el nombre real de tu página
            {
                contenedorLogin.Visible = false;
            }

        }
    }
}
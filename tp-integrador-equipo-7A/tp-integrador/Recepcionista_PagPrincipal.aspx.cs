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
    public partial class Recepcionista_PagPrincipal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RecepcionistaNegocio negocioRecepcionista = new RecepcionistaNegocio();
            Usuario usuario = (Usuario)Session["usuario"];
            Recepcionista seleccionado = negocioRecepcionista.buscarRecepcionista_Usuario(usuario.User);
            recepcionista.InnerText = seleccionado.nombreCompleto();

            if (!(Seguridad.sesionActiva(Session["usuario"])))
                Response.Redirect("IniciarSesion.aspx", false);
        }
    }
}
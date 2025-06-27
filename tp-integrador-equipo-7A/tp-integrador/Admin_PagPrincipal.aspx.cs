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
    public partial class Admin_PagPrincipal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!(Seguridad.sesionActiva(Session["usuario"])) || (!Seguridad.isAdmin(Session["usuario"])))
                Response.Redirect("IniciarSesion.aspx", false);
            else
            {
                try
                {
                    VeterinarioNegocio veterinarioNegocio = new VeterinarioNegocio();
                    RecepcionistaNegocio recepcionistaNegocio = new RecepcionistaNegocio();

                    gvVeterinarios.DataSource = veterinarioNegocio.listar();
                    gvVeterinarios.DataBind();

                    gvRecepcionistas.DataSource = recepcionistaNegocio.listar();
                    gvRecepcionistas.DataBind();

                }
                catch (Exception ex)
                {

                    throw ex;
                }
            }
        }

        protected void btnModificarVet_Click(object sender, EventArgs e)
        {

        }

        protected void btnEliminarVet_Click(object sender, EventArgs e)
        {

        }

        protected void btnModificarRec_Click(object sender, EventArgs e)
        {

        }

        protected void btnEliminarRec_Click(object sender, EventArgs e)
        {

        }
    }
}
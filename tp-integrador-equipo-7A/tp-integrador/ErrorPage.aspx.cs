using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tp_integrador
{
    public partial class ErrorPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Error"] != null)
                {
                    lblMensajeError.Text = Session["Error"].ToString();
                }
                else
                {
                    lblMensajeError.Text = "Ocurrió un error inesperado. Por favor, intente nuevamente.";
                }
            }

        }
    }
}
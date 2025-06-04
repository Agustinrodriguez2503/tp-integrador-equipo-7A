using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
using negocio;

namespace tp_integrador
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnDNI_Click(object sender, EventArgs e)
        {
            string dni = tbxDNI.Text;
            MascotaNegocio mascota = new MascotaNegocio();
            gdvMascotas.DataSource = mascota.listar(dni);
            gdvMascotas.DataBind();
            
        }
    }
}
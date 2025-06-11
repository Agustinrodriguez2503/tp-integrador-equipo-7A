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
    public partial class Turnos : System.Web.UI.Page
    {
        public List<Veterinario> listaVeterinario { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                VeterinarioNegocio negocioVeterinario = new VeterinarioNegocio();
                listaVeterinario = negocioVeterinario.listar();

            }
            catch (Exception ex)
            {

                throw;
            }

        }
    }
}
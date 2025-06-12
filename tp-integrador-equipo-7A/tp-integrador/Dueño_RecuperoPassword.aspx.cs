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
    public partial class Dueño_RecuperoPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnGuardarClave_Click(object sender, EventArgs e)
        {
            DueñoNegocio dueñoNegocio = new DueñoNegocio();
            Dueño dueño = new Dueño();
            UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
            Usuario usuario = new Usuario();

            if (Session["contacto"] != null)
            {
                string contacto = (string)Session["contacto"];
           
                dueño = dueñoNegocio.listarPorUser(contacto)[0];
                usuario = usuarioNegocio.ListarUnoTodos(dueño.Usuario)[0];

                if (txtNuevaClave.Text == txtConfirmarClave.Text)
                {
                    usuario.Pass = txtConfirmarClave.Text;
                    usuarioNegocio.Modificar(usuario);
                    lblClaves.Text = "Clave modificada exitosamente.";
                }
                else
                {
                    lblClaves.Visible = true;
                    lblClaves.Text = "Las claves no coinciden.";
                }
            }
        }
    }
}
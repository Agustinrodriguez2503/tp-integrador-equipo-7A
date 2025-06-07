using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
using negocio;

namespace tp_integrador
{
    public partial class IniciarSesion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnIniciar_Click(object sender, EventArgs e)
        {
            Usuario usuario = new Usuario();
            UsuarioNegocio negocio = new UsuarioNegocio();
            try
            {
                usuario.User = txtUsuario.Text;
                usuario.Pass = txtClave.Text;
                if (negocio.Loguear(usuario))
                {
                    Session.Add("usuario", usuario);
                    if(usuario.Rol == 1)
                    {
                        Response.Redirect("Dueño_PagPrincipal.aspx", false);
                    }
                    else if (usuario.Rol == 2)
                    {
                        Response.Redirect("Recepcionista_PagPrincipal.aspx", false);
                    }
                    else if (usuario.Rol == 3)
                    {
                        Response.Redirect("Veterinario_PagPrincipal.aspx", false);
                    }
                }
                lblMensaje.Text = "Usuario o contraseña incorrecta.";
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Visible = true;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}
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
    public partial class Dueño_RecuperoPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!(Seguridad.sesionActiva(Session["usuario"])))
            //    Response.Redirect("IniciarSesion.aspx", false);
        }

        protected void btnGuardarClave_Click(object sender, EventArgs e)
        {
            DueñoNegocio dueñoNegocio = new DueñoNegocio();
            Dueño dueño = new Dueño();
            UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
            Usuario usuario = new Usuario();

            try
            {
                if (Session["contacto"] != null)
                {
                    string contacto = (string)Session["contacto"];

                    dueño = dueñoNegocio.listarPorUser(contacto)[0];
                    usuario = usuarioNegocio.ListarUnoTodos(dueño.Usuario)[0];

                    if (txtNuevaClave.Text == txtConfirmarClave.Text)
                    {

                        usuario.Pass = txtConfirmarClave.Text;
                        usuarioNegocio.Modificar(usuario);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "cambioClave", @"
                    Swal.fire({
                        title: '¡Modificación de clave!',
                        text: 'Su contraseña fue modificada exitosamente.',
                        icon: 'success',
                        confirmButtonText: 'Aceptar'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location.href = 'IniciarSesion.aspx';
                        }
                    });
                ", true);
                    }
                    else
                    {
                        lblClaves.Visible = true;
                        lblClaves.Text = "Las claves no coinciden.";
                    }
                }
            }
            catch (Exception ex)
            {
                Session["Error"] = ex.Message.ToString();
                Response.Redirect("ErrorPage.aspx");
            }

        }
    }
}

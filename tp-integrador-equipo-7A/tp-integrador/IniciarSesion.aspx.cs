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
using helpers;

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
                    if (usuario.Rol == 1)
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

        protected void btnRegistro_Click(object sender, EventArgs e)
        {
            Usuario usuario = new Usuario();
            UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
            Dueño dueño = new Dueño();
            DueñoNegocio dueñoNegocio = new DueñoNegocio();
            try
            {
                if (string.IsNullOrWhiteSpace(txtUsuarioRegistro.Text) ||
                    string.IsNullOrWhiteSpace(txtClaveRegistro.Text) ||
                    string.IsNullOrWhiteSpace(txtDni.Text) ||
                    string.IsNullOrWhiteSpace(txtNombre.Text) ||
                    string.IsNullOrWhiteSpace(txtApellido.Text) ||
                    string.IsNullOrWhiteSpace(txtTelefono.Text) ||
                    string.IsNullOrWhiteSpace(txtCorreo.Text) ||
                    string.IsNullOrWhiteSpace(txtDomicilio.Text))
                {
                    lblError.Text = "Todos los campos son obligatorios.";
                    lblError.Visible = true;
                    MostrarModalRegistro();
                    return;
                }

                try
                {
                    var email = new System.Net.Mail.MailAddress(txtCorreo.Text);
                }
                catch
                {
                    lblError.Text = "Correo electrónico inválido.";
                    lblError.Visible = true;
                    MostrarModalRegistro();
                    return;
                }

                if (txtClaveRegistro.Text.Length < 6)
                {
                    lblError.Text = "La contraseña debe tener al menos 6 caracteres.";
                    lblError.Visible = true;
                    MostrarModalRegistro();
                    return;
                }

                if (usuarioNegocio.ListarUnoTodos(txtUsuarioRegistro.Text).Count() > 0)
                {
                    lblError.Text = "Usuario existente.";
                    lblError.Visible = true;
                    MostrarModalRegistro();
                    return;
                }

                if (dueñoNegocio.listar(txtDni.Text).Count() > 0)
                {
                    lblError.Text = "DNI existente.";
                    lblError.Visible = true;
                    MostrarModalRegistro();
                    return;
                }


                usuario.User = txtUsuarioRegistro.Text;
                usuario.Pass = txtClaveRegistro.Text;
                usuario.Rol = 1;
                dueño.Dni = txtDni.Text;
                dueño.Usuario = txtUsuarioRegistro.Text;
                dueño.Nombre = txtNombre.Text;
                dueño.Apellido = txtApellido.Text;
                dueño.Telefono = txtTelefono.Text;
                dueño.Correo = txtCorreo.Text;
                dueño.Domicilio = txtDomicilio.Text;

                dueñoNegocio.Agregar(dueño, usuario);

                Session.Add("usuario", usuario);

                ScriptManager.RegisterStartupScript(this, this.GetType(), "registroExitoso", @"
    Swal.fire({
        title: '¡Registro exitoso!',
        text: 'Tu cuenta fue creada correctamente.',
        icon: 'success',
        confirmButtonText: 'Aceptar'
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = 'Dueño_PagPrincipal.aspx';
        }
    });
", true);
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        private void MostrarModalRegistro()
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "registroModal", "var myModal = new bootstrap.Modal(document.getElementById('modalRegistro')); myModal.show();", true);
        }

        protected void btnRecuperarClave_Click(object sender, EventArgs e)
        {
            DueñoNegocio dueñoNegocio = new DueñoNegocio();
            Dueño dueño = new Dueño();

            string contacto = txtCorreoUsuario.Text;
            string correo;
            string nombre;

            try
            {
                if (contacto != null)
                {
                    dueño = dueñoNegocio.listarPorUser(contacto)[0];
                    nombre = dueño.nombreCompleto();
                    correo = dueño.Correo;

                    Session.Add("contacto", contacto);
                    Servicios.enviarMailRecupero(correo, nombre);
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}
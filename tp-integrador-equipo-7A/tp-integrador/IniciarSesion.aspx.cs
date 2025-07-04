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
                    else if (usuario.Rol == 4)
                    {
                        Response.Redirect("Admin_PagPrincipal.aspx", false);
                    }
                }
                lblMensaje.Text = "Usuario o contraseña incorrecta.";
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Visible = true;
            }
            catch (Exception ex)
            {
                Session["Error"] = ex.Message.ToString();
                Response.Redirect("ErrorPage.aspx");
            }
        }
        protected void btnRegistro_Click(object sender, EventArgs e)
        {
            try
            {
                //Guardamos en un listado de TexBox todos los campos que necesitamos verificar si estan completos.
                List<TextBox> campos = new List<TextBox> { txtNombre, txtApellido, txtDni, txtTelefono, txtCorreo, txtDomicilio, txtClaveDueño, txtClaveDueñoConfirmada };

                //Funcion LINQ "All". En este caso pregunta si NO son nulos o tiene espcios en blanco.
                bool todosCompletos = campos.All(c => !string.IsNullOrWhiteSpace(c.Text));

                if (!todosCompletos)
                {
                    divAlerta.Visible = true;
                    lblValidacion_registroDueño.Text = "Restan campos por completar";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModal", "var modal = new bootstrap.Modal(document.getElementById('modalRegistrarDueño')); modal.show();", true);
                    return;
                }

                DueñoNegocio negocioDueño = new DueñoNegocio();
                Dueño nuevoDueño = negocioDueño.listar(txtDni.Text).Find(x => x.Dni == txtDni.Text);

                if (nuevoDueño != null)
                {
                    divAlerta.Visible = true;
                    lblValidacion_registroDueño.Text = "Ya existe Dueño registrado con el DNI: " + txtDni.Text;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModal", "var modal = new bootstrap.Modal(document.getElementById('modalRegistrarDueño')); modal.show();", true);
                    return;

                }

                if (txtClaveDueño.Text != txtClaveDueñoConfirmada.Text)
                {
                    divAlerta.Visible = true;
                    lblValidacion_registroDueño.Text = "Las contraseñas no coinciden.";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModal", "var modal = new bootstrap.Modal(document.getElementById('modalRegistrarDueño')); modal.show();", true);
                    return;
                }

                UsuarioNegocio negocioUsuario = new UsuarioNegocio();
                Usuario nuevoUsuario = new Usuario();
                nuevoDueño = new Dueño();

                nuevoDueño.Nombre = txtNombre.Text.Trim();
                nuevoDueño.Apellido = txtApellido.Text;
                nuevoDueño.Dni = txtDni.Text.Trim();
                nuevoDueño.Correo = txtCorreo.Text;
                nuevoDueño.Domicilio = txtDomicilio.Text;
                nuevoDueño.Telefono = txtTelefono.Text;


                // Para generarle un usuario con su primer nombre y los ultimos 3 digitos de su DNI
                //Obtenemos el primer nombre
                string primerNombre = nuevoDueño.Nombre.Split(' ')[0];

                //obtenemos los ultimos 3 digitos del DNI
                string ultimos3 = nuevoDueño.Dni.Length >= 3
                    ? nuevoDueño.Dni.Substring(nuevoDueño.Dni.Length - 3)
                    : nuevoDueño.Dni;  // Si el DNI tiene menos de 3 dígitos, devuelve lo que haya

                nuevoDueño.Usuario = primerNombre + ultimos3;
                nuevoUsuario.User = primerNombre + ultimos3;
                nuevoUsuario.Pass = txtClaveDueñoConfirmada.Text;
                nuevoUsuario.Rol = 1;

                // Registramos el Usuario del dueño en la Base de Datos.
                negocioUsuario.Agregar(nuevoUsuario);
                //Ahora podemos registrar el Dueño ya que el Usuario se encuentra registrado y es FK en Dueño.
                negocioDueño.AgregarDueño(nuevoDueño);

                ScriptManager.RegisterStartupScript(this, this.GetType(), "registroDueñoExitoso", @"
                Swal.fire({
                    title: '¡Registro exitoso!',
                    text: 'Sus datos han sido registrados exitosamente.',
                    icon: 'success',
                    confirmButtonText: 'Aceptar'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = 'IniciarSesion.aspx';
                    }
                });
            ", true);
            }
            catch (Exception ex)
            {
                Session["Error"] = ex.Message.ToString();
                Response.Redirect("ErrorPage.aspx");
            }
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

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "envioMail", @"
                            Swal.fire({
                                title: '¡Envio de correo!',
                                text: 'Se envío un mail a su correo registrado.',
                                icon: 'success',
                                confirmButtonText: 'Aceptar'
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    window.location.href = 'IniciarSesion.aspx';
                                }
                            });
                        ", true);
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
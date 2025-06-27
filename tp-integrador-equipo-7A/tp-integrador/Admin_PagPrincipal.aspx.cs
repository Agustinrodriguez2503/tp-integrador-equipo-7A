using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using dominio;
using helpers;
using negocio;

namespace tp_integrador
{
    public partial class Admin_PagPrincipal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
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

        protected void btnRegistroVeterinario_Click(object sender, EventArgs e)
        {
            try
            {
                //Guardamos en un listado de TexBox todos los campos que necesitamos verificar si estan completos.
                List<WebControl> controles = new List<WebControl> { txtNombreVet, txtApellidoVet, txtTelefonoVet, txtCorreoVet, txtDniVet, fuImagenVet, txtMatricula };

                //Funcion LINQ "All". En este caso pregunta si NO son nulos o tiene espcios en blanco.
                bool todosCompletos = controles.All(c =>
                {
                    if (c is TextBox tb)
                        return !string.IsNullOrWhiteSpace(tb.Text);
                    else if (c is FileUpload file)
                        return file.HasFile;

                    return true;
                });

                if (!todosCompletos)
                {
                    divAlertaVeterinario.Visible = true;
                    lblValidacion_registroVeterinario.Text = "Restan campos por completar";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModal", "var modal = new bootstrap.Modal(document.getElementById('modalAltaVeterinario')); modal.show();", true);
                    return;
                }

                VeterinarioNegocio negocioVeterinario = new VeterinarioNegocio();
                Veterinario nuevoVeterianario = negocioVeterinario.listar(txtMatricula.Text).Find(x => x.Matricula == txtMatricula.Text);

                if (nuevoVeterianario != null)
                {
                    divAlertaVeterinario.Visible = true;
                    lblValidacion_registroVeterinario.Text = "Ya existe un Veterinario registrado con la matricula: " + txtMatricula.Text;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModal", "var modal = new bootstrap.Modal(document.getElementById('modalAltaVeterinario')); modal.show();", true);
                    return;

                }

                //Guardar la Imagen
                string ruta = Server.MapPath("./Images/Veterinarios/");
                fuImagenVet.PostedFile.SaveAs(ruta + "perfil-" + txtMatricula.Text + ".jpg");

                UsuarioNegocio negocioUsuario = new UsuarioNegocio();
                Usuario nuevoUsuario = new Usuario();
                nuevoVeterianario = new Veterinario();

                nuevoVeterianario.Matricula = txtMatricula.Text;
                nuevoVeterianario.Dni = txtDniVet.Text;
                nuevoVeterianario.Nombre = txtNombreVet.Text;
                nuevoVeterianario.Apellido = txtApellidoVet.Text.Trim();
                nuevoVeterianario.Correo = txtCorreoVet.Text;
                nuevoVeterianario.Telefono = txtTelefonoVet.Text;
                nuevoVeterianario.Imagen = "perfil-" + txtMatricula.Text + ".jpg";

                // Para generarle un usuario con su primer nombre y los ultimos 3 digitos de su DNI
                //Obtenemos el primer nombre
                string primerApellido = nuevoVeterianario.Apellido.Split(' ')[0];

                //obtenemos los ultimos 3 digitos del DNI
                string ultimos3 = nuevoVeterianario.Dni.Length >= 3
                    ? nuevoVeterianario.Dni.Substring(nuevoVeterianario.Dni.Length - 3)
                    : nuevoVeterianario.Dni;  // Si el DNI tiene menos de 3 dígitos, devuelve lo que haya

                nuevoVeterianario.Usuario = primerApellido + ultimos3;
                nuevoUsuario.User = primerApellido + ultimos3;
                nuevoUsuario.Pass = txtDniVet.Text;
                nuevoUsuario.Rol = 3;

                // Registramos el Usuario del dueño en la Base de Datos.
                negocioUsuario.Agregar(nuevoUsuario);
                //Ahora podemos registrar el Dueño ya que el Usuario se encuentra registrado y es FK en Dueño.
                negocioVeterinario.Agregar(nuevoVeterianario);

                ScriptManager.RegisterStartupScript(this, this.GetType(), "registroExitoso",
                    "setTimeout(function() { Swal.fire({ icon: 'success', title: '¡Registrado!', " +
                    "text: 'El Veterinario fue registrado correctamente.' }); }, 300);", true);



            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        protected void btnRegistroRecepcionista_Click(object sender, EventArgs e)
        {
            try
            {
                //Guardamos en un listado de TexBox todos los campos que necesitamos verificar si estan completos.
                List<TextBox> campos = new List<TextBox> { txtNombreRec, txtApellidoRec, txtDniRec, txtTelefonoRec, txtCorreoRec };

                //Funcion LINQ "All". En este caso pregunta si NO son nulos o tiene espcios en blanco.
                bool todosCompletos = campos.All(c => !string.IsNullOrWhiteSpace(c.Text));

                if (!todosCompletos)
                {
                    divAlertaRecepcionista.Visible = true;
                    lblValidacion_registroRecepcionista.Text = "Restan campos por completar";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModal", "var modal = new bootstrap.Modal(document.getElementById('modalAltaRecepcionista')); modal.show();", true);
                    return;
                }

                RecepcionistaNegocio negocioRecep = new RecepcionistaNegocio();
                Recepcionista nuevoRecep = negocioRecep.listar(txtDniRec.Text).Find(x => x.DNI == txtDniRec.Text);

                if (nuevoRecep != null)
                {
                    divAlertaVeterinario.Visible = true;
                    lblValidacion_registroVeterinario.Text = "Ya existe un Recepcionista registrado con el DNI : " + txtDniRec.Text;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModal", "var modal = new bootstrap.Modal(document.getElementById('modalAltaRecepcionista')); modal.show();", true);
                    return;

                }

                UsuarioNegocio negocioUsuario = new UsuarioNegocio();
                Usuario nuevoUsuario = new Usuario();
                nuevoRecep = new Recepcionista();

                nuevoRecep.Nombre = txtNombreRec.Text;
                nuevoRecep.Apellido = txtApellidoRec.Text.Trim();
                nuevoRecep.DNI = txtDniRec.Text;
                nuevoRecep.Correo = txtCorreoRec.Text;
                nuevoRecep.Telefono = txtTelefonoRec.Text;

                // Para generarle un usuario con su primer nombre y los ultimos 3 digitos de su DNI
                // Obtenemos el primer nombre
                string primerApellido = nuevoRecep.Apellido.Split(' ')[0];

                //obtenemos los ultimos 3 digitos del DNI
                string ultimos3 = nuevoRecep.DNI.Length >= 3
                    ? nuevoRecep.DNI.Substring(nuevoRecep.DNI.Length - 3)
                    : nuevoRecep.DNI;  // Si el DNI tiene menos de 3 dígitos, devuelve lo que haya

                nuevoRecep.Usuario = primerApellido + ultimos3;
                nuevoUsuario.User = primerApellido + ultimos3;
                nuevoUsuario.Pass = txtDniRec.Text;
                nuevoUsuario.Rol = 2;

                // Registramos el Usuario del recepcionista en la Base de Datos.
                negocioUsuario.Agregar(nuevoUsuario);
                //Ahora podemos registrar el recepcionista ya que el Usuario se encuentra registrado y es FK en recepcionista.
                negocioRecep.Agregar(nuevoRecep);

                ScriptManager.RegisterStartupScript(this, this.GetType(), "registroExitoso",
                    "setTimeout(function() { Swal.fire({ icon: 'success', title: '¡Registrado!', " +
                    "text: 'El Recepcionista fue registrado correctamente.' }); }, 300);", true);

            }
            catch (Exception ex)
            {

                throw ex;
            }

        }
    }
}
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
    public partial class Dueño_PagPrincipal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!(Seguridad.sesionActiva(Session["usuario"])))
                Response.Redirect("IniciarSesion.aspx", false);

            if (Session["usuario"] != null)
            {
                try
                {
                    Mascota mascota = new Mascota();
                    MascotaNegocio mascotaNegocio = new MascotaNegocio();
                    DueñoNegocio dueñoNegocio = new DueñoNegocio();
                    Dueño dueño = new Dueño();

                    Usuario usuario = (Usuario)Session["usuario"];
                    dueño = dueñoNegocio.listarPorUser(usuario.User)[0];

                    lblBienvenido.Text = dueño.nombreCompleto();
                    gvMascotas.DataSource = mascotaNegocio.listar(dueño.Dni);
                    gvMascotas.DataBind();
                }
                catch (Exception ex)
                {

                    throw ex;
                }
            }
        }
        protected void btnRegistroMascota_Click(object sender, EventArgs e)
        {
            Mascota mascota = new Mascota();
            MascotaNegocio mascotaNegocio = new MascotaNegocio();
            DueñoNegocio dueñoNegocio = new DueñoNegocio();
            Dueño dueño = new Dueño();

            try
            {
                if (Session["usuario"] != null)
                {
                    Usuario usuario = (Usuario)Session["usuario"];
                    dueño = dueñoNegocio.listarPorUser(usuario.User)[0];

                    //Guardamos en un listado de TexBox todos los campos que necesitamos verificar si estan completos.
                    List<WebControl> controles = new List<WebControl> { txtNombreMascota, txtEdadMascota, txtFechaNacimientoMascota, txtPesoMascota, txtTipoMascota, txtRazaMascota, ddlSexoMascota };

                    //Funcion LINQ "All". En este caso pregunta si NO son nulos o tiene espcios en blanco y si el DDL seleccionó 1.
                    bool todosCompletos = controles.All(c =>
                    {
                        if (c is TextBox tb)
                            return !string.IsNullOrWhiteSpace(tb.Text);
                        else if (c is DropDownList ddl)
                            return ddl.SelectedIndex > 0;
                        return true;
                    });

                    if (!todosCompletos)
                    {
                        divAlertaMascota.Visible = true;
                        lblValidacion_registroMascota.Text = "Restan campos por completar";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModal", "var modal = new bootstrap.Modal(document.getElementById('modalAltaMascota')); modal.show();", true);
                        return;
                    }

                    mascota.DniDueño = dueño.Dni;
                    mascota.Nombre = txtNombreMascota.Text.Trim();
                    mascota.Edad = int.Parse(txtEdadMascota.Text);
                    mascota.FechaNacimiento = DateTime.Parse(txtFechaNacimientoMascota.Text);
                    mascota.Peso = decimal.Parse(txtPesoMascota.Text);
                    mascota.Tipo = txtTipoMascota.Text;
                    mascota.Raza = txtRazaMascota.Text;
                    mascota.Sexo = ddlSexoMascota.SelectedValue;

                    mascotaNegocio.Agregar(mascota);

                    gvMascotas.DataSource = mascotaNegocio.listar(dueño.Dni);
                    gvMascotas.DataBind();

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "modificacionMascotaExitosa", @"
                        Swal.fire({
                            title: '¡Alta de mascota exitosa.!',
                            text: 'Su mascota ha sido dada de alta exitosamente.',
                            icon: 'success',
                            confirmButtonText: 'Aceptar'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location.href = 'Dueño_PagPrincipal.aspx';
                            }
                        });
                    ", true);
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }  
        protected void btnModificar_Click(object sender, EventArgs e)
        {
            MascotaNegocio mascotaNegocio = new MascotaNegocio();
            try
            {
                LinkButton btn = (LinkButton)sender;
                int id = int.Parse(btn.CommandArgument);

                if (mascotaNegocio.listar_Uno_o_Todos(id).Count > 0)
                {
                    Mascota nueva = new Mascota();
                    nueva = mascotaNegocio.listar_Uno_o_Todos(id)[0];

                    txtNombreMascotaMod.Text = nueva.Nombre;
                    txtEdadMascotaMod.Text = nueva.Edad.ToString();
                    txtFechaNacimientoMascotaMod.Text = nueva.FechaNacimiento.ToString("yyyy-MM-dd");
                    txtPesoMascotaMod.Text = nueva.Peso.ToString();
                    txtTipoMascotaMod.Text = nueva.Tipo;
                    txtRazaMascotaMod.Text = nueva.Raza;
                    ddlSexoMascotaMod.SelectedValue = nueva.Sexo;

                    ViewState["IDMascotaModificacion"] = id;

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModal", "var modal = new bootstrap.Modal(document.getElementById('modalModificacionMascota')); modal.show();", true);
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }
        protected void btnGuardarMascota_Click(object sender, EventArgs e)
        {
            Mascota mascota = new Mascota();
            MascotaNegocio mascotaNegocio = new MascotaNegocio();

            try
            {
                int idMascota;
                if (ViewState["IDMascotaModificacion"] != null)
                {
                    idMascota = (int)ViewState["IDMascotaModificacion"];
                    mascota = mascotaNegocio.listar_Uno_o_Todos(idMascota)[0];

                    //Guardamos en un listado de TexBox todos los campos que necesitamos verificar si estan completos.
                    List<WebControl> controles = new List<WebControl> { txtNombreMascotaMod, txtEdadMascotaMod, txtFechaNacimientoMascotaMod, txtPesoMascotaMod, txtTipoMascotaMod, txtRazaMascotaMod, ddlSexoMascotaMod };

                    //Funcion LINQ "All". En este caso pregunta si NO son nulos o tiene espcios en blanco y si el DDL seleccionó 1.
                    bool todosCompletos = controles.All(c =>
                    {
                        if (c is TextBox tb)
                            return !string.IsNullOrWhiteSpace(tb.Text);
                        else if (c is DropDownList ddl)
                            return ddl.SelectedIndex > 0;
                        return true;
                    });

                    if (!todosCompletos)
                    {
                        divAlertaMascota.Visible = true;
                        lblValidacion_registroMascota.Text = "Restan campos por completar";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModal", "var modal = new bootstrap.Modal(document.getElementById('modalModificacionMascota')); modal.show();", true);
                        return;
                    }

                    mascota.Nombre = txtNombreMascotaMod.Text;
                    mascota.Edad = int.Parse(txtEdadMascotaMod.Text);
                    mascota.FechaNacimiento = DateTime.Parse(txtFechaNacimientoMascotaMod.Text);
                    mascota.Peso = decimal.Parse(txtPesoMascotaMod.Text);
                    mascota.Tipo = txtTipoMascotaMod.Text;
                    mascota.Raza = txtRazaMascotaMod.Text;
                    mascota.Sexo = ddlSexoMascotaMod.Text;
                    mascotaNegocio.Modificar(mascota);

                    Usuario usuario = (Usuario)Session["usuario"];
                    DueñoNegocio dueñoNegocio = new DueñoNegocio();
                    Dueño dueño = dueñoNegocio.listarPorUser(usuario.User)[0];

                    gvMascotas.DataSource = mascotaNegocio.listar(dueño.Dni);
                    gvMascotas.DataBind();

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "modificacionMascotaExitosa", @"
    Swal.fire({
        title: '¡Modificación exitosa!',
        text: 'Los datos de su mascota han sido actualizados exitosamente.',
        icon: 'success',
        confirmButtonText: 'Aceptar'
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = 'Dueño_PagPrincipal.aspx';
        }
    });
", true);

                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            MascotaNegocio mascotaNegocio = new MascotaNegocio();
            try
            {
                LinkButton btn = (LinkButton)sender;
                int id = int.Parse(btn.CommandArgument);

                if (id > 0)
                {
                    Mascota nueva = new Mascota();
                    mascotaNegocio.Eliminar(id);

                    Usuario usuario = (Usuario)Session["usuario"];
                    DueñoNegocio dueñoNegocio = new DueñoNegocio();
                    Dueño dueño = dueñoNegocio.listarPorUser(usuario.User)[0];

                    gvMascotas.DataSource = mascotaNegocio.listar(dueño.Dni);
                    gvMascotas.DataBind();
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        protected void datosCliente_Click(object sender, EventArgs e)
        {
            try
            {
                Dueño dueño = new Dueño();
                DueñoNegocio dueñoNegocio = new DueñoNegocio();
                if (Session["usuario"] != null)
                {
                    Usuario usuario = (Usuario)Session["usuario"];
                    dueño = dueñoNegocio.listarPorUser(usuario.User)[0];

                    txtNombre.Text = dueño.Nombre;
                    txtApellido.Text = dueño.Apellido;
                    txtTelefono.Text = dueño.Telefono;
                    txtCorreo.Text = dueño.Correo;
                    txtDomicilio.Text = dueño.Domicilio;
                    txtDni.Text = dueño.Dni;

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModalDatosCliente", "var modal = new bootstrap.Modal(document.getElementById('modalDatosCliente')); modal.show();", true);
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        protected void btnGuardarDatosCliente_Click(object sender, EventArgs e)
        {
            Dueño dueño = new Dueño();
            DueñoNegocio dueñoNegocio = new DueñoNegocio();
            try
            {
                if (Session["usuario"] != null)
                {
                    Usuario usuario = (Usuario)Session["usuario"];
                    dueño = dueñoNegocio.listarPorUser(usuario.User)[0];

                    //Guardamos en un listado de TexBox todos los campos que necesitamos verificar si estan completos.
                    List<TextBox> campos = new List<TextBox> { txtNombre, txtApellido, txtDni, txtTelefono, txtCorreo, txtDomicilio };

                    //Funcion LINQ "All". En este caso pregunta si NO son nulos o tiene espcios en blanco.
                    bool todosCompletos = campos.All(c => !string.IsNullOrWhiteSpace(c.Text));

                    if (!todosCompletos)
                    {
                        divAlertaMod.Visible = true;
                        lblValidacion_modificacionDueño.Text = "Restan campos por completar";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModal", "var modal = new bootstrap.Modal(document.getElementById('modalRegistrarDueño')); modal.show();", true);
                        return;
                    }

                    dueño.Nombre = txtNombre.Text.Trim();
                    dueño.Apellido = txtApellido.Text;
                    dueño.Telefono = txtTelefono.Text;
                    dueño.Domicilio = txtDomicilio.Text;
                    dueño.Correo = txtCorreo.Text;

                    // Modificamos el dueño.
                    dueñoNegocio.Modificar(dueño);


                    ScriptManager.RegisterStartupScript(this, this.GetType(), "modificacionExitosa", @"
                        Swal.fire({
                            title: '¡Modificación exitosa!',
                            text: 'Sus datos han sido actualizados exitosamente.',
                            icon: 'success',
                            confirmButtonText: 'Aceptar'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location.href = 'Dueño_PagPrincipal.aspx';
                            }
                        });
                    ", true);

                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        protected void btnTurno_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton btn = (LinkButton)sender;
                int idMascota = int.Parse(btn.CommandArgument);

                Session.Add("IDMascota", idMascota);
                Response.Redirect("Turnos.aspx", false);
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        protected void btnFicha_Click(object sender, EventArgs e)
        {
            Dueño dueño = new Dueño();
            DueñoNegocio dueñoNegocio = new DueñoNegocio();
            try
            {
                //PASAJE DNI
                if (Session["usuario"] != null)
                {
                    Usuario usuario = (Usuario)Session["usuario"];
                    dueño = dueñoNegocio.listarPorUser(usuario.User)[0];

                    string dni = dueño.Dni;
                    Session.Add("DniDueño", dni);
                    Response.Redirect("Veterinario_FichasMedicas.aspx", false);
                }

                //PASAJE IDMascota
                //LinkButton btn = (LinkButton)sender;
                //int idMascota = int.Parse(btn.CommandArgument);

                //Session.Add("IDMascota", idMascota);
                //Response.Redirect("Veterinario_FichasMedicas.aspx", false);


            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}

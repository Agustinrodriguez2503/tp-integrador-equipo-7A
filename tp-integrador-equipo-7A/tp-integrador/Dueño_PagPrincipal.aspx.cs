using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
using helpers;
using negocio;
using WebGrease;

namespace tp_integrador
{
    public partial class Dueño_PagPrincipal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!(Seguridad.sesionActiva(Session["usuario"])))
                    Response.Redirect("IniciarSesion.aspx", false);
                else
                {
                    try
                    {
                        Mascota mascota = new Mascota();
                        MascotaNegocio mascotaNegocio = new MascotaNegocio();
                        Dueño dueño = new Dueño();

                        dueño = devolverDueño();
                        List<Mascota> mascotas = mascotaNegocio.listar(dueño.Dni);

                        lblBienvenido.Text = dueño.nombreCompleto();


                        cargarMascotas(mascotas);
                        cargarTurnos();
                    }
                    catch (Exception ex)
                    {
                        Session["Error"] = ex.Message.ToString();
                        Response.Redirect("ErrorPage.aspx");
                    }
                }
            }
        }

        // CANCELAR TURNO
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            TurnoNegocio turnoNegocio = new TurnoNegocio();
            try
            {
                //LinkButton btn = (LinkButton)sender;
                //int idTurno = Convert.ToInt32(btn.CommandArgument);

                int idTurno = (int)Session["IDTurnoEliminar"];

                turnoNegocio.modificarEstado(idTurno, "CANCELADO");
                cargarTurnos();

                string titulo = "¡Cancelación exitosa!";
                string mensaje = "El turno ha sido cancelado correctamente.";

                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertaExito", $@"
            Swal.fire({{
                title: '{titulo}',
                text: '{mensaje}',
                icon: 'success',
                confirmButtonText: 'Aceptar'
            }}).then((result) => {{
                if (result.isConfirmed) {{
                    window.location.href = 'Dueño_PagPrincipal.aspx';
                }}
            }});", true);
            }
            catch (Exception ex)
            {
                Session["Error"] = ex.Message.ToString();
                Response.Redirect("ErrorPage.aspx");
            }
        }
        protected void btnCancelar_Command(object sender, CommandEventArgs e)
        {
            int idTurnoEliminar = Convert.ToInt32(e.CommandArgument);
            Session["IDTurnoEliminar"] = idTurnoEliminar;

            ScriptManager.RegisterStartupScript(this, this.GetType(), "modalCancelar", "var modal = new bootstrap.Modal(document.getElementById('modalCancelarTurno')); modal.show();", true);
        }
        // REGISTRO DE MASCOTA
        protected void btnRegistroMascota_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["usuario"] == null)
                    return;

                Dueño dueño = new Dueño();
                dueño = devolverDueño();
                MascotaNegocio mascotaNegocio = new MascotaNegocio();
                Mascota mascota;

                bool esModificacion = ViewState["IDMascotaModificacion"] != null;

                List<WebControl> controles = new List<WebControl>
                {
                    txtNombreMascota,
                    txtEdadMascota,
                    txtFechaNacimientoMascota,
                    txtPesoMascota,
                    txtTipoMascota,
                    txtRazaMascota,
                    ddlSexoMascota
                };

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

                // Cargar mascota (nueva o existente)
                if (esModificacion)
                {
                    int idMascota = (int)ViewState["IDMascotaModificacion"];
                    mascota = mascotaNegocio.listar_Uno_o_Todos(idMascota)[0];
                }
                else
                {
                    mascota = new Mascota();
                    mascota.DniDueño = dueño.Dni;
                }

                // Cargar datos comunes
                mascota.Nombre = txtNombreMascota.Text.Trim();
                mascota.Edad = int.Parse(txtEdadMascota.Text);
                mascota.FechaNacimiento = DateTime.Parse(txtFechaNacimientoMascota.Text);
                mascota.Peso = decimal.Parse(txtPesoMascota.Text);
                mascota.Tipo = txtTipoMascota.Text;
                mascota.Raza = txtRazaMascota.Text;
                mascota.Sexo = ddlSexoMascota.SelectedValue;

                // Alta o modificación
                if (esModificacion)
                    mascotaNegocio.Modificar(mascota);
                else
                    mascotaNegocio.Agregar(mascota);

                // Refrescar grilla
                cargarMascotas(mascotaNegocio.listar(dueño.Dni));

                // Mensaje de éxito
                string titulo = esModificacion ? "¡Modificación exitosa!" : "¡Alta de mascota exitosa!";
                string mensaje = esModificacion ? "Los datos de su mascota han sido actualizados." : "La mascota ha sido registrada correctamente.";

                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertaExito", $@"
            Swal.fire({{
                title: '{titulo}',
                text: '{mensaje}',
                icon: 'success',
                confirmButtonText: 'Aceptar'
            }}).then((result) => {{
                if (result.isConfirmed) {{
                    window.location.href = 'Dueño_PagPrincipal.aspx';
                }}
            }});", true);

            }
            catch (Exception ex)
            {
                Session["Error"] = ex.Message.ToString();
                Response.Redirect("ErrorPage.aspx");
            }
        }
        // CARGA DE DATOS PARA MODIFICAR MASCOTA
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

                    txtNombreMascota.Text = nueva.Nombre;
                    txtEdadMascota.Text = nueva.Edad.ToString();
                    txtFechaNacimientoMascota.Text = nueva.FechaNacimiento.ToString("yyyy-MM-dd");
                    txtPesoMascota.Text = nueva.Peso.ToString();
                    txtTipoMascota.Text = nueva.Tipo;
                    txtRazaMascota.Text = nueva.Raza;
                    ddlSexoMascota.SelectedValue = nueva.Sexo;

                    ViewState["IDMascotaModificacion"] = id;

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModal", "var modal = new bootstrap.Modal(document.getElementById('modalAltaMascota')); modal.show();", true);
                }
            }
            catch (Exception ex)
            {
                Session["Error"] = ex.Message.ToString();
                Response.Redirect("ErrorPage.aspx");
            }

        }
        // ELIMINAR MASCOTA
        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            MascotaNegocio mascotaNegocio = new MascotaNegocio();
            TurnoNegocio turnoNegocio = new TurnoNegocio();
            try
            {
                //LinkButton btn = (LinkButton)sender;
                //int id = int.Parse(btn.CommandArgument);
                int idMascota = (int)Session["IDMascotaEliminar"];

                if (idMascota > 0)
                {
                    if (turnoNegocio.listar("PENDIENTE", idMascota).Count == 0)
                    {
                        Mascota nueva = new Mascota();
                        mascotaNegocio.Eliminar(idMascota);

                        Usuario usuario = (Usuario)Session["usuario"];
                        DueñoNegocio dueñoNegocio = new DueñoNegocio();
                        Dueño dueño = dueñoNegocio.listarPorUser(usuario.User)[0];

                        cargarMascotas(mascotaNegocio.listar(dueño.Dni));
                        string titulo = "¡Eliminación Exitosa!";
                        string mensaje = "La mascota fue eliminada correctamente.";

                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertaExito", $@"
                Swal.fire({{
                    title: '{titulo}',
                    text: '{mensaje}',
                    icon: 'success',
                    confirmButtonText: 'Aceptar'
                }}).then((result) => {{
                    if (result.isConfirmed) {{
                        window.location.href = 'Dueño_PagPrincipal.aspx';
                    }}
                }});", true);
                    }
                    else
                    {
                        string titulo = "¡No se pudo eliminar la mascota!";
                        string mensaje = "La mascota que intenta eliminar tiene turnos pendientes.";

                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertaError", $@"
                Swal.fire({{
                    title: '{titulo}',
                    text: '{mensaje}',
                    icon: 'error',
                    confirmButtonText: 'Aceptar'
                }}).then((result) => {{
                    if (result.isConfirmed) {{
                        window.location.href = 'Dueño_PagPrincipal.aspx';
                    }}
                }});", true);
                    }
                }
            }
            catch (Exception ex)
            {
                Session["Error"] = ex.Message.ToString();
                Response.Redirect("ErrorPage.aspx");
            }
        }
        protected void btnEliminar_Command(object sender, CommandEventArgs e)
        {
            int idMascota = Convert.ToInt32(e.CommandArgument);
            Session["IDMascotaEliminar"] = idMascota;

            ScriptManager.RegisterStartupScript(this, this.GetType(), "modalEliminar", "var modal = new bootstrap.Modal(document.getElementById('modalConfirmarEliminar')); modal.show();", true);
        }
        // CARGA DE DATOS PARA MODIFICAR CLIENTE
        protected void datosCliente_Click(object sender, EventArgs e)
        {
            try
            {
                Dueño dueño = new Dueño();
                dueño = devolverDueño();

                txtNombre.Text = dueño.Nombre;
                txtApellido.Text = dueño.Apellido;
                txtTelefono.Text = dueño.Telefono;
                txtCorreo.Text = dueño.Correo;
                txtDomicilio.Text = dueño.Domicilio;
                txtDni.Text = dueño.Dni;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModalDatosCliente", "var modal = new bootstrap.Modal(document.getElementById('modalDatosCliente')); modal.show();", true);

            }
            catch (Exception ex)
            {
                Session["Error"] = ex.Message.ToString();
                Response.Redirect("ErrorPage.aspx");
            }
        }
        // MODIFICACION DE CLIENTE
        protected void btnGuardarDatosCliente_Click(object sender, EventArgs e)
        {
            Dueño dueño = new Dueño();
            DueñoNegocio dueñoNegocio = new DueñoNegocio();
            try
            {
                dueño = devolverDueño();

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
            catch (Exception ex)
            {
                Session["Error"] = ex.Message.ToString();
                Response.Redirect("ErrorPage.aspx");
            }
        }
        // REDIRECCIÓN A TURNOS
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

                Session["Error"] = ex.Message.ToString();
                Response.Redirect("ErrorPage.aspx");
            }
        }
        // REDIRECCIÓN A FICHAS
        protected void btnFicha_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;

            try
            {
                int idMascota = int.Parse(btn.CommandArgument);

                Session.Add("IDMascota", idMascota);
                Response.Redirect("Veterinario_FichasMedicas.aspx", false);

                //mando por url el id de la mascota

                //int idMascota = int.Parse(btn.CommandArgument);

                //Response.Redirect($"Veterinario_FichasMedicas.aspx?idMascota={idMascota}");

            }
            catch (Exception ex)
            {
                Session["Error"] = ex.Message.ToString();
                Response.Redirect("ErrorPage.aspx");
            }
        }
        // DEVOLVER EL DUEÑO QUE INICIO SESIÓN
        protected Dueño devolverDueño()
        {
            Dueño dueño = new Dueño();
            DueñoNegocio dueñoNegocio = new DueñoNegocio();
            if (Session["usuario"] != null)
            {
                Usuario usuario = (Usuario)Session["usuario"];
                dueño = dueñoNegocio.listarPorUser(usuario.User)[0];

                return dueño;
            }
            return null;
        }
        // CARGAR TARJETAS CON TURNOS PROXIMOS
        private void cargarTurnos()
        {
            Dueño dueño = devolverDueño();

            TurnoNegocio turnoNegocio = new TurnoNegocio();
            List<Turno> turnos = turnoNegocio.listarTurnosConMascotaYVeterinario(dueño.Dni, "PENDIENTE");

            if (turnos.Count > 0)
            {
                repProximosTurnos.DataSource = turnos;
                repProximosTurnos.DataBind();

                lblCantidadTurnos.Text = $"Turnos pendientes: {turnos.Count}";
                lblCantidadTurnos.Visible = true;
            }
            else
            {
                repProximosTurnos.DataSource = null;
                repProximosTurnos.DataBind();

                lblCantidadTurnos.Text = "Usted no tiene turnos pendientes.";
                lblCantidadTurnos.Visible = true;
            }

        }
        // CARGAR GRILLA CON MASCOTAS
        private void cargarMascotas(List<Mascota> mascotas)
        {
            if (mascotas.Count > 0)
            {
                gvMascotas.DataSource = mascotas;
                gvMascotas.DataBind();
            }
            else
            {
                lblCantidadMascotas.Text = "Usted no tiene mascotas registradas.";
                lblCantidadMascotas.Visible = true;
            }

        }


    }
}

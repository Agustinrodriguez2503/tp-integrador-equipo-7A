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
        public bool FiltroAvanzado { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            FiltroAvanzado = chkAvanzado.Checked;
            if (!IsPostBack)
            {
                //if (!(Seguridad.sesionActiva(Session["usuario"])) || (!Seguridad.isAdmin(Session["usuario"])))
                //    Response.Redirect("IniciarSesion.aspx", false);
                //else
                //{
                try
                {
                    VeterinarioNegocio veterinarioNegocio = new VeterinarioNegocio();
                    RecepcionistaNegocio recepcionistaNegocio = new RecepcionistaNegocio();
                    DueñoNegocio dueñoNegocio = new DueñoNegocio();
                    Session.Add("listaVeterinarios", veterinarioNegocio.listar());
                    Session.Add("listaRecepcionistas", recepcionistaNegocio.listar());
                    Session.Add("listaDueños", dueñoNegocio.listar());


                    gvVeterinarios.DataSource = Session["listaVeterinarios"];
                    gvVeterinarios.DataBind();

                    gvRecepcionistas.DataSource = Session["listaRecepcionistas"];
                    gvRecepcionistas.DataBind();

                    gvDueños.DataSource = Session["listaDueños"];
                    gvDueños.DataBind();

                }
                catch (Exception ex)
                {

                    throw ex;
                }
                //}

            }

        }



        protected void btnRegistroVeterinario_Click(object sender, EventArgs e)
        {
            try
            {
                //Guardamos en un listado de TexBox todos los campos que necesitamos verificar si estan completos.
                List<TextBox> controles = new List<TextBox> { txtNombreVet, txtApellidoVet, txtTelefonoVet, txtCorreoVet, txtDniVet, txtImagenVet, txtMatricula };

                //Funcion LINQ "All". En este caso pregunta si NO son nulos o tiene espcios en blanco.
                bool todosCompletos = controles.All(c => !string.IsNullOrWhiteSpace(c.Text));


                if (!todosCompletos)
                {
                    divAlertaVeterinario.Visible = true;
                    lblValidacion_registroVeterinario.Text = "Restan campos por completar";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModal", "var modal = new bootstrap.Modal(document.getElementById('modalAltaVeterinario')); modal.show();", true);
                    return;
                }

                VeterinarioNegocio negocioVeterinario = new VeterinarioNegocio();
                Veterinario nuevoVeterianario = negocioVeterinario.listar(txtMatricula.Text).Find(x => x.Matricula == txtMatricula.Text);


                string modificarVet = ViewState["modificarVet"].ToString();
                if (modificarVet != "Modificar")
                {
                    if (nuevoVeterianario != null)
                    {
                        divAlertaVeterinario.Visible = true;
                        lblValidacion_registroVeterinario.Text = "Ya existe un Veterinario registrado con la matricula: " + txtMatricula.Text;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModal", "var modal = new bootstrap.Modal(document.getElementById('modalAltaVeterinario')); modal.show();", true);
                        return;

                    }
                }



                UsuarioNegocio negocioUsuario = new UsuarioNegocio();
                Usuario nuevoUsuario = new Usuario();
                nuevoVeterianario = new Veterinario();

                nuevoVeterianario.Matricula = txtMatricula.Text;
                nuevoVeterianario.Dni = txtDniVet.Text;
                nuevoVeterianario.Nombre = txtNombreVet.Text;
                nuevoVeterianario.Apellido = txtApellidoVet.Text.Trim();
                nuevoVeterianario.Correo = txtCorreoVet.Text;
                nuevoVeterianario.Telefono = txtTelefonoVet.Text;
                nuevoVeterianario.Imagen = txtImagenVet.Text;

                if (modificarVet != "Modificar")
                {
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
                }


                //Ahora podemos registrar el Dueño ya que el Usuario se encuentra registrado y es FK en Dueño.
                if (modificarVet == "Modificar")
                {
                    negocioVeterinario.Modificar(nuevoVeterianario);

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "modificacionExitosa",
                    "Swal.fire({" +
                    "    icon: 'success'," +
                    "    title: '¡Modificado!'," +
                    "    text: 'El Veterinario fue modificado correctamente.'," +
                    "    showConfirmButton: true," +
                    //"    timer: 1500" +             // la alerta se cierra automáticamente después de 1.5 segundos
                    "}).then(function() {" +
                    "    window.location.href = 'Admin_PagPrincipal.aspx';" +
                    "});", true);
                }
                else
                {
                    negocioVeterinario.Agregar(nuevoVeterianario);

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "registroExitoso",
                    "setTimeout(function() { Swal.fire({ icon: 'success', title: '¡Registrado!', " +
                    "text: 'El Veterinario fue registrado correctamente.' }); }, 300);", true);
                }



            }
            catch (Exception ex)
            {

                throw ex;
            }

        }
        protected void btnModificarVet_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string matricula = btn.CommandArgument;
            string accion = btn.CommandName;
            ViewState["modificarVet"] = accion;

            if (matricula != null)
            {
                if (accion == "Modificar")
                {
                    VeterinarioNegocio veterinarioNegocio = new VeterinarioNegocio();
                    List<Veterinario> listaVeterinario = veterinarioNegocio.listar(matricula);
                    Veterinario modificar = listaVeterinario[0];

                    txtNombreVet.Text = modificar.Nombre;
                    txtApellidoVet.Text = modificar.Apellido;
                    txtDniVet.Text = modificar.Dni;
                    txtTelefonoVet.Text = modificar.Telefono;
                    txtCorreoVet.Text = modificar.Correo;
                    txtImagenVet.Text = modificar.Imagen;
                    txtMatricula.Text = matricula;

                    btnRegistroVeterinario.Text = "Modificar Veterinario";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModal", "var modal = new bootstrap.Modal(document.getElementById('modalAltaVeterinario')); modal.show();", true);
                }


            }
        }
        protected void btnHabilitarVet_Click(object sender, EventArgs e)
        {
            VeterinarioNegocio veterinarioNegocio = new VeterinarioNegocio();
            try
            {
                LinkButton btn = (LinkButton)sender;
                string matricula = btn.CommandArgument;
                string accion = btn.CommandName;

                if (matricula != null)
                {
                    if (accion == "Habilitar")
                        veterinarioNegocio.Habilitar_O_Eliminar(matricula, 1);
                    else if (accion == "Eliminar")
                        veterinarioNegocio.Habilitar_O_Eliminar(matricula);

                    gvVeterinarios.DataSource = veterinarioNegocio.listar();
                    gvVeterinarios.DataBind();
                }
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

                string modificarRec = ViewState["modificarRec"].ToString();
                if (modificarRec != "Modificar")
                {
                    if (nuevoRecep != null)
                    {
                        divAlertaVeterinario.Visible = true;
                        lblValidacion_registroVeterinario.Text = "Ya existe un Recepcionista registrado con el DNI : " + txtDniRec.Text;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModal", "var modal = new bootstrap.Modal(document.getElementById('modalAltaRecepcionista')); modal.show();", true);
                        return;
                    }
                }


                UsuarioNegocio negocioUsuario = new UsuarioNegocio();
                Usuario nuevoUsuario = new Usuario();
                nuevoRecep = new Recepcionista();

                nuevoRecep.Nombre = txtNombreRec.Text;
                nuevoRecep.Apellido = txtApellidoRec.Text.Trim();
                nuevoRecep.DNI = txtDniRec.Text;
                nuevoRecep.Correo = txtCorreoRec.Text;
                nuevoRecep.Telefono = txtTelefonoRec.Text;

                if (modificarRec != "Modificar")
                {
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
                }

                //Ahora podemos registrar el Dueño ya que el Usuario se encuentra registrado y es FK en Dueño.
                if (modificarRec == "Modificar")
                {
                    negocioRecep.Modificar(nuevoRecep);

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "modificacionExitosa",
                    "Swal.fire({" +
                    "    icon: 'success'," +
                    "    title: '¡Modificado!'," +
                    "    text: 'El Recepcionista fue modificado correctamente.'," +
                    "    showConfirmButton: true," +
                    //"    timer: 1500" +             // la alerta se cierra automáticamente después de 1.5 segundos
                    "}).then(function() {" +
                    "    window.location.href = 'Admin_PagPrincipal.aspx';" +
                    "});", true);
                }
                else
                {
                    negocioRecep.Agregar(nuevoRecep);

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "registroExitoso",
                    "setTimeout(function() { Swal.fire({ icon: 'success', title: '¡Registrado!', " +
                    "text: 'El Recepcionista fue registrado correctamente.' }); }, 300);", true);
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }
        protected void btnModificarRec_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string dni = btn.CommandArgument;
            string accion = btn.CommandName;
            ViewState["modificarRec"] = accion;

            if (dni != null)
            {
                if (accion == "Modificar")
                {
                    RecepcionistaNegocio recepcionistaNegocio = new RecepcionistaNegocio();
                    List<Recepcionista> listaRecepcionista = recepcionistaNegocio.listar(dni);
                    Recepcionista modificar = listaRecepcionista[0];

                    txtNombreRec.Text = modificar.Nombre;
                    txtApellidoRec.Text = modificar.Apellido;
                    txtDniRec.Text = modificar.DNI;
                    txtTelefonoRec.Text = modificar.Telefono;
                    txtCorreoRec.Text = modificar.Correo;

                    btnRegistroRecepcionista.Text = "Modificar Recepcionista";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModal", "var modal = new bootstrap.Modal(document.getElementById('modalAltaRecepcionista')); modal.show();", true);
                }


            }
        }
        protected void btnHabilitarRec_Click(object sender, EventArgs e)
        {
            RecepcionistaNegocio recepcionistaNegocio = new RecepcionistaNegocio();
            try
            {
                LinkButton btn = (LinkButton)sender;
                int legajo = int.Parse(btn.CommandArgument);
                string accion = btn.CommandName;

                if (legajo != 0)
                {
                    if (accion == "Habilitar")
                        recepcionistaNegocio.Habilitar_O_Eliminar(legajo, 1);
                    else if (accion == "Eliminar")
                        recepcionistaNegocio.Habilitar_O_Eliminar(legajo);

                    gvRecepcionistas.DataSource = recepcionistaNegocio.listar();
                    gvRecepcionistas.DataBind();
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        protected void btnRegistroDueño_Click(object sender, EventArgs e)
        {
            try
            {
                //Guardamos en un listado de TexBox todos los campos que necesitamos verificar si estan completos.
                List<TextBox> campos = new List<TextBox> { txtNombre, txtApellido, txtDni, txtTelefono, txtCorreo, txtDomicilio };

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

                string modificarDueño = ViewState["modificarDue"].ToString();
                if (modificarDueño != "Modificar")
                {
                    if (modificarDueño != null)
                    {
                        divAlerta.Visible = true;
                        lblValidacion_registroDueño.Text = "Ya existe un Dueño registrado con el DNI : " + txtDni.Text;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModal", "var modal = new bootstrap.Modal(document.getElementById('modalRegistrarDueño')); modal.show();", true);
                        return;
                    }
                }


                UsuarioNegocio negocioUsuario = new UsuarioNegocio();
                Usuario nuevoUsuario = new Usuario();
                nuevoDueño = new Dueño();

                nuevoDueño.Nombre = txtNombre.Text;
                nuevoDueño.Apellido = txtApellido.Text.Trim();
                nuevoDueño.Dni = txtDni.Text;
                nuevoDueño.Correo = txtCorreo.Text;
                nuevoDueño.Telefono = txtTelefono.Text;
                nuevoDueño.Domicilio = txtDomicilio.Text;

                if (modificarDueño != "Modificar")
                {
                    // Para generarle un usuario con su primer nombre y los ultimos 3 digitos de su DNI
                    // Obtenemos el primer nombre
                    string primerApellido = nuevoDueño.Apellido.Split(' ')[0];

                    //obtenemos los ultimos 3 digitos del DNI
                    string ultimos3 = nuevoDueño.Dni.Length >= 3
                        ? nuevoDueño.Dni.Substring(nuevoDueño.Dni.Length - 3)
                        : nuevoDueño.Dni;  // Si el DNI tiene menos de 3 dígitos, devuelve lo que haya

                    nuevoDueño.Usuario = primerApellido + ultimos3;
                    nuevoUsuario.User = primerApellido + ultimos3;
                    nuevoUsuario.Pass = txtDni.Text;
                    nuevoUsuario.Rol = 1;

                    // Registramos el Usuario del recepcionista en la Base de Datos.
                    negocioUsuario.Agregar(nuevoUsuario);
                }

                //Ahora podemos registrar el Dueño ya que el Usuario se encuentra registrado y es FK en Dueño.
                if (modificarDueño == "Modificar")
                {
                    negocioDueño.Modificar(nuevoDueño);

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "modificacionExitosa",
                    "Swal.fire({" +
                    "    icon: 'success'," +
                    "    title: '¡Modificado!'," +
                    "    text: 'El Dueño fue modificado correctamente.'," +
                    "    showConfirmButton: true," +
                    //"    timer: 1500" +             // la alerta se cierra automáticamente después de 1.5 segundos
                    "}).then(function() {" +
                    "    window.location.href = 'Admin_PagPrincipal.aspx';" +
                    "});", true);
                }
                else
                {
                    negocioDueño.AgregarDueño(nuevoDueño);

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "registroExitoso",
                    "setTimeout(function() { Swal.fire({ icon: 'success', title: '¡Registrado!', " +
                    "text: 'El Dueño fue registrado correctamente.' }); }, 300);", true);
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        protected void btnModificarDueño_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string dni = btn.CommandArgument;
            string accion = btn.CommandName;
            ViewState["modificarDue"] = accion;

            if (dni != null)
            {
                if (accion == "Modificar")
                {
                    DueñoNegocio dueñoaNegocio = new DueñoNegocio();
                    List<Dueño> listaDueño = dueñoaNegocio.listar(dni);
                    Dueño modificar = listaDueño[0];

                    txtNombre.Text = modificar.Nombre;
                    txtApellido.Text = modificar.Apellido;
                    txtDni.Text = modificar.Dni;
                    txtTelefono.Text = modificar.Telefono;
                    txtCorreo.Text = modificar.Correo;
                    txtDomicilio.Text = modificar.Domicilio;

                    btnRegistroDueño.Text = "Modificar Dueño";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModal", "var modal = new bootstrap.Modal(document.getElementById('modalRegistrarDueño')); modal.show();", true);
                }
            }
        }
        protected void btnHabilitarDueño_Click(object sender, EventArgs e)
        {
            DueñoNegocio dueñoNegocio = new DueñoNegocio();
            UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
            try
            {
                LinkButton btn = (LinkButton)sender;
                string dni = btn.CommandArgument;
                string accion = btn.CommandName;

                if (dni != null)
                {
                    if (accion == "Habilitar")
                    {
                        dueñoNegocio.Habilitar_O_Eliminar(dni, 1);
                        usuarioNegocio.Habilitar_O_Eliminar(dueñoNegocio.listar(dni)[0].Usuario, 1);
                    }
                    else if (accion == "Eliminar")
                    {
                        dueñoNegocio.Habilitar_O_Eliminar(dni);
                        usuarioNegocio.Habilitar_O_Eliminar(dueñoNegocio.listar(dni)[0].Usuario);
                    }
                        

                    gvDueños.DataSource = dueñoNegocio.listar();
                    gvDueños.DataBind();
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        protected void txtFiltroDueño_TextChanged(object sender, EventArgs e)
        {
            List<Dueño> dueños = (List<Dueño>)Session["listaDueños"];
            List<Dueño> dueñoFiltrados = dueños.FindAll(x => x.Apellido.ToUpper().Contains(txtFiltroDueño.Text.ToUpper()));

            gvDueños.DataSource = dueñoFiltrados;
            gvDueños.DataBind();

        }

        protected void chkAvanzado_CheckedChanged(object sender, EventArgs e)
        {
            FiltroAvanzado = chkAvanzado.Checked;
            txtFiltroDueño.Enabled = !FiltroAvanzado;

        }

        protected void txtFiltroRec_TextChanged(object sender, EventArgs e)
        {
            List<Recepcionista> recepcionistas  = (List<Recepcionista>)Session["listaRecepcionistas"];
            List<Recepcionista> recepcionistasFiltrados = recepcionistas.FindAll(x => x.Apellido.ToUpper().Contains(txtFiltroRec.Text.ToUpper()));

            gvRecepcionistas.DataSource = recepcionistasFiltrados;
            gvRecepcionistas.DataBind();
        }

        protected void txtFiltroVet_TextChanged(object sender, EventArgs e)
        {
            List<Veterinario> veterinarios = (List<Veterinario>)Session["listaVeterinarios"];
            List<Veterinario> veterinariosFiltrados = veterinarios.FindAll(x => x.Apellido.ToUpper().Contains(txtFiltroVet.Text.ToUpper()));

            gvVeterinarios.DataSource = veterinariosFiltrados;
            gvVeterinarios.DataBind();
        }


        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                DueñoNegocio dueñoNegocio = new DueñoNegocio();
                gvDueños.DataSource = dueñoNegocio.Filtrar(ddlCampo.SelectedItem.ToString(), 
                    ddlCriterio.SelectedItem.ToString(), 
                    txtFiltroAvanzado.Text, 
                    ddlEstado.SelectedItem.ToString());
                gvDueños.DataBind();
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}
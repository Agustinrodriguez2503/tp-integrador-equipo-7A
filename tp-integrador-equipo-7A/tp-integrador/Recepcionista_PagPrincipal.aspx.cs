using System;
using System.Collections;
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
    public partial class Recepcionista_PagPrincipal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //RecepcionistaNegocio negocioRecepcionista = new RecepcionistaNegocio();
            //Usuario usuario = (Usuario)Session["usuario"];
            //Recepcionista seleccionado = negocioRecepcionista.buscarRecepcionista_Usuario(usuario.User);
            //recepcionista.InnerText = seleccionado.nombreCompleto();

            //if (!(Seguridad.sesionActiva(Session["usuario"])))
            //    Response.Redirect("IniciarSesion.aspx", false);
        }

        protected void txtDueño_TextChanged(object sender, EventArgs e)
        {
            MascotaNegocio negocioMascota = new MascotaNegocio();

            try
            {
                string dniDueño = txtDueño.Text;
                List<Mascota> mascotas = new List<Mascota>();
                mascotas = negocioMascota.listar(dniDueño);
                lbl_ddlMascotas.Visible = false;
                btnBuscarTurno.Enabled = false;
                ddlMascota.Items.Clear();

                if (!FuncionesGenericas.validaTexto(txtDueño.Text))
                {
                    lblDniNoValido.Text = "Ingrese el DNI del dueño de la mascota.";
                    lblDniNoValido.Visible = true;
                    return;
                }

                if (mascotas != null && mascotas.Count > 0)
                {
                    ddlMascota.Enabled = true;
                    ddlMascota.DataSource = mascotas;
                    ddlMascota.DataTextField = "Nombre";
                    ddlMascota.DataValueField = "IdMascota";
                    ddlMascota.DataBind();
                    ddlMascota.Items.Insert(0, new ListItem("-- Seleccione una mascota --", ""));
                    lblDniNoValido.Visible = false;
                }
                else
                {
                    lblDniNoValido.Text = "El DNI ingresado no pertenece a un Dueño registrado.";
                    lblDniNoValido.Visible = true;
                    ddlMascota.Enabled = false;
                }



            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        protected void btnTurnos_Click(object sender, EventArgs e)
        {
            panelRegistrar.Visible = false;
            upPanelTurnos.Visible = true;
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            panelRegistrar.Visible = true;
            upPanelTurnos.Visible = false;

        }
       
        
        
        protected void btnBuscarTurno_Click(object sender, EventArgs e)
        {

            if (ddlMascota.SelectedItem != null && !string.IsNullOrEmpty(ddlMascota.SelectedItem.Value))
            {
                int idMascota = int.Parse(ddlMascota.SelectedItem.Value);
                Session["IDMascota"] = idMascota;
                Response.Redirect("Turnos.aspx", false);

            }

            lbl_ddlMascotas.Visible = true;
        }

        protected void ddlMascota_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnBuscarTurno.Enabled = true;
            lbl_ddlMascotas.Visible = false;

        }


        protected void btnRegistrarDueño_Click(object sender, EventArgs e)
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

                if (nuevoDueño != null)
                {
                    divAlerta.Visible = true;
                    lblValidacion_registroDueño.Text = "Ya existe Dueño registrado con el DNI: " + txtDni.Text;
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
                nuevoUsuario.Pass = txtDni.Text;
                nuevoUsuario.Rol = 1;

                // Registramos el Usuario del dueño en la Base de Datos.
                negocioUsuario.Agregar(nuevoUsuario);
                //Ahora podemos registrar el Dueño ya que el Usuario se encuentra registrado y es FK en Dueño.
                negocioDueño.AgregarDueño(nuevoDueño);

                ScriptManager.RegisterStartupScript(this, this.GetType(), "registroExitoso",
                    "setTimeout(function() { Swal.fire({ icon: 'success', title: '¡Registrado!', " +
                    "text: 'El dueño fue registrado correctamente.' }); }, 300);", true);

            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        protected void btnAgregarMascota_Click(object sender, EventArgs e)
        {
            txtBuscarMascota.Visible = true;
            btnBuscarMascota.Visible = true;
        }


        protected void btnBuscarMascota_Click(object sender, EventArgs e)
        {
            DueñoNegocio negocioDueño = new DueñoNegocio();
            Dueño dueñoEncontrado = new Dueño();
            dueñoEncontrado = negocioDueño.listar(txtBuscarMascota.Text).Find(x => x.Dni == txtBuscarMascota.Text);

            if (dueñoEncontrado == null)
            {
                lblInfoBuscarMascota.Text = "El DNI ingresado no pertenece a un dueño registrado.";
                lblInfoBuscarMascota.Visible = true;
                return;
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModal", "var modal = new bootstrap.Modal(document.getElementById('modalAltaMascota')); modal.show();", true);

        }

        protected void txtBuscarMascota_TextChanged(object sender, EventArgs e)
        {
            lblInfoBuscarMascota.Visible = false;
        }

        protected void btnRegistroMascota_Click(object sender, EventArgs e)
        {
            try
            {

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
                MascotaNegocio negocioMascota = new MascotaNegocio();
                Mascota nuevaMascota = new Mascota();

                nuevaMascota.DniDueño = txtBuscarMascota.Text;
                nuevaMascota.Nombre = txtNombreMascota.Text;
                nuevaMascota.Edad = int.Parse(txtEdadMascota.Text);
                nuevaMascota.FechaNacimiento = DateTime.Parse(txtFechaNacimientoMascota.Text);
                nuevaMascota.Peso = decimal.Parse(txtPesoMascota.Text);
                nuevaMascota.Tipo = txtTipoMascota.Text;
                nuevaMascota.Raza = txtRazaMascota.Text;
                nuevaMascota.Sexo = ddlSexoMascota.SelectedValue;

                negocioMascota.Agregar(nuevaMascota);

                ScriptManager.RegisterStartupScript(this, this.GetType(), "modificacionMascotaExitosa", @"
                        Swal.fire({
                            title: '¡Alta de mascota exitosa!',
                            text: 'Su mascota ha sido dada de alta exitosamente.',
                            icon: 'success',
                            confirmButtonText: 'Aceptar'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location.href = 'Recepcionista_PagPrincipal.aspx';
                            }
                        });
                    ", true);


            }
            catch (Exception ex)
            {

                throw ex;
            }
            
        }
    }
}
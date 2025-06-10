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

                    lblBienvenido.Text = dueño.Nombre + " " + dueño.Apellido;
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

                    mascota.DniDueño = dueño.Dni;
                    mascota.Nombre = txtNombreMascota.Text;
                    mascota.Edad = int.Parse(txtEdadMascota.Text);
                    mascota.FechaNacimiento = DateTime.Parse(txtFechaNacimientoMascota.Text);
                    mascota.Peso = decimal.Parse(txtPesoMascota.Text);
                    mascota.Tipo = txtTipoMascota.Text;
                    mascota.Raza = txtRazaMascota.Text;
                    mascota.Sexo = ddlSexoMascota.Text;

                    mascotaNegocio.Agregar(mascota);

                    gvMascotas.DataSource = mascotaNegocio.listar(dueño.Dni);
                    gvMascotas.DataBind();
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

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModal", "abrirModalModificacionMascota();", true);
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

                    mascota.Nombre = txtNombreMascotaMod.Text;
                    mascota.Edad = int.Parse(txtEdadMascotaMod.Text);
                    mascota.FechaNacimiento = DateTime.Parse(txtFechaNacimientoMascotaMod.Text);
                    mascota.Peso = int.Parse(txtPesoMascotaMod.Text);
                    mascota.Tipo = txtTipoMascotaMod.Text;
                    mascota.Raza = txtRazaMascotaMod.Text;
                    mascota.Sexo = ddlSexoMascotaMod.Text;
                    mascotaNegocio.Modificar(mascota);

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

    }
}

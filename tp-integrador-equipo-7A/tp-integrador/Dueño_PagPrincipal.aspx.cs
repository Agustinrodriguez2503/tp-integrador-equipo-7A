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

            if (!(IsPostBack))
            {
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
                    dueño = dueñoNegocio.listar(usuario.User)[0];

                    mascota.DniDueño = dueño.Dni;
                    mascota.Nombre = txtNombreMascota.Text;
                    mascota.Edad = int.Parse(txtEdadMascota.Text);
                    mascota.FechaNacimiento = DateTime.Parse(txtFechaNacimientoMascota.Text);
                    mascota.Peso = decimal.Parse(txtPesoMascota.Text);
                    mascota.Tipo = txtTipoMascota.Text;
                    mascota.Raza = txtRazaMascota.Text;
                    mascota.Sexo = ddlSexoMascota.Text;

                    mascotaNegocio.Agregar(mascota);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
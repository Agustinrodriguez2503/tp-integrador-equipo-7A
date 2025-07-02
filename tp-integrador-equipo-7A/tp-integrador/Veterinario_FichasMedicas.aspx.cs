using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
using helpers;
using Microsoft.Ajax.Utilities;
using negocio;

namespace tp_integrador
{

    public partial class Veterinario_FichasMedicas : System.Web.UI.Page
    {
        public List<Ficha> listaFichas { get; set; }
        public List<Dueño> listaDueños { get; set; }
        public List<Mascota> listaMascotas { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!(Seguridad.sesionActiva(Session["usuario"])))
                Response.Redirect("IniciarSesion.aspx", false);

            //if (!IsPostBack)
            //{
            btnRegistrarVisita.Visible = false;

            //if (Request.QueryString["idTurno"] != null && Request.QueryString["idMascota"] != null)
            if (Request.QueryString["idMascota"] != null)
            {
                btnBuscar.Visible = false;

                string idMascotaString = Request.QueryString["idMascota"];
                int idMascota = Convert.ToInt32(idMascotaString);
                ViewState["IDMascota"] = idMascota;

                //En el caso de que se acceda desde Veterinarios_TurnosPendientes guardamos el idTurno
                if (Request.QueryString["idTurno"] != null)
                {
                    string idTurnoString = Request.QueryString["idTurno"];
                    int idTurno = Convert.ToInt32(idTurnoString);
                    ViewState["IDTurno"] = idTurno;
                    btnRegistrarVisita.Visible = true;
                    btnDescargarPDF.Visible = false;
                }

                FichaNegocio dni = new FichaNegocio();
                string dniDueño = dni.buscarDueño(idMascota);

                MascotaNegocio negocioMascota = new MascotaNegocio();
                listaMascotas = negocioMascota.listar(dniDueño);
                Mascota DatosMascota = listaMascotas.FirstOrDefault(m => m.IDMascota == idMascota);

                FichaNegocio negocio = new FichaNegocio();
                listaFichas = negocio.listarFichasPorMascota(dniDueño, idMascota);
                Ficha fichaSeleccionada = listaFichas.FirstOrDefault();

                DueñoNegocio negocioDueño = new DueñoNegocio();
                listaDueños = negocioDueño.listar(dniDueño);
                Dueño DatosDueño = listaDueños.FirstOrDefault();

                //Datos Mascota
                lblNombre.Text = DatosMascota.Nombre;
                lblEdad.Text = DatosMascota.Edad.ToString();
                lblSexo.Text = DatosMascota.Sexo;
                lblTipo.Text = DatosMascota.Tipo;
                lblPeso.Text = DatosMascota.Peso.ToString();
                lblRaza.Text = DatosMascota.Raza;

                //Datos Dueño
                lblNombreDueño.Text = DatosDueño.Nombre;
                lblApellidoDueño.Text = DatosDueño.Apellido;
                lblTelefonoDueño.Text = DatosDueño.Telefono.ToString();
                lblCorreoDueño.Text = DatosDueño.Correo;

                txtFiltroFicha.Text = dniDueño;
                ddlFiltroFicha.SelectedItem.Text = DatosMascota.Nombre;

                txtFiltroFicha.Enabled = false;
                ddlFiltroFicha.Enabled = false;
            }
            //}
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {

            try
            {
                string textoIngresado = txtFiltroFicha.Text.Trim();


                if (!ddlFiltroFicha.SelectedValue.IsNullOrWhiteSpace())
                {
                    if (string.IsNullOrEmpty(textoIngresado))
                    {
                        txtFiltroFicha.Focus();
                        lblNombre.Text = "";
                        lblEdad.Text = "";
                        lblSexo.Text = "";
                        lblTipo.Text = "";
                        lblPeso.Text = "";
                        lblRaza.Text = "";
                        lblNombreDueño.Text = "";
                        lblApellidoDueño.Text = "";
                        lblTelefonoDueño.Text = "";
                        lblCorreoDueño.Text = "";
                    }
                    else
                    {
                        MascotaNegocio negocioMascota = new MascotaNegocio();
                        listaMascotas = negocioMascota.listar(txtFiltroFicha.Text);
                        int idMascotaSeleccionado;
                        bool parseSuccess = int.TryParse(ddlFiltroFicha.SelectedValue, out idMascotaSeleccionado);
                        Mascota DatosMascota = listaMascotas.FirstOrDefault(m => m.IDMascota == idMascotaSeleccionado);

                        FichaNegocio negocio = new FichaNegocio();
                        listaFichas = negocio.listarFichasPorMascota(txtFiltroFicha.Text, idMascotaSeleccionado);
                        Ficha fichaSeleccionada = listaFichas.FirstOrDefault();

                        DueñoNegocio negocioDueño = new DueñoNegocio();
                        listaDueños = negocioDueño.listar(txtFiltroFicha.Text);
                        Dueño DatosDueño = listaDueños.FirstOrDefault();

                        //Datos Mascota
                        lblNombre.Text = DatosMascota.Nombre;
                        lblEdad.Text = DatosMascota.Edad.ToString();
                        lblSexo.Text = DatosMascota.Sexo;
                        lblTipo.Text = DatosMascota.Tipo;
                        lblPeso.Text = DatosMascota.Peso.ToString();
                        lblRaza.Text = DatosMascota.Raza;

                        //Datos Dueño
                        lblNombreDueño.Text = DatosDueño.Nombre;
                        lblApellidoDueño.Text = DatosDueño.Apellido;
                        lblTelefonoDueño.Text = DatosDueño.Telefono.ToString();
                        lblCorreoDueño.Text = DatosDueño.Correo;
                    }
                }
            }
            catch (Exception)
            {

                throw;
            }
        }

        protected void txtFiltroFicha_TextChanged(object sender, EventArgs e)
        {

            if (Request.QueryString["idTurno"] == null && Request.QueryString["idMascota"] == null)
            {
                MascotaNegocio negocioMascota = new MascotaNegocio();
                listaMascotas = negocioMascota.listar(txtFiltroFicha.Text);

                lblNombre.Text = "";
                lblEdad.Text = "";
                lblSexo.Text = "";
                lblTipo.Text = "";
                lblPeso.Text = "";
                lblRaza.Text = "";
                lblNombreDueño.Text = "";
                lblApellidoDueño.Text = "";
                lblTelefonoDueño.Text = "";
                lblCorreoDueño.Text = "";
                ddlFiltroFicha.Items.Clear();
                ddlFiltroFicha.Items.Add(new ListItem("Filtrar por Mascota...", ""));

                if (listaMascotas != null && listaMascotas.Any())
                {
                    foreach (dominio.Mascota mascota in listaMascotas)
                    {
                        ddlFiltroFicha.Items.Add(new ListItem(mascota.Nombre, mascota.IDMascota.ToString()));
                    }
                }
            }
        }

        protected void btnRegistrarVisita_Click(object sender, EventArgs e)
        {
            txtDescripcionVisita.Text = string.Empty;
            upModalRegistrar.Update();

            string script = "Sys.Application.add_load(function() { " +
                            $"    $('#{modalRegistrarVisita.ClientID}').modal('show'); " +
                            "});";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModalScript", script, true);

        }

        protected void btnGuardarVisita_Click(object sender, EventArgs e)
        {
            int idTurno = (int)ViewState["IDTurno"];
            string descripcion = txtDescripcionVisita.Text;

            //Agrego una nueva visita a la ficha de la mascota seleccionada
            FichaNegocio fichaNegocio = new FichaNegocio();
            fichaNegocio.Agregar(idTurno, descripcion);

            //Cambio el estado del turno seleccionado a "REALIZADO"
            TurnoNegocio turnoNegocio = new TurnoNegocio();
            turnoNegocio.modificarEstado(idTurno, "REALIZADO");

            Response.Redirect("Veterinario_TurnosPendientes.aspx");
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {

            Usuario usuario = (Usuario)Session["usuario"];

            //Si accediò desde turnospendientes "Iniciar", que devuelva al usuario a turnospendientes
            if ((Request.QueryString["idTurno"] != null && Request.QueryString["idMascota"] != null) && (usuario.Rol == 3))
                Response.Redirect("Veterinario_TurnosPendientes.aspx");

            //Si no accedió desde turnospendientes, ver que tipo de usuario es

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

        protected void btnDescargarPDF_Click(object sender, EventArgs e)
        {
            if (ViewState["IDMascota"] != null)
            {
                int idMascota = (int)ViewState["IDMascota"];

                FichaNegocio fichaNegocio = new FichaNegocio();
                string dniDueño = fichaNegocio.buscarDueño(idMascota);

                MascotaNegocio mascotaNegocio = new MascotaNegocio();
                Mascota mascota = mascotaNegocio.listar(dniDueño).FirstOrDefault(m => m.IDMascota == idMascota);

                DueñoNegocio dueñoNegocio = new DueñoNegocio();
                Dueño dueño = dueñoNegocio.listar(dniDueño).FirstOrDefault();

                List<Ficha> historial = fichaNegocio.listarFichasPorMascota(dniDueño, idMascota);

                if (mascota != null && dueño != null)
                {
                    //Generar el PDF
                    byte[] pdfBytes = Servicios.GenerarPdfHistorialMascota(mascota, dueño, historial);

                    //Enviar el PDF al navegador para descarga
                    Response.Clear();
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("content-disposition", $"attachment;filename=Ficha_{mascota.Nombre.Replace(" ", "_")}.pdf");
                    Response.BinaryWrite(pdfBytes);
                    Response.End();
                }
            }
        }

    }
}
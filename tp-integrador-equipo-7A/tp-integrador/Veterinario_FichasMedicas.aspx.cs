using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
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

            //if (!IsPostBack)
            //{
            btnRegistrarVisita.Visible = false;
            if (Request.QueryString["idTurno"] != null && Request.QueryString["idMascota"] != null)
            {
                btnRegistrarVisita.Visible = true;
                btnBuscar.Visible = false;
                string idTurnoString = Request.QueryString["idTurno"];
                string idMascotaString = Request.QueryString["idMascota"];
                int idTurno = Convert.ToInt32(idTurnoString);
                int idMascota = Convert.ToInt32(idMascotaString);

                FichaNegocio dni = new FichaNegocio();
                string dniDueño = dni.buscarDueño(idMascota);

                MascotaNegocio negocioMascota = new MascotaNegocio();
                listaMascotas = negocioMascota.listar(dniDueño);
                //int idMascotaSeleccionado;
                //bool parseSuccess = int.TryParse(ddlFiltroFicha.SelectedValue, out idMascota);
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

            // CORREGIDO: Usamos Sys.Application.add_load para garantizar que el script
            // se ejecute después de que el UpdatePanel haya terminado su actualización.
            // Esto resuelve los problemas de timing con el modal de Bootstrap.
            string script = "Sys.Application.add_load(function() { " +
                            $"    $('#{modalRegistrarVisita.ClientID}').modal('show'); " +
                            "});";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModalScript", script, true);

        }

        protected void btnGuardarVisita_Click(object sender, EventArgs e)
        {
            // Aquí va la lógica para guardar la nueva visita en la base de datos.

            // 1. Recuperar los IDs que guardamos en el Page_Load.
            int idTurno = (int)ViewState["IDTurno"];
            int idMascota = (int)ViewState["IDMascota"];
            string descripcion = txtDescripcionVisita.Text;

            // 2. Crear un objeto Visita o llamar a tu capa de negocio para guardarlo.
            // VisitaNegocio negocio = new VisitaNegocio();
            // negocio.RegistrarNuevaVisita(idTurno, idMascota, descripcion, DateTime.Now);

            // 3. Opcional: Actualizar el GridView del historial.
            // CargarHistorial(idMascota);
            // upHistorial.Update(); // Suponiendo que el GridView esté en un UpdatePanel llamado "upHistorial".

            // 4. Script para cerrar el modal.
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Hide", "$('#modalRegistrarVisita').modal('hide');", true);
        }
    }
}
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
            if (!IsPostBack)
            {
                //    FichaNegocio negocio = new FichaNegocio();
                //    listaFichas = negocio.listarFiltroPorDNI("x");


                //lblNombre.Text = "";
                //lblEdad.Text = "";
                //lblSexo.Text = "";
                //lblTipo.Text = "";
                //lblPeso.Text = "";
                //lblRaza.Text = "";
                //lblNombreDueño.Text = "";
                //lblTelefonoDueño.Text = "";
                //lblCorreoDueño.Text = "";
            }
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
}
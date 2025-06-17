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
    public partial class Turnos : System.Web.UI.Page
    {
        public List<Veterinario> listaVeterinario { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                VeterinarioNegocio negocioVeterinario = new VeterinarioNegocio();
                listaVeterinario = negocioVeterinario.listar();
                repVeterinarios.DataSource = listaVeterinario;
                repVeterinarios.DataBind();

            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        protected void seleccionarVeterinario_Command(object sender, CommandEventArgs e)
        {
            TurnoNegocio negocioTurnos = new TurnoNegocio();
            FuncionesGenericas generarTurnos = new FuncionesGenericas();
            string matricula = e.CommandArgument.ToString();

            List<Turno> turnosOcupados = negocioTurnos.listar_turnosOcupados(matricula);
            List<DateTime> turnosDisponibles = generarTurnos.generarTurnosPosibles();
            List<DateTime> turnosMostrar = generarTurnos.generarTurnosPosibles();

            foreach (Turno turnoOcupado in turnosOcupados)
            {
                foreach (DateTime turnoDisponible in turnosDisponibles)
                {
                    if (turnoOcupado.FechaHora == turnoDisponible)
                    {
                        turnosMostrar.Remove(turnoDisponible);
                    }

                }


            }
            Session["TurnosMostrar"] = turnosMostrar;

            var fuente = turnosMostrar.Select(t => new { Turno = t }).ToList();
            dgvTurnos.DataSource = fuente;
            dgvTurnos.DataBind();


        }

        protected void dgvTurnos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            List<DateTime> turnos = Session["TurnosMostrar"] as List<DateTime>;
            if (turnos != null)
            {
                var fuente = turnos.Select(t => new { Turno = t }).ToList();
                dgvTurnos.DataSource = fuente;
                dgvTurnos.DataBind();
            }
            dgvTurnos.PageIndex = e.NewPageIndex;
            dgvTurnos.DataBind();
        }

        protected void dgvTurnos_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
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
                if (!(Seguridad.sesionActiva(Session["usuario"])))
                {
                    Response.Redirect("IniciarSesion.aspx", false);
                    return;
                }
                VeterinarioNegocio negocioVeterinario = new VeterinarioNegocio();
                listaVeterinario = negocioVeterinario.listar();
                repVeterinarios.DataSource = listaVeterinario;
                repVeterinarios.DataBind();

            }
            catch (Exception ex)
            {

                Session["Error"] = ex.Message.ToString();
                Response.Redirect("ErrorPage.aspx");

            }

        }

        protected void seleccionarVeterinario_Command(object sender, CommandEventArgs e)
        {

            try
            {
                TurnoNegocio negocioTurnos = new TurnoNegocio();
                FuncionesGenericas generarTurnos = new FuncionesGenericas();
                string matricula = e.CommandArgument.ToString();



                List<Turno> turnosOcupados = negocioTurnos.listar_turnosOcupados(matricula, "PENDIENTE");
                List<DateTime> turnosDisponibles = generarTurnos.generarTurnosPosibles();
                List<DateTime> turnosMostrar = generarTurnos.generarTurnosPosibles();

                VeterinarioNegocio negocioVeterinario = new VeterinarioNegocio();
                Veterinario vet = negocioVeterinario.listar(matricula).FirstOrDefault();
                if (vet != null)
                {
                    litTituloTurnos.Text = $"Seleccioná la fecha y horario del turno con <strong style='color:#000;'>{vet.nombreCompleto()}</strong>";


                }

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
                Session["VeteSeleccionado"] = matricula;

                var fuente = turnosMostrar.Select(t => new { Turno = t }).ToList();
                dgvTurnos.DataSource = fuente;
                dgvTurnos.DataBind();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "scrollTurnos",
                    "document.getElementById('seccionTurnos').scrollIntoView({ behavior: 'smooth' });", true);

            }
            catch (Exception ex)
            {
                Session["Error"] = ex.Message.ToString();
                Response.Redirect("ErrorPage.aspx");
            }



        }

        protected void dgvTurnos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
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
            catch (Exception ex)
            {
                Session["Error"] = ex.Message.ToString();
                Response.Redirect("ErrorPage.aspx");
            }
        }

        protected void dgvTurnos_SelectedIndexChanged(object sender, EventArgs e)
        {

            try
            {
                Turno turnoSeleccionado = new Turno();
                turnoSeleccionado.FechaHora = (DateTime)dgvTurnos.SelectedDataKey.Value;
                turnoSeleccionado.Mascota = new Mascota();

                if (Session["IDMascota"] == null)
                {
                    Session["Error"] = "No se encuentra logueado, inicie sesión por favor.";
                    Response.Redirect("ErrorPage.aspx", false);
                    return;
                }
                turnoSeleccionado.Mascota.IDMascota = (int)Session["IDMascota"];
                turnoSeleccionado.MatriculaVeterinario = (string)Session["VeteSeleccionado"];

                MascotaNegocio negocioMascota = new MascotaNegocio();
                Mascota mascotaSeleccionada = negocioMascota.listar_Uno_o_Todos(turnoSeleccionado.Mascota.IDMascota)[0];

                VeterinarioNegocio negocioVeterinario = new VeterinarioNegocio();
                Veterinario veterinarioSeleccionado = negocioVeterinario.listar(turnoSeleccionado.MatriculaVeterinario)[0];

                string mensajeJS = $"<strong>{mascotaSeleccionada.Nombre}</strong> tiene un turno para el <strong>{turnoSeleccionado.FechaHora:dddd dd/MM/yyyy - HH:mm}</strong> con el Vet. <strong>{veterinarioSeleccionado.nombreCompleto()}</strong>.";

                //Verificamos que el turno seleccionado no se encuentre CANCELADO
                TurnoNegocio negocioTurno = new TurnoNegocio();
                List<Turno> verificarTurno = negocioTurno.listarTurno_porVetyFecha(turnoSeleccionado.MatriculaVeterinario, turnoSeleccionado.FechaHora);

                if (verificarTurno != null && verificarTurno.Any())
                {
                    turnoSeleccionado.IdTurno = verificarTurno[0].IdTurno;
                    negocioTurno.modificarTurno(turnoSeleccionado);
                }
                else
                {
                    negocioTurno.Agregar(turnoSeleccionado);

                }




                Usuario usuario = (Usuario)Session["usuario"];
                ScriptManager.RegisterStartupScript(this, this.GetType(), "registroExitoso",
                        $@"Swal.fire({{
                    title: '¡Turno Registrado!',
                    html: '{mensajeJS}',
                    imageUrl: 'https://cdn-icons-png.flaticon.com/512/616/616408.png',
                    imageWidth: 80,
                    imageHeight: 80,
                    imageAlt: 'Icono Huellita',
                    confirmButtonText: 'Ir al inicio',
                    confirmButtonColor: '#20c997',
                    background: '#f8f9fa',
                    color: '#343a40',
                    backdrop: `
                        rgba(0,0,0,0.2)
                        left top
                        no-repeat
                    `,
                    customClass: {{
                        popup: 'rounded-4 shadow-lg'
                    }}
                }}).then(function() {{
                    window.location.href = '{(usuario.Rol == 1 ? "Dueño_PagPrincipal.aspx" : "Recepcionista_PagPrincipal.aspx")}';
                }});", true);




            }
            catch (Exception ex)
            {
                Session["Error"] = ex.Message.ToString();
                Response.Redirect("ErrorPage.aspx");
            }

        }
    }
}
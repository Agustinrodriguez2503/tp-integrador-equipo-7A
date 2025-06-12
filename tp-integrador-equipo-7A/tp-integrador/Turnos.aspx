<%@ Page Title="" Language="C#" MasterPageFile="~/RecepcionistaMasterPage.Master" AutoEventWireup="true" CodeBehind="Turnos.aspx.cs" Inherits="tp_integrador.Turnos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .card-selectable {
            transition: transform 0.2s ease, box-shadow 0.3s ease;
            cursor: pointer;
            border: 2px solid transparent;
        }

            .card-selectable:hover {
                transform: translateY(-4px);
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
            }

            .card-selectable.selected {
                border: 2px solid #0d6efd; /* azul Bootstrap */
                box-shadow: 0 0 0 4px rgba(13, 110, 253, 0.25);
            }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--    <div class="container mt-5 px-4">
        <div class="row g-4">
            <% foreach (dominio.Veterinario vete in listaVeterinario)
                { %>
            <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                <div class="card h-100 shadow border-0 rounded-4 overflow-hidden">
                    <img src="<%: vete.Imagen %>" class="card-img-top img-fluid" alt="Veterinario" style="height: 250px; object-fit: cover;">
                    <div class="card-body text-center">
                        <h5 class="card-title fw-semibold mb-1"><%: vete.nombreCompleto() %></h5>
                        <p class="card-text text-muted mb-0">Matrícula: <%: vete.Matricula %></p>
                    </div>
                </div>
            </div>
            <% } %>
        </div>

        <div class="row justify-content-center mt-4">
            <div class="col-auto">
                <div class="btn-group">
                    <button class="btn btn-outline-secondary btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Opciones
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#">Ver Todos</a></li>
                        <li><a class="dropdown-item" href="#">Ordenar por nombre</a></li>
                        <li><a class="dropdown-item" href="#">Filtrar por especialidad</a></li>
                    </ul>
                </div>
            </div>

            <div class="col-auto">
                <div class="btn-group">
                    <button class="btn btn-outline-secondary btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Más acciones
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#">Agregar nuevo</a></li>
                        <li><a class="dropdown-item" href="#">Exportar listado</a></li>
                        <li><a class="dropdown-item" href="#">Ayuda</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>--%>

    <!-- Contenedor principal con margen superior -->
    <div class="container mt-5 px-4">

        <!-- Título -->
        <div class="row mb-4">
            <div class="col text-center">
                <h2 class="fw-bold">Seleccioná un Veterinario</h2>
                <p class="text-muted">Elegí un profesional para ver sus turnos disponibles</p>
            </div>
        </div>

        <!-- Cards de veterinarios -->
        <div class="row g-4" id="veterinarios">
            <!-- CARD DE EJEMPLO -->
            <% foreach (dominio.Veterinario vete in listaVeterinario)
                { %>
            <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                <div class="card card-selectable h-100 shadow border-0 rounded-4 overflow-hidden">
                    <img src="<%: vete.Imagen %>" class="card-img-top img-fluid" alt="Veterinario" style="height: 250px; object-fit: cover;">
                    <div class="card-body text-center">
                        <h5 class="card-title fw-semibold mb-1"><%: vete.nombreCompleto() %></h5>
                        <p class="card-text text-muted mb-0">Matrícula: <%: vete.Matricula %></p>
                    </div>
                </div>
            </div>
            <% } %>

        </div>

        <!-- Turnos disponibles (placeholder visual) -->
        <div class="row mt-5" id="turnosDisponibles">
            <div class="col">
                <h4 class="fw-semibold mb-3">Turnos disponibles</h4>
                <ul class="list-group">
                    <li class="list-group-item">Lunes 10/06 - 10:00 hs</li>
                    <li class="list-group-item">Miércoles 12/06 - 15:30 hs</li>
                    <li class="list-group-item">Viernes 14/06 - 09:00 hs</li>
                </ul>
            </div>
        </div>
    </div>



</asp:Content>

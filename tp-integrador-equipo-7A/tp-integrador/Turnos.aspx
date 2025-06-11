<%@ Page Title="" Language="C#" MasterPageFile="~/RecepcionistaMasterPage.Master" AutoEventWireup="true" CodeBehind="Turnos.aspx.cs" Inherits="tp_integrador.Turnos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="row row-cols-1 row-cols-md-3 g-4">

    <% foreach (dominio.Veterinario vete in listaVeterinario)
        { %>

        <div class="col">
            <div class="card h-100 shadow-sm border-0 rounded-4 overflow-hidden">
                <img src="<%: vete.Imagen %>" class="card-img-top img-fluid" alt="Veterinario" style="height: 250px; object-fit: cover;">
                <div class="card-body text-center">
                    <h5 class="card-title fw-bold mb-2"><%: vete.nombreCompleto() %></h5>
                    <p class="card-text text-muted">Matrícula: <%: vete.Matricula %></p>
                </div>
            </div>
        </div>

    <% } %>

</div>

</asp:Content>

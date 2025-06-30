<%@ Page Title="" Language="C#" MasterPageFile="~/PaginaPrincipalMasterPage.Master" AutoEventWireup="true" CodeBehind="ErrorPage.aspx.cs" Inherits="tp_integrador.ErrorPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="container d-flex justify-content-center align-items-center" style="min-height: 80vh;">
        <div class="card shadow p-4 rounded-4 text-center" style="max-width: 600px; width: 100%;">
            <img src="/Images/Error.png" alt="Error" class="img-fluid mb-4" style="max-height: 300px;" />
            <h2 class="mb-3 text-dark fw-bold">¡Uy! Algo salió mal...</h2>
            <asp:Label ID="lblMensajeError" runat="server" CssClass="text-danger fs-5 fw-semibold d-block mb-4"
                Text="Se produjo un error inesperado."></asp:Label>
            <a href="PaginaPrincipal.aspx" class="btn btn-outline-primary px-4 rounded-pill">Volver al inicio</a>
        </div>
    </div>
</asp:Content>

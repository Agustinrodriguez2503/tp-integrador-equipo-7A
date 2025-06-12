<%@ Page Title="" Language="C#" MasterPageFile="~/PaginaPrincipalMasterPage.Master" AutoEventWireup="true" CodeBehind="Dueño_RecuperoPassword.aspx.cs" Inherits="tp_integrador.Dueño_RecuperoPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5" style="max-width: 500px;">
        <h3 class="fw-bold text-center">Cambio de contraseña</h3>
        <p class="text-muted text-center">Ingrese su nueva clave y confírmela.</p>

        <asp:Panel runat="server">
            <asp:TextBox ID="txtNuevaClave" runat="server" CssClass="form-control mb-3" TextMode="Password" placeholder="Nueva clave"></asp:TextBox>
            <asp:TextBox ID="txtConfirmarClave" runat="server" CssClass="form-control mb-3" TextMode="Password" placeholder="Confirmar clave"></asp:TextBox>
            <asp:Label ID="lblClaves" runat="server" Visible="false" color="red"></asp:Label>

            <asp:Button ID="btnGuardarClave" runat="server" Text="Guardar nueva clave" CssClass="btn btn-success w-100 fw-bold" OnClick="btnGuardarClave_Click" />
        </asp:Panel>
    </div>
</asp:Content>

<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="tp_integrador._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="mb-3">
        <label for="exampleInputEmail1" class="form-label">Ingrese su DNI aqui para consultar por mascota:</label>
        <asp:TextBox runat="server" class="form-control" ID="tbxDNI"></asp:TextBox>
    </div>
    <asp:Button runat="server" Text="Button" ID="btnDNI" class="btn btn-primary" OnClick="btnDNI_Click" />

    <asp:GridView ID="gdvMascotas" runat="server" CssClass="table">

    </asp:GridView>

</asp:Content>

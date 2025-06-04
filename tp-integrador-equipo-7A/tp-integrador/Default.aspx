<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="tp_integrador._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" ONCLICK="btnBuscar_Click"/>

    <asp:GridView ID="GridView1" runat="server">

    </asp:GridView>

</asp:Content>

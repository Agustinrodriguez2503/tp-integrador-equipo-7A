<%@ Page Title="" Language="C#" MasterPageFile="~/PaginaPrincipalMasterPage.Master" AutoEventWireup="true" CodeBehind="IniciarSesion.aspx.cs" Inherits="tp_integrador.IniciarSesion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="banner mt-3"></div>
    <div class="row mt-5">
        <div class="col-3"></div>
        <div class="col-6">
            <div class="p-4 bg-white shadow rounded">
                <div class="mb-3">
                    <label for="txtCodigo" class="form-label">Ingrese el código:</label>
                    <asp:TextBox ID="txtCodigo" runat="server" CssClass="form-control"></asp:TextBox>
                    <div id="divAlerta" runat="server" class="alert alert-warning alerta-chica" visible="false">
                        Ingrese un código, por favor.
                    </div>
                </div>
            </div>
        </div>
        <div class="col-3"></div>
    </div>
</asp:Content>

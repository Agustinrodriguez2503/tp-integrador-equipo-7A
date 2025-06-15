<%@ Page Title="" Language="C#" MasterPageFile="~/VeterinarioMasterPage.Master" AutoEventWireup="true" CodeBehind="Veterinario_FichasMedicas.aspx.cs" Inherits="tp_integrador.Veterinario_FichasMedicas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
        }

        .main-content-wrapper {
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
            box-sizing: border-box;
        }

        .form-control {
            width: 100%;
            box-sizing: border-box;
        }

        .inner-block-padding {
            padding: 20px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="main-content-wrapper">

        <div style="background-color: #f0f0f0; border-radius: 8px; font-family: Arial, sans-serif; margin-bottom: 20px;">
            <div style="background-color: #20c997; color: white; padding: 15px 20px; border-radius: 8px 8px 0 0; display: flex; align-items: center; font-size: 1.2em; font-weight: bold;">
                <i class="fas fa-filter" style="margin-right: 10px;"></i>Buscar Ficha
            </div>

            <div style="background-color: white; padding: 20px; border-radius: 0 0 8px 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); display: flex; gap: 15px; flex-wrap: wrap; align-items: center;">
                <asp:TextBox runat="server" ID="txtFiltroFicha" AutoPostBack="true"
                    PlaceHolder="DNI Dueño"
                    CssClass="form-control" OnTextChanged="txtFiltroFicha_TextChanged"
                    Style="flex: 1; min-width: 180px; padding: 10px; border: 1px solid #ccc; border-radius: 5px; box-shadow: inset 0 1px 2px rgba(0,0,0,0.075);" />
                <asp:DropDownList ID="ddlFiltroFicha" runat="server" AutoPostBack="false"
                    CssClass="form-control"
                    Style="flex: 1; min-width: 180px; padding: 10px; border: 1px solid #ccc; border-radius: 5px; background-color: white; cursor: pointer; box-shadow: inset 0 1px 2px rgba(0,0,0,0.075);">
                    <asp:ListItem Text="Filtrar por Mascota..." Value=""></asp:ListItem>
                </asp:DropDownList>


                <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-primary" OnClick="btnBuscar_Click"
                    Style="background-color: #20c997; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; transition: background-color 0.3s ease;"
                    onmouseover="this.style.backgroundColor='#1a9f78'" onmouseout="this.style.backgroundColor='#20c997'" />


            </div>
        </div>

        <div style="background-color: #f0f0f0; border-radius: 8px; font-family: Arial, sans-serif; margin-bottom: 20px;">
            <div style="background-color: #20c997; color: white; padding: 15px 20px; border-radius: 8px 8px 0 0; display: flex; align-items: center; font-size: 1.2em; font-weight: bold;">
                <i class="fas fa-paw" style="margin-right: 10px;"></i>Datos
            </div>

            <div style="display: flex; justify-content: space-between; gap: 20px; background-color: white; padding: 20px; border-radius: 0 0 8px 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">

                <div style="flex: 1; border: 1px solid #e0e0e0; border-radius: 8px; padding: 15px; box-shadow: 0 2px 4px rgba(0,0,0,0.05);">
                    <h4 style="margin-top: 0; color: #333;">Datos de la Mascota</h4>
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
                        <div>
                            <label style="font-weight: bold;">Nombre:</label>
                            <asp:Label ID="lblNombre" runat="server" Text=""></asp:Label>
                        </div>
                        <div>
                            <label style="font-weight: bold;">Edad:</label>
                            <asp:Label ID="lblEdad" runat="server" Text=""></asp:Label>
                        </div>
                        <div>
                            <label style="font-weight: bold;">Sexo:</label>
                            <asp:Label ID="lblSexo" runat="server" Text=""></asp:Label>
                        </div>
                        <div>
                            <label style="font-weight: bold;">Tipo:</label>
                            <asp:Label ID="lblTipo" runat="server" Text=""></asp:Label>
                        </div>
                        <div>
                            <label style="font-weight: bold;">Peso:</label>
                            <asp:Label ID="lblPeso" runat="server" Text=""></asp:Label>
                        </div>
                        <div>
                            <label style="font-weight: bold;">Raza:</label>
                            <asp:Label ID="lblRaza" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>

                <div style="width: 1px; background-color: #ddd; margin: 0 10px;"></div>

                <div style="flex: 1; border: 1px solid #e0e0e0; border-radius: 8px; padding: 15px; box-shadow: 0 2px 4px rgba(0,0,0,0.05);">
                    <h4 style="margin-top: 0; color: #333;">Datos del Dueño</h4>
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
                        <div>
                            <label style="font-weight: bold;">Nombre:</label>
                            <asp:Label ID="lblNombreDueño" runat="server"></asp:Label>
                        </div>
                        <div>
                            <label style="font-weight: bold;">Telefono:</label>
                            <asp:Label ID="lblTelefonoDueño" runat="server"></asp:Label>
                        </div>
                        <div>
                            <label style="font-weight: bold;">Correo:</label>
                            <asp:Label ID="lblCorreoDueño" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div style="background-color: #f0f0f0; border-radius: 8px; font-family: Arial, sans-serif;">
            <div style="background-color: #20c997; color: white; padding: 15px 20px; border-radius: 8px 8px 0 0; display: flex; align-items: center; font-size: 1.2em; font-weight: bold;">
                <i class="fas fa-history" style="margin-right: 10px;"></i>Historial de Visitas Veterinarias
            </div>

            <div style="background-color: white; padding: 20px; border-radius: 0 0 8px 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
                <%if (listaFichas != null)
                    { %>
                <% foreach (dominio.Ficha ficha in listaFichas)
                    { %>

                    <div style="border: 1px solid #e0e0e0; border-radius: 8px; padding: 15px; background-color: #fefefe; margin-bottom: 15px;">
                        <div style="margin-bottom: 10px; padding-bottom: 10px; border-bottom: 1px dashed #eee;">
                            <label class="field-label">Fecha:</label>
                            <label><%: ficha.Turno.FechaHora.ToString("dd/MM/yyyy") %></label>
                        </div>
                        <div>
                            <label class="field-label">Comentarios del Veterinario:</label>
                            <label><%: ficha.Descripcion %></label>
                        </div>
                    </div>

                <% } %>
                <% } %>
            </div>
        </div>
    </div>
</asp:Content>



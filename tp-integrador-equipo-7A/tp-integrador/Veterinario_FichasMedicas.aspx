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
                <asp:TextBox runat="server" ID="txtFiltroFicha" AutoPostBack="True"
                    PlaceHolder="DNI Dueño"
                    CssClass="form-control"
                    Style="flex: 1; min-width: 180px; padding: 10px; border: 1px solid #ccc; border-radius: 5px; box-shadow: inset 0 1px 2px rgba(0,0,0,0.075);" />
                <asp:DropDownList ID="ddlFiltroFicha" runat="server" AutoPostBack="True"
                    CssClass="form-control"
                    Style="flex: 1; min-width: 180px; padding: 10px; border: 1px solid #ccc; border-radius: 5px; background-color: white; cursor: pointer; box-shadow: inset 0 1px 2px rgba(0,0,0,0.075);">
                    <asp:ListItem Text="Filtrar por Mascota..." Value=""></asp:ListItem>
                    <asp:ListItem Text="Mascota1" Value="Mascota1"></asp:ListItem>
                    <asp:ListItem Text="Mascota2" Value="Mascota2"></asp:ListItem>
                </asp:DropDownList>
                <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-primary"
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
                            <asp:Label ID="lblDueño" runat="server"></asp:Label>
                        </div>
                        <div>
                            <label style="font-weight: bold;">Telefono:</label>
                            <asp:Label ID="lblTelefono" runat="server"></asp:Label>
                        </div>
                        <div>
                            <label style="font-weight: bold;">Correo:</label>
                            <asp:Label ID="lblCorreo" runat="server"></asp:Label>
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


                <%--
                <div style="margin-bottom: 20px; padding: 15px; border: 1px solid #e0e0e0; border-radius: 8px; background-color: #f9f9f9;">
                    <h5 style="margin-top: 0; color: #333;">Registrar Nueva Visita:</h5>
                    <div style="display: flex; flex-wrap: wrap; gap: 15px; align-items: center;">
                        <div>
                            <label style="font-weight: bold;">Fecha:</label>
                            <asp:TextBox ID="txtFechaVisita" runat="server" TextMode="Date" CssClass="form-control" style="padding: 8px; border: 1px solid #ccc; border-radius: 4px;"></asp:TextBox>
                        </div>
                        <div style="flex-grow: 1;">
                            <label style="font-weight: bold;">Comentarios:</label>
                            <asp:TextBox ID="txtComentarios" runat="server" TextMode="MultiLine" Rows="3" Columns="50" CssClass="form-control" style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; resize: vertical;"></asp:TextBox>
                        </div>
                        <asp:Button ID="btnAgregarVisita" runat="server" Text="Agregar Visita" OnClick="btnAgregarVisita_Click" CssClass="btn btn-primary"
                            style="background-color: #20c997; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; transition: background-color 0.3s ease;"
                            onmouseover="this.style.backgroundColor='#1a9f78'" onmouseout="this.style.backgroundColor='#20c997'"/>
                    </div>
                </div>
                --%>

                <div style="border: 1px solid #e0e0e0; border-radius: 8px; padding: 15px; background-color: #fefefe; margin-bottom: 15px;">
                    <div style="margin-bottom: 10px; padding-bottom: 10px; border-bottom: 1px dashed #eee;">
                        <label style="font-weight: bold; display: block; margin-bottom: 5px;">Fecha:</label>
                        <asp:Label ID="lblFechaUltimaVisita" runat="server" Text="05/06/2025"></asp:Label>
                    </div>
                    <div>
                        <label style="font-weight: bold; display: block; margin-bottom: 5px;">Comentarios del Veterinario:</label>
                        <asp:Label ID="lblComentariosUltimaVisita" runat="server" Text="Revisión general, se aplicó la vacuna anual y se desparasitó. La mascota se encuentra en excelente estado de salud y su peso es adecuado para su edad."></asp:Label>
                    </div>
                </div>
                <div style="border: 1px solid #e0e0e0; border-radius: 8px; padding: 15px; background-color: #fefefe;">
                    <div style="margin-bottom: 10px; padding-bottom: 10px; border-bottom: 1px dashed #eee;">
                        <label style="font-weight: bold; display: block; margin-bottom: 5px;">Fecha:</label>
                        <asp:Label ID="lblFechaPenultimaVisita" runat="server" Text="15/12/2024"></asp:Label>
                    </div>
                    <div>
                        <label style="font-weight: bold; display: block; margin-bottom: 5px;">Comentarios del Veterinario:</label>
                        <asp:Label ID="lblComentariosPenultimaVisita" runat="server" Text="Visita de control por pequeña tos, se recetó jarabe por 5 días. La tos desapareció, sin complicaciones."></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>



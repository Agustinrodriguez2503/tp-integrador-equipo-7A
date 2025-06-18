<%@ Page Title="" Language="C#" MasterPageFile="~/VeterinarioMasterPage.Master" AutoEventWireup="true" CodeBehind="Veterinario_TurnosPendientes.aspx.cs" Inherits="tp_integrador.Veterinario_TurnosPendientes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }

        .main-content-wrapper {
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
            box-sizing: border-box;
        }

        .filter-section {
            background-color: #f0f0f0;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .filter-header {
            background-color: #20c997;
            color: white;
            padding: 15px 20px;
            border-radius: 8px 8px 0 0;
            display: flex;
            align-items: center;
            font-size: 1.2em;
            font-weight: bold;
        }

        .filter-content {
            background-color: white;
            padding: 20px;
            border-radius: 0 0 8px 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: flex-start;
            gap: 15px;
            flex-wrap: wrap;
            align-items: center;
        }

        .date-input {
            width: 200px;
            max-width: 100%;
            box-sizing: border-box;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: inset 0 1px 2px rgba(0,0,0,0.075);
        }

        .btn {
            background-color: #20c997;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

            .btn i {
                margin-right: 5px;
            }

            .btn:hover {
                background-color: #1a9f78;
            }

        .btn-secondary {
            background-color: #007bff;
        }

            .btn-secondary:hover {
                background-color: #0056b3;
            }

        .card-buttons {
            margin-top: 20px;
            display: flex;
            gap: 10px;
            justify-content: flex-end;
        }

        .btn.btn-eliminar {
            background-color: #dc3545;
            color: white;
        }

            .btn.btn-eliminar:hover {
                background-color: #c82333;
            }

        @media (max-width: 768px) {
            .filter-content {
                flex-direction: column;
                align-items: stretch;
                justify-content: flex-start;
            }

            .date-input {
                width: 100%;
                min-width: unset;
            }

            .card-buttons {
                justify-content: center;
            }
        }

        .gridViewStyle {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }

            .gridViewStyle th {
                background-color: #20c997;
                color: white;
                padding: 12px 15px;
                text-align: left;
                font-weight: bold;
                border-bottom: 1px solid #1a9f78;
            }

            .gridViewStyle td {
                padding: 10px 15px;
                border-bottom: 1px solid #eee;
                color: #333;
            }

            .gridViewStyle tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            .gridViewStyle tr:hover {
                background-color: #e6f7f2;
                cursor: pointer;
            }

            .gridViewStyle .gridButtonColumn {
                text-align: center;
                white-space: nowrap;
            }

                .gridViewStyle .gridButtonColumn .btn {
                    padding: 6px 12px;
                    font-size: 0.9em;
                    margin: 0 3px;
                }

                    .gridViewStyle .gridButtonColumn .btn.btn-eliminar {
                        padding: 6px 12px;
                    }

        .emptyDataRow {
            text-align: center;
            padding: 20px;
            color: #777;
            font-style: italic;
            background-color: #fefefe;
        }

        .gridCenteredHeader {
            text-align: center;
        }

        .gridViewStyle th {
            background-color: #20c997;
            color: white;
            padding: 12px 15px;
            text-align: left;
            font-weight: bold;
            border-bottom: 1px solid #1a9f78;
        }

            .gridViewStyle th.gridCenteredHeader {
                text-align: center;
            }

        .gridViewStyle .gridButtonColumn {
            text-align: center;
            white-space: nowrap;
        }

        .buttons-flex-container {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="main-content-wrapper">

        <div class="filter-section">
            <div class="filter-header">
                <i class="fas fa-calendar-alt" style="margin-right: 10px;"></i>Filtrar Turnos
            </div>
            <div class="filter-content">
                <asp:TextBox ID="txtFecha" runat="server" TextMode="Date" CssClass="date-input"></asp:TextBox>
            </div>
        </div>

        <div class="filter-section">
            <div class="filter-header">
                <i class="fas fa-clock" style="margin-right: 10px;"></i>Turnos Pendientes
            </div>
            <div class="filter-content" style="padding: 0; border-radius: 0 0 8px 8px; box-shadow: none;">
                <asp:GridView ID="gvTurnos" runat="server" AutoGenerateColumns="False"
                    CssClass="gridViewStyle" HeaderStyle-CssClass="gridHeader"
                    RowStyle-CssClass="gridRow" AlternatingRowStyle-CssClass="gridAltRow"
                    EmptyDataText="No hay turnos pendientes para mostrar." EmptyDataRowStyle-CssClass="emptyDataRow"
                    OnRowCommand="gvTurnos_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="DescripcionTurno" HeaderText="Fecha y Hora" HeaderStyle-CssClass="gridCenteredHeader" />
                        <asp:BoundField DataField="Estado" HeaderText="Estado" />
                        <asp:TemplateField HeaderText="Acciones" ItemStyle-CssClass="gridButtonColumn" HeaderStyle-CssClass="gridCenteredHeader">
                            <ItemTemplate>
                                <div class="buttons-flex-container">
                                    <%-- Botón Eliminar --%>
                                    <asp:Button ID="btnEliminarGrid" runat="server" Text="Eliminar" CssClass="btn btn-eliminar"
                                        CommandName="EliminarTurno" CommandArgument='<%# Eval("IdTurno") %>' />
                                    <%-- Botón Iniciar  --%>
                                    <button id="btnIniciarGrid" runat="server" class="btn"
                                        style="background-color: #20c997; color: white; border: none; padding: 6px 12px; border-radius: 5px; cursor: pointer; transition: background-color 0.3s ease;"
                                        onmouseover="this.style.backgroundColor='#1a9f78'" onmouseout="this.style.backgroundColor='#20c997'"
                                        commandname="IniciarTurno" commandargument='<%# Eval("IdTurno") %>'>
                                        <i class="fas fa-check" style="margin-right: 5px;"></i>Iniciar
                                    </button>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="gridHeader"></HeaderStyle>
                    <RowStyle CssClass="gridRow"></RowStyle>
                    <AlternatingRowStyle CssClass="gridAltRow"></AlternatingRowStyle>
                    <EmptyDataRowStyle CssClass="emptyDataRow"></EmptyDataRowStyle>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>

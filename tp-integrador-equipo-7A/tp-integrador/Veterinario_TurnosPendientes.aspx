<%@ Page Title="" Language="C#" MasterPageFile="~/VeterinarioMasterPage.Master" AutoEventWireup="true" CodeBehind="Veterinario_TurnosPendientes.aspx.cs" Inherits="tp_integrador.Veterinario_TurnosPendientes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
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
            display: flex;
            justify-content: flex-start;
            gap: 15px;
            flex-wrap: wrap;
            align-items: center;
        }

        .grid-container {
            padding: 0;
            border-radius: 0 0 8px 8px;
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

            .btn:hover {
                background-color: #1a9f78;
            }

            .btn.btn-eliminar {
                background-color: #dc3545;
                color: white;
            }

                .btn.btn-eliminar:hover {
                    background-color: #c82333;
                }

            .btn.btn-iniciar {
                background-color: #20c997;
                color: white;
            }

                .btn.btn-iniciar:hover {
                    background-color: #1a9f78;
                }

        .gridViewStyle {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            border-radius: 0 0 8px 8px;
            overflow: hidden;
        }

            .gridViewStyle th {
                background-color: #20c997;
                color: white;
                padding: 12px 20px;
                text-align: left;
                font-weight: bold;
                border-bottom: 1px solid #1a9f78;
            }

                .gridViewStyle th.gridCenteredHeader {
                    text-align: center;
                }

            .gridViewStyle td {
                padding: 10px 20px;
                border-bottom: 1px solid #eee;
                color: #333;
                vertical-align: middle;
            }

                .gridViewStyle td.gridCellCentered {
                    text-align: center;
                }

            .gridViewStyle tr:last-child td {
                border-bottom: none;
            }

            .gridViewStyle tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            .gridViewStyle tr:hover {
                background-color: #e6f7f2;
            }

            .gridViewStyle .gridButtonColumn {
                text-align: center;
                white-space: nowrap;
            }

                .gridViewStyle .gridButtonColumn .btn {
                    padding: 6px 12px;
                    font-size: 0.9em;
                    margin: 0 3px;
                    min-width: 95px;
                    box-sizing: border-box;
                }

        .emptyDataRow {
            text-align: center;
            padding: 20px;
            color: #777;
            font-style: italic;
            background-color: #fefefe;
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

    <asp:ScriptManager runat="server" ID="sm_TurnosPendientesVet"></asp:ScriptManager>
    <div class="main-content-wrapper">

        <div class="filter-section">
            <div class="filter-header"><i class="fas fa-calendar-alt" style="margin-right: 10px;"></i>Filtrar Turnos</div>
            <div class="filter-content">
                <asp:TextBox ID="txtFecha" runat="server" TextMode="Date" CssClass="date-input" AutoPostBack="true" OnTextChanged="txtFecha_TextChanged"></asp:TextBox>
            </div>
        </div>

        <asp:UpdatePanel ID="upTurnosGrid" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="filter-section">
                    <div class="filter-header">
                        <div style="display: flex; align-items: center;">
                            <i class="fas fa-clock" style="margin-right: 10px;"></i>
                            <span>Turnos Pendientes</span>
                        </div>
                        <div style="margin-left: auto;">
                            <asp:Button ID="btnAbrirModalReporte" runat="server" Text="Generar Reporte" CssClass="btn btn-light" OnClick="btnAbrirModalReporte_Click" />
                        </div>
                    </div>
                    <div class="grid-container">
                        <asp:GridView ID="gvTurnos" runat="server" AutoGenerateColumns="False" CssClass="gridViewStyle" OnRowCommand="gvTurnos_RowCommand">
                            <Columns>
                                <asp:BoundField DataField="DescripcionTurno" HeaderText="Fecha y Hora" HeaderStyle-CssClass="gridCenteredHeader" ItemStyle-CssClass="gridCellCentered" />
                                <asp:BoundField DataField="Estado" HeaderText="Estado" HeaderStyle-CssClass="gridCenteredHeader" ItemStyle-CssClass="gridCellCentered" />
                                <asp:TemplateField HeaderText="Acciones" ItemStyle-CssClass="gridButtonColumn" HeaderStyle-CssClass="gridCenteredHeader">
                                    <ItemTemplate>
                                        <div class="buttons-flex-container">
                                            <asp:Button ID="btnEliminarGrid" runat="server" Text="Cancelar" CssClass="btn btn-eliminar"
                                                CommandName="SeleccionarParaCancelar"
                                                CommandArgument='<%# GetCommandArgument(Eval("IdTurno"), Eval("FechaHora"), Eval("Mascota.IdMascota")) %>' />

                                            <asp:Button ID="btnIniciarGrid" runat="server" Text="Iniciar" CssClass="btn btn-iniciar"
                                                CommandName="IniciarTurno"
                                                CommandArgument='<%# GetCommandArgument(Eval("IdTurno"), Eval("FechaHora"), Eval("Mascota.IdMascota")) %>' />
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataRowStyle CssClass="emptyDataRow" />
                        </asp:GridView>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="txtFecha" EventName="TextChanged" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    </asp:UpdatePanel>

        <div style="display: flex; justify-content: center; padding: 10px 0;">
            <asp:Button ID="btnVolver" runat="server" Text="Volver" CssClass="btn btn-primary" OnClick="btnVolver_Click"
                Style="background-color: #20c997; margin-top: 20px; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; transition: background-color 0.3s ease;"
                onmouseover="this.style.backgroundColor='#1a9f78'"
                onmouseout="this.style.backgroundColor='#20c997'" />
        </div>

    </div>

    <%-- MODAL DE CONFIRMACIÓN --%>
    <asp:UpdatePanel ID="upModalConfirmacion" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Panel ID="modalConfirmacion" CssClass="modal fade" runat="server" TabIndex="-1" aria-labelledby="modalConfirmacionLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content rounded-4 shadow">
                        <div class="modal-header bg-danger text-white rounded-top-4">
                            <h5 class="modal-title fw-semibold" id="modalConfirmacionLabel">
                                <i class="fas fa-exclamation-triangle me-2"></i>Confirmar Cancelación
                            </h5>
                        </div>
                        <div class="modal-body">
                            <p class="fs-5 text-center py-3">¿Está seguro de que desea cancelar este turno?</p>
                        </div>
                        <div class="modal-footer justify-content-center">
                            <asp:Button ID="btnConfirmarCancelacion" runat="server" Text="Confirmar"
                                CssClass="btn btn-danger btn-lg px-4 rounded-pill" OnClick="btnConfirmarCancelacion_Click" 
                                OnClientClick="this.disabled=true; this.value='Procesando...';document.getElementById(this.parentElement.querySelector('[data-bs-dismiss=\'modal\']').id).disabled=true;"
                                UseSubmitBehavior="false" />
                            <button type="button" id="btnCerrarModal" runat="server" class="btn btn-outline-secondary btn-lg px-4 rounded-pill" data-bs-dismiss="modal">Cerrar</button>
                        </div>
                    </div>
                </div>
            </asp:Panel>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvTurnos" EventName="RowCommand" />
        </Triggers>
    </asp:UpdatePanel>

    <%-- Modal para generar el reporte --%>
<%--    <asp:UpdatePanel ID="upModalReporte" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="modal fade" id="modalReporte" runat="server" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content rounded-4 shadow">
                        <div class="modal-header modal-header-principal rounded-top-4">
                            <h5 class="modal-title"><i class="fas fa-file-pdf me-2"></i>Generar Reporte de Turnos</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="<%= txtFechaDesde.ClientID %>" class="form-label fw-semibold">Desde:</label>
                                    <asp:TextBox ID="txtFechaDesde" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvDesde" runat="server" ControlToValidate="txtFechaDesde"
                                        ErrorMessage="Fecha 'Desde' es requerida." ForeColor="Red" Display="Dynamic" ValidationGroup="ReporteGroup" />
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="<%= txtFechaHasta.ClientID %>" class="form-label fw-semibold">Hasta:</label>
                                    <asp:TextBox ID="txtFechaHasta" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvHasta" runat="server" ControlToValidate="txtFechaHasta"
                                        ErrorMessage="Fecha 'Hasta' es requerida." ForeColor="Red" Display="Dynamic" ValidationGroup="ReporteGroup" />
                                </div>
                                <div class="col-12">
                                    <asp:CustomValidator ID="cvFechas" runat="server" OnServerValidate="cvFechas_ServerValidate"
                                        ErrorMessage="La fecha 'Desde' no puede ser posterior a la fecha 'Hasta'." ForeColor="Red" Display="Dynamic" ValidationGroup="ReporteGroup" />
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer justify-content-center">
                            <asp:Button ID="btnGenerarReporte" runat="server" Text="Generar PDF" OnClick="btnGenerarReporte_Click" ValidationGroup="ReporteGroup" CssClass="btn btn-principal" />
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>--%>


</asp:Content>

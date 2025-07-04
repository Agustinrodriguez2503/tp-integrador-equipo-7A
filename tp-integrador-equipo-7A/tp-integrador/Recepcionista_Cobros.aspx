<%@ Page Title="" Language="C#" MasterPageFile="~/RecepcionistaMasterPage.Master" AutoEventWireup="true" CodeBehind="Recepcionista_Cobros.aspx.cs" Inherits="tp_integrador.Recepcionista_Cobros" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        /*------DropDown de turnos------*/
        .ddl-estetico {
            width: 100%;
            padding: 0.6rem;
            font-size: 1rem;
            border-radius: 0.5rem;
            border: 1px solid #ced4da;
            background-color: #f8f9fa;
            color: #212529;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
        }

            .ddl-estetico:hover {
                border-color: #20c997;
                background-color: #e9f7f3;
            }

            .ddl-estetico:focus {
                outline: none;
                border-color: #20c997;
                box-shadow: 0 0 0 0.2rem rgba(32, 201, 151, 0.25);
            }
        /*--------------------------------------------------------------------------------*/

        .text-verde-agua {
            color: #20c997;
        }

        .bg-verde-agua {
            background-color: #20c997 !important;
        }

        .bg-verde-agua-claro {
            background-color: #e6f8f5;
        }

        .border-verde-agua {
            border-color: #20c997 !important;
        }

        .info-box {
            background-color: #fff;
            padding: 1rem;
            border-left: 4px solid #20c997;
            border-radius: 0.5rem;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 100%;
        }

            .info-box .label {
                font-size: 0.9rem;
                color: #6c757d;
                margin-bottom: 0.25rem;
            }

            .info-box .value {
                font-weight: 600;
                font-size: 1.05rem;
                color: #212529;
            }

        .card-header i {
            font-size: 1.2rem;
        }
        /*---------------BOTON--------------------*/
        .btn-cobro-hover {
            background-color: white;
            color: #20c997;
            border: 2px solid #20c997;
            border-radius: 2rem;
            padding: 0.75rem 1.5rem;
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }

            .btn-cobro-hover:hover {
                background-color: #20c997;
                color: white;
                box-shadow: 0 6px 18px rgba(32, 201, 151, 0.4);
                transform: translateY(-2px);
            }

            .btn-cobro-hover:focus {
                outline: none;
                box-shadow: 0 0 0 0.25rem rgba(32, 201, 151, 0.3);
            }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <div class="container my-5">

        <!-- SECCIÓN: NUEVO COBRO -->
        <section class="mb-5">
            <div class="p-4 rounded-4 shadow bg-white border border-light-subtle">
                <div class="mb-4 border-bottom pb-2">
                    <h3 class="fw-bold text-success mb-1"><i class="bi bi-wallet-fill me-2"></i>Registrar Cobro</h3>
                    <p class="text-muted mb-0">Complete los siguientes datos para registrar el cobro del turno</p>
                </div>
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                                <!-- SELECCIÓN DE TURNO -->
                                <div class="mb-4">
                                    <asp:DropDownList ID="ddlTurnos" runat="server"
                                        CssClass="form-select form-select-lg shadow-sm rounded-3"
                                        AutoPostBack="true" OnSelectedIndexChanged="ddlTurnos_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>

                                <!-- RESUMEN DEL TURNO -->
                                <div class="row g-4 mb-5">
                                    <div class="col-md-4">
                                        <div class="bg-light rounded-3 p-3 border-start border-3 border-success shadow-sm">
                                            <small class="text-muted">Veterinario</small>
                                            <h6 class="fw-semibold mb-0">
                                                <asp:Label ID="lblNombreVete" runat="server" /></h6>
                                            <span class="text-muted small">
                                                <asp:Label ID="lblMatriculaVete" runat="server" /></span>
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="bg-light rounded-3 p-3 border-start border-3 border-primary shadow-sm">
                                            <small class="text-muted">Mascota</small>
                                            <h6 class="fw-semibold mb-0">
                                                <asp:Label ID="lblNombreMascota" runat="server" /></h6>
                                            <span class="text-muted small">
                                                <asp:Label ID="lblDatoMascota" runat="server" /></span>
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="bg-light rounded-3 p-3 border-start border-3 border-info shadow-sm">
                                            <small class="text-muted">Dueño</small>
                                            <h6 class="fw-semibold mb-0">
                                                <asp:Label ID="lblNombreDuenio" runat="server" /></h6>
                                            <span class="text-muted small">
                                                <asp:Label ID="lblDatoDuenio" runat="server" /></span>
                                        </div>
                                    </div>
                                </div>

                                <!-- FORMULARIO -->
                                <div class="row g-4">
                                            <div class="col-md-4">
                                                <label class="form-label fw-semibold">Forma de Pago</label>
                                                <asp:DropDownList ID="ddlFormaPago" runat="server" CssClass="form-select shadow-sm" AutoPostBack="true" OnSelectedIndexChanged="ddlFormaPago_SelectedIndexChanged">
                                                    <asp:ListItem Text="-- Seleccionar --" Value="" />
                                                    <asp:ListItem Text="Efectivo" />
                                                    <asp:ListItem Text="Tarjeta" />
                                                    <asp:ListItem Text="Transferencia" />
                                                </asp:DropDownList>
                                            </div>

                                    <div class="col-md-4">
                                        <label class="form-label fw-semibold">Nro. Comprobante</label>
                                        <asp:TextBox ID="tbxComprobante" runat="server" CssClass="form-control shadow-sm" Enabled="false" />
                                    </div>

                                    <div class="col-md-4">
                                        <label class="form-label fw-semibold">Costo ($)</label>
                                        <asp:TextBox ID="tbxImporte" runat="server" CssClass="form-control shadow-sm" />
                                    </div>
                                </div>

                                <!-- BOTÓN -->
                                <div class="d-grid mt-4">
                                    <asp:Button
                                        ID="btnRegistrarCobro"
                                        runat="server"
                                        Text="Registrar Cobro"
                                        CssClass="btn btn-success btn-lg fw-semibold shadow-sm" 
                                        OnClick="btnRegistrarCobro_Click"/>
                                </div>
                            </div>
                        </section>
                    </ContentTemplate>
                </asp:UpdatePanel>

               

        <!-- SECCIÓN: HISTORIAL -->
        <section>
            <div class="p-4 rounded-4 shadow bg-white border border-light-subtle">
                <div class="mb-4 border-bottom pb-2 d-flex justify-content-between align-items-center">
                    <div>
                        <h3 class="fw-bold text-primary mb-1"><i class="bi bi-journal-text me-2"></i>Historial de Cobros</h3>
                        <p class="text-muted mb-0">Listado de cobros registrados con filtros disponibles</p>
                    </div>
                </div>

                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <div class="row g-3 mb-4">
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Filtrar por:</label>
                                <asp:Label CssClass="form-label fw-semibold text-danger fst-italic" runat="server" ID="lbl_ddlFiltro" Visible="false" />
                                <asp:DropDownList ID="ddlFiltroCobros" runat="server" CssClass="form-select shadow-sm">
                                    <asp:ListItem Text="-- Seleccione un criterio --" Value="Seleccione" />
                                    <asp:ListItem Text="Fecha" Value="Fecha" />
                                    <asp:ListItem Text="DNI del Dueño" Value="DNI" />
                                </asp:DropDownList>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Valor: </label>
                                <asp:Label CssClass="form-label fw-semibold text-danger fst-italic" runat="server" ID="lblFiltroValor" Visible="false" />
                                <asp:TextBox ID="txtValorFiltroCobros" runat="server" CssClass="form-control shadow-sm" placeholder="Ej: 25/06/2025 o 12345678" onkeypress="return soloNumeros(event)" />
                            </div>

                            <div class="col-md-4 d-flex align-items-end">
                                <asp:Button ID="btnFiltrarCobros" runat="server" Text="Filtrar" CssClass="btn btn-outline-primary shadow-sm fw-semibold px-4 w-100" OnClick="btnFiltrarCobros_Click" />
                            </div>
                        </div>

                        <!-- GRILLA -->
                        <asp:GridView
                            ID="gvCobros"
                            runat="server"
                            CssClass="table table-hover table-bordered table-striped shadow-sm rounded-3 overflow-hidden"
                            AutoGenerateColumns="false"
                            EmptyDataText="No se registraron cobros aún."
                            HeaderStyle-CssClass="table-primary fw-semibold text-center"
                            RowStyle-CssClass="align-middle"
                            AllowPaging="true"
                            PageSize="5"
                            OnPageIndexChanging="gvCobros_PageIndexChanging">
                            <Columns>
                                <asp:BoundField DataField="FechaHora" HeaderText="Fecha y Hora" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                                <asp:BoundField DataField="DNIDueño" HeaderText="Dueño" />
                                <asp:BoundField DataField="nombreMascota" HeaderText="Mascota" />
                                <asp:BoundField DataField="FormaPago" HeaderText="Forma de Pago" />
                                <asp:BoundField DataField="Costo" HeaderText="Costo" DataFormatString="${0:N2}" HtmlEncode="false" />
                            </Columns>
                            <PagerStyle CssClass="pager-custom" HorizontalAlign="Center" />
                        </asp:GridView>

                    </ContentTemplate>
                </asp:UpdatePanel>



            </div>
        </section>

    </div>
   
 <%--   ---------------------  Para que no deje ingresas letras en el DNI cuando se filtra --------------------%>
    
    <script type="text/javascript">
    function soloNumeros(e) {
        var tecla = e.key;
        return /^[0-9]$/.test(tecla) || e.keyCode === 8; // permite backspace
    }
    </script>


</asp:Content>

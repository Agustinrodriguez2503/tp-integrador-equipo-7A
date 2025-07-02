<%@ Page Title="" Language="C#" MasterPageFile="~/RecepcionistaMasterPage.Master" AutoEventWireup="true" CodeBehind="Recepcionista_PagPrincipal.aspx.cs" Inherits="tp_integrador.Recepcionista_PagPrincipal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <%--para icono de bootstrap--%>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        .val-error {
            color: #ff4d4f;
            font-size: 0.875rem;
            font-style: italic;
            margin-top: 0.25rem;
            display: block;
        }
        /*Para que el contenido del placeholder de los texbox se vean mas clarito y el cursiva*/
        input.placeholder-custom::placeholder {
            color: #bcbcbc !important;
            font-style: italic;
        }


        .card-link-custom {
            text-decoration: none;
            color: inherit;
        }

        .custom-card {
            border: none;
            border-radius: 1rem;
            transition: transform 0.2s, box-shadow 0.2s;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

            .custom-card:hover {
                transform: scale(1.03);
                box-shadow: 0 6px 18px rgba(0, 0, 0, 0.15);
                cursor: pointer;
            }

        .card-verde-agua {
            background-color: #a2ded0; /* Verde Agua */
            color: #00332f;
        }

            .card-verde-agua:hover {
                background-color: #8bd0c1;
            }

        .card-title {
            font-weight: 600;
            font-size: 1.25rem;
        }

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

            .btn-cobro-hover:disabled {
                background-color: #e0e0e0;
                color: #888888;
                border-color: #cccccc;
                cursor: not-allowed;
                box-shadow: none;
                transform: none;
            }

        /*RadioButton*/
        .btn-group input[type="radio"] {
            display: none;
        }

        .btn-group label {
            padding: 10px 16px;
            border: 1px solid #ced4da;
            border-radius: 0.5rem;
            background-color: #f8f9fa;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
        }

            .btn-group label:hover {
                background-color: #e2f0f5;
            }

        .btn-group input[type="radio"]:checked + label {
            background-color: #20c997;
            color: white;
            border-color: #20c997;
        }
        /*GridView de Turnos*/

        .pager-custom a, .pager-custom span {
            display: inline-block;
            padding: 6px 12px;
            margin: 2px;
            border-radius: 8px;
            border: 1px solid #20c997;
            text-decoration: none;
            color: #20c997;
            background-color: white;
            transition: all 0.2s ease;
            font-weight: 500;
        }

        .pager-custom a:hover {
            background-color: #20c997;
            color: white;
        }

        .pager-custom span {
            background-color: #20c997;
            color: white;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:ScriptManager runat="server" ID="sm_PaginaInicialRecep"></asp:ScriptManager>

    <%----------------------------------MENU PRINCIPAL----------------------------------------%>
    <div class="container my-5">
        <h1 class="text-center mb-3">¡BIENVENIDO/A!</h1>
        <h3 class="text-center text-secondary mb-5" runat="server" id="recepcionista"></h3>


        <div class="row g-4 justify-content-center">
            <div class="col-md-6 col-lg-4">
                <asp:LinkButton
                    ID="btnTurnos"
                    runat="server"
                    OnClick="btnTurnos_Click"
                    CssClass="card-link-custom d-block text-decoration-none">
            
                    <div class="card custom-card h-100 text-center card-verde-agua">
                        <div class="card-body">
                            <h5 class="card-title">TURNOS</h5>
                        </div>
                    </div>
                </asp:LinkButton>
            </div>
            <div class="col-md-6 col-lg-4">
                <a href="Recepcionista_Cobros.aspx" class="card-link-custom">
                    <div class="card custom-card h-100 text-center card-verde-agua">
                        <div class="card-body">
                            <h5 class="card-title">COBROS</h5>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-6 col-lg-4">
                <asp:LinkButton
                    ID="btnRegistrar"
                    runat="server"
                    CssClass="card-link-custom d-block text-decoration-none"
                    OnClick="btnRegistrar_Click">
                    <div class="card custom-card h-100 text-center card-verde-agua">
                        <div class="card-body">
                            <h5 class="card-title">REGISTRAR</h5>
                        </div>
                    </div>
                </asp:LinkButton>
            </div>
        </div>

        <div class="row g-4 justify-content-center mt-2">
            <div class="col-md-6 col-lg-4">
                <a href="reportes.aspx" class="card-link-custom">
                    <div class="card custom-card h-100 text-center card-verde-agua">
                        <div class="card-body">
                            <h5 class="card-title">REPORTES</h5>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-6 col-lg-4">
                <a href="fichas.aspx" class="card-link-custom">
                    <div class="card custom-card h-100 text-center card-verde-agua">
                        <div class="card-body">
                            <h5 class="card-title">FICHAS MÉDICAS</h5>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-6 col-lg-4">
                <a href="mensajeria.aspx" class="card-link-custom">
                    <div class="card custom-card h-100 text-center card-verde-agua">
                        <div class="card-body">
                            <h5 class="card-title">MENSAJERÍA</h5>
                        </div>
                    </div>
                </a>
            </div>
        </div>

        <%-----------------------------------P A N E L  P A R A  P E D I R  T U R N O----------------------------------%>

        <div class="container-fluid px-4">
            <div class="row justify-content-center mt-5">
                <div class="col-12">
                    <asp:UpdatePanel runat="server" Visible="false" ID="upPanelTurnos">
                        <ContentTemplate>
                            <!-- CARD PRINCIPAL -->
                            <div class="card border-0 shadow-lg rounded-4">
                                <div class="card-body p-4 bg-white">

                                    <!-- TÍTULO PRINCIPAL -->
                                    <h2 class="text-center fw-bold mb-4 text-primary">
                                        <i class="bi bi-calendar-plus me-2"></i>Asignación de Turnos
                                    </h2>

                                    <!-- DNI -->
                                    <div class="mb-4">
                                        <label for="txtDueño" class="form-label fw-semibold">DNI del dueño</label>
                                        <asp:TextBox
                                            ID="txtDueño"
                                            runat="server"
                                            CssClass="form-control form-control-lg shadow-sm rounded-3"
                                            placeholder="Ej: 30123456"
                                            OnTextChanged="txtDueño_TextChanged"
                                            AutoPostBack="true" />
                                        <asp:Label
                                            ID="lblDniNoValido"
                                            runat="server"
                                            CssClass="text-danger fw-semibold mt-2 d-block"
                                            Visible="false" />
                                    </div>

                                    <!-- MASCOTA -->
                                    <div class="mb-4">
                                        <label for="ddlMascota" class="form-label fw-semibold">Seleccionar Mascota</label>
                                        <asp:DropDownList
                                            ID="ddlMascota"
                                            runat="server"
                                            CssClass="form-select form-select-lg shadow-sm rounded-3"
                                            Enabled="false"
                                            OnSelectedIndexChanged="ddlMascota_SelectedIndexChanged"
                                            AutoPostBack="true" />
                                        <asp:Label
                                            ID="lbl_ddlMascotas"
                                            runat="server"
                                            CssClass="text-danger fw-semibold mt-2 d-block"
                                            Visible="false" />
                                    </div>

                                    <!-- BOTÓN -->
                                    <div class="mb-4 text-center">
                                        <asp:Button
                                            ID="btnBuscarTurno"
                                            runat="server"
                                            Text="Buscar Turnos"
                                            CssClass="btn btn-success btn-lg px-5 fw-semibold shadow-sm"
                                            Enabled="false"
                                            OnClick="btnBuscarTurno_Click" />
                                    </div>
                                </div>
                            </div>

                            <!-- SECCIÓN DE CONSULTA -->
                            <div class="card border-0 shadow-lg rounded-4 mt-5">
                                <div class="card-body bg-light p-4">

                                    <!-- TÍTULO CONSULTA -->
                                    <h3 class="text-center fw-bold mb-4 text-primary">
                                        <i class="bi bi-search me-2"></i>Consultar Turnos
                                    </h3>

                                    <!-- FILTROS -->
                                    <div class="row g-3 mb-4 justify-content-center">


                                        <!-- RadioButtonList para estados específicos -->
                                        <div class="col-12">
                                            <label class="form-label fw-semibold">Estado del turno por el que desea filtrar:</label>
                                            <asp:RadioButtonList
                                                ID="rblEstadoTurno"
                                                runat="server"
                                                RepeatDirection="Horizontal"
                                                CssClass="btn-group d-flex flex-wrap gap-2"
                                                AutoPostBack="true"
                                                RepeatLayout="Flow">
                                                <asp:ListItem Text="Pendientes" Value="PENDIENTE" />
                                                <asp:ListItem Text="Cancelados" Value="CANCELADO" />
                                                <asp:ListItem Text="Realizados" Value="REALIZADO" />
                                                <asp:ListItem Text="Cobrados" Value="COBRADO" />
                                                <asp:ListItem Text="Todos" Value="TODO" />
                                            </asp:RadioButtonList>
                                        </div>

                                        <!-- DDL Estado general -->
                                        <div class="col-12">
                                            <label class="form-label fw-semibold">Filtrar por: </label>
                                            <asp:DropDownList
                                                ID="ddlEstadoFiltro"
                                                runat="server"
                                                CssClass="form-select form-select-lg shadow-sm rounded-3"
                                                AutoPostBack="true"
                                                ValidationGroup="FiltroTurnos">
                                                <asp:ListItem Text="-- Seleccione un criterio --" Value="Seleccione" Selected="True" />
                                                <asp:ListItem Text="Fecha" Value="Fecha" />
                                                <asp:ListItem Text="Veterinario" Value="Veterinario" />
                                                <asp:ListItem Text="Mascota" Value="Mascota" />
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator
                                                ID="rfvEstadoFiltro"
                                                runat="server"
                                                ControlToValidate="ddlEstadoFiltro"
                                                InitialValue="Seleccione"
                                                ErrorMessage="Debe seleccionar un criterio."
                                                CssClass="text-danger fw-semibold d-block mt-1"
                                                Display="Dynamic"
                                                EnableClientScript="true"
                                                ValidationGroup="FiltroTurnos" />
                                        </div>

                                        <!-- Buscador y botón -->
                                        <div class="col-12">
                                            <label id="lblBuscarPor" class="form-label fw-semibold">Ingrese:</label>
                                            <div class="input-group input-group-lg shadow-sm rounded-3">
                                                <asp:TextBox
                                                    ID="txtBuscarTurno"
                                                    runat="server"
                                                    CssClass="form-control"
                                                    placeholder="Ej: Luna o Dr. García" />

                                                <asp:Button
                                                    ID="btnLimpiarBuscarFiltros"
                                                    runat="server"
                                                    Text="Buscar"
                                                    CssClass="btn btn-outline-secondary"
                                                    OnClick="btnLimpiarBuscarFiltros_Click"
                                                    ValidationGroup="FiltroTurnos"/>

                                            </div>
                                        </div>


                                        <!-- GRIDVIEW -->
                                        <asp:GridView
                                            ID="gvTurnos"
                                            runat="server"
                                            CssClass="table table-hover table-bordered table-striped text-center rounded-3 overflow-hidden shadow-sm"
                                            AutoGenerateColumns="false"
                                            EmptyDataText="No hay turnos registrados."
                                            AllowPaging="true"
                                            PageSize="5"
                                            OnPageIndexChanging="gvTurnos_PageIndexChanging"
                                            Visible="false">
                                            <Columns>
                                                <asp:BoundField DataField="FechaHora" HeaderText="Fecha y Hora" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                                                <asp:BoundField DataField="NombreVeterinario" HeaderText="Veterinario" />
                                                <asp:BoundField DataField="Mascota.Nombre" HeaderText="Mascota" />
                                                <asp:BoundField DataField="Estado" HeaderText="Estado" />
                                            </Columns>
                                            <PagerStyle CssClass="pager-custom" HorizontalAlign="Center" />
                                        </asp:GridView>


                                    </div>
                                </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>






        <%-------------- PANERL PARA REGISTRAR UN DUEÑO, MASCOTA -------------------------%>


        <div class="row g-2 justify-content-center mt-1">
            <div class="col-12 col-md-6">
                <asp:UpdatePanel runat="server" Visible="false" ID="panelRegistrar">
                    <ContentTemplate>
                        <div class="container mt-5 px-4">
                            <div class="card shadow rounded-4 border-0">
                                <div class="card-body">

                                    <!-- Título principal -->
                                    <h3 class="fw-bold text-center mb-4">¿Qué desea registrar?</h3>

                                    <div class="row justify-content-center align-items-center g-3">

                                        <!-- Grupo 1: Dueño y Mascota con TextBox -->
                                        <div class="col-md-6 d-flex flex-wrap align-items-center justify-content-center gap-3">

                                            <asp:Button ID="btnAgregarDueño" runat="server" Text="Dueño" CssClass="btn btn-outline-primary btn-lg rounded-pill px-4" data-bs-toggle="modal" data-bs-target="#modalRegistrarDueño" />

                                            <asp:Button ID="btnAgregarMascota" runat="server" Text="Mascota" CssClass="btn btn-outline-success btn-lg rounded-pill px-4" OnClick="btnAgregarMascota_Click" />

                                            <%--SE SOLICITA EL DNI DEL DUEÑO, SE CORROBORA QUE EXISTA Y SE ABRE EL MODAL PARA REGISTRAR MASCOTA--%>
                                            <div class="input-group mt-2" style="min-width: 250px">
                                                <asp:TextBox ID="txtBuscarMascota" Visible="false" runat="server" AutoPostBack="true" OnTextChanged="txtBuscarMascota_TextChanged" CssClass="form-control form-control-lg shadow-sm rounded-start-3" placeholder="Ingrese DNI del dueño" />
                                                <asp:Button ID="btnBuscarMascota" Visible="false" runat="server" Text="+" CssClass="btn btn-outline-secondary btn-lg px-3 rounded-end-3" OnClick="btnBuscarMascota_Click" />
                                            </div>
                                            <asp:Label ID="lblInfoBuscarMascota" runat="server" CssClass="text-danger small fst-italic mt-1 ms-1 d-block" Visible="false" />
                                        </div>

                                        <!-- Separador visual -->
                                        <div class="col-12 my-3 text-center">
                                            <span class="text-muted">— o —</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>

            </div>
        </div>





        <!--------------------------------------------- MODAL PARA REGISTRAR UN DUEÑO ---------------------------------------------->

        <div class="modal fade" id="modalRegistrarDueño" tabindex="-1" aria-labelledby="modalRegistrarDueñoLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content rounded-4 shadow">

                    <div class="modal-header bg-primary text-white rounded-top-4">
                        <h5 class="modal-title fw-semibold" id="modalRegistrarDueñoLabel">
                            <i class="bi bi-person-lines-fill me-2"></i>Nuevo Dueño
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>

                    <div class="modal-body bg-light">
                        <div class="container-fluid px-4">
                            <div class="row g-4">

                                <!-- Nombre -->
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold" for="txtNombre">Nombre</label>
                                    <asp:TextBox ID="txtNombre" runat="server" ValidationGroup="registrarDueño" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom" placeholder="Ej: Laura" />
                                    <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre" ValidationGroup="registrarDueño" ErrorMessage="El Nombre es obligatorio"
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                </div>

                                <!-- Apellido -->
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold" for="txtApellido">Apellido</label>
                                    <asp:TextBox ID="txtApellido" runat="server" ValidationGroup="registrarDueño" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom" placeholder="Ej: González" />
                                    <asp:RequiredFieldValidator ID="rfvApellido" runat="server" ControlToValidate="txtApellido" ValidationGroup="registrarDueño" ErrorMessage="El Apellido es obligatorio"
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                </div>

                                <!-- DNI -->
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold" for="txtDni">DNI</label>
                                    <asp:TextBox ID="txtDni" runat="server" ValidationGroup="registrarDueño" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom" placeholder="Ej: 30123456" />
                                    <asp:RequiredFieldValidator ID="rfvDNI" runat="server" ControlToValidate="txtDNI" ValidationGroup="registrarDueño" ErrorMessage="El D.N.I. es obligatorio"
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="revDni" runat="server" ControlToValidate="txtDni" ValidationGroup="registrarDueño" ErrorMessage="Ingrese un DNI válido (sin puntos ni letras)"
                                        CssClass="text-danger small fst-italic" ValidationExpression="^\d{7,8}$" Display="Dynamic" />


                                </div>

                                <!-- Teléfono -->
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold" for="txtTelefono">Teléfono</label>
                                    <asp:TextBox ID="txtTelefono" runat="server" ValidationGroup="registrarDueño" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom" placeholder="Ej: 11 5555-5555" />
                                    <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" ControlToValidate="txtTelefono" ValidationGroup="registrarDueño" ErrorMessage="El Telefono es obligatorio"
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="revTelefono" runat="server" ControlToValidate="txtTelefono" ValidationGroup="registrarDueño" ErrorMessage="Formato invalido. Use: 11 5555-5555"
                                        CssClass="text-danger small fst-italic" Display="Dynamic" ValidationExpression="^(\+?\d{2,3}\s?)?(\(?\d{2,4}\)?\s?-?)?\d{3,4}-?\d{4}$" />
                                </div>

                                <!-- Correo -->
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold" for="txtCorreo">Correo electrónico</label>
                                    <asp:TextBox ID="txtCorreo" runat="server" ValidationGroup="registrarDueño" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom" placeholder="Ej: correo@ejemplo.com" />
                                    <asp:RequiredFieldValidator ID="rfvCorreo" runat="server" ControlToValidate="txtCorreo" ValidationGroup="registrarDueño" ErrorMessage="El e-mail es obligatorio"
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="revCorreo" runat="server" ValidationGroup="registrarDueño" ControlToValidate="txtCorreo" ErrorMessage="Ingrese un correo electrónico válido"
                                        CssClass="val-error" ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" Display="Dynamic" />
                                </div>

                                <!-- Domicilio -->
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold" for="txtDomicilio">Domicilio</label>
                                    <asp:TextBox ID="txtDomicilio" runat="server" ValidationGroup="registrarDueño" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom" placeholder="Ej: Av. Rivadavia 1234, Lanus" />
                                    <asp:RequiredFieldValidator ID="rfvDomicilio" runat="server" ControlToValidate="txtDomicilio" ValidationGroup="registrarDueño" ErrorMessage="El domicilio es obligatorio"
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="revDomicilio" runat="server" ControlToValidate="txtDomicilio" ValidationGroup="registrarDueño" ErrorMessage="Formato inválido. Use: Calle Altura, Localidad"
                                        CssClass="text-danger small fst-italic" Display="Dynamic" ValidationExpression="^[A-Za-zÁÉÍÓÚáéíóúÑñ\s\.]{3,}\s\d{1,5},\s[A-Za-zÁÉÍÓÚáéíóúÑñ\s]{3,}$" />
                                </div>

                                <hr class="my-4">

                                <div id="divAlerta" runat="server" visible="false" class="alert alert-danger d-flex align-items-center p-2 mb-3" role="alert">
                                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                    <asp:Label ID="lblValidacion_registroDueño" runat="server" CssClass="m-0 text-dark" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer bg-white rounded-bottom-4 d-flex justify-content-between px-4 py-3">
                        <asp:Button ID="btnRegistrarDueño" runat="server" ValidationGroup="registrarDueño" Text="Registrar" CssClass="btn btn-success btn-lg px-4 rounded-pill" CausesValidation="true" OnClick="btnRegistrarDueño_Click" />
                        <button type="button" class="btn btn-outline-secondary btn-lg px-4 rounded-pill" data-bs-dismiss="modal">Cancelar</button>
                    </div>

                </div>
            </div>
        </div>



        <%-----------------------------          MODAL PARA CARGAR UNA MASCOTA      --------------------------------------%>

        <div class="modal fade" id="modalAltaMascota" tabindex="-1" aria-labelledby="modalAltaMascotaLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content rounded-4 shadow">

                    <div class="modal-header bg-primary text-white rounded-top-4">
                        <h5 class="modal-title fw-semibold" id="modalAltaMascotaLabel">
                            <i class="bi bi-person-lines-fill me-2"></i>Nueva mascota
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>

                    <div class="modal-body bg-light">
                        <div class="container-fluid px-4">
                            <div class="row g-4">

                                <!-- Nombre -->
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold" for="txtNombreMascota">Nombre</label>
                                    <asp:TextBox ID="txtNombreMascota" runat="server" ValidationGroup="registrarMascota" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom" placeholder="Ej: Bonnie" />
                                    <asp:RequiredFieldValidator ID="rfvNombreMascota" runat="server" ControlToValidate="txtNombreMascota" ValidationGroup="registrarMascota" ErrorMessage="El Nombre es obligatorio."
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                </div>

                                <!-- Edad -->
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold" for="txtEdadMascota">Edad</label>
                                    <asp:TextBox ID="txtEdadMascota" runat="server" ValidationGroup="registrarMascota" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom" placeholder="Ej: 6 (años)." TextMode="Number" />
                                    <asp:RequiredFieldValidator ID="rfvEdadMascota" runat="server" ControlToValidate="txtEdadMascota" ValidationGroup="registrarMascota" ErrorMessage="La edad es obligatoria."
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                    <asp:RangeValidator ID="rvEdadMascota" runat="server" ControlToValidate="txtEdadMascota"
                                        MinimumValue="1" MaximumValue="100" Type="Integer"
                                        ValidationGroup="registrarMascota" ErrorMessage="La edad debe ser mayor a 0."
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                </div>

                                <!-- Fecha de Nacimiento -->
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold" for="txtFechaNacimientoMascota">Fecha de Nacimiento</label>
                                    <asp:TextBox ID="txtFechaNacimientoMascota" runat="server" ValidationGroup="registrarMascota" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom" placeholder="Ej: 02/06/19" TextMode="Date" />
                                    <asp:RequiredFieldValidator ID="rfvFechaNacimientoMascota" runat="server" ControlToValidate="txtFechaNacimientoMascota" ValidationGroup="registrarMascota" ErrorMessage="La fecha de nacimiento es obligatoria."
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="revFechaNacimiento" runat="server" ControlToValidate="txtFechaNacimientoMascota" ValidationGroup="registrarMascota" ErrorMessage="Ingrese una fecha válida: (dd/MM/yyyy)."
                                        CssClass="text-danger small fst-italic" ValidationExpression="^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$" Display="Dynamic" />
                                </div>

                                <!-- Peso -->
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold" for="txtPesoMascota">Peso</label>
                                    <asp:TextBox ID="txtPesoMascota" runat="server" ValidationGroup="registrarMascota" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom" placeholder="Ej: 6 (kg)." TextMode="Number" />
                                    <asp:RequiredFieldValidator ID="rfvPesoMascota" runat="server" ControlToValidate="txtPesoMascota" ValidationGroup="registrarMascota" ErrorMessage="El peso es obligatorio."
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="revPeso" runat="server" ControlToValidate="txtPesoMascota" ValidationGroup="registrarMascota" ErrorMessage="Ingrese un peso válido. (ej: 6 o 6.5)."
                                        CssClass="text-danger small fst-italic" Display="Dynamic" ValidationExpression="^([1-9]\d{0,2})(\.\d{1,2})?$" />
                                    <asp:RangeValidator ID="rvPeso" runat="server"
                                        ControlToValidate="txtPesoMascota" ValidationGroup="registrarMascota"
                                        MinimumValue="0.1" MaximumValue="999" ErrorMessage="Ingrese un peso válido mayor a 0 (ej: 6 o 6.5)."
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                </div>

                                <!-- Tipo -->
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold" for="txtTipoMascota">Tipo</label>
                                    <asp:TextBox ID="txtTipoMascota" runat="server" ValidationGroup="registrarMascota" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom" placeholder="Ej: Perro." />
                                    <asp:RequiredFieldValidator ID="rfvTipoMascota" runat="server" ControlToValidate="txtTipoMascota" ValidationGroup="registrarMascota" ErrorMessage="El tipo es obligatorio."
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                </div>

                                <!-- Raza -->
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold" for="txtRazaMascota">Raza</label>
                                    <asp:TextBox ID="txtRazaMascota" runat="server" ValidationGroup="registrarMascota" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom" placeholder="Ej: Bull Dog" />
                                    <asp:RequiredFieldValidator ID="rfvRazaMascota" runat="server" ControlToValidate="txtRazaMascota" ValidationGroup="registrarMascota" ErrorMessage="La raza es obligatorio."
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                </div>

                                <!-- Sexo -->
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold" for="ddlSexoMascota">Sexo</label>
                                    <asp:DropDownList ID="ddlSexoMascota" runat="server" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom">
                                        <asp:ListItem Text="Seleccione el sexo" Value="" Disabled="true" Selected="true" />
                                        <asp:ListItem Text="Macho" Value="Macho" />
                                        <asp:ListItem Text="Hembra" Value="Hembra" />
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvSexoMascota" runat="server" ControlToValidate="ddlSexoMascota" ValidationGroup="registrarMascota" ErrorMessage="El sexo es obligatorio."
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                </div>

                                <hr class="my-4">

                                <div id="divAlertaMascota" runat="server" visible="false" class="alert alert-danger d-flex align-items-center p-2 mb-3" role="alert">
                                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                    <asp:Label ID="lblValidacion_registroMascota" runat="server" CssClass="m-0 text-dark" />
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="modal-footer bg-white rounded-bottom-4 d-flex justify-content-between px-4 py-3">
                        <asp:Button ID="btnRegistroMascota" runat="server" ValidationGroup="registrarMascota" Text="Registrar mascota" CssClass="btn btn-success btn-lg px-4 rounded-pill" CausesValidation="true" OnClick="btnRegistroMascota_Click" />
                        <button type="button" class="btn btn-outline-secondary btn-lg px-4 rounded-pill" data-bs-dismiss="modal">Cancelar</button>
                    </div>

                </div>
            </div>
        </div>

    </div>



</asp:Content>

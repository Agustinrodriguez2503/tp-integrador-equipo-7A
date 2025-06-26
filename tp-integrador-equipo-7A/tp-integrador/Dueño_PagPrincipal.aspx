<%@ Page Title="" Language="C#" MasterPageFile="~/PaginaPrincipalMasterPage.Master" AutoEventWireup="true" CodeBehind="Dueño_PagPrincipal.aspx.cs" Inherits="tp_integrador.Dueño_PagPrincipal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
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
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <div class="container my-5">
        <h1 class="text-center mb-3">¡BIENVENIDO/A!</h1>
        <asp:Label ID="lblBienvenido" runat="server"
            CssClass="h3 text-center text-secondary mb-5 fw-bold d-block text-dark"
            Text=""></asp:Label>
        <!------------------------ LISTADO DE MASCOTAS ------------------------>
        <asp:GridView ID="gvMascotas" runat="server" CssClass="table text-center align-middle" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField HeaderText="Nombre" DataField="Nombre">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Edad" DataField="Edad">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Fecha de nacimiento" DataField="FechaNacimiento">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Peso" DataField="Peso">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Tipo" DataField="Tipo">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Raza" DataField="Raza">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Sexo" DataField="Sexo">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>

                <asp:TemplateField HeaderText="Acciones">
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <div class="d-flex justify-content-center gap-1">
                            <asp:LinkButton ID="btnTurno" runat="server" CssClass="btn btn-primary btn-sm fw-bold"
                                CommandArgument='<%# Eval("IDMascota") %>'
                                OnClick="btnTurno_Click">
                            <i class="bi bi-calendar-check"></i> Turno
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnFicha" runat="server" CssClass="btn btn-info btn-sm fw-bold"
                                CommandArgument='<%# Eval("IDMascota") %>'
                                OnClick="btnFicha_Click">
                            <i class="bi bi-file-earmark-text"></i> Ficha
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnModificar" runat="server" CssClass="btn btn-success btn-sm fw-bold"
                                CommandArgument='<%# Eval("IDMascota") %>'
                                OnClick="btnModificar_Click">
                            <i class="bi bi-pencil-square"></i> Modificar
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnEliminar" runat="server"
                                CommandArgument='<%# Eval("IDMascota") %>'
                                OnClick="btnEliminar_Click"
                                CssClass="btn btn-danger btn-sm fw-bold"
                                OnClientClick="return confirm('¿Estás seguro de eliminar esta mascota?');">
                            <i class="bi bi-trash"></i> Eliminar
                            </asp:LinkButton>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <!------------------------ ACCIONES DEL DUEÑO ------------------------>
        <div class="row g-4 justify-content-center">
            <div class="col-md-6 col-lg-4">
                <a href="#" data-bs-toggle="modal" data-bs-target="#modalAltaMascota" class="card-link-custom">
                    <div class="card custom-card h-100 text-center card-verde-agua">
                        <div class="card-body">
                            <h5 class="card-title">ALTA DE MASCOTA</h5>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-6 col-lg-4">
                <asp:LinkButton ID="datosCliente" OnClick="datosCliente_Click" runat="server" CssClass="card-link-custom">
                <div class="card custom-card h-100 text-center card-verde-agua">
                    <div class="card-body">
                        <h5 class="card-title">MIS DATOS</h5>
                    </div>
                </div>
                </asp:LinkButton>
            </div>
            <div class="col-md-6 col-lg-4">
                <a href="#" class="card-link-custom">
                    <div class="card custom-card h-100 text-center card-verde-agua">
                        <div class="card-body">
                            <h5 class="card-title">MENSAJERIA</h5>
                        </div>
                    </div>
                </a>
            </div>
        </div>
        <div class="row g-4 justify-content-center mt-1">
            <div class="col-md-6 col-lg-4">
                <a href="IniciarSesion.aspx" class="card-link-custom">
                    <div class="card custom-card h-100 text-center card-verde-agua">
                        <div class="card-body">
                            <h5 class="card-title">CERRAR SESIÓN</h5>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>

    <!------------------------ MODAL DE ALTA DE MASCOTA ------------------------>
    <asp:UpdatePanel ID="upRegistrarMascota" runat="server" />
    <contenttemplate>
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
                                        CssClass="text-danger small fst-italic" ValidationExpression="^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$" Display="Dynamic" />
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
                                        MinimumValue="0.1" MaximumValue="999" Type="Double"
                                        ErrorMessage="Ingrese un peso válido mayor a 0 (ej: 6 o 6.5)."
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
    </contenttemplate>
    </asp:UpdatePanel>

    
    <!------------------------ MODAL DE MODIFICACIÓN DE MASCOTA ------------------------>
    <asp:UpdatePanel ID="upModificarMascota" runat="server" />
    <contenttemplate>
        <div class="modal fade" id="modalModificacionMascota" tabindex="-1" aria-labelledby="modalModificacionMascotaLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content rounded-4 shadow">

                    <div class="modal-header bg-primary text-white rounded-top-4">
                        <h5 class="modal-title fw-semibold" id="modalModificacionMascotaLabel">
                            <i class="bi bi-person-lines-fill me-2"></i>Datos de mi mascota
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>

                    <div class="modal-body bg-light">
                        <div class="container-fluid px-4">
                            <div class="row g-4">

                                <!-- Nombre -->
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold" for="txtNombreMascota">Nombre</label>
                                    <asp:TextBox ID="txtNombreMascotaMod" runat="server" ValidationGroup="modificarMascota" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom" placeholder="Ej: Bonnie" />
                                    <asp:RequiredFieldValidator ID="rfvNombreMascotaMod" runat="server" ControlToValidate="txtNombreMascotaMod" ValidationGroup="modificarMascota" ErrorMessage="El Nombre es obligatorio."
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                </div>

                                <!-- Edad -->
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold" for="txtEdadMascota">Edad</label>
                                    <asp:TextBox ID="txtEdadMascotaMod" runat="server" ValidationGroup="modificarMascota" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom" placeholder="Ej: 6 (años)." TextMode="Number" />
                                    <asp:RequiredFieldValidator ID="rfvEdadMascotaMod" runat="server" ControlToValidate="txtEdadMascotaMod" ValidationGroup="modificarMascota" ErrorMessage="La edad es obligatoria."
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                    <asp:RangeValidator ID="rvEdadMascotaMod" runat="server" ControlToValidate="txtEdadMascotaMod"
                                        MinimumValue="1" MaximumValue="100" Type="Integer"
                                        ValidationGroup="registrarMascota" ErrorMessage="La edad debe ser mayor a 0."
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                </div>

                                <!-- Fecha de Nacimiento -->
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold" for="txtFechaNacimientoMascotaMod">Fecha de Nacimiento</label>
                                    <asp:TextBox ID="txtFechaNacimientoMascotaMod" runat="server" ValidationGroup="modificarMascota" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom" placeholder="Ej: 02/06/19" TextMode="DateTime" />
                                    <asp:RequiredFieldValidator ID="rfvFechaNacimientoMascotaMod" runat="server" ControlToValidate="txtFechaNacimientoMascotaMod" ValidationGroup="modificarMascota" ErrorMessage="La fecha de nacimiento es obligatoria."
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="revFechaNacimientoMod" runat="server" ControlToValidate="txtFechaNacimientoMascotaMod" ValidationGroup="modificarMascota" ErrorMessage="Ingrese una fecha válida: (dd/MM/yyyy)."
                                        CssClass="text-danger small fst-italic" ValidationExpression="^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$" Display="Dynamic" />
                                </div>

                                <!-- Peso -->
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold" for="txtPesoMascotaMod">Peso</label>
                                    <asp:TextBox ID="txtPesoMascotaMod" runat="server" ValidationGroup="modificarMascota" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom" placeholder="Ej: 6 (kg)." TextMode="Number" />
                                    <asp:RequiredFieldValidator ID="rfvPesoMascotaMod" runat="server" ControlToValidate="txtPesoMascotaMod" ValidationGroup="modificarMascota" ErrorMessage="El peso es obligatorio."
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="revPesoMod" runat="server" ControlToValidate="txtPesoMascotaMod" ValidationGroup="modificarMascota" ErrorMessage="Ingrese un peso válido. (ej: 6 o 6.5)."
                                        CssClass="text-danger small fst-italic" Display="Dynamic" ValidationExpression="^([1-9]\d{0,2})(\.\d{1,2})?$" />
                                    <asp:RangeValidator ID="rvPesoMascotaMod" runat="server"
                                        ControlToValidate="txtPesoMascotaMod" ValidationGroup="registrarMascota"
                                        MinimumValue="0.1" MaximumValue="999" Type="Double"
                                        ErrorMessage="Ingrese un peso válido mayor a 0 (ej: 6 o 6.5)."
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                </div>

                                <!-- Tipo -->
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold" for="txtTipoMascotaMod">Tipo</label>
                                    <asp:TextBox ID="txtTipoMascotaMod" runat="server" ValidationGroup="modificarMascota" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom" placeholder="Ej: Perro." />
                                    <asp:RequiredFieldValidator ID="rfvTipoMascotaMod" runat="server" ControlToValidate="txtTipoMascotaMod" ValidationGroup="modificarMascota" ErrorMessage="El tipo es obligatorio."
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                </div>

                                <!-- Raza -->
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold" for="txtRazaMascotaMod">Raza</label>
                                    <asp:TextBox ID="txtRazaMascotaMod" runat="server" ValidationGroup="modificarMascota" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom" placeholder="Ej: Bull Dog" />
                                    <asp:RequiredFieldValidator ID="rfvRazaMascotaMod" runat="server" ControlToValidate="txtRazaMascotaMod" ValidationGroup="modificarMascota" ErrorMessage="La raza es obligatorio."
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                </div>

                                <!-- Sexo -->
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold" for="ddlSexoMascotaMod">Sexo</label>
                                    <asp:DropDownList ID="ddlSexoMascotaMod" runat="server" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom">
                                        <asp:ListItem Text="Seleccione el sexo" Value="" Disabled="true" Selected="true" />
                                        <asp:ListItem Text="Macho" Value="Macho" />
                                        <asp:ListItem Text="Hembra" Value="Hembra" />
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvSexoMascotaMod" runat="server" ControlToValidate="ddlSexoMascotaMod" ValidationGroup="modificarMascota" ErrorMessage="El sexo es obligatorio."
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                </div>

                                <hr class="my-4">

                                <div id="divAlertaMascotaModificada" runat="server" visible="false" class="alert alert-danger d-flex align-items-center p-2 mb-3" role="alert">
                                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                    <asp:Label ID="lblValidacion_modificacionMascota" runat="server" CssClass="m-0 text-dark" />
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="modal-footer bg-white rounded-bottom-4 d-flex justify-content-between px-4 py-3">
                        <asp:Button ID="btnGuardarMascota" runat="server" ValidationGroup="modificarMascota" Text="Guardar datos de mascota" CssClass="btn btn-success btn-lg px-4 rounded-pill" CausesValidation="true" OnClick="btnGuardarMascota_Click" />
                        <button type="button" class="btn btn-outline-secondary btn-lg px-4 rounded-pill" data-bs-dismiss="modal">Cancelar</button>
                    </div>

                </div>
            </div>
        </div>
    </contenttemplate>
    </asp:UpdatePanel>


    <!------------------------ MODAL DE MODIFICACIÓN DE DUEÑO ------------------------>
    <asp:UpdatePanel ID="upModificarDueño" runat="server" />
    <contenttemplate>
        <div class="modal fade" id="modalDatosCliente" tabindex="-1" aria-labelledby="modalModificarDueñoLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content rounded-4 shadow">

                    <div class="modal-header bg-primary text-white rounded-top-4">
                        <h5 class="modal-title fw-semibold" id="modalModificarDueñoLabel">
                            <i class="bi bi-person-lines-fill me-2"></i>Mis datos
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>

                    <div class="modal-body bg-light">
                        <div class="container-fluid px-4">
                            <div class="row g-4">

                                <!-- Nombre -->
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold" for="txtNombre">Nombre</label>
                                    <asp:TextBox ID="txtNombre" runat="server" ValidationGroup="ModificarDueño" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom" placeholder="Ej: Laura" />
                                    <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre" ValidationGroup="ModificarDueño" ErrorMessage="El Nombre es obligatorio"
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                </div>

                                <!-- Apellido -->
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold" for="txtApellido">Apellido</label>
                                    <asp:TextBox ID="txtApellido" runat="server" ValidationGroup="ModificarDueño" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom" placeholder="Ej: González" />
                                    <asp:RequiredFieldValidator ID="rfvApellido" runat="server" ControlToValidate="txtApellido" ValidationGroup="ModificarDueño" ErrorMessage="El Apellido es obligatorio"
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                </div>

                                <!-- DNI -->
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold" for="txtDni">DNI</label>
                                    <asp:TextBox ID="txtDni" runat="server" ReadOnly="true" ValidationGroup="ModificarDueño" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom" placeholder="Ej: 30123456" />
                                    <asp:RequiredFieldValidator ID="rfvDNI" runat="server" ControlToValidate="txtDNI" ValidationGroup="ModificarDueño" ErrorMessage="El D.N.I. es obligatorio"
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="revDni" runat="server" ControlToValidate="txtDni" ValidationGroup="ModificarDueño" ErrorMessage="Ingrese un DNI válido (sin puntos ni letras)"
                                        CssClass="text-danger small fst-italic" ValidationExpression="^\d{7,8}$" Display="Dynamic" />


                                </div>

                                <!-- Teléfono -->
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold" for="txtTelefono">Teléfono</label>
                                    <asp:TextBox ID="txtTelefono" runat="server" ValidationGroup="ModificarDueño" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom" placeholder="Ej: 11 5555-5555" />
                                    <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" ControlToValidate="txtTelefono" ValidationGroup="ModificarDueño" ErrorMessage="El Telefono es obligatorio"
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="revTelefono" runat="server" ControlToValidate="txtTelefono" ValidationGroup="ModificarDueño" ErrorMessage="Formato invalido. Use: 11 5555-5555"
                                        CssClass="text-danger small fst-italic" Display="Dynamic" ValidationExpression="^(\+?\d{2,3}\s?)?(\(?\d{2,4}\)?\s?-?)?\d{3,4}-?\d{4}$" />
                                </div>

                                <!-- Correo -->
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold" for="txtCorreo">Correo electrónico</label>
                                    <asp:TextBox ID="txtCorreo" runat="server" ValidationGroup="ModificarDueño" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom" placeholder="Ej: correo@ejemplo.com" />
                                    <asp:RequiredFieldValidator ID="rfvCorreo" runat="server" ControlToValidate="txtCorreo" ValidationGroup="ModificarDueño" ErrorMessage="El e-mail es obligatorio"
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="revCorreo" runat="server" ValidationGroup="ModificarDueño" ControlToValidate="txtCorreo" ErrorMessage="Ingrese un correo electrónico válido"
                                        CssClass="val-error" ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" Display="Dynamic" />
                                </div>

                                <!-- Domicilio -->
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold" for="txtDomicilio">Domicilio</label>
                                    <asp:TextBox ID="txtDomicilio" runat="server" ValidationGroup="ModificarDueño" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom" placeholder="Ej: Av. Rivadavia 1234, Lanus" />
                                    <asp:RequiredFieldValidator ID="rfvDomicilio" runat="server" ControlToValidate="txtDomicilio" ValidationGroup="ModificarDueño" ErrorMessage="El domicilio es obligatorio"
                                        CssClass="text-danger small fst-italic" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="revDomicilio" runat="server" ControlToValidate="txtDomicilio" ValidationGroup="ModificarDueño" ErrorMessage="Formato inválido. Use: Calle Altura, Localidad"
                                        CssClass="text-danger small fst-italic" Display="Dynamic" ValidationExpression="^[A-Za-zÁÉÍÓÚáéíóúÑñ\s\.]{3,}\s\d{1,5},\s[A-Za-zÁÉÍÓÚáéíóúÑñ\s]{3,}$" />
                                </div>

                                <hr class="my-4">

                                <div id="divAlertaMod" runat="server" visible="false" class="alert alert-danger d-flex align-items-center p-2 mb-3" role="alert">
                                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                    <asp:Label ID="lblValidacion_modificacionDueño" runat="server" CssClass="m-0 text-dark" />
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="modal-footer bg-white rounded-bottom-4 d-flex justify-content-between px-4 py-3">
                        <asp:Button ID="btnDatosCliente" runat="server" ValidationGroup="ModificarDueño" Text="Guardar" CssClass="btn btn-success btn-lg px-4 rounded-pill" CausesValidation="true" OnClick="btnGuardarDatosCliente_Click" />
                        <button type="button" class="btn btn-outline-secondary btn-lg px-4 rounded-pill" data-bs-dismiss="modal">Cancelar</button>
                    </div>

                </div>
            </div>
        </div>
    </contenttemplate>
    </asp:UpdatePanel>

</asp:Content>

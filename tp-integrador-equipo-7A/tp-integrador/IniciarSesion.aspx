<%@ Page Title="" Language="C#" MasterPageFile="~/PaginaPrincipalMasterPage.Master" AutoEventWireup="true" CodeBehind="IniciarSesion.aspx.cs" Inherits="tp_integrador.IniciarSesion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .enlace-registro-recupero {
            margin-top: 10px;
            text-align: left;
        }

            .enlace-registro-recupero a {
                font-size: 14px;
                color: lightseagreen;
                text-decoration: none;
            }

                .enlace-registro-recupero a:hover {
                    text-decoration: underline;
                }
    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <div class="banner mt-3"></div>
    <div class="row mt-5">
        <div class="col-3"></div>
        <div class="col-6">
            <div class="p-4 bg-white shadow rounded">
                <div class="mb-3">
                    <h1 class="text-center fw-bold">INICIAR SESIÓN</h1>
                    <h4 class="mb-3">Ingrese sus datos para iniciar sesión.</h4>
                    <div class="mb-3">
                        <asp:TextBox ID="txtUsuario" placeholder="Usuario" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <asp:TextBox ID="txtClave" placeholder="Contraseña" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                    </div>
                    <asp:Button ID="btnIniciar" runat="server" Text="Iniciar Sesión" class="btn btn-primary fw-bold" BackColor="lightseagreen" BorderColor="lightseagreen" ForeColor="Black" OnClick="btnIniciar_Click" />
                    <div>
                        <asp:Label ID="lblMensaje" runat="server" ForeColor="Red" Visible="False"></asp:Label>
                        <div class="enlace-registro-recupero">
                            <a href="#" data-bs-toggle="modal" data-bs-target="#modalRegistrarDueño">¿Aún no tenés cuenta? ¡Registrate!</a>
                        </div>

                        <div class="enlace-registro-recupero">
                            <a href="#" data-bs-toggle="modal" data-bs-target="#modalRecupero">¿Olvidaste tu clave? ¡Recuperá tu usuario!</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal de registro -->

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


                            <!-- Clave -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold" for="txtClave">Clave</label>
                                <asp:TextBox ID="txtClaveDueño" runat="server" ValidationGroup="registrarDueño" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom" TextMode="Password" placeholder="Contraseña segura" />
                                <asp:RequiredFieldValidator ID="rfvClaveDueño" runat="server" ControlToValidate="txtClaveDueño" ValidationGroup="registrarDueño" ErrorMessage="La clave es obligatoria"
                                    CssClass="text-danger small fst-italic" Display="Dynamic" />
                            </div>
                            <!-- Confirmar Clave -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold" for="txtClave">Confirmar clave</label>
                                <asp:TextBox ID="txtClaveDueñoConfirmada" runat="server" ValidationGroup="registrarDueño" CssClass="form-control form-control-lg shadow-sm rounded-3 placeholder-custom" TextMode="Password" placeholder="Contraseña segura" />
                                <asp:RequiredFieldValidator ID="rfvClaveDueñoConfirmar" runat="server" ControlToValidate="txtClaveDueñoConfirmada" ValidationGroup="registrarDueño" ErrorMessage="La clave es obligatoria"
                                    CssClass="text-danger small fst-italic" Display="Dynamic" />
                            </div>


                            <div id="divAlerta" runat="server" visible="false" class="alert alert-danger d-flex align-items-center p-2 mb-3" role="alert">
                                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                <asp:Label ID="lblValidacion_registroDueño" runat="server" CssClass="m-0 text-dark" />
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer bg-white rounded-bottom-4 d-flex justify-content-between px-4 py-3">
                    <asp:Button ID="btnRegistro" runat="server" ValidationGroup="registrarDueño" Text="Registrar" CssClass="btn btn-success btn-lg px-4 rounded-pill" CausesValidation="true" OnClick="btnRegistro_Click" />
                    <button type="button" class="btn btn-outline-secondary btn-lg px-4 rounded-pill" data-bs-dismiss="modal">Cancelar</button>
                </div>

            </div>
        </div>
    </div>



    <!-- Modal de recupero -->
    <div class="modal fade" id="modalRecupero" tabindex="-1" aria-labelledby="recuperoLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content p-4">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="recuperoLabel">Recupero de usuario</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <h6 class="mb-3">Ingrese correo electrónico o usuario registrado y luego haga click en "Recuperar contraseña".</h6>

                    <asp:Panel runat="server">
                        <asp:TextBox ID="txtCorreoUsuario" placeholder="Correo electrónico / Usuario" runat="server" CssClass="form-control mb-3" />

                        <asp:Label ID="lblRecuperoError" runat="server" CssClass="text-danger" Visible="false" />

                        <asp:Button ID="btnRecuperarClave" runat="server" Text="Recuperar contraseña" CssClass="btn btn-success w-100 fw-bold" OnClick="btnRecuperarClave_Click" />
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>


</asp:Content>

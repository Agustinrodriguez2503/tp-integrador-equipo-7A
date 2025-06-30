<%@ Page Title="" Language="C#" MasterPageFile="~/PaginaPrincipalMasterPage.Master" AutoEventWireup="true" CodeBehind="Admin_PagPrincipal.aspx.cs" Inherits="tp_integrador.Admin_PagPrincipal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="container my-5">
        <h1 class="text-center mb-3">¡BIENVENIDO/A ADMINISTRADOR/A! </h1>
        <asp:Label ID="lblVet" runat="server"
            CssClass="h3 text-center text-secondary mb-5 fw-bold d-block text-dark"
            Text="Listado de veterinarios."></asp:Label>
        <!------------------------ LISTADO DE VETERINARIO ------------------------>
        <asp:GridView ID="gvVeterinarios" runat="server" CssClass="table text-center align-middle" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField HeaderText="Matrícula" DataField="Matricula">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Usuario" DataField="Usuario">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Nombre" DataField="Nombre">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Apellido" DataField="Apellido">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Dni" DataField="Dni">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Estado" DataField="Estado">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>

                <asp:TemplateField HeaderText="Acciones">
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemTemplate>

                        <asp:LinkButton ID="btnHabilitarVet" runat="server"
                            CommandArgument='<%# Eval("Matricula") %>'
                            CommandName="Habilitar"
                            OnClick="btnHabilitarVet_Click"
                            CssClass="btn btn-primary btn-sm fw-bold">
                            <i class="bi bi-check-circle"></i> Habilitar
                        </asp:LinkButton>

                        <asp:LinkButton ID="btnModificarVet" runat="server" CssClass="btn btn-success btn-sm fw-bold"
                            CommandName="Modificar"
                            CommandArgument='<%# Eval("Matricula") %>'
                            OnClick="btnModificarVet_Click">
                            <i class="bi bi-pencil-square"></i> Modificar
                        </asp:LinkButton>

                        <asp:LinkButton ID="btnEliminarVet" runat="server"
                            CommandArgument='<%# Eval("Matricula") %>'
                            CommandName="Eliminar"
                            OnClick="btnHabilitarVet_Click"
                            CssClass="btn btn-danger btn-sm fw-bold"
                            OnClientClick="return confirm('¿Estás seguro de eliminar este recepcionista?');">
                            <i class="bi bi-trash"></i> Eliminar
                        </asp:LinkButton>

                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <div class="col-md-6 d-flex flex-wrap justify-content-center gap-3">
            <asp:LinkButton ID="btnVeterinario" runat="server" Text="Agregar Veterinario" CssClass="btn btn-outline-dark btn-lg rounded-pill px-4" data-bs-toggle="modal" data-bs-target="#modalAltaVeterinario"></asp:LinkButton>
        </div>
        <!------------------------ LISTADO DE RECEPCIONISTA ------------------------>
        <asp:Label ID="lblRec" runat="server"
            CssClass="h3 text-center text-secondary mb-5 fw-bold d-block text-dark"
            Text="Listado de Recepcionistas."></asp:Label>
        <asp:GridView ID="gvRecepcionistas" runat="server" CssClass="table text-center align-middle" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField HeaderText="Legajo" DataField="Legajo">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Usuario" DataField="Usuario">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Nombre" DataField="Nombre">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Apellido" DataField="Apellido">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Dni" DataField="dni">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Estado" DataField="Estado">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>

                <asp:TemplateField HeaderText="Acciones">
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemTemplate>

                        <asp:LinkButton ID="btnHabilitarRec" runat="server"
                            CommandArgument='<%# Eval("Legajo") %>'
                            CommandName="Habilitar"
                            OnClick="btnHabilitarRec_Click"
                            CssClass="btn btn-primary btn-sm fw-bold">
                            <i class="bi bi-check-circle"></i> Habilitar
                        </asp:LinkButton>

                        <asp:LinkButton ID="btnModificarRec" runat="server" CssClass="btn btn-success btn-sm fw-bold"
                            CommandName="Modificar"
                            CommandArgument='<%# Eval("DNI") %>'
                            OnClick="btnModificarRec_Click">
                        <i class="bi bi-pencil-square"></i> Modificar
                        </asp:LinkButton>

                        <asp:LinkButton ID="btnEliminarRec" runat="server"
                            CommandArgument='<%# Eval("Legajo") %>'
                            CommandName="Eliminar"
                            OnClick="btnHabilitarRec_Click"
                            CssClass="btn btn-danger btn-sm fw-bold"
                            OnClientClick="return confirm('¿Estás seguro de eliminar este veterinario?');">
                        <i class="bi bi-trash"></i> Eliminar
                        </asp:LinkButton>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <div class="col-md-6 d-flex flex-wrap justify-content-center gap-3">
            <asp:LinkButton ID="btnRecepcionista" runat="server" Text="Agregar Recepcionista" CssClass="btn btn-outline-dark btn-lg rounded-pill px-4" data-bs-toggle="modal" data-bs-target="#modalAltaRecepcionista"></asp:LinkButton>
        </div>

        <asp:Label ID="lblDueño" runat="server"
            CssClass="h3 text-center text-secondary mb-5 fw-bold d-block text-dark"
            Text="Listado de dueño."></asp:Label>
        <!------------------------ LISTADO DE DUEÑOS ------------------------>
        <asp:GridView ID="gvDueños" runat="server" CssClass="table text-center align-middle" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField HeaderText="Dni" DataField="Dni">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Usuario" DataField="Usuario">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Nombre" DataField="Nombre">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Apellido" DataField="Apellido">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Activo" DataField="Activo">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>

                <asp:TemplateField HeaderText="Acciones">
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemTemplate>

                        <asp:LinkButton ID="btnHabilitarDueño" runat="server"
                            CommandArgument='<%# Eval("Dni") %>'
                            CommandName="Habilitar"
                            OnClick="btnHabilitarDueño_Click"
                            CssClass="btn btn-primary btn-sm fw-bold">
                            <i class="bi bi-check-circle"></i> Habilitar
                        </asp:LinkButton>

                        <asp:LinkButton ID="btnModificarDueño" runat="server" CssClass="btn btn-success btn-sm fw-bold"
                            CommandArgument='<%# Eval("Dni") %>' 
                            CommandName="Modificar"
                            OnClick="btnModificarDueño_Click">
                            <i class="bi bi-pencil-square"></i> Modificar
                        </asp:LinkButton>

                        <asp:LinkButton ID="btnEliminarDueño" runat="server"
                            CommandArgument='<%# Eval("Dni") %>'
                            CommandName="Eliminar"
                            OnClick="btnHabilitarDueño_Click"
                            CssClass="btn btn-danger btn-sm fw-bold"
                            OnClientClick="return confirm('¿Estás seguro de eliminar este dueño?');">
                    <i class="bi bi-trash"></i> Eliminar
                        </asp:LinkButton>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>



    <%-----------------------------          MODAL PARA CARGAR UN VETERINARIO      --------------------------------------%>

    <div class="modal fade" id="modalAltaVeterinario" tabindex="-1" aria-labelledby="modalAltaVeterinarioLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content rounded-4 shadow">

                <div class="modal-header bg-primary text-white rounded-top-4">
                    <h5 class="modal-title fw-semibold" id="modalAltaVeterinarioLabel">
                        <i class="bi bi-person-vcard me-2"></i>Datos Veterinario
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>

                <div class="modal-body bg-light">
                    <div class="container-fluid px-4">
                        <div class="row g-4">

                            <!-- Nombre -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold" for="txtNombreVet">Nombre</label>
                                <asp:TextBox ID="txtNombreVet" runat="server" ValidationGroup="registrarVeterinario" CssClass="form-control form-control-lg shadow-sm rounded-3" placeholder="Ej: Sofía" />
                                <asp:RequiredFieldValidator ID="rfvNombreVet" runat="server" ControlToValidate="txtNombreVet" ValidationGroup="registrarVeterinario" ErrorMessage="El nombre es obligatorio." CssClass="text-danger small fst-italic" Display="Dynamic" />
                            </div>

                            <!-- Apellido -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold" for="txtApellidoVet">Apellido</label>
                                <asp:TextBox ID="txtApellidoVet" runat="server" ValidationGroup="registrarVeterinario" CssClass="form-control form-control-lg shadow-sm rounded-3" placeholder="Ej: Fernández" />
                                <asp:RequiredFieldValidator ID="rfvApellidoVet" runat="server" ControlToValidate="txtApellidoVet" ValidationGroup="registrarVeterinario" ErrorMessage="El apellido es obligatorio." CssClass="text-danger small fst-italic" Display="Dynamic" />
                            </div>

                            <!-- DNI -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold" for="txtDniVet">DNI</label>
                                <asp:TextBox ID="txtDniVet" runat="server" ValidationGroup="registrarVeterinario" CssClass="form-control form-control-lg shadow-sm rounded-3" placeholder="Ej: 30123456" />
                                <asp:RequiredFieldValidator ID="rfvDniVet" runat="server" ControlToValidate="txtDniVet" ValidationGroup="registrarVeterinario" ErrorMessage="El DNI es obligatorio." CssClass="text-danger small fst-italic" Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="revDniVet" runat="server" ControlToValidate="txtDniVet" ValidationGroup="registrarVeterinario" ErrorMessage="Ingrese un DNI válido (7 u 8 dígitos, sin puntos)" CssClass="text-danger small fst-italic" ValidationExpression="^\d{7,8}$" Display="Dynamic" />
                            </div>

                            <!-- Teléfono -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold" for="txtTelefonoVet">Teléfono</label>
                                <asp:TextBox ID="txtTelefonoVet" runat="server" ValidationGroup="registrarVeterinario" CssClass="form-control form-control-lg shadow-sm rounded-3" placeholder="Ej: 11 5555-5555" />
                                <asp:RequiredFieldValidator ID="rfvTelefonoVet" runat="server" ControlToValidate="txtTelefonoVet" ValidationGroup="registrarVeterinario" ErrorMessage="El teléfono es obligatorio." CssClass="text-danger small fst-italic" Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="revTelefonoVet" runat="server" ControlToValidate="txtTelefonoVet" ValidationGroup="registrarVeterinario" ErrorMessage="Formato inválido. Use: 11 5555-5555" CssClass="text-danger small fst-italic" ValidationExpression="^(\+?\d{2,3}\s?)?(\(?\d{2,4}\)?\s?-?)?\d{3,4}-?\d{4}$" Display="Dynamic" />
                            </div>

                            <!-- Correo -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold" for="txtCorreoVet">Correo electrónico</label>
                                <asp:TextBox ID="txtCorreoVet" runat="server" ValidationGroup="registrarVeterinario" CssClass="form-control form-control-lg shadow-sm rounded-3" placeholder="Ej: correo@ejemplo.com" />
                                <asp:RequiredFieldValidator ID="rfvCorreoVet" runat="server" ControlToValidate="txtCorreoVet" ValidationGroup="registrarVeterinario" ErrorMessage="El correo es obligatorio." CssClass="text-danger small fst-italic" Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="revCorreoVet" runat="server" ControlToValidate="txtCorreoVet" ValidationGroup="registrarVeterinario" ErrorMessage="Correo inválido" CssClass="text-danger small fst-italic" ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" Display="Dynamic" />
                            </div>

                            <!-- Imagen URL -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold" for="fuImagenVet">Imagen</label>
                                <asp:TextBox ID="txtImagenVet" runat="server" ValidationGroup="registrarVeterinario" CssClass="form-control form-control-lg shadow-sm rounded-3" placeholder="Ej: http://imagen.com" />
                                <asp:RequiredFieldValidator ID="rfvImagenVet" runat="server" ControlToValidate="txtImagenVet" ValidationGroup="registrarVeterinario"
                                    ErrorMessage="Debe informar URL de la imagen." CssClass="text-danger small fst-italic" Display="Dynamic" />
                            </div>


                            <!-- Matrícula -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold" for="txtMatricula">Matrícula</label>
                                <asp:TextBox ID="txtMatricula" runat="server" ValidationGroup="registrarVeterinario" CssClass="form-control form-control-lg shadow-sm rounded-3" placeholder="Ej: 12345" />
                                <asp:RequiredFieldValidator ID="rfvMatricula" runat="server" ControlToValidate="txtMatricula" ValidationGroup="registrarVeterinario" ErrorMessage="La matrícula es obligatoria." CssClass="text-danger small fst-italic" Display="Dynamic" />
                            </div>

                            <hr class="my-4" />

                            <!-- Alerta -->
                            <div id="divAlertaVeterinario" runat="server" visible="false" class="alert alert-danger d-flex align-items-center p-2 mb-3" role="alert">
                                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                <asp:Label ID="lblValidacion_registroVeterinario" runat="server" CssClass="m-0 text-dark" />
                            </div>

                        </div>
                    </div>
                </div>

                <div class="modal-footer bg-white rounded-bottom-4 d-flex justify-content-between px-4 py-3">
                    <asp:Button ID="btnRegistroVeterinario" runat="server" ValidationGroup="registrarVeterinario" Text="Registrar Veterinario" CssClass="btn btn-success btn-lg px-4 rounded-pill" CausesValidation="true" OnClick="btnRegistroVeterinario_Click" />
                    <button type="button" class="btn btn-outline-secondary btn-lg px-4 rounded-pill" data-bs-dismiss="modal">Cancelar</button>
                </div>

            </div>
        </div>
    </div>

    <%-----------------------------          MODAL PARA CARGAR UN RECEPCIONISTA      --------------------------------------%>

    <div class="modal fade" id="modalAltaRecepcionista" tabindex="-1" aria-labelledby="modalAltaRecepcionistaLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content rounded-4 shadow">

                <div class="modal-header bg-secondary text-white rounded-top-4">
                    <h5 class="modal-title fw-semibold" id="modalAltaRecepcionistaLabel">
                        <i class="bi bi-person-fill-add me-2"></i>Datos Recepcionista
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>

                <div class="modal-body bg-light">
                    <div class="container-fluid px-4">
                        <div class="row g-4">

                            <!-- Nombre -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold" for="txtNombreRec">Nombre</label>
                                <asp:TextBox ID="txtNombreRec" runat="server" CssClass="form-control form-control-lg shadow-sm rounded-3" placeholder="Ej: Camila" ValidationGroup="registrarRecepcionista" />
                                <asp:RequiredFieldValidator ID="rfvNombreRec" runat="server" ControlToValidate="txtNombreRec" ErrorMessage="El nombre es obligatorio." CssClass="text-danger small fst-italic" ValidationGroup="registrarRecepcionista" Display="Dynamic" />
                            </div>

                            <!-- Apellido -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold" for="txtApellidoRec">Apellido</label>
                                <asp:TextBox ID="txtApellidoRec" runat="server" CssClass="form-control form-control-lg shadow-sm rounded-3" placeholder="Ej: Gómez" ValidationGroup="registrarRecepcionista" />
                                <asp:RequiredFieldValidator ID="rfvApellidoRec" runat="server" ControlToValidate="txtApellidoRec" ErrorMessage="El apellido es obligatorio." CssClass="text-danger small fst-italic" ValidationGroup="registrarRecepcionista" Display="Dynamic" />
                            </div>

                            <!-- DNI -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold" for="txtDniRec">DNI</label>
                                <asp:TextBox ID="txtDniRec" runat="server" CssClass="form-control form-control-lg shadow-sm rounded-3" placeholder="Ej: 30123456" ValidationGroup="registrarRecepcionista" />
                                <asp:RequiredFieldValidator ID="rfvDniRec" runat="server" ControlToValidate="txtDniRec" ErrorMessage="El DNI es obligatorio." CssClass="text-danger small fst-italic" ValidationGroup="registrarRecepcionista" Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="revDniRec" runat="server" ControlToValidate="txtDniRec" ErrorMessage="DNI inválido. Ingresá 7 u 8 dígitos." CssClass="text-danger small fst-italic" ValidationGroup="registrarRecepcionista" ValidationExpression="^\d{7,8}$" Display="Dynamic" />
                            </div>

                            <!-- Teléfono -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold" for="txtTelefonoRec">Teléfono</label>
                                <asp:TextBox ID="txtTelefonoRec" runat="server" CssClass="form-control form-control-lg shadow-sm rounded-3" placeholder="Ej: 11 5555-5555" ValidationGroup="registrarRecepcionista" />
                                <asp:RequiredFieldValidator ID="rfvTelefonoRec" runat="server" ControlToValidate="txtTelefonoRec" ErrorMessage="El teléfono es obligatorio." CssClass="text-danger small fst-italic" ValidationGroup="registrarRecepcionista" Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="revTelefonoRec" runat="server" ControlToValidate="txtTelefonoRec" ErrorMessage="Formato inválido. Use: 11 5555-5555" CssClass="text-danger small fst-italic" ValidationGroup="registrarRecepcionista" ValidationExpression="^(\+?\d{2,3}\s?)?(\(?\d{2,4}\)?\s?-?)?\d{3,4}-?\d{4}$" Display="Dynamic" />
                            </div>

                            <!-- Correo -->
                            <div class="col-md-12">
                                <label class="form-label fw-semibold" for="txtCorreoRec">Correo electrónico</label>
                                <asp:TextBox ID="txtCorreoRec" runat="server" CssClass="form-control form-control-lg shadow-sm rounded-3" placeholder="Ej: ejemplo@email.com" ValidationGroup="registrarRecepcionista" />
                                <asp:RequiredFieldValidator ID="rfvCorreoRec" runat="server" ControlToValidate="txtCorreoRec" ErrorMessage="El correo es obligatorio." CssClass="text-danger small fst-italic" ValidationGroup="registrarRecepcionista" Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="revCorreoRec" runat="server" ControlToValidate="txtCorreoRec" ErrorMessage="Correo inválido" CssClass="text-danger small fst-italic" ValidationGroup="registrarRecepcionista" ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" Display="Dynamic" />
                            </div>

                            <!-- Alerta -->
                            <div id="divAlertaRecepcionista" runat="server" visible="false" class="alert alert-danger d-flex align-items-center p-2 mb-3" role="alert">
                                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                <asp:Label ID="lblValidacion_registroRecepcionista" runat="server" CssClass="m-0 text-dark" />
                            </div>

                        </div>
                    </div>
                </div>

                <div class="modal-footer bg-white rounded-bottom-4 d-flex justify-content-between px-4 py-3">
                    <asp:Button ID="btnRegistroRecepcionista" runat="server" Text="Registrar Recepcionista" CssClass="btn btn-secondary btn-lg px-4 rounded-pill" ValidationGroup="registrarRecepcionista" OnClick="btnRegistroRecepcionista_Click" />
                    <button type="button" class="btn btn-outline-secondary btn-lg px-4 rounded-pill" data-bs-dismiss="modal">Cancelar</button>
                </div>

            </div>
        </div>
    </div>

    <!--------------------------------------------- MODAL PARA REGISTRAR UN DUEÑO ---------------------------------------------->

    <div class="modal fade" id="modalRegistrarDueño" tabindex="-1" aria-labelledby="modalRegistrarDueñoLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content rounded-4 shadow">

                <div class="modal-header bg-primary text-white rounded-top-4">
                    <h5 class="modal-title fw-semibold" id="modalRegistrarDueñoLabel">
                        <i class="bi bi-person-lines-fill me-2"></i>Datos Dueño
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
                    <asp:Button ID="btnRegistroDueño" runat="server" ValidationGroup="registrarDueño" Text="Registrar Dueño" CssClass="btn btn-success btn-lg px-4 rounded-pill" CausesValidation="true" OnClick="btnRegistrarDueño_Click" />
                    <button type="button" class="btn btn-outline-secondary btn-lg px-4 rounded-pill" data-bs-dismiss="modal">Cancelar</button>
                </div>

            </div>
        </div>
    </div>




</asp:Content>

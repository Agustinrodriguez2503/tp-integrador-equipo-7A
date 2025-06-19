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
                            <a href="#" data-bs-toggle="modal" data-bs-target="#modalRegistro">¿Aún no tenés cuenta? ¡Registrate!</a>
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
    <div class="modal fade" id="modalRegistro" tabindex="-1" aria-labelledby="registroLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content p-4">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="registroLabel">Registro</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <asp:Panel runat="server">
                        <asp:TextBox ID="txtNombre" placeholder="Nombre" runat="server" CssClass="form-control mb-2" />
                        <asp:TextBox ID="txtApellido" placeholder="Apellido" runat="server" CssClass="form-control mb-2" />
                        <asp:TextBox ID="txtDni" placeholder="DNI" runat="server" CssClass="form-control mb-2" />
                        <asp:TextBox ID="txtTelefono" placeholder="Teléfono" runat="server" CssClass="form-control mb-2" />
                        <asp:TextBox ID="txtCorreo" placeholder="Correo" runat="server" CssClass="form-control mb-2" />
                        <asp:TextBox ID="txtDomicilio" placeholder="Domicilio" runat="server" CssClass="form-control mb-2" />
                        <asp:TextBox ID="txtUsuarioRegistro" placeholder="Usuario" runat="server" CssClass="form-control mb-2" />
                        <asp:TextBox ID="txtClaveRegistro" placeholder="Clave" TextMode="Password" runat="server" CssClass="form-control mb-2" />
                        <asp:Label ID="lblError" runat="server" CssClass="text-danger" Visible="false" />
                        <asp:Button ID="btnRegistro" runat="server" Text="Registrarse" CssClass="btn btn-success w-100 fw-bold" OnClick="btnRegistro_Click" />
                    </asp:Panel>
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

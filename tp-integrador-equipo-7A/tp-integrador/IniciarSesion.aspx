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

        /* Estilo del modal */
        .modal {
            display: none;
            position: fixed;
            z-index: 999;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }

        .modal-content {
            background-color: #fff;
            margin: 10% auto;
            padding: 20px;
            border-radius: 8px;
            width: auto;
            max-width: 600px;
            text-align: left;
            position: relative;
        }

        .cerrar {
            position: absolute;
            top: 10px;
            right: 15px;
            font-size: 20px;
            cursor: pointer;
        }
    </style>

    <script>
        // MODAL DE REGISTRO
        function abrirModalRegistro() {
            document.getElementById("modalRegistro").style.display = "block";
        }

        function cerrarModalRegistro() {
            document.getElementById("modalRegistro").style.display = "none";
        }

        // MODAL DE RECUPERO
        function abrirModalRecupero() {
            document.getElementById("modalRecupero").style.display = "block";
        }

        function cerrarModalRecupero() {
            document.getElementById("modalRecupero").style.display = "none";
        }

        // Cierra el modal si se hace clic fuera
        window.onclick = function (event) {
            const modalRegistro = document.getElementById("modalRegistro");
            const modalRecupero = document.getElementById("modalRecupero");

            if (event.target === modalRegistro) {
                cerrarModalRegistro();
            }
            if (event.target === modalRecupero) {
                cerrarModalRecupero();
            }
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
                            <a href="#" onclick="abrirModalRegistro()">¿Aun no tenés cuenta? Registrate!</a>
                        </div>

                        <div class="enlace-registro-recupero">
                            <a href="#" onclick="abrirModalRecupero()">¿Olvidaste tu clave? Recuperá tu usuario!</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal de registro -->
    <div id="modalRegistro" class="modal">
        <div class="modal-content">
            <span class="cerrar" onclick="cerrarModalRegistro()">&times;</span>
            <h3 class="fw-bold text-center">Registro</h3>
            <h4>Ingrese sus datos.</h4>
            <form>
                <asp:TextBox ID="txtNombre" placeholder="Nombre" runat="server" class="form-control mb-2"></asp:TextBox>
                <asp:TextBox ID="txtApellido" placeholder="Apellido" runat="server" class="form-control mb-2"></asp:TextBox>
                <asp:TextBox ID="txtDni" placeholder="DNI" runat="server" class="form-control mb-2"></asp:TextBox>
                <asp:TextBox ID="txtDomicilio" placeholder="Domicilio" runat="server" class="form-control mb-2"></asp:TextBox>
                <asp:TextBox ID="txtTelefono" placeholder="Teléfono" runat="server" class="form-control mb-2"></asp:TextBox>
                <asp:TextBox ID="txtCorreo" placeholder="Correo" runat="server" class="form-control mb-2"></asp:TextBox>
                <asp:TextBox ID="txtUsuarioRegistro" placeholder="Usuario" runat="server" class="form-control mb-2"></asp:TextBox>
                <asp:TextBox ID="txtClaveRegistro" placeholder="Clave" runat="server" class="form-control mb-2" TextMode="Password" ></asp:TextBox>

                <asp:Button ID="btnRegistro" class="btn btn-success w-100 fw-bold" runat="server" Text="Registrarse" BackColor="lightseagreen" BorderColor="lightseagreen" ForeColor="Black" onclick="btnRegistro_Click"/>

            </form>
        </div>
    </div>

    <!-- Modal de recupero -->
    <div id="modalRecupero" class="modal">
        <div class="modal-content">
            <span class="cerrar" onclick="cerrarModalRecupero()">&times;</span>
            <h3 class="fw-bold text-center">Recupero de usuario</h3>
            <h5>Ingrese correo electrónico o usuario registrado y luego haga click en "Recuperar contraseña".</h5>
            <form>
                <asp:TextBox ID="txtCorreoUsuario" placeholder="Correo electrónico/Usuario" runat="server" class="form-control mb-2"></asp:TextBox>

                <asp:Button ID="btnRecuperarClave" class="btn btn-success w-100 fw-bold" runat="server" Text="Recuperar contraseña" BackColor="lightseagreen" BorderColor="lightseagreen" ForeColor="Black" />
            </form>
        </div>
    </div>

</asp:Content>

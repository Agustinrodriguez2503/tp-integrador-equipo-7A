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
        // MODAL DE REGISTRO DE MASCOTA
        function abrirModalRegistroMascota() {
            document.getElementById("modalAltaMascota").style.display = "block";
        }

        function cerrarModalRegistroMascota() {
            document.getElementById("modalAltaMascota").style.display = "none";
        }

        //// MODAL DE RECUPERO
        //function abrirModalRecupero() {
        //    document.getElementById("modalRecupero").style.display = "block";
        //}

        //function cerrarModalRecupero() {
        //    document.getElementById("modalRecupero").style.display = "none";
        //}

        // Cierra el modal si se hace clic fuera
        window.onclick = function (event) {
            const modalRegistroMascota = document.getElementById("modalAltaMascota");
            const modalRecupero = document.getElementById("modalRecupero");

            if (event.target === modalRegistroMascota) {
                cerrarModalRegistroMascota();
            }
        }
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container my-5">
        <h1 class="text-center mb-3">¡BIENVENIDO/A!</h1>
        <h3 class="text-center text-secondary mb-5">Agustin Alejandro Rodriguez</h3>

        <div class="row g-4 justify-content-center">
            <div class="col-md-6 col-lg-4">
                <a href="#" onclick="abrirModalRegistroMascota()" class="card-link-custom">
                    <div class="card custom-card h-100 text-center card-verde-agua">
                        <div class="card-body">
                            <h5 class="card-title">ALTA DE MASCOTA</h5>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-6 col-lg-4">
                <a href="" class="card-link-custom">
                    <div class="card custom-card h-100 text-center card-verde-agua">
                        <div class="card-body">
                            <h5 class="card-title">LISTADO DE MASCOTAS</h5>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-6 col-lg-4">
                <a href="" class="card-link-custom">
                    <div class="card custom-card h-100 text-center card-verde-agua">
                        <div class="card-body">
                            <h5 class="card-title">TURNOS</h5>
                        </div>
                    </div>
                </a>
            </div>
        </div>

        <div class="row g-4 justify-content-right mt-2">
            <div class="col-md-6 col-lg-4">
                <a href="" class="card-link-custom">
                    <div class="card custom-card h-100 text-center card-verde-agua">
                        <div class="card-body">
                            <h5 class="card-title">CONSULTAS DE FICHAS</h5>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-6 col-lg-4">
                <a href="" class="card-link-custom">
                    <div class="card custom-card h-100 text-center card-verde-agua">
                        <div class="card-body">
                            <h5 class="card-title">MENSAJERIA</h5>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>

    <!-- Modal de alta de mascota -->
    <div id="modalAltaMascota" class="modal">
        <div class="modal-content">
            <span class="cerrar" onclick="cerrarModalRegistroMascota()">&times;</span>
            <h3 class="fw-bold text-center">Registro de mascota</h3>
            <h4>Ingrese los datos de su mascota.</h4>
            <form>
                <asp:TextBox ID="txtNombreMascota" placeholder="Nombre" runat="server" class="form-control mb-2"></asp:TextBox>
                <asp:TextBox ID="txtEdadMascota" placeholder="Edad" runat="server" class="form-control mb-2"></asp:TextBox>
                <asp:TextBox ID="txtFechaNacimientoMascota" placeholder="Fecha de nacimiento" runat="server" class="form-control mb-2"></asp:TextBox>
                <asp:TextBox ID="txtPesoMascota" placeholder="Peso" runat="server" class="form-control mb-2"></asp:TextBox>
                <asp:TextBox ID="txtTipoMascota" placeholder="Tipo" runat="server" class="form-control mb-2"></asp:TextBox>
                <asp:TextBox ID="txtRazaMascota" placeholder="Raza" runat="server" class="form-control mb-2"></asp:TextBox>
                <asp:TextBox ID="txtSexoMascota" placeholder="Sexo" runat="server" class="form-control mb-2"></asp:TextBox>

                <asp:Button ID="btnRegistroMascota" class="btn btn-success w-100 fw-bold" runat="server" Text="Registrar mascota" BackColor="lightseagreen" BorderColor="lightseagreen" ForeColor="Black" onclick="btnRegistroMascota_Click" />

            </form>
        </div>
    </div>

</asp:Content>

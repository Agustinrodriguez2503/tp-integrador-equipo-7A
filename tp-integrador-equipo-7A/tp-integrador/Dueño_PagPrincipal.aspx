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
            z-index: 1050;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
        }

        .modal-content {
            background-color: #fff;
            margin: 10% auto;
            padding: 2rem;
            border-radius: 1rem;
            width: 100%;
            max-width: 500px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.3);
            position: relative;
        }

        .btn-close {
            position: absolute;
            top: 1rem;
            right: 1rem;
            background: transparent;
            border: none;
            font-size: 1.5rem;
        }

        .btn-success {
            background-color: lightseagreen;
            border-color: lightseagreen;
            color: black;
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

        // MODAL DATOS DE CLIENTE
        function abrirModalDatosCliente() {
            document.getElementById("modalDatosCliente").style.display = "block";
        }

        function cerrarModalDatosCliente() {
            document.getElementById("modalDatosCliente").style.display = "none";
        }

        // MODAL DE REGISTRO DE MASCOTA
        function abrirModalModificacionMascota() {
            document.getElementById("modalModificacionMascota").style.display = "block";
        }

        function cerrarModalModificacionMascota() {
            document.getElementById("modalModificacionMascota").style.display = "none";
        }

        // Cierra el modal si se hace clic fuera
        window.onclick = function (event) {
            const modalRegistroMascota = document.getElementById("modalAltaMascota");
            const modalModificacionCliente = document.getElementById("modalDatosCliente");

            if (event.target === modalRegistroMascota) {
                cerrarModalRegistroMascota();
            }
            if (event.target === modalModificacionCliente) {
                cerrarModalDatosCliente();
            }
            if (event.target === modalModificacionMascota) {
                cerrarModalModificacionMascota();
            }
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container my-5">
        <h1 class="text-center mb-3">¡BIENVENIDO/A!</h1>
        <asp:Label ID="lblBienvenido" runat="server"
            CssClass="h3 text-center text-secondary mb-5 fw-bold d-block text-dark"
            Text=""></asp:Label>

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
                            <asp:LinkButton ID="btnTurno" runat="server" CssClass="btn btn-primary btn-sm fw-bold">
            <i class="bi bi-calendar-check"></i> Turno
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnFicha" runat="server" CssClass="btn btn-info btn-sm fw-bold">
            <i class="bi bi-file-earmark-text"></i> Ficha
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnModificar" runat="server" CssClass="btn btn-success btn-sm fw-bold"
                                CommandArgument='<%# Eval("IDMascota") %>'
                                OnClick="btnModificar_Click">
    <i class="bi bi-pencil-square"></i> Modificar
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnEliminar" runat="server"
                                CssClass="btn btn-danger btn-sm fw-bold"
                                OnClientClick="return confirm('¿Estás seguro de eliminar esta mascota?');">
            <i class="bi bi-trash"></i> Eliminar
                            </asp:LinkButton>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

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
                <a href="#" onclick="abrirModalDatosCliente()" class="card-link-custom">
                    <div class="card custom-card h-100 text-center card-verde-agua">
                        <div class="card-body">
                            <h5 class="card-title">MIS DATOS</h5>
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

    <!-- Modal de modificación de mascota -->
    <div id="modalModificacionMascota" class="modal">
        <div class="modal-content">
            <span class="cerrar" onclick="cerrarModalModificacionMascota()">&times;</span>
            <h3 class="fw-bold text-center">Registro de mascota</h3>
            <p class="text-muted text-center">Ingrese los datos de su mascota.</p>
            <form>
                <asp:TextBox ID="txtModificarNombre" placeholder="" runat="server" class="form-control mb-2"></asp:TextBox>
                <asp:TextBox ID="txtModificarEdad" placeholder="" runat="server" class="form-control mb-2" TextMode="Number"></asp:TextBox>
                <asp:TextBox ID="txtModificarNacimiento" placeholder="" runat="server" class="form-control mb-2" TextMode="Date"></asp:TextBox>
                <asp:TextBox ID="txtModificarPeso" placeholder="" runat="server" class="form-control mb-2" TextMode="Number"></asp:TextBox>
                <asp:TextBox ID="txtModificarTipo" placeholder="" runat="server" class="form-control mb-2"></asp:TextBox>
                <asp:TextBox ID="txtModificarRaza" placeholder="" runat="server" class="form-control mb-2"></asp:TextBox>
                <asp:DropDownList ID="ddlModificarSexo" runat="server" CssClass="form-control mb-2">
                    <asp:ListItem Text="Seleccione el sexo" Value="" Disabled="true" Selected="true" />
                    <asp:ListItem Text="Macho" Value="Macho" />
                    <asp:ListItem Text="Hembra" Value="Hembra" />
                </asp:DropDownList>

                <asp:Button ID="btnGuardarMascota" onclick="btnGuardarMascota_Click" class="btn btn-success w-100 fw-bold" runat="server" Text="Modificar mascota" BackColor="lightseagreen" BorderColor="lightseagreen" ForeColor="Black" />
            </form>
        </div>
    </div>



    <!-- Modal de alta de mascota -->
    <div id="modalAltaMascota" class="modal">
        <div class="modal-content">
            <span class="cerrar" onclick="cerrarModalRegistroMascota()">&times;</span>
            <h3 class="fw-bold text-center">Registro de mascota</h3>
            <p class="text-muted text-center">Ingrese los datos de su mascota.</p>
            <form>
                <asp:TextBox ID="txtNombreMascota" placeholder="Nombre" runat="server" class="form-control mb-2"></asp:TextBox>
                <asp:TextBox ID="txtEdadMascota" placeholder="Edad (años)" runat="server" class="form-control mb-2" TextMode="Number"></asp:TextBox>
                <asp:TextBox ID="txtFechaNacimientoMascota" placeholder="Fecha de nacimiento" runat="server" class="form-control mb-2" TextMode="Date"></asp:TextBox>
                <asp:TextBox ID="txtPesoMascota" placeholder="Peso (kg)" runat="server" class="form-control mb-2" TextMode="Number"></asp:TextBox>
                <asp:TextBox ID="txtTipoMascota" placeholder="Tipo" runat="server" class="form-control mb-2"></asp:TextBox>
                <asp:TextBox ID="txtRazaMascota" placeholder="Raza" runat="server" class="form-control mb-2"></asp:TextBox>
                <asp:DropDownList ID="ddlSexoMascota" runat="server" CssClass="form-control mb-2">
                    <asp:ListItem Text="Seleccione el sexo" Value="" Disabled="true" Selected="true" />
                    <asp:ListItem Text="Macho" Value="Macho" />
                    <asp:ListItem Text="Hembra" Value="Hembra" />
                </asp:DropDownList>

                <asp:Button ID="btnRegistroMascota" class="btn btn-success w-100 fw-bold" runat="server" Text="Registrar mascota" BackColor="lightseagreen" BorderColor="lightseagreen" ForeColor="Black" OnClick="btnRegistroMascota_Click" />
            </form>
        </div>
    </div>

    <!-- Modal de datos de cliente -->
    <div id="modalDatosCliente" class="modal">
        <div class="modal-content">
            <span class="cerrar" onclick="cerrarModalDatosCliente()">&times;</span>
            <h3 class="fw-bold text-center">Mis datos</h3>
            <p class="text-muted text-center">Modifique los datos que desee.</p>
            <form>
                <asp:TextBox ID="txtDni" placeholder="DNI" runat="server" class="form-control mb-2"></asp:TextBox>
                <asp:TextBox ID="txtNombre" placeholder="Nombre" runat="server" class="form-control mb-2"></asp:TextBox>
                <asp:TextBox ID="txtApellido" placeholder="Apellido" runat="server" class="form-control mb-2"></asp:TextBox>
                <asp:TextBox ID="txtTelefono" placeholder="Teléfono" runat="server" class="form-control mb-2"></asp:TextBox>
                <asp:TextBox ID="txtCorreo" placeholder="Correo" runat="server" class="form-control mb-2"></asp:TextBox>
                <asp:TextBox ID="txtDomicilio" placeholder="Domicilio" runat="server" class="form-control mb-2"></asp:TextBox>

                <asp:Button ID="btnModificarDueño" class="btn btn-success w-100 fw-bold" runat="server" Text="Guardar datos" BackColor="lightseagreen" BorderColor="lightseagreen" ForeColor="Black" />
            </form>
        </div>
    </div>

</asp:Content>

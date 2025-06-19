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

    <!------------------------ MODAL DE MODIFICACIÓN DE MASCOTA ------------------------>
    <div class="modal fade" id="modalModificacionMascota" tabindex="-1" aria-labelledby="modificacionMascotaLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content p-4">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="modificacionMascotaLabel">Modificación de mascota</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <p class="text-muted text-center">Actualice los datos de su mascota.</p>
                    <asp:Panel runat="server">
                        <asp:TextBox ID="txtNombreMascotaMod" placeholder="Nombre" runat="server" CssClass="form-control mb-2" />
                        <asp:TextBox ID="txtEdadMascotaMod" placeholder="Edad (años)" runat="server" CssClass="form-control mb-2" TextMode="Number" />
                        <asp:TextBox ID="txtFechaNacimientoMascotaMod" placeholder="Fecha de nacimiento" runat="server" CssClass="form-control mb-2" TextMode="Date" />
                        <asp:TextBox ID="txtPesoMascotaMod" placeholder="Peso (kg)" runat="server" CssClass="form-control mb-2" TextMode="Number" />
                        <asp:TextBox ID="txtTipoMascotaMod" placeholder="Tipo" runat="server" CssClass="form-control mb-2" />
                        <asp:TextBox ID="txtRazaMascotaMod" placeholder="Raza" runat="server" CssClass="form-control mb-2" />
                        <asp:DropDownList ID="ddlSexoMascotaMod" runat="server" CssClass="form-control mb-2">
                            <asp:ListItem Text="Seleccione el sexo" Value="" Disabled="true" Selected="true" />
                            <asp:ListItem Text="Macho" Value="Macho" />
                            <asp:ListItem Text="Hembra" Value="Hembra" />
                        </asp:DropDownList>
                        <asp:Button ID="btnModificarMascota" runat="server" Text="Guardar cambios" CssClass="btn btn-primary w-100 fw-bold" OnClick="btnGuardarMascota_Click" />
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>

    <!------------------------ MODAL DE ALTA DE MASCOTA ------------------------>
    <div class="modal fade" id="modalAltaMascota" tabindex="-1" aria-labelledby="altaMascotaLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content p-4">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="altaMascotaLabel">Registro de mascota</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <p class="text-muted text-center">Ingrese los datos de su mascota.</p>

                    <asp:Panel ID="panelAltaMascota" runat="server">
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
                        <asp:Label ID="lblRegistroMascota" runat="server" Text=""></asp:Label>
                        <asp:Button ID="btnRegistroMascota" class="btn btn-success w-100 fw-bold" runat="server" Text="Registrar mascota" OnClick="btnRegistroMascota_Click" />
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>

    <!------------------------ MODAL DE DATOS DE DUEÑO ------------------------>
    <div class="modal fade" id="modalDatosCliente" tabindex="-1" aria-labelledby="datosClienteLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content p-4">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="datosClienteLabel">Mis datos</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <p class="text-muted text-center">Modifique sus datos personales.</p>
                    <asp:Panel runat="server">
                        <asp:TextBox ID="txtNombreCliente" placeholder="Nombre" runat="server" CssClass="form-control mb-2" />
                        <asp:TextBox ID="txtApellidoCliente" placeholder="Apellido" runat="server" CssClass="form-control mb-2" />
                        <asp:TextBox ID="txtTelefonoCliente" placeholder="Teléfono" runat="server" CssClass="form-control mb-2" TextMode="Phone" />
                        <asp:TextBox ID="txtDireccionCliente" placeholder="Dirección" runat="server" CssClass="form-control mb-2" />
                        <asp:TextBox ID="txtCorreoCliente" placeholder="Correo electrónico" runat="server" CssClass="form-control mb-2" TextMode="Email" />
                        <asp:TextBox ID="txtDniCliente" placeholder="DNI" runat="server" CssClass="form-control mb-2" TextMode="Number" ReadOnly="true" />
                        <asp:Label ID="lblDatosCliente" runat="server" Text=""></asp:Label>
                        <asp:Button ID="btnGuardarDatosCliente" OnClick="btnGuardarDatosCliente_Click" runat="server" Text="Guardar datos" CssClass="btn btn-success w-100 fw-bold" />
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

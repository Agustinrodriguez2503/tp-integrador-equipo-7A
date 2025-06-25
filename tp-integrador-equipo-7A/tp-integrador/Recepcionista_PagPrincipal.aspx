<%@ Page Title="" Language="C#" MasterPageFile="~/RecepcionistaMasterPage.Master" AutoEventWireup="true" CodeBehind="Recepcionista_PagPrincipal.aspx.cs" Inherits="tp_integrador.Recepcionista_PagPrincipal" %>
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
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
    <asp:ScriptManager runat="server" ID="sm_PaginaInicialRecep"></asp:ScriptManager>
    
    <div class="container my-5">
        <h1 class="text-center mb-3">¡BIENVENIDO/A!</h1>
        <h3 class="text-center text-secondary mb-5" runat ="server" id="recepcionista"></h3>


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
       
        <div class="row g-4 justify-content-center mt-5" >
            <div class="col-12 col-md-6">
                <asp:UpdatePanel runat="server" Visible="false" ID="upPanelTurnos">
                    <ContentTemplate>
                        <!-- Se solicita que se ingrese el DNI del dueño -->
                        <div class="mb-3">
                            <label for="txtDueño" class="form-label fw-semibold">Ingrese el DNI del dueño de la mascota</label>
                            <asp:TextBox 
                                ID="txtDueño" 
                                runat="server" 
                                CssClass="form-control form-control-lg shadow-sm rounded-3" 
                                placeholder="Ej: 30123456" OnTextChanged="txtDueño_TextChanged" AutoPostBack="true">
                            </asp:TextBox>
                            <asp:Label 
                                ID="lblDniNoValido" 
                                runat="server" 
                                CssClass="text-danger fw-semibold mt-1" Visible="false">
                            </asp:Label>

                        </div>

                        <!-- Luego que se ingreso el DNI se carga automaticamente el ddl -->
                        <div class="mb-3">
                            <label for="ddlMascota" class="form-label fw-semibold">Seleccioná la mascota que desea asignarle un turno</label>
                            <asp:DropDownList 
                                ID="ddlMascota" 
                                runat="server" 
                                CssClass="form-select form-select-lg shadow-sm rounded-3" Enabled="false" 
                                OnSelectedIndexChanged="ddlMascota_SelectedIndexChanged" AutoPostBack="true">
                            </asp:DropDownList>
                            <asp:Label 
                                ID="lbl_ddlMascotas" 
                                runat="server" 
                                Text="Debe seleccionar una mascota para continuar." 
                                CssClass="text-danger fw-semibold mt-1" Visible="false">
                            </asp:Label>
                        </div>
                        <div class="mb-3 text-center">
                            <asp:Button 
                                ID="btnBuscarTurno" 
                                runat="server" 
                                Text="Buscar Turnos" 
                                CssClass="btn-cobro-hover btn-lg fw-semibold shadow-sm" 
                                Enabled="false" 
                                OnClick="btnBuscarTurno_Click" />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>

        <%-- PANERL PARA REGISTRAR UN DUEÑO, MASCOTA, VETERINARIO O RECEPCIONISTA. --%>


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

                                  <asp:Button ID="btnAgregarMascota" runat="server" Text="Mascota" CssClass="btn btn-outline-success btn-lg rounded-pill px-4" OnClick="btnAgregarMascota_Click"/>

                                  <div class="input-group mt-2" style="min-width: 250px" >
                                    <asp:TextBox ID="txtBuscarMascota" Visible="false" runat="server" CssClass="form-control form-control-lg shadow-sm rounded-start-3" placeholder="Ingrese DNI del dueño" />
                                    <asp:Button ID="btnBuscarMascota" Visible="false" runat="server" Text="+" CssClass="btn btn-outline-secondary btn-lg px-3 rounded-end-3" />
                                  </div>

                                </div>

                                <!-- Separador visual -->
                                <div class="col-12 my-3 text-center">
                                  <span class="text-muted">— o —</span>
                                </div>

                                <!-- Grupo 2: Recepcionista y Veterinario -->
                                <div class="col-md-6 d-flex flex-wrap justify-content-center gap-3">

                                  <asp:Button ID="btnRecepcionista" runat="server" Text="Recepcionista" CssClass="btn btn-outline-secondary btn-lg rounded-pill px-4" />

                                  <asp:Button ID="btnVeterinario" runat="server" Text="Veterinario" CssClass="btn btn-outline-dark btn-lg rounded-pill px-4" />

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
        <asp:UpdatePanel ID="upRegistrarDueño" runat="server" />
            <ContentTemplate>
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
                              <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control form-control-lg shadow-sm rounded-3"  placeholder="Ej: Laura" />
                            </div>

                            <!-- Apellido -->
                            <div class="col-md-6">
                              <label class="form-label fw-semibold" for="txtApellido">Apellido</label>
                              <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control form-control-lg shadow-sm rounded-3" placeholder="Ej: González" />
                            </div>

                            <!-- DNI -->
                            <div class="col-md-6">
                              <label class="form-label fw-semibold" for="txtDni">DNI</label>
                              <asp:TextBox ID="txtDni" runat="server" CssClass="form-control form-control-lg shadow-sm rounded-3" placeholder="Ej: 30123456" />
                            </div>

                            <!-- Teléfono -->
                            <div class="col-md-6">
                              <label class="form-label fw-semibold" for="txtTelefono">Teléfono</label>
                              <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control form-control-lg shadow-sm rounded-3" placeholder="Ej: 11 5555-5555" />
                            </div>

                            <!-- Correo -->
                            <div class="col-md-6">
                              <label class="form-label fw-semibold" for="txtCorreo">Correo electrónico</label>
                              <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control form-control-lg shadow-sm rounded-3" TextMode="Email" placeholder="Ej: correo@ejemplo.com" />
                            </div>

                            <!-- Domicilio -->
                            <div class="col-md-6">
                              <label class="form-label fw-semibold" for="txtDomicilio">Domicilio</label>
                              <asp:TextBox ID="txtDomicilio" runat="server" CssClass="form-control form-control-lg shadow-sm rounded-3" placeholder="Ej: Av. Rivadavia 1234" />
                            </div>

                            <hr class="my-4">
            
                            <div class="col-md-6">
                                <asp:Label CssClass="text-danger" ID="lblValidacion_registroDueño" Visible="false" runat="server" />
                            </div>

                           <%-- <!-- Usuario -->
                            <div class="col-md-6">
                              <label class="form-label fw-semibold" for="txtUsuario">Usuario</label>
                              <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control form-control-lg shadow-sm rounded-3" placeholder="Ej: laura123" />
                            </div>

                            <!-- Clave -->
                            <div class="col-md-6">
                              <label class="form-label fw-semibold" for="txtClave">Clave</label>
                              <asp:TextBox ID="txtClave" runat="server" CssClass="form-control form-control-lg shadow-sm rounded-3" TextMode="Password" placeholder="Contraseña segura" />
                            </div>--%>

                          </div>
                        </div>
                      </div>

                      <div class="modal-footer bg-white rounded-bottom-4 d-flex justify-content-between px-4 py-3">
                        <asp:Button ID="btnRegistrarDueño" runat="server" Text="Registrar" CssClass="btn btn-success btn-lg px-4 rounded-pill" OnClick="btnRegistrarDueño_Click" />
                        <button type="button" class="btn btn-outline-secondary btn-lg px-4 rounded-pill" data-bs-dismiss="modal">Cancelar</button>
                      </div>

                    </div>
                  </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        
</asp:Content>

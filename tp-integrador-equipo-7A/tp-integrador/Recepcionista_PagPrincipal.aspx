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
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>
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
                <a href="registrar.aspx" class="card-link-custom">
                    <div class="card custom-card h-100 text-center card-verde-agua">
                        <div class="card-body">
                            <h5 class="card-title">REGISTRAR</h5>
                        </div>
                    </div>
                </a>
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
                        <!-- Descripción del DNI -->
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
                                Text="El DNI ingresado no pertenece a un Dueño registrado" 
                                CssClass="text-danger fw-semibold mt-1" Visible="false">
                            </asp:Label>

                        </div>

                        <!-- Título para la selección de mascota -->
                        <div class="mb-3">
                            <label for="ddlMascota" class="form-label fw-semibold">Seleccioná la mascota que desea asignarle un turno</label>
                            <asp:DropDownList 
                                ID="ddlMascota" 
                                runat="server" 
                                CssClass="form-select form-select-lg shadow-sm rounded-3" Enabled="false" 
                                OnSelectedIndexChanged="ddlMascota_SelectedIndexChanged" AutoPostBack="true">
                            </asp:DropDownList>
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


</asp:Content>

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
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container my-5">
    <h1 class="text-center mb-3">¡BIENVENIDO/A!</h1>
    <h3 class="text-center text-secondary mb-5">Maria Sol Desimone</h3>

    <div class="row g-4 justify-content-center">
        <div class="col-md-6 col-lg-4">
            <a href="turno.aspx" class="card-link-custom">
                <div class="card custom-card h-100 text-center card-verde-agua">
                    <div class="card-body">
                        <h5 class="card-title">TURNOS</h5>
                    </div>
                </div>
            </a>
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
</div>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/RecepcionistaMasterPage.Master" AutoEventWireup="true" CodeBehind="Recepcionista_Cobros.aspx.cs" Inherits="tp_integrador.Recepcionista_Cobros" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        /*------DropDown de turnos------*/
        .ddl-estetico {
            width: 100%;
            padding: 0.6rem;
            font-size: 1rem;
            border-radius: 0.5rem;
            border: 1px solid #ced4da;
            background-color: #f8f9fa;
            color: #212529;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
        }

            .ddl-estetico:hover {
                border-color: #20c997;
                background-color: #e9f7f3;
            }

            .ddl-estetico:focus {
                outline: none;
                border-color: #20c997;
                box-shadow: 0 0 0 0.2rem rgba(32, 201, 151, 0.25);
            }
        /*--------------------------------------------------------------------------------*/

        .text-verde-agua {
            color: #20c997;
        }

        .bg-verde-agua {
            background-color: #20c997 !important;
        }

        .bg-verde-agua-claro {
            background-color: #e6f8f5;
        }

        .border-verde-agua {
            border-color: #20c997 !important;
        }

        .info-box {
            background-color: #fff;
            padding: 1rem;
            border-left: 4px solid #20c997;
            border-radius: 0.5rem;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 100%;
        }

            .info-box .label {
                font-size: 0.9rem;
                color: #6c757d;
                margin-bottom: 0.25rem;
            }

            .info-box .value {
                font-weight: 600;
                font-size: 1.05rem;
                color: #212529;
            }

        .card-header i {
            font-size: 1.2rem;
        }
        /*---------------BOTON--------------------*/
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
    <div class="container my-5">

        <!-- ENCABEZADO -->
        <div class="text-center mb-5">
            <h2 class="fw-bold text-verde-agua">Registrar Cobro</h2>
            <p class="text-muted">Complete los siguientes datos para registrar el cobro del turno</p>
        </div>

        <!-- SELECCIÓN DE TURNO -->
        <div class="mb-4">
            <asp:DropDownList ID="ddlTurnos" runat="server"
                CssClass="form-label fw-semibold ddl-estetico"
                AutoPostBack="true" OnSelectedIndexChanged="ddlTurnos_SelectedIndexChanged">
            </asp:DropDownList>
        </div>

        <!-- RESUMEN DEL TURNO -->
        <div class="card shadow-sm rounded-4 mb-5">
            <div class="card-header bg-verde-agua text-white rounded-top-4">
                <h5 class="mb-0 fw-semibold"><i class="bi bi-info-circle-fill me-2"></i>Resumen del Turno</h5>
            </div>

            <div class="card-body bg-light">
                <div class="row g-4">

                    <div class="col-md-4">
                        <div class="info-box">
                            <asp:Label ID="lblVeterinario" runat="server" CssClass="label">Veterinario</asp:Label>
                            <asp:Label ID="lblNombreVete" runat="server" CssClass="value"></asp:Label>
                            <asp:Label ID="lblMatriculaVete" runat="server" CssClass="text-muted small"></asp:Label>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="info-box">
                            <asp:Label ID="lblMascota" runat="server" CssClass="label">Mascota</asp:Label>
                            <asp:Label ID="lblNombreMascota" runat="server" CssClass="value"></asp:Label>
                            <asp:Label ID="lblDatoMascota" runat="server" CssClass="text-muted small"></asp:Label>

                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="info-box">
                            <asp:Label ID="lblDuenio" runat="server" CssClass="label">Dueño</asp:Label>
                            <asp:Label ID="lblNombreDuenio" runat="server" CssClass="value"></asp:Label>
                            <asp:Label ID="lblDatoDuenio" runat="server" CssClass="text-muted small"></asp:Label>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <!-- FORMULARIO DE COBRO -->
        <div class="row g-4">
            <div class="col-md-4">
                <label class="form-label fw-semibold">Forma de Pago</label>
                <asp:DropDownList ID="ddlFormaPago" runat="server" CssClass="form-select shadow-sm" OnSelectedIndexChanged="ddlFormaPago_SelectedIndexChanged" AutoPostBack="true">
                    <asp:ListItem Text="-- Seleccionar --" Value="" />
                    <asp:ListItem Text="Efectivo" />
                    <asp:ListItem Text="Tarjeta" />
                    <asp:ListItem Text="Transferencia" />
                </asp:DropDownList>
            </div>

            <div class="col-md-4">
                <label class="form-label fw-semibold">Nro. Comprobante</label>
                <asp:TextBox ID="tbxComprobante" runat="server" CssClass="form-control shadow-sm" Enabled="false"></asp:TextBox>
            </div>

            <div class="col-md-4">
                <label class="form-label fw-semibold">Costo ($)</label>
                <asp:TextBox ID="tbxImporte" runat="server" CssClass="form-control shadow-sm"></asp:TextBox>
            </div>
        </div>

        <!-- BOTÓN -->
        <div class="d-grid mt-5">
            <asp:Button
                ID="btnRegistrarCobro"
                runat="server"
                Text="Registrar Cobro"
                CssClass="btn btn-cobro-hover btn-lg fw-semibold shadow-sm"
                OnClick="btnRegistrarCobro_Click"
                UseSubmitBehavior="false" />
        </div>

    </div>

</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/RecepcionistaMasterPage.Master" AutoEventWireup="true" CodeBehind="Turnos.aspx.cs" Inherits="tp_integrador.Turnos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="container mt-5 px-4">
        <!-- Título -->
        <div class="row mb-4 text-center">
            <div class="col">
                <h2 class="fw-bold titulo-pagina">Seleccioná un Veterinario</h2>
                <p class="subtitulo-pagina">Elegí un profesional para ver sus turnos disponibles</p>
            </div>
        </div>

        <!-- Cards de Veterinarios -->
        <div class="row g-4 mb-5" id="veterinarios">
            <asp:Repeater runat="server" ID="repVeterinarios">
                <ItemTemplate>
                    <div class="col-12 col-sm-6 col-md-6 col-lg-4">
                        <asp:LinkButton
                            runat="server"
                            CssClass="text-decoration-none text-reset d-block h-100"
                            CommandArgument='<%#Eval("Matricula") %>'
                            OnCommand="seleccionarVeterinario_Command">

                            <div class="card card-selectable h-100 shadow border-0 rounded-4 overflow-hidden">
                                <asp:Image
                                    ID="imgVet"
                                    runat="server"
                                    CssClass="card-img-top img-fluid"
                                    ImageUrl='<%#Eval("Imagen") %>'
                                    AlternateText="Veterinario"
                                    Style="max-height: 240px; object-fit: contain; background-color: #f8f9fa;" />
                                <div class="card-body text-center">
                                    <h5 class="card-title fw-semibold mb-1">
                                        <%#Eval("Nombre") + " " + Eval("Apellido") %>
                                    </h5>
                                    <p class="card-text text-muted mb-0">
                                        Matrícula: <%#Eval("Matricula") %>
                                    </p>
                                </div>
                            </div>
                        </asp:LinkButton>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- Turnos disponibles -->
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <hr class="border border-2 opacity-50" style="border-color: #20c997;" />
                <!-- Sección encabezado -->
                <div class="row justify-content-center mb-4">
                    <div class="col-lg-8 text-center">
                        <div class="p-3 rounded-4 shadow-sm border" style="background-color: #e6f7f4;">
                            <div class="fs-5 fw-semibold" style="color: #20c997;">
                                <asp:Literal ID="litTituloTurnos" runat="server" />
                            </div>

                        </div>
                    </div>
                </div>


                <!-- Tabla de turnos -->
                <div class="row justify-content-center" id="seccionTurnos">
                    <div class="col-12">
                        <div class="table-responsive rounded-4 shadow-sm border overflow-hidden">
                            <asp:GridView ID="dgvTurnos" runat="server"
                                CssClass="table align-middle mb-0 table-hover text-center w-100"
                                HeaderStyle-BackColor="#20c997"
                                HeaderStyle-ForeColor="white"
                                HeaderStyle-HorizontalAlign="Center"
                                RowStyle-HorizontalAlign="Center"
                                AutoGenerateColumns="false"
                                GridLines="None"
                                DataKeyNames="Turno"
                                AllowPaging="true"
                                PageSize="5"
                                PagerStyle-HorizontalAlign="Center"
                                PagerStyle-CssClass="pager-custom"
                                OnSelectedIndexChanged="dgvTurnos_SelectedIndexChanged"
                                OnPageIndexChanging="dgvTurnos_PageIndexChanging">
                                <Columns>
                                    <asp:BoundField HeaderText="Turno Disponible" DataField="Turno"
                                        DataFormatString="{0:dddd dd/MM/yyyy - HH:mm}" HtmlEncode="false" />
                                    <asp:CommandField ShowSelectButton="true"
                                        SelectText="Seleccionar"
                                        HeaderText="Elegir Turno"
                                        ButtonType="Button" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>


            </ContentTemplate>
        </asp:UpdatePanel>


    </div>
</asp:Content>

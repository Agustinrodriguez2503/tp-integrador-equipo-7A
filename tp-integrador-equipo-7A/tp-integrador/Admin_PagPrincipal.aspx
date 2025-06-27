<%@ Page Title="" Language="C#" MasterPageFile="~/PaginaPrincipalMasterPage.Master" AutoEventWireup="true" CodeBehind="Admin_PagPrincipal.aspx.cs" Inherits="tp_integrador.Admin_PagPrincipal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container my-5">
        <h1 class="text-center mb-3">¡BIENVENIDO/A ADMINISTRADOR/A! </h1>
        <asp:Label ID="lblVet" runat="server"
            CssClass="h3 text-center text-secondary mb-5 fw-bold d-block text-dark"
            Text="Listado de veterinarios."></asp:Label>
        <!------------------------ LISTADO DE VETERINARIO ------------------------>
        <asp:GridView ID="gvVeterinarios" runat="server" CssClass="table text-center align-middle" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField HeaderText="Matrícula" DataField="Matricula">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Usuario" DataField="Usuario">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Nombre" DataField="Nombre">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Apellido" DataField="Apellido">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Dni" DataField="dni">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>

                <asp:TemplateField HeaderText="Acciones">
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:LinkButton ID="btnModificarVet" runat="server" CssClass="btn btn-success btn-sm fw-bold"
                            CommandArgument='<%# Eval("Matricula") %>'
                            OnClick="btnModificarVet_Click">
                            <i class="bi bi-pencil-square"></i> Modificar
                        </asp:LinkButton>

                        <asp:LinkButton ID="btnEliminarVet" runat="server"
                            CommandArgument='<%# Eval("Matricula") %>'
                            OnClick="btnEliminarVet_Click"
                            CssClass="btn btn-danger btn-sm fw-bold"
                            OnClientClick="return confirm('¿Estás seguro de eliminar esta mascota?');">
                            <i class="bi bi-trash"></i> Eliminar
                        </asp:LinkButton>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <!------------------------ LISTADO DE RECEPCIONISTA ------------------------>
        <asp:Label ID="lblRec" runat="server"
            CssClass="h3 text-center text-secondary mb-5 fw-bold d-block text-dark"
            Text="Listado de Recepcionistas."></asp:Label>
        <asp:GridView ID="gvRecepcionistas" runat="server" CssClass="table text-center align-middle" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField HeaderText="Legajo" DataField="Legajo">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Usuario" DataField="Usuario">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Nombre" DataField="Nombre">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Apellido" DataField="Apellido">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Dni" DataField="dni">
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>

                <asp:TemplateField HeaderText="Acciones">
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:LinkButton ID="btnModificarRec" runat="server" CssClass="btn btn-success btn-sm fw-bold"
                            CommandArgument='<%# Eval("Legajo") %>'
                            OnClick="btnModificarRec_Click">
                        <i class="bi bi-pencil-square"></i> Modificar
                        </asp:LinkButton>

                        <asp:LinkButton ID="btnEliminarRec" runat="server"
                            CommandArgument='<%# Eval("Legajo") %>'
                            OnClick="btnEliminarRec_Click"
                            CssClass="btn btn-danger btn-sm fw-bold"
                            OnClientClick="return confirm('¿Estás seguro de eliminar esta mascota?');">
                        <i class="bi bi-trash"></i> Eliminar
                        </asp:LinkButton>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

</asp:Content>

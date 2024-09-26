<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Borradores.aspx.cs" Inherits="CASEWEB.Admin.Borradores" %>
<%@ Import Namespace="CASEWEB" %>

<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var categoryRows = document.querySelectorAll(".table.data-table-export tbody tr");
            categoryRows.forEach(function (row) {
                var isActive = row.querySelector(".lblIsActive").textContent;
                if (isActive === "Activo") {
                    row.style.display = "none";
                }
            });
        });
    </script>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pcoded-inner-content pt-0">
        <div class="align-align-self-end">
            <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
        </div>
        <div class="main-body">
            <div class="page-wrapper">
                <div class="page-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="sub-title">Lista de Categorias Inactivas</h4>
                                </div>
                                <div class="card-block">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">
                                                    <asp:Repeater ID="rDraftCategories" runat="server" OnItemCommand="rDraftCategories_ItemCommand" OnItemDataBound="rDraftCategories_ItemDataBound">
                                                        <HeaderTemplate>
                                                            <table class="table data-table-export table-hover nowrap">
                                                                <thead>
                                                                    <tr>
                                                                        <th class="table-plus">Nombre</th>
                                                                        <th>Imagen</th>
                                                                        <th>Activo</th>
                                                                        <th>Fecha Creada</th>
                                                                        <th class="datatable-nosort">Accion</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <tr class="inactive-category">
                                                                <td class="table-plus"><%# Eval("Nombre_Cat") %> </td>
                                                                <td>
                                                                    <img alt="" width="40" src="<%# Utils.GetImageUrl( Eval("ImagenUrl_Cat")) %>" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblIsActive" runat="server" Text='<%# Eval("Activo_Cat") %>'></asp:Label>
                                                                </td>
                                                                <td><%# Eval("CrearFecha_Cat") %> </td>
                                                                <td>
                                                                    <asp:LinkButton ID="lnkActivate" runat="server" CommandName="activate" CommandArgument='<%# Eval("Cod_Cat") %>' Style="font-size: 10px; background-color:limegreen; color: white; border-radius: 15px; padding: 3px;">
                                                                        <i class="ti-check"></i>
                                                                    </asp:LinkButton>
                                                                
                                                                    <asp:LinkButton ID="lnkDelete" Text="Delete" runat="server" CommandName="delete"
                                                                        CssClass="badge bg-danger" CommandArgument='<%# Eval("Cod_Cat") %>'
                                                                        OnClientClick="return confirm('Quieres Eliminar esta Categoria?');"
                                                                        CausesValidation="false">
                                                                        <i class="ti-trash"></i>
                                                                    </asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            </tbody>
                                                            </table>
                                                        </FooterTemplate>
                                                    </asp:Repeater>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="RegistrosMercado.aspx.cs" Inherits="CASEWEB.Admin.RegistrosMercado" %>

<%@ Import Namespace="CASEWEB" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="col-sm-6 col-md-8 col-lg-8 mobile-inputs">
        <h4 class="sub-title">Lista de Registros Mercado</h4>
        <div class="card-block table-border-style">
            <div class="table-responsive">

                <asp:Repeater ID="rMercado" runat="server">

                    <HeaderTemplate>
                        <table class="table data-table-export table-hover nowrap">
                            <thead>
                                <tr>
                                    <th class="table-plus">Nombre Nivel</th>
                                    <th>Numero Caseta</th>
                                    <th>Color Caseta</th>
                                    <th>Nombre Categoria</th>
                                    <th>Nombre Casera</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <h2>PROXIMAMENTE</h2>
                            <td class="table-plus"><%# Eval("Nombre_Niv") %> </td>

                           <td><%# Eval("Numero_Cast") %> </td>
                            
                            <td><%# Eval("Nombre_Cat") %> </td>
                            <td><%# Eval("Nombre_Cas") %> </td>
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
</asp:Content>

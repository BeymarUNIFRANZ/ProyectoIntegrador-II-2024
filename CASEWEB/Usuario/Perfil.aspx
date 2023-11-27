<%@ Page Title="" Language="C#" MasterPageFile="~/Usuario/Usuario.Master" AutoEventWireup="true" CodeBehind="Perfil.aspx.cs" Inherits="CASEWEB.Usuario.Perfil" %>

<%@ Import Namespace="CASEWEB" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%
        string imageUrl = Session["ImagenUrl_Usu"].ToString();
    %>

    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">

                <h2>Informacion de Usuario</h2>

            </div>

            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="card-title mb-4">
                                <div class="d-flex justify-content-start">

                                    <div class="image-container">
                                        <img src="<%= Utils.GetImageUrl(imageUrl) %>" id="imgPerfil"
                                            style="width: 150px; height: 150px;" class="img-thumbnail" />
                                        <div class="middle pt-2">
                                            <a href="Registro.aspx?id=<% Response.Write(Session["Cod_Usu"]);%>" class="btn btn-warning">
                                                <i class="fa fa-pencil"></i>Editar Detalles
                                            </a>
                                        </div>
                                    </div>

                                    <div class="userData ml-3">
                                        <h2 class="d-block" style="font-size: 1.5rem; font-weight: bold"><a href="javascript:void(0);
                                            "><% Response.Write(Session["Nombre_Usu"]); %> </a>
                                        </h2>
                                        <h6 class="d-block">
                                            <a href="javascript:void(0)">
                                                <asp:Label ID="lblUsername" runat="server" ToolTip="Unique Username"> 
                                                    <% Response.Write(Session["NombreUsuario_Usu"]);%>
                                                </asp:Label>
                                            </a>
                                        </h6>

                                        <h6 class="d-block">
                                            <a href="javascript:void(0)">
                                                <asp:Label ID="lblEmail" runat="server" ToolTip="User Email"> 
                                                    <% Response.Write(Session["Correo_Usu"]); %>
                                                </asp:Label>
                                            </a>
                                        </h6>
                                        <h6 class="d-block">
                                            <a href="javascript:void(0)">
                                                <asp:Label ID="lblCreatedDate" runat="server" ToolTip="Account Created On"> 
                                                    <% Response.Write(Session["CreadoFecha_Usu"]);%>
                                                </asp:Label>
                                            </a>
                                        </h6>
                                    </div>

                                </div>
                            </div>

                            <div class="row">
                                <div class="col-12">
                                    <ul class="nav nav-tabs mb-4" id="myTab" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link active text-info" id="basicInfo-tab" data-toggle="tab"
                                                href="#basicInfo" role="tab" aria-controls="basicInfo" aria-selected="true">
                                                <i class="fa fa-id-badge mr-2"></i>Informacion Basica</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-info" id="connectedServices-tab" data-toggle="tab"
                                                href="#connectedServices" role="tab" aria-controls="connectedServices" aria-selected="false">
                                                <i class="fa fa-clock-o mr-2"></i>Historial</a>
                                        </li>
                                    </ul>

                                    <div class="tab-content ml-1" id="myTabContent">
                                        <%-- Informacion Basica de usuario--%>
                                        <div class="tab-pane fade show active" id="basicInfo" role="tabpanel" aria-labelledby="basicInfo-tab">
                                            <asp:Repeater ID="rUserProfile" runat="server">
                                                <ItemTemplate>

                                                    <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight: bold;">Nombre Completo</label>
                                                        </div>
                                                        <div class="col-md-8 col-6">
                                                            <%# Eval("Nombre_Usu") %>
                                                        </div>
                                                    </div>
                                                    <hr />
                                                    <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight: bold;">Nombre de Usuario</label>
                                                        </div>
                                                        <div class="col-md-8 col-6">
                                                            @<%# Eval("NombreUsuario_Usu") %>
                                                        </div>
                                                    </div>
                                                    <hr />
                                                    <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight: bold;">Numero de Cel. o Tel. </label>
                                                        </div>
                                                        <div class="col-md-8 col-6">
                                                            <%# Eval("Telefono_Usu") %>
                                                        </div>
                                                    </div>
                                                    <hr />
                                                    <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight: bold;">Correo Electronico</label>
                                                        </div>
                                                        <div class="col-md-8 col-6">
                                                            <%# Eval("Correo_Usu") %>
                                                        </div>
                                                    </div>

                                                    <hr />
                                                    <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight: bold;">Direccion</label>
                                                        </div>
                                                        <div class="col-md-8 col-6">
                                                            <%# Eval("Direccion_Usu") %>
                                                        </div>
                                                    </div>
                                                    <hr />

                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                        <%-- Informacion Basica de usuario--%>

                                        <%-- Historial de ordenes usuario--%>
                                        <div class="tab-pane fade" id="connectedServices" role="tabpanel"
                                            aria-labelledby="connectedServices-tab">

                                            <asp:Repeater ID="rPurchaseHistory" runat="server" OnItemDataBound="rPurchaseHistory_ItemDataBound">
                                                <ItemTemplate>
                                                    <div class="container">
                                                        <div class="row pt-1 pb-1" style="background-color: wheat">
                                                            <div class="col-4">
                                                                <%--<span class="badge badge-pill badge-dark text-white">
                                                                    <%# Eval("NumOrden_Ord") %>
                                                                </span>--%>
                                                               Modo de Pago: <%# Eval("ModoPago_Pag").ToString() == "cod" ? "Pedido por Delivery" : Eval("ModoPago_Pag").ToString().ToUpper() %>
                                                            </div>
                                                            <div class="col-6">
                                                                <%# string.IsNullOrEmpty( Eval("NumTarjeta_Pag").ToString()) ? "" : "Numero de Trajeta: " + Eval("NumTarjeta_Pag") %>
                                                            </div>
                                                            <div class="col-2" style="text-align: end">
                                                                <a href="Recibo.aspx?id=<%# Eval("Cod_Pag") %>" class="btn btn-info btn-sm">
                                                                    <i class="fa fa-download mr-2"></i>Comprobante</a>
                                                            </div>
                                                        </div>
                                                        <asp:HiddenField ID="hdnPaymentId" runat="server" Value='<%# Eval("Cod_Pag") %>' />

                                                        <asp:Repeater ID="rOrders" runat="server">
                                                            <HeaderTemplate>
                                                                <table class="table data-table-export table-responsive-sm table-bordered table-hover">
                                                                    <thead class="bg-dark text-white">
                                                                        <tr>
                                                                            <th>Nombre de Productos</th>
                                                                            <th>Precio</th>
                                                                            <th>Cantidad</th>
                                                                            <th>Precio Total</th>
                                                                            <%--<th>Numero de Orden</th>--%>
                                                                            <th>Estado</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblName" runat="server" Text='<%# Eval("Nombre_Pro") %>'></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblPrice" runat="server" Text='<%#string.IsNullOrEmpty( Eval("Precio_Pro").ToString()) ? "" : "Bs" + Eval("Precio_Pro") %>'></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblQuantity" runat="server" Text='<%# Eval("Cantidad_Ord") %>'></asp:Label>
                                                                    </td>
                                                                    <td>Bs<asp:Label ID="lblTotalPrice" runat="server" Text='<%# Eval("TotalPrice") %>'></asp:Label>
                                                                    </td>
                                                                    <%--<td>
                                                                        <asp:Label ID="lblOrderNo" runat="server" Text='<%#Eval("NumOrden_Ord") %>'></asp:Label>
                                                                    </td>--%>
                                                                    <td>
                                                                        <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Estado_Ord") %>'
                                                                            CssClass='<%# Eval("Estado_Ord").ToString() == "Entregado" ? "badge badge-success" : "badge badge-warning" %>'></asp:Label>
                                                                        <%-- en la base de datos poner arreglar el pending con delivered--%>
                                                                   </td>
                                                                </tr>
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                </tbody>
                                                                    </table>
                                                            </FooterTemplate>
                                                        </asp:Repeater>

                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>

                                        </div>
                                        <%-- Historial de ordenes usuario--%>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
    </section>

</asp:Content>

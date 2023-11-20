<%@ Page Title="" Language="C#" MasterPageFile="~/Usuario/Usuario.Master" AutoEventWireup="true" CodeBehind="PerfilCasero.aspx.cs" Inherits="CASEWEB.Usuario.PerfilCasero" %>

<%@ Import Namespace="CASEWEB" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%
        string imageUrl = (Session["ImagenUrl_Cas"] ?? "").ToString();
    %>

    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">

                <h2>Informacion de Caserita(o)</h2>

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
                                        <%--<div class="middle pt-2">
                                         <a href="Registro.aspx?id=<% Response.Write(Session["Cod_Cas"]);%>" class="btn btn-warning">
                                             <i class="fa fa-pencil"></i>Editar Detalles
                                         </a>
                                     </div>--%>
                                    </div>

                                    <div class="userData ml-3">
                                        <h2 class="d-block" style="font-size: 1.5rem; font-weight: bold"><a href="javascript:void(0);
                                         "><% Response.Write(Session["Nombre_Cas"]); %> </a>
                                        </h2>
                                        <h6 class="d-block">
                                            <a href="javascript:void(0)">
                                                <asp:Label ID="lblUsername" runat="server" ToolTip="Unique Username"> 
                                                 <% Response.Write(Session["NombreUsuario_Cas"]);%>
                                                </asp:Label>
                                            </a>
                                        </h6>

                                        <h6 class="d-block">
                                            <a href="javascript:void(0)">
                                                <asp:Label ID="lblEmail" runat="server" ToolTip="User Email"> 
                                                 <% Response.Write(Session["Correo_Cas"]); %>
                                                </asp:Label>
                                            </a>
                                        </h6>
                                        <h6 class="d-block">
                                            <a href="javascript:void(0)">
                                                <asp:Label ID="lblCreatedDate" runat="server" ToolTip="Account Created On"> 
                                                 <% Response.Write(Session["CreadoFecha_Cas"]);%>
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
                                                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-cart4 m-2" viewBox="0 3 16 16">
                                              <path d="M0 2.5A.5.5 0 0 1 .5 2H2a.5.5 0 0 1 .485.379L2.89 4H14.5a.5.5 0 0 1 .485.621l-1.5 6A.5.5 0 0 1 13 11H4a.5.5 0 0 1-.485-.379L1.61 3H.5a.5.5 0 0 1-.5-.5zM3.14 5l.5 2H5V5H3.14zM6 5v2h2V5H6zm3 0v2h2V5H9zm3 0v2h1.36l.5-2H12zm1.11 3H12v2h.61l.5-2zM11 8H9v2h2V8zM8 8H6v2h2V8zM5 8H3.89l.5 2H5V8zm0 5a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm-2 1a2 2 0 1 1 4 0 2 2 0 0 1-4 0zm9-1a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm-2 1a2 2 0 1 1 4 0 2 2 0 0 1-4 0z"/>
                                            </svg>Productos</a>

                                        </li>
                                    </ul>

                                    <div class="tab-content ml-1" id="myTabContent">
                                        <%-- Informacion Basica de usuario--%>
                                        <div class="tab-pane fade show active" id="basicInfo" role="tabpanel" aria-labelledby="basicInfo-tab">
                                            <asp:Repeater ID="rCaseraProfile" runat="server">
                                                <ItemTemplate>

                                                    <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight: bold;">Nombre Completo</label>
                                                        </div>
                                                        <div class="col-md-8 col-6">
                                                            <%# Eval("Nombre_Cas") %>
                                                        </div>
                                                    </div>
                                                    <hr />
                                                    <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight: bold;">Nombre de Usuario</label>
                                                        </div>
                                                        <div class="col-md-8 col-6">
                                                            @<%# Eval("NombreUsuario_Cas") %>
                                                        </div>
                                                    </div>
                                                    <hr />
                                                    <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight: bold;">Numero de Cel.</label>
                                                        </div>
                                                        <div class="col-md-8 col-6">
                                                            <%# Eval("Telefono_Cas") %>
                                                        </div>
                                                    </div>
                                                    <hr />
                                                    <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight: bold;">Correo Electronico</label>
                                                        </div>
                                                        <div class="col-md-8 col-6">
                                                            <%# Eval("Correo_Cas") %>
                                                        </div>
                                                    </div>


                                                    <%-- <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight: bold;">Direccion</label>
                                                        </div>
                                                        <div class="col-md-8 col-6">
                                                            <%#Eval("Direccion_Cas") %>
                                                        </div>
                                                    </div>--%>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                        <%-- Informacion Basica de usuario--%>

                                        <%-- Historial de ordenes usuario--%>
                                        <div class="tab-pane fade" id="connectedServices" role="tabpanel"
                                            aria-labelledby="connectedServices-tab">
                                            <h3>¡Mis Productos!</h3>
                                           
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

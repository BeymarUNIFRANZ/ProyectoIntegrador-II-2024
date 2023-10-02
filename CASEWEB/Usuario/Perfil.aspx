<%@ Page Title="" Language="C#" MasterPageFile="~/Usuario/Usuario.Master" AutoEventWireup="true" CodeBehind="Perfil.aspx.cs" Inherits="CASEWEB.Usuario.Perfil" %>

<%@Import Namespace="CASEWEB" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%
        string imageUrl = Session["imageUrl"].ToString();
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

                                            <img src="<%= Utils.GetImageUrl(imageUrl) %>"/>

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

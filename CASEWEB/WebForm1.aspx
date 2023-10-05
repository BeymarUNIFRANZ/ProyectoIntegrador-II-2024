<%@ Page Title="" Language="C#" MasterPageFile="~/Usuario/Usuario.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="CASEWEB.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">ç
   <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-4">
                <div class="card shadow-lg">
                    <div class="card-header bg-primary text-white text-center"> <!-- Centered text -->
                        <h2 class="card-title">Iniciar Sesión</h2>
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <label for="txtCorreo" class="form-label">Correo Electrónico:</label>
                            <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control" placeholder="Ingresa tu correo electrónico"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtContraseña" class="form-label">Contraseña:</label>
                            <asp:TextBox ID="txtContraseña" runat="server" TextMode="Password" CssClass="form-control" placeholder="Ingresa tu contraseña"></asp:TextBox>
                        </div>
                        <br />
                        <asp:Button ID="btnLogin" runat="server" Text="Iniciar Sesión" OnClick="btnLogin_Click" CssClass="btn btn-primary btn-block" />
                    </div>
                  
                </div>
                <br />
                <br />
                <br />
            </div>
        </div>
    </div>
    <style>
    /* Custom CSS to increase text size and adjust margins */
    .large-text {
        font-size: 18px;
    }

  
    .card {
        margin: 0;
    }
    </style>
</asp:Content>


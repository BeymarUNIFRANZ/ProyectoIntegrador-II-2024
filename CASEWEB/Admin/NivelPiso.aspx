
<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="NivelPiso.aspx.cs" Inherits="CASEWEB.Admin.NivelPiso" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Vincular tus hojas de estilo -->
    <link href="..\PlantillaArchivos\css\style.css" rel="stylesheet" type="text/css" />
    <link href="..\assets\css\bootstrap\css\bootstrap.min.css" rel="stylesheet" type="text/css" />
    <style>
        /* Estilos para centrar verticalmente el contenido */
        .vertical-center {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 50vh;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h5>NIVELES DE PISO DEL MERCADO LANZA</h5>
    <div class="vertical-center">
        <div class="vertical-buttons">
            
            <asp:Button ID="btnSubterraneo" runat="server" Text="Subterraneo" CssClass="btn btn-primary large-button" OnClick="btnSubterraneo_Click" />
            <asp:Button ID="btnPlantaBaja" runat="server" Text="Planta Baja" CssClass="btn btn-primary large-button" OnClick="btnPlantaBaja_Click" />
            <asp:Button ID="btnPiso1" runat="server" Text="Piso 1" CssClass="btn btn-primary large-button" OnClick="btnPiso1_Click" />
            <asp:Button ID="btnPiso2" runat="server" Text="Piso 2" CssClass="btn btn-primary large-button" OnClick="btnPiso2_Click" />
        </div>
    </div>

</asp:Content>
 
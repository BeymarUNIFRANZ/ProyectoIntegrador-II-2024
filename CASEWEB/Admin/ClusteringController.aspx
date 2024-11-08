<%@ Page Title="Clustering Results" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ClusteringController.aspx.cs" Inherits="CASEWEB.Admin.ClusteringController" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .table-header {
            background-color: #007bff; /* Cambia el color del encabezado */
            color: black; /* Color del texto en el encabezado */
            text-align: center; /* Centra el texto del encabezado */
        }
        .table-row {
            text-align: center; /* Centra el texto en las filas */
        }
        .table-hover tbody tr:hover {
            background-color: #f1f1f1; /* Color de fondo al pasar el ratón */
        }
        h2 {
            margin-bottom: 20px; /* Espaciado inferior para el título */
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Resultados del Clustering de Pedidos</h2>

    <div class="table-responsive">
        <!-- Este GridView mostrará los resultados de los clusters -->
        <asp:GridView ID="GridViewClusteringResults" runat="server" AutoGenerateColumns="False" 
            CssClass="table table-striped table-hover"
            HeaderStyle-CssClass="table-header"
            RowStyle-CssClass="table-row">
            <Columns>
                <asp:BoundField DataField="ClusterId" HeaderText="N° Cluster" />
                <asp:BoundField DataField="Count" HeaderText="Cantidad" />
                <asp:BoundField DataField="AvgCantidadOrd" HeaderText="Promedio/Cantidad Pedidos" />
                <asp:BoundField DataField="AvgCodPro" HeaderText="Promedio/Producto" />
                <asp:BoundField DataField="AvgCodPag" HeaderText="Promedio/Paga" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>

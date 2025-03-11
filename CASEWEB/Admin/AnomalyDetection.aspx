<%@ Page Title="Gaussian Clustering Results" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="GaussianClusteringController.aspx.cs" Inherits="CASEWEB.Admin.GaussianClusteringController" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .table-header {
            background-color: #007bff;
            color: black;
            text-align: center;
        }
        .table-row {
            text-align: center;
        }
        .table-hover tbody tr:hover {
            background-color: #f1f1f1;
        }
        h2 {
            margin-bottom: 20px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Resultados de Clustering (GMM Aproximado)</h2>

    <div class="table-responsive">
        <asp:GridView ID="GridViewGaussianClusteringResults" runat="server" AutoGenerateColumns="False" 
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

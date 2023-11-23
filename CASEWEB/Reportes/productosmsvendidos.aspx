<%@ Page Title="" Language="C#" MasterPageFile="~/Vendedor/Vendedor.Master" AutoEventWireup="true" CodeBehind="productosmsvendidos.aspx.cs" Inherits="CASEWEB.Vendedor.productosmsvendidos" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    <asp:Button ID="btnDescargarPDF" runat="server" Text="Descargar PDF" OnClick="btnDescargarPDF_Click" />

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:OficialConnectionString %>" SelectCommand="SELECT TOP (10) Cod_Pro, Nombre_Pro, Precio_Pro, Cantidad_Pro AS TotalVendido FROM PRODUCTOS ORDER BY TotalVendido DESC"></asp:SqlDataSource>

    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" ReportSourceID="CrystalReportSource1" OnInit="CrystalReportViewer1_Init" />

    <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
        <Report FileName="productomsvendidos.rpt"></Report>
    </CR:CrystalReportSource>

</asp:Content>

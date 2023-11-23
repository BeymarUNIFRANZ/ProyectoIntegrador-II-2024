<%@ Page Title="" Language="C#" MasterPageFile="~/Vendedor/Vendedor.Master" AutoEventWireup="true" CodeBehind="ventacat.aspx.cs" Inherits="CASEWEB.Vendedor.ventacat1" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:OficialConnectionString %>" SelectCommand="SELECT CATEGORIAS.Nombre_Cat, PRODUCTOS.Nombre_Pro, PRODUCTOS.Precio_Pro, PRODUCTOS.Cantidad_Pro
FROM     PRODUCTOS INNER JOIN
                  CATEGORIAS ON PRODUCTOS.Cod_Cat = CATEGORIAS.Cod_Cat"></asp:SqlDataSource>

    
    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" ReportSourceID="CrystalReportSource1" />


    <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
        <Report FileName="ventacat.rpt">
            <DataSources>
                <CR:DataSourceRef DataSourceID="SqlDataSource1"></CR:DataSourceRef>
            </DataSources>
        </Report>
    </CR:CrystalReportSource>

</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="listpedi.aspx.cs" Inherits="CASEWEB.Admin.listpedi" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">       

    
    <asp:Button ID="btnDescargarPDF" runat="server" Text="Descargar PDF" OnClick="btnDescargarPDF_Click" />

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CaseBDConnectionString %>" SelectCommand="SELECT ORDEN.NumOrden_Ord, PRODUCTOS.Nombre_Pro, ORDEN.Cantidad_Ord, USUARIOS.Nombre_Usu, PAGO.Nombre_Pag, ORDEN.Estado_Ord FROM PRODUCTOS INNER JOIN ORDEN ON PRODUCTOS.Cod_Pro = ORDEN.Cod_Pro INNER JOIN PAGO ON ORDEN.Cod_Pag = PAGO.Cod_Pag INNER JOIN USUARIOS ON ORDEN.Cod_Usu = USUARIOS.Cod_Usu GROUP BY ORDEN.NumOrden_Ord, PRODUCTOS.Nombre_Pro, ORDEN.Cantidad_Ord, USUARIOS.Nombre_Usu, PAGO.Nombre_Pag, ORDEN.Estado_Ord"></asp:SqlDataSource>

    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" ReportSourceID="CrystalReportSource1" DisplayToolbar="False" EnableDatabaseLogonPrompt="False" EnableParameterPrompt="False" ToolPanelView="None" />

    <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
        <Report FileName="listpedi.rpt"></Report>
    </CR:CrystalReportSource>
</asp:Content>

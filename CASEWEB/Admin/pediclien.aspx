<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="pediclien.aspx.cs" Inherits="CASEWEB.Admin.pediclien1" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

      
    <asp:Button ID="btnDescargarPDF" runat="server" Text="Descargar PDF" OnClick="btnDescargarPDF_Click" />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CaseBDConnectionString %>" SelectCommand="SELECT ORDEN.NumOrden_Ord, USUARIOS.Nombre_Usu, USUARIOS.Telefono_Usu, ORDEN.Estado_Ord, ORDEN.Fecha_Ord FROM ORDEN INNER JOIN USUARIOS ON ORDEN.Cod_Usu = USUARIOS.Cod_Usu"></asp:SqlDataSource>

    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" ReportSourceID="CrystalReportSource1" DisplayToolbar="False" EnableDatabaseLogonPrompt="False" EnableParameterPrompt="False" ToolPanelView="None" />

    <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
        <Report FileName="pedidclien.rpt">
             <DataSources>
     <CR:DataSourceRef DataSourceID="SqlDataSource1"></CR:DataSourceRef>
 </DataSources>
        </Report>
    </CR:CrystalReportSource>
</asp:Content>
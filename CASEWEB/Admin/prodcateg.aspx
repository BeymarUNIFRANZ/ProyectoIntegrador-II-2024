<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="prodcateg.aspx.cs" Inherits="CASEWEB.Admin.prodcateg1" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

          <!-- Agregar un título con subtítulo en negritas -->
   <h2 style="text-align: center; color: #333; margin-bottom: 10px;"><strong>Reporte:</strong> Lista de productos por categoria </h2>
    <br />
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cs %>" SelectCommand="SELECT CATEGORIAS.Nombre_Cat, PRODUCTOS.Nombre_Pro, PRODUCTOS.Precio_Pro, PRODUCTOS.Cantidad_Pro
FROM     CATEGORIAS INNER JOIN
                  PRODUCTOS ON CATEGORIAS.Cod_Cat = PRODUCTOS.Cod_Cat"></asp:SqlDataSource>
    <style type="text/css">
        .btnExportContainer {
            text-align: center;
        }

                        .btnExport {
    --main-color: rgb(69, 68, 68);
    display: inline-block;
    padding: 15px 30px;
    font-size: 18px;
    text-align: center;
    text-decoration: none;
    cursor: pointer;
    border: 0.3em solid var(--main-color);
    border-radius: 0.5em;
    overflow: hidden;
    position: relative;
    background-color: var(--main-color);
    color: white;
    transition: background 0.5s, color 0.5s;
    z-index: 1;
}

     .btnExport:hover {
    background-color: #fcfcfc; /* Cambia al color deseado al pasar el ratón */
    color: rgb(3, 3, 3); /* Cambia al color de texto deseado al pasar el ratón */
}

        .btnExport img {
            width: 24px;
            height: 24px;
            margin-right: 12px;
            display: inline-block;
            transform-origin: center;
            transition: transform 0.3s ease;
        }

        .btnExport span {
            position: absolute;
            width: 25%;
            height: 100%;
            background-color: var(--main-color);
            transform: translateY(150%);
            border-radius: 50%;
            left: calc((var(--n) - 1) * 25%);
            transition: 0.5s;
            transition-delay: calc((var(--n) - 1) * 0.1s);
            z-index: -1;
        }

        .btnExport:hover span {
            transform: translateY(0) scale(2);
        }

        .btnExport span:nth-child(1),
        .btnExport span:nth-child(2),
        .btnExport span:nth-child(3),
        .btnExport span:nth-child(4) {
            --n: calc((var(--i) * 2) - 1);
        }

        ul {
            list-style: none; /* Elimina los puntos de la lista */
            padding: 0; /* Elimina el padding predeterminado de la lista */
        }

        li {
            margin-bottom: 10px; /* Añade un espacio entre elementos de la lista si es necesario */
        }
    </style>
   <div style="text-align: center; margin-bottom: 20px;">
    <!-- Botones de exportación con logos -->
    <div class="btnExportContainer">
        <asp:LinkButton ID="LinkButton6" runat="server" CssClass="btnExport" OnClick="btnExportPDF_Click">
            <img src="../assets/images/iconos/pdf.png" alt="Logo PDF"/>
            Exportar a PDF
        </asp:LinkButton>
    </div>
    <br />
    <div class="btnExportContainer">
        <asp:LinkButton ID="LinkButton7" runat="server" CssClass="btnExport" OnClick="btnExportWord_Click">
             <img src="../assets/images/iconos/palabra.png" alt="Logo Word"/>
            Exportar a Word
        </asp:LinkButton>
    </div>
    <br />
    <div class="btnExportContainer">
        <asp:LinkButton ID="LinkButton8" runat="server" CssClass="btnExport" OnClick="btnExportExcel_Click">
            <img src="../assets/images/iconos/sobresalir.png" alt="Logo Excel"/>
            Exportar a Excel
        </asp:LinkButton>
    </div>
    <br />
    <div class="btnExportContainer">
        <asp:LinkButton ID="LinkButton9" runat="server" CssClass="btnExport" OnClick="btnExportCSV_Click">
            <img src="../assets/images/iconos/csv.png" alt="Logo CSV" />
            Exportar a CSV
        </asp:LinkButton>
    </div>
    <br />
    <div class="btnExportContainer">
        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btnExport" OnClick="btnExportText_Click">
            <img src="../assets/images/iconos/formatotexto.png" alt="Logo Texto"/>
            Exportar a Texto
        </asp:LinkButton>
    </div>
</div>

    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" />

    <CR:CrystalReportSource ID="CrystalReportSource1" runat="server"></CR:CrystalReportSource>

</asp:Content>

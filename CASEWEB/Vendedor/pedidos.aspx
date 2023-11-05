<%@ Page Title="" Language="C#" MasterPageFile="~/Vendedor/Vendedor.Master" AutoEventWireup="true" CodeBehind="pedidos.aspx.cs" Inherits="CASEWEB.Vendedor.pedidos1" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <script type="text/javascript">
        function openPdfPage3() {
            var pdfPageUrl = 'pedidos.aspx'; // Reemplaza 'TuArchivo.aspx' con la URL de tu archivo ASPX
            var iframe = '<iframe width="100%" height="700px" src="' + pdfPageUrl + '"></iframe>';

            // Limpia el contenido previo del cuadro de diálogo
            $('#exampleModal .modal-body').empty();

            // Asigna el iframe al cuerpo del cuadro de diálogo
            $('#exampleModal .modal-body').html(iframe);

            // Abre el cuadro de diálogo modal
            $('#exampleModal').modal('show');
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">


    <asp:LinkButton ID="LinkButton1" Text="Edit" runat="server" CssClass="badge badge-success"
        CommandArgument='<%# Eval("Cod_Pro") %>' CommandName="edit" OnClientClick="openPdfPage3(); return false;">
    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="10" fill="currentColor" class="bi bi-hand-index" viewBox="0 0 16 16">
        <h6>Pedidos</h6>
    </svg>
    </asp:LinkButton>
    <hr />

    <!-- Cuadro de diálogo modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <!-- Puedes ajustar el tamaño del cuadro de diálogo modal según tus necesidades -->
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Reportes de Pedidos</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body"></div>
            </div>
        </div>
    </div>


    <br />
    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" />
</asp:Content>

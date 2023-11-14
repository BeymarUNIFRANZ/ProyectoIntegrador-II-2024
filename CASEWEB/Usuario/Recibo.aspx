<%@ Page Title="" Language="C#" MasterPageFile="~/Usuario/Usuario.Master" AutoEventWireup="true" CodeBehind="Recibo.aspx.cs" Inherits="CASEWEB.Usuario.Recibo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <script>
     /*FOR DISPPEARING ALERT MESSAGE */
     window.onload = function () {
         var seconds = 5;
         setTimeout(function () {
             document.getElementById("<%=lblMsg.ClientID %>").style.display = "none";
         }, seconds * 1000);
     };
     </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <section class="book_section layout_padding">
    <div class="container">
        <div class="heading_container">
            <div class="align-self-end">
                <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
            </div>
        </div>
    </div>

    <div class="container">
        <asp:Repeater ID="rOrderItem" runat="server">
            <HeaderTemplate>
                <table class="table table-responsive-sm table-bordered table-hover" id="tblInvoice">
                    <thead class="bg-dark text-white">
                        <tr>
                            <th>Nº</th>
                            <th>Numero de Orden</th>
                            <th>Nombre de Producto(s)</th>
                            <th>Precio</th>
                            <th>Cantidad</th>
                            <th>Precio Total</th>
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td> <%# Eval("Srno") %> </td>
                    <td> <%# Eval("NumOrden_Ord") %> </td>
                    <td> <%# Eval("Nombre_Pro") %> </td>
                    <td> <%# string.IsNullOrEmpty( Eval("Precio_Pro").ToString()) ? "" : "Bs"+ Eval("Precio_Pro") %> </td>
                    <td> <%# Eval("Cantidad_Ord") %> </td>
                    <td> Bs<%# Eval("TotalPrice") %> </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </tbody>
                </table>
            </FooterTemplate>
         </asp:Repeater>

        <div class="text-center">
            <asp:LinkButton ID="lblDownloadInvoice" runat="server" CssClass="btn btn-info" 
                OnClick="lbDownloadInvoice_Click">
                     <i class="fa fa-file-pdf-o mr-2"></i> Descargar Comprobante
            </asp:LinkButton>
        </div>

    </div>
</section>

</asp:Content>

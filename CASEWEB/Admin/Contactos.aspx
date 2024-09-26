<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Contactos.aspx.cs" Inherits="CASEWEB.Admin.Contactos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

     <script>
     /*For disappearing alert message*/
     window.onload = function () {
         var seconds = 5;
         setTimeout(function () {
             document.getElementById("<%=lblMsg.ClientID%>").style.display = "none";
         }, seconds * 1000);
     };
     </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="pcoded-inner-content pt-0">
    <div class="align-align-self-end">
        <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
    </div>
    <div class="main-body">
        <div class="page-wrapper">
            <div class="page-body">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="card">
                            <div class="card-header">
                            </div>
                            <div class="card-block">
                                <div class="row">

                                    <div class="col-12 mobile-inputs">
                                        <h4 class="sub-title">Lista de Mensajes</h4>
                                        <div class="card-block table-border-style">
                                            <div class="table-responsive">

                                                <asp:Repeater ID="rContacts" runat="server" OnItemCommand="rContacts_ItemCommand">

                                                    <HeaderTemplate>
                                                        <table class="table data-table-export table-hover nowrap">
                                                            <thead>
                                                                <tr>
                                                                    <th class="table-plus">Nº</th>
                                                                    <th>Nombre de Usuario</th>
                                                                    <th>Correo</th>
                                                                    
                                                                    <th>Mensaje</th>
                                                                    <th>Fecha</th>
                                                                    <th class="datatable-nosort">Eliminar</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td class="table-plus"><%# Eval("SrNo") %> </td>

                                                            <td> <%# Eval("Nombre_Con") %> </td>
                                                            <td> <%# Eval("Correo_Con") %> </td>
                                                            
                                                            <td> <%# Eval("Mensaje_Con") %> </td>
                                                            <td> <%# Eval("CreadoFecha_Con") %> </td>


                                                            <%--<td><%# Eval("CreadoFecha_Usu") %> </td>--%>
                                                            <td>

                                                                <asp:LinkButton ID="lnkDelete" Text="Eliminar" runat="server" CommandName="delete"
                                                                    CssClass="badge bg-danger" CommandArgument='<%# Eval("Cod_Con") %>'
                                                                    OnClientClick="return confirm('Seguro que quieres eliminar este Mensaje?');">
                                                               <i class="ti-trash"></i>
                                                                </asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        </tbody>
                                              </table>
                                             
                                                    </FooterTemplate>
                                                </asp:Repeater>

                                            </div>
                                        </div>
                                    </div>


                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


</asp:Content>

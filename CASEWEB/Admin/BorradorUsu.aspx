<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="BorradorUsu.aspx.cs" Inherits="CASEWEB.Admin.BorradorUsu" %>

<%@ Import Namespace="CASEWEB" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        /*for disappearing alert message*/
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID %>").style.display = "none";
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

                                        <div class="col-sm-12">
                                            <h4 class="sub-title">Lista de Usuarios</h4>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">

                                                    <%-- <asp:LinkButton ID="lnkEdit" Text="Edit" runat="server" CssClass="badge badge-success"
                                                      CommandArgument='<%# Eval("Cod_Cas") %>' CommandName="edit" data-toggle="modal" data-target="#exampleModal">
                                                  <svg xmlns="http://www.w3.org/2000/svg" width="20" height="10" fill="currentColor" class="bi bi-hand-index" viewBox="0 0 16 16">
                                                     <h6>Abrir PDF</h6>
                                                  </svg>  
                                                  </asp:LinkButton>


                                                  <!-- Cuadro de diálogo -->
                                                  <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                      <div class="modal-dialog">
                                                          <div class="modal-content">
                                                              <div class="modal-header">
                                                                  <h5 class="modal-title" id="exampleModalLabel">Selecciona una Caseta</h5>
                                                                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                      <span aria-hidden="true">&times;</span>
                                                                  </button>

                                                              </div>
                                                              <h2>hola</h2>
                                                          </div>
                                                      </div>
                                                  </div>--%>
                                                    <asp:Repeater ID="rInactiveUsers" runat="server" OnItemCommand="rInactiveUsers_ItemCommand">

                                                        <HeaderTemplate>
                                                            <table class="table data-table-export table-hover nowrap">
                                                                <thead>
                                                                    <tr>
                                                                        <th class="table-plus">Nombre</th>
                                                                        <th>Usuario</th>
                                                                        <th>Contraseña</th>
                                                                        <th>Dirección</th>
                                                                        <th>Imagen</th>
                                                                        <th>Teléfono</th>

                                                                        <th>Correo</th>

                                                                        <th>Rol</th>
                                                                        <th>Activo</th>
                                                                        <%--<th>Carnet de Sanidad</th>--%>

                                                                        <th>Fecha de Creacion</th>
                                                                        <th class="datatable-nosort">Accion</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td class="table-plus"><%# Eval("Nombre_Usu") %></td>
                                                                <td class="table-plus"><%# Eval("NombreUsuario_Usu") %></td>
                                                                <td class="table-plus"><%# Eval("Clave_Usu") %></td>
                                                                <td><%# Eval("Direccion_Usu") %> </td>
                                                                <td>
                                                                    <img alt="" width="40" src="<%# Utils.GetImageUrl( Eval("ImagenUrl_Usu")) %>" />
                                                                </td>

                                                                <td><%# Eval("Telefono_Usu") %> </td>
                                                                <td><%# Eval("Correo_Usu") %> </td>
                                                                <td><%# Eval("Roles") %> </td>
                                                                <%--<th><%# Eval("Nit_Cas") %></th>--%>
                                                                <td>
                                                                    <asp:Label ID="lblIsActive" runat="server" Text='<%# Eval("Activo_Usu") %>'>
                                                                    </asp:Label>
                                                                </td>

                                                                <td><%# Eval("CreadoFecha_Usu") %></td>


                                                                <td>
                                                                    <asp:LinkButton ID="lnkActivate" runat="server" CommandName="activate" CommandArgument='<%# Eval("Cod_Usu") %>' Style="font-size: 10px; background-color: limegreen; color: white; border-radius: 15px; padding: 3px;">
                                                                        <i class="ti-check"></i>
                                                                    </asp:LinkButton>
                                                                    <asp:LinkButton ID="lnkDelete" runat="server" CommandName="delete" CommandArgument='<%# Eval("Cod_Usu") %>'
                                                                        CssClass="badge bg-danger" OnClientClick="return confirm('Quieres eliminar este Usuario Permanentemente?');" CausesValidation="false">
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
    <script>
        function validateNumber(input) {
            // Obtén el valor actual del campo
            var value = input.value;

            // Usa una expresión regular para verificar si solo contiene números
            if (/[^0-9]/.test(value)) {
                // Si se ingresaron caracteres no numéricos, muestra un mensaje de error
                alert("Por favor, ingrese solo números.");
                // Elimina los caracteres no numéricos
                input.value = value.replace(/[^0-9]/g, '');
            }

            return true;
        }
    </script>
</asp:Content>

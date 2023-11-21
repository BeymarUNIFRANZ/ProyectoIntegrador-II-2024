<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="RegistroCasera.aspx.cs" Inherits="CASEWEB.Admin.RegistroCasera" %>

<%@ Import Namespace="CASEWEB" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        /*for disappearing alert massage*/
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID %>").style.display = "none";
            }, seconds * 1000);
        };
    </script>
    <script>
        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=imgCasera.ClientID%>').prop('src', e.target.result)
                        .width(200)
                        .height(200);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
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



                                        <div class="col-sm-6 col-md-4 col-lg-4">
                                            <h4 class="sub-title">Registro de Casera(o)</h4>
                                            <div>

                                                <div class="form-group">
                                                    <label>Nombre de Casera(o)</label>
                                                    <div>
                                                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"
                                                            placeholder="Ingrese Nombre de Casera(o)"></asp:TextBox>
                                                        <asp:HiddenField ID="hdnId" Value="0" runat="server" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label>Nombre de Usuario</label>
                                                    <div>
                                                        

                                                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"
                                                            placeholder="Ingrese Nombre de Usuario" ToolTip="Username">
                                                        </asp:TextBox>

                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label>Contraseña</label>
                                                    <div>
                                                        
                                                        <asp:TextBox ID="txtClave" runat="server" CssClass="form-control"
                                                            placeholder="Ingrese su Contraseña" TextMode="Password"></asp:TextBox>
                                                    </div>
                                                </div>


                                                <div class="form-group">
                                                    <label>Teléfono</label>
                                                    <div>
                                                        <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control"
                                                            placeholder="Ingrese Teléfono"></asp:TextBox>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label>Correo</label>
                                                    <div>
                                                        <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control"
                                                            placeholder="Ingrese Correo"></asp:TextBox>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label>Dirección</label>
                                                    <div>
                                                        <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control"
                                                            placeholder="Ingrese Direccion de Domicilio" TextMode="MultiLine"></asp:TextBox>
                                                       
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label>Imagen de Casera(o)</label>
                                                    <div>
                                                        <asp:FileUpload ID="fuCaseraImage" runat="server" CssClass="form-control"
                                                            onchange="ImagePreview(this);" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label>NIT de la Casera(o) (Opcional)</label>
                                                    <div>
                                                        <asp:TextBox ID="txtNitCas" runat="server" CssClass="form-control"
                                                            placeholder="Ingrese NIT de la Casera(o)" oninput="return validateNumber(this);"></asp:TextBox>
                                                    </div>
                                                </div>



                                                <div class="form-check pl-4">
                                                    <asp:CheckBox ID="cbIsActive" runat="server" Text="&nbsp; Activo"
                                                        CssClass="form-check-input" />
                                                </div>
                                                <div class="pb-5">
                                                    <asp:Button ID="btnAddOrUpdate" runat="server" Text="Añadir" CssClass="btn btn-primary"
                                                        OnClick="btnAddOrUpdate_Click" />
                                                    &nbsp;
                                                    <asp:Button ID="btnClear" runat="server" Text="Eliminar" CssClass="btn btn-primary"
                                                        CausesValidation="false" OnClick="btnClear_Click" />
                                                </div>
                                                <div>
                                                    <asp:Image ID="imgCasera" runat="server" CssClass="img-thumbnail" />
                                                </div>
                                            </div>
                                        </div>



                                        <div class="col-sm-6 col-md-8 col-lg-8 mobile-inputs">
                                            <h4 class="sub-title">Lista de Caseras(os)</h4>
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
                                                    <asp:Repeater ID="rCasera" runat="server" OnItemCommand="rCasera_ItemCommand"
                                                        OnItemDataBound="rCasera_ItemDataBound">

                                                        <HeaderTemplate>
                                                            <table class="table data-table-export table-hover nowrap">
                                                                <thead>
                                                                    <tr>
                                                                        <th class="table-plus">Nombre</th>
                                                                        <th>Usuario</th>
                                                                        <th>Contraseña</th>
                                                                        <th>Imagen</th>
                                                                        <th>Teléfono</th>
                                                                        <th>Correo</th>
                                                                        <th>Dirección</th>
                                                                        <th>NIT</th>
                                                                        <%--<th>Activo</th>--%>
                                                                        <th>Fecha de Creacion</th>
                                                                        <th class="datatable-nosort">Accion</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td class="table-plus"><%# Eval("Nombre_Cas") %></td>
                                                                <td class="table-plus"><%# Eval("NombreUsuario_Cas") %></td>
                                                                <td class="table-plus"><%# Eval("Clave_Cas") %></td>
                                                                <td>
                                                                    <img alt="" width="40" src="<%# Utils.GetImageUrl( Eval("ImagenUrl_Cas")) %>" />
                                                                </td>

                                                                <td><%# Eval("Telefono_Cas") %> </td>
                                                                <td><%# Eval("Correo_Cas") %> </td>
                                                                <td><%# Eval("Direccion_Cas") %> </td>
                                                                <th><%# Eval("Nit_Cas") %></th>
                                                                <%--<td>
                                                                    <asp:Label ID="lblIsActive" runat="server" Text='<%# Eval("Activo_Cas") %>'>
                                                                    </asp:Label>
                                                                </td>--%>
                                                                <td><%# Eval("CreadoFecha_Cas") %></td>


                                                                <td>
                                                                    <asp:LinkButton ID="lnkEdit" Text="Edit" runat="server" CssClass="badge badge-primary"
                                                                        CommandArgument='<%# Eval("Cod_Cas") %>' CommandName="edit">
                                                                    <i class="ti-pencil"></i>
                                                                    </asp:LinkButton>
                                                                    <asp:LinkButton ID="lnkDelete" Text="Delete" runat="server" CommandName="delete"
                                                                        CssClass="badge bg-danger" CommandArgument='<%# Eval("Cod_Cas") %>'
                                                                        OnClientClick="return confirm('¿Quieres eliminar esta casera?);">
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

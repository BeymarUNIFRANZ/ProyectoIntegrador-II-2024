<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Category.aspx.cs" Inherits="CASEWEB.Admin.Category" %>

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
                    $('#<%=imgCategory.ClientID%>').prop('src', e.target.result)
                        .width(200)
                        .height(200);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>

    <!-- JavaScript para abrir la página ASPX en un cuadro de diálogo modal -->
    <script type="text/javascript">
        function openPdfPage() {
            var pdfPageUrl = 'ventacat.aspx'; // Reemplaza 'TuArchivo.aspx' con la URL de tu archivo ASPX
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
                                            <h4 class="sub-title">Categoria</h4>
                                            <div>
                                                <!--
                                                <div class="form-group">
                                                    <label>Numero de Caseta</label>
                                                    <div>
                                                        <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control"
                                                            placeholder="Ingrese Numero" required></asp:TextBox>
                                                        <asp:HiddenField ID="HiddenField1" Value="0" runat="server" />
                                                    </div>
                                                </div>
                                                -->
                                                <div class="form-group">
                                                    <label>Nombre de la Categoria</label>
                                                    <div>
                                                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control"
                                                            placeholder="Ingrese Nombre"></asp:TextBox>
                                                        <asp:HiddenField ID="hdnId" Value="0" runat="server" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Imagen de la Categoria</label>
                                                    <div>
                                                        <asp:FileUpload ID="fuCategoryImage" runat="server" CssClass="form-control"
                                                            onchange="ImagePreview(this);" />
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
                                                    <asp:Image ID="imgCategory" runat="server" CssClass="img-thumbnail" />
                                                </div>
                                            </div>
                                        </div>


                                        <div class="col-sm-6 col-md-8 col-lg-8 mobile-inputs">
                                            <h4 class="sub-title">Lista de Categorias</h4>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">

                                                    <asp:LinkButton ID="lnkEdit" Text="Edit" runat="server" CssClass="badge badge-primary"
                                                        CommandArgument='<%# Eval("Cod_Pro") %>' CommandName="edit" OnClientClick="openPdfPage(); return false;">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="10" fill="currentColor" class="bi bi-hand-index" viewBox="0 0 16 16">
                                                        <h6>Abrir PDF</h6>
                                                    </svg>
                                                    </asp:LinkButton>
                                                    <hr />

                                                    <!-- Cuadro de diálogo modal -->
                                                    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                        <div class="modal-dialog modal-lg">
                                                            <!-- Puedes ajustar el tamaño del cuadro de diálogo modal según tus necesidades -->
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="exampleModalLabel">Reportes por Categoria</h5>
                                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                        <span aria-hidden="true">&times;</span>
                                                                    </button>
                                                                </div>
                                                                <div class="modal-body"></div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <asp:Repeater ID="rCategory" runat="server" OnItemCommand="rCategory_ItemCommand"
                                                        OnItemDataBound="rCategory_ItemDataBound1">

                                                        <HeaderTemplate>
                                                            <table class="table data-table-export table-hover nowrap">
                                                                <thead>
                                                                    <tr>
                                                                        <th class="table-plus">Nombre</th>
                                                                        <th>Imagen</th>
                                                                        <th>Activo</th>
                                                                        <th>Fecha Creada</th>
                                                                        <th class="datatable-nosort">Accion</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td class="table-plus"><%# Eval("Nombre_Cat") %> </td>
                                                                <td>
                                                                    <img alt="" width="40" src="<%# Utils.GetImageUrl( Eval("ImagenUrl_Cat")) %>" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblIsActive" runat="server" Text='<%# Eval("Activo_Cat") %>'></asp:Label>
                                                                </td>
                                                                <td><%# Eval("CrearFecha_Cat") %> </td>
                                                                <td>
                                                                    <asp:LinkButton ID="lnkEdit" Text="Edit" runat="server" CssClass="badge badge-primary"
                                                                        CommandArgument='<%# Eval("Cod_Cat") %>' CommandName="edit">
                                                                            <i class="ti-pencil"></i>
                                                                    </asp:LinkButton>

                                                                    <asp:LinkButton ID="lnkDelete" Text="Delete" runat="server" CommandName="delete"
                                                                        CssClass="badge bg-danger" CommandArgument='<%# Eval("Cod_Cat") %>'
                                                                        OnClientClick="return confirm('Do you want to delete this category?');">
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

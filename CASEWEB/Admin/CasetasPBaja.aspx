<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="CasetasPBaja.aspx.cs" Inherits="CASEWEB.Admin.CasetasPBaja" %>

<%@ Import Namespace="CASEWEB" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- margen de botones -->
    <link href="../PlantillaArchivos/css/style.css" rel="stylesheet" type="text/css" />
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" />

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
                                            <h4 class="sub-title">Casetas</h4>

                                            <div class="form-group">
                                                <label>Nivel de Piso</label>
                                                <div>
                                                    <asp:DropDownList ID="txtPiso" runat="server" CssClass="form-control">
                                                        <asp:ListItem Text="Seleccione una opción" Value="0" />
                                                        <asp:ListItem Text="Piso 1" Value="P1" />
                                                        <asp:ListItem Text="Piso 2" Value="P2" />
                                                        <asp:ListItem Text="Planta Baja" Value="PlantaBaja" />
                                                        <asp:ListItem Text="Subterraneo" Value="Subterraneo" />
                                                    </asp:DropDownList>

                                                </div>
                                                <asp:HiddenField ID="HiddenField1" Value="0" runat="server" />
                                            </div>

                                            <div class="form-group">
                                                <label>Numero de Caseta</label>
                                                <div>
                                                    <asp:DropDownList ID="txtName" runat="server" CssClass="form-control">
                                                        <asp:ListItem Text="Seleccione una opción" Value="0" />
                                                        <asp:ListItem Text="1" Value="1" />
                                                        <asp:ListItem Text="2" Value="2" />
                                                        <asp:ListItem Text="3" Value="3" />
                                                        <asp:ListItem Text="4" Value="4" />
                                                        <asp:ListItem Text="5" Value="5" />
                                                        <asp:ListItem Text="6" Value="6" />
                                                        <asp:ListItem Text="7" Value="7" />
                                                        <asp:ListItem Text="8" Value="8" />
                                                        <asp:ListItem Text="9" Value="9" />
                                                        <asp:ListItem Text="10" Value="10" />
                                                        <asp:ListItem Text="11" Value="11" />
                                                        <asp:ListItem Text="12" Value="12" />
                                                    </asp:DropDownList>

                                                </div>
                                                <asp:HiddenField ID="hdnId" Value="0" runat="server" />
                                            </div>

                                            <div class="form-group">
                                                <label>Color de la Caseta</label>
                                                <div>
                                                    <asp:DropDownList ID="ddlColorCaseta" runat="server" CssClass="form-control">
                                                        <asp:ListItem Text="Seleccione un color" Value="" />
                                                        <asp:ListItem Text="Rojo" Value="rojo" />
                                                        <asp:ListItem Text="Azul" Value="azul" />
                                                        <asp:ListItem Text="Verde" Value="verde" />
                                                        <asp:ListItem Text="Amarillo" Value="amarillo" />
                                                        <asp:ListItem Text="Rosa" Value="rosa" />
                                                    </asp:DropDownList>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label>Nombre de la Caseta</label>
                                                <div>
                                                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"
                                                        placeholder="Ingresar Nombre de la Caseta"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                                        ErrorMessage="Requiere Nombre" ForeColor="Red" Display="Dynamic"
                                                        SetFocusOnError="true" ControlToValidate="txtNombre"></asp:RequiredFieldValidator>
                                                    <asp:HiddenField ID="HiddenField2" runat="server" Value="0" />
                                                </div>
                                            </div>

                                            <div class="form-group">

                                                <div>
                                                    <label>Categoria</label>
                                                    <asp:DropDownList ID="ddlCategories" runat="server" CssClass="form-control"
                                                        DataSourceID="SqlDataSource1" DataTextField="Nombre_Cat" DataValueField="Cod_Cat"
                                                        AppendDataBoundItems="true">
                                                        <asp:ListItem Value="0">Seleccionar Categoria</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                                                        ErrorMessage="Categoria es Necesaria" ForeColor="Red" Display="Dynamic"
                                                        SetFocusOnError="true" ControlToValidate="ddlCategories" InitialValue="0">
                                                    </asp:RequiredFieldValidator>
                                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cs %>" SelectCommand="SELECT [Cod_Cat], [Nombre_Cat] FROM [CATEGORIAS]"></asp:SqlDataSource>
                                                </div>

                                            </div>

                                            <div class="form-group">

                                                <div>
                                                    <label>Caseras(os)</label>
                                                    <asp:DropDownList ID="ddlCaseras" runat="server" CssClass="form-control"
                                                        DataSourceID="SqlDataSource2" DataTextField="Nombre_Cas" DataValueField="Cod_Cas"
                                                        AppendDataBoundItems="true">
                                                        <asp:ListItem Value="0">Seleccionar Casera</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                                        ErrorMessage="Casera es Necesaria" ForeColor="Red" Display="Dynamic"
                                                        SetFocusOnError="true" ControlToValidate="ddlCaseras" InitialValue="0">
                                                    </asp:RequiredFieldValidator>
                                                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:cs %>" SelectCommand="SELECT [Cod_Cas], [Nombre_Cas] FROM [CASERA]"></asp:SqlDataSource>
                                                </div>

                                            </div>

                                            <div class="form-group">
                                                <label>Imagen de la Categoria</label>
                                                <div>
                                                    <asp:FileUpload ID="fuCasetaImage" runat="server" CssClass="form-control"
                                                        onchange="ImagePreview(this);" />
                                                </div>
                                            </div>

                                            <div class="form-check pl-4">
                                                <asp:CheckBox ID="cbIsActive" runat="server" Text="&nbsp; Activo"
                                                    CssClass="form-check-input" />
                                            </div>
                                            <div class="pb-5">
                                                <asp:Button ID="btnAddOrUpdate" runat="server" Text="Agregar" CssClass="btn btn-primary" OnClick="btnAddOrUpdate_Click"
                                                    OnItemDataBound="rCasetas_ItemDataBound1" />
                                            </div>

                                            <div>
                                                <asp:Image ID="imgCaseta" runat="server" CssClass="img-thumbnail" />
                                            </div>

                                        </div>

                                        <div class="col-sm-6 col-md-8 col-lg-8 mobile-inputs">
                                            <h4 class="sub-title">Lista de Casetas</h4>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">
                                                    <asp:Repeater ID="rCasetas" runat="server" OnItemCommand="rCasetas_ItemCommand">

                                                        <HeaderTemplate>
                                                            <table class="table data-table-export table-hover nowrap">
                                                                <thead>
                                                                    <tr>
                                                                        <th class="table-plus">Piso</th>
                                                                        <th>Numero Caseta</th>
                                                                        <th>Color</th>
                                                                        <th>Nombre</th>
                                                                        <th>Imagen</th>
                                                                        <th>Categoria</th>
                                                                        <th>Casera(o)</th>
                                                                        <th>Activo</th>
                                                                        <th>Fecha Creada</th>
                                                                        <th class="datatable-nosort">Accion</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td class="table-plus"><%# Eval("Piso_Cast") %> </td>
                                                                <td class="table-plus"><%# Eval("Numero_Cast") %> </td>

                                                                <td><%# Eval("Color_Cast") %> </td>

                                                                <td><%# Eval("Nombre_Cast") %> </td>

                                                                <td>
                                                                    <img alt="" width="40" src="<%# Utils.GetImageUrl( Eval("ImagenUrl_Cast")) %>" />
                                                                </td>

                                                                <td><%# Eval("Cod_Cat") %> </td>

                                                                <td><%# Eval("Cod_Cas") %> </td>

                                                                <td>
                                                                    <asp:Label ID="lblIsActive" runat="server" Text='<%# Eval("Activo_Cast") %>'></asp:Label>
                                                                </td>

                                                                <td><%# Eval("FechaCreada_Cast") %> </td>

                                                                <td>
                                                                    <asp:LinkButton ID="lnkEdit" Text="Edit" runat="server" CssClass="badge badge-primary"
                                                                        CommandArgument='<%# Eval("Cod_Cast") %>' CommandName="edit">
                                                                <i class="ti-pencil"></i>
                                                                    </asp:LinkButton>

                                                                    <asp:LinkButton ID="lnkDelete" Text="Delete" runat="server" CommandName="delete"
                                                                        CssClass="badge bg-danger" CommandArgument='<%# Eval("Cod_Cast") %>'
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

                                                    <br />


                                                </div>
                                            </div>
                                            <div>
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

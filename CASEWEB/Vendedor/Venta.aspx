﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Vendedor/Vendedor.Master" AutoEventWireup="true" CodeBehind="Venta.aspx.cs" Inherits="CASEWEB.Vendedor.Venta" %>
<%@ Import Namespace="CASEWEB" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
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
                                        <h4 class="sub-title">Productos</h4>
                                        <div>
                                            <%--<div class="form-group">
                                                <label>Nombre del Producto</label>
                                                <div>
                                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control"
                                                        placeholder="Ingresar Nombre del Producto"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                                        ErrorMessage="Requiere Nombre" ForeColor="Red" Display="Dynamic"
                                                        SetFocusOnError="true" ControlToValidate="txtName"></asp:RequiredFieldValidator>
                                                    <asp:HiddenField ID="hdnId" runat="server" Value="0" />
                                                </div>
                                            </div>--%>

                                            <div class="form-group">
                                                <label>Descripcion</label>
                                                <div>
                                                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control"
                                                        placeholder="Ingresar Descripcion del Producto" TextMode="MultiLine"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                                        ErrorMessage="Requiere Descripcion" ForeColor="Red" Display="Dynamic"
                                                        SetFocusOnError="true" ControlToValidate="txtDescription">
                                                    </asp:RequiredFieldValidator>
                                                </div>
                                            </div>

<%--                                            <div class="form-group">
                                                <label>Precio de Producto(Bs)</label>
                                                <div>
                                                    <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control"
                                                        placeholder="Ingresar Precio del Producto"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                                        ErrorMessage="Requiere Precio" ForeColor="Red" Display="Dynamic"
                                                        SetFocusOnError="true" ControlToValidate="txtPrice"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                                        ErrorMessage="El Precio tiene que estar en Decimal y sin caracteres" ForeColor="Red" Display="Dynamic"
                                                        SetFocusOnError="true" ControlToValidate="txtPrice"
                                                        ValidationExpression="^\d{0,8}(\.\d{1,4})?$"></asp:RegularExpressionValidator>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label>Stock de Producto</label>
                                                <div>
                                                    <asp:TextBox ID="txtQunatity" runat="server" CssClass="form-control"
                                                        placeholder="Cantidad Producto"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                                        ErrorMessage="Requiere Stock" ForeColor="Red" Display="Dynamic"
                                                        SetFocusOnError="true" ControlToValidate="txtQunatity"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                                                        ErrorMessage="La Cantidad No puede ser Negativa/Ni contener Caracteres" ForeColor="Red" Display="Dynamic"
                                                        SetFocusOnError="true" ControlToValidate="txtQunatity"
                                                        ValidationExpression="^([1-9]\d*|0)$"></asp:RegularExpressionValidator>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label>Imagen de Producto</label>
                                                <div>
                                                    <asp:FileUpload ID="fuProductImage" runat="server" CssClass="form-control"
                                                        onchange="ImagePreview(this);" />
                                                </div>
                                            </div>--%>

                                            <%--<div class="form-group">
                                                <label>Categoria de Producto</label>
                                                <div>
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
                                            </div>--%>

                                           <!-- <div class="form-group">
                                                <label>Casetas</label>
                                                <div>
                                                    <asp:DropDownList ID="ddlCasetas" runat="server" CssClass="form-control"
                                                        DataSourceID="SqlDataSource2" DataTextField="Nombre_Cast" DataValueField="Cod_Cast"
                                                        AppendDataBoundItems="true">
                                                        <asp:ListItem Value="0">Seleccionar Caseta</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                                                        ErrorMessage="Casetas es Necesaria" ForeColor="Red" Display="Dynamic"
                                                        SetFocusOnError="true" ControlToValidate="ddlCasetas" InitialValue="0">
                                                    </asp:RequiredFieldValidator>
                                                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:cs %>" SelectCommand="SELECT [Cod_Cast],[Nombre_Cast] FROM [CASETAS]"></asp:SqlDataSource>
                                                </div>
                                            </div>-->

                                            <%--<div class="form-check pl-4">
                                                <asp:CheckBox ID="cbIsActive" runat="server" Text="&nbsp; Activo"
                                                    CssClass="form-check-input" />
                                            </div>--%>
                                           <%-- <div class="pb-5">
                                                <asp:Button ID="btnAddOrUpdate" runat="server" Text="Añadir" CssClass="btn btn-primary"
                                                    OnClick="btnAddOrUpdate_Click" />
                                                &nbsp;
                                            <asp:Button ID="btnClear" runat="server" Text="Cancelar" CssClass="btn btn-primary"
                                                CausesValidation="false" OnClick="btnClear_Click" />
                                            </div>--%>
                                            <%--<div>
                                                <asp:Image ID="imgProduct" runat="server" CssClass="img-thumbnail" />
                                            </div>--%>
                                        </div>
                                    </div>


                                    <div class="col-sm-6 col-md-8 col-lg-8 mobile-inputs">
                                        <h4 class="sub-title">Lista de Productos</h4>
                                        <div class="card-block table-border-style">
                                            <div class="table-responsive">



                                               <%-- <asp:LinkButton ID="LinkButton1" Text="Edit" runat="server" CssClass="badge badge-success"
                                                    CommandArgument='<%# Eval("Cod_Pro") %>' CommandName="edit" OnClientClick="openPdfPage2(); return false;">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="10" fill="currentColor" class="bi bi-hand-index" viewBox="0 0 16 16">
                                                        <h6>Mas Vendidos</h6>
                                                    </svg>
                                                </asp:LinkButton>
                                                <hr />
                                                <!-- Cuadro de diálogo modal -->
                                                <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog modal-lg">
                                                        <!-- Puedes ajustar el tamaño del cuadro de diálogo modal según tus necesidades -->
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Reportes de Ventas</h5>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                            </div>
                                                            <div class="modal-body"></div>
                                                        </div>
                                                    </div>
                                                </div>


                                                <asp:LinkButton ID="LinkButton2" Text="Edit" runat="server" CssClass="badge badge-success"
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
                                                </div>--%>


                                                <br />

                                               <asp:Repeater ID="rVenta" runat="server" >
    <HeaderTemplate>
        <table class="table data-table-export table-hover nowrap">
            <thead>
                <tr>
                    <th class="table-plus">Nombre</th>
                    <th>Imagen</th>
                    <th>Precio(Bs)</th>
                    <th>Cantidad</th>
                    <th>Categoria</th>
                    <th>Activo</th>
                    <th>Descripcion</th>
                    <th>Fecha Creada</th>
                    <th class="datatable-nosort">Acciones</th>
                </tr>
            </thead>
            <tbody>
    </HeaderTemplate>
    <ItemTemplate>
        <tr>
            <td class="table-plus"><%# Eval("Nombre_Pro") %></td>
            <td>
                <img alt="" width="40" src="<%# Utils.GetImageUrl(Eval("ImagenUrl_Pro")) %>" />
            </td>
            <td><%# Eval("Precio_Pro") %></td>
            <td>
                <asp:Label ID="lblQuantity" runat="server" Text='<%# Eval("Cantidad_Pro") %>'></asp:Label>
            </td>
            <td class="table-plus"><%# Eval("Nombre_Pro") %></td>
            <td>
                <asp:Label ID="lblIsActive" runat="server" Text='<%# Eval("Activo_Pro") %>'></asp:Label>
            </td>
            <td><%# Eval("Descripcion_Pro") %></td>
            <td><%# Eval("CreadoFecha_Pro") %></td>
            <td>
                <asp:RadioButton ID="rbSelect" runat="server" GroupName="productSelection" Text="Select" />
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

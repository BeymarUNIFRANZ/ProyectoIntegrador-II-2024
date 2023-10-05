<%@ Page Title="" Language="C#" MasterPageFile="~/Usuario/Usuario.Master" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="CASEWEB.Usuario.Registro" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script>
        /*For disappearing alert message*/
        window.onload = function () {
            var seconds = 10;
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID%>").style.display = "none";
            }, seconds * 10000);
        };
    </script>
    <script>
        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=imgUser.ClientID%>').prop('src', e.target.result)
                        .width(200)

                        .height(200);
                };
                reader.readAsDataURL(input.files[0]);
            }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align-self-end">
                    <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
                </div>
                <asp:Label ID="lblHeaderMsg" runat="server" Text="<h2>Registro de Usuario</h2>"></asp:Label>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="form_container">

                        <div>

                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                                ErrorMessage="Requiere Nombre Completo"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true">
                            </asp:RequiredFieldValidator>

                            <asp:RegularExpressionValidator ID="revName" runat="server"
                                ErrorMessage="El Nombre solo debe contener caracteres"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true"
                                ValidationExpression="^[a-zA-Z\s]+$" ControlToValidate="txtName">
                            </asp:RegularExpressionValidator>

                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control"
                                placeholder="Ingrese su Nombre Completo" ToolTip="FullName">
                            </asp:TextBox>
                        </div>

                        <div>

                            <asp:RequiredFieldValidator ID="rfvUsername" runat="server"
                                ControlToValidate="txtUsername" ErrorMessage="Requiere Nombre de Usuario"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true">
                            </asp:RequiredFieldValidator>

                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"
                                placeholder="Ingrese Nombre de Usuario" ToolTip="Username">
                            </asp:TextBox>

                        </div>

                        <div>

                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                                ControlToValidate="txtEmail" ErrorMessage="Requiere Correo Electronico"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true">
                            </asp:RequiredFieldValidator>


                            <asp:RegularExpressionValidator ID="revEmail" runat="server"
                                ErrorMessage="No Corresponde a un formato Email"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true"
                                ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"
                                 ControlToValidate="txtEmail">
                            </asp:RegularExpressionValidator>

                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"
                                placeholder="Ingrese su Correo Electronico" ToolTip="Email" TextMode="Email">
                            </asp:TextBox>
                        </div>

                        <div>

                            <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" ControlToValidate="txtTelefono"
                                ErrorMessage="Requiere Numero de Celular o Telefono"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true">
                            </asp:RequiredFieldValidator>

                            <asp:RegularExpressionValidator ID="revTelefono" runat="server"
                                ErrorMessage="El Numero no puede tener mas de 8 digitos ni caracteres"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true"
                                ValidationExpression="^[0-9]{8}$" ControlToValidate="txtTelefono">
                            </asp:RegularExpressionValidator>

                            <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control"
                                placeholder="Ingrese su Numero de Celular o Telefono" ToolTip="Mobile">
                            </asp:TextBox>

                        </div>

                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form_container">


                        <div>

                            <asp:RequiredFieldValidator ID="rfvDireccion" runat="server" ControlToValidate="TxtDireccion"
                                ErrorMessage="Requiere Direccion de Domicilio"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true">
                            </asp:RequiredFieldValidator>

                            <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control"
                                TextMode="MultiLine" placeholder="Ingrese su Direccion de Domicilio" ToolTip="Address">
                            </asp:TextBox>

                        </div>

                        <div>
                            <asp:FileUpload ID="fuImagenUsuario" runat="server" CssClass="form-control"
                                ToolTip="UserImage" onchange="ImagePreview(this);" />
                        </div>

                        <div>

                            <asp:RequiredFieldValidator ID="rfvClave" runat="server" ControlToValidate="txtClave"
                                ErrorMessage="Requiere Contraseña"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true">
                            </asp:RequiredFieldValidator>

                            <asp:TextBox ID="txtClave" runat="server" CssClass="form-control"
                                placeholder="Ingrese su Contraseña" ToolTip="Password" TextMode="Password">
                            </asp:TextBox>


                        </div>

                        <div class="row pl-4">
                            <div class="btn_box">
                                <asp:Button ID="btnRegister" runat="server" Text="Registrar" CssClass="btn btn-success rounded-pill pl-4 pr-4 text-white"
                                     OnClick="btnRegistrar_Click"/>
                                <asp:Label ID="lblAlreadyUser" runat="server" CssClass="pl-3 text-black-100"
                                    Text="Ya estas Registrado? <a href='Login.aspx' class='badge badge-info'>Logueate aqui...</a>">
                                </asp:Label>
                            </div>
                        </div>
                        <div class="row p-5">
                            <div style="align-items: center">
                                <asp:Image ID="imgUser" runat="server" CssClass="ing-thumbnail" />
                            </div>
                        </div>

                    </div>
                </div>
            </div>

        </div>
    </section>

</asp:Content>

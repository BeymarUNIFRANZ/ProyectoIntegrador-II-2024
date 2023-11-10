<%@ Page Title="" Language="C#" MasterPageFile="~/Usuario/Usuario.Master" AutoEventWireup="true" CodeBehind="Pago.aspx.cs" Inherits="CASEWEB.Usuario.Pago" %>
<%@ Import Namespace="CASEWEB" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

        <style>
        .rounded {
            border-radius: 1rem
        }

        .nav-pills .nav-link {
            color: #555
        }

            .nav-pills .nav-link.active {
                color: white
            }

        .bold {
            font-weight: bold
        }

        .card {
            padding: 40px 50px;
            border-radius: 20px;
            border: none;
            box-shadow: 1px 5px 10px 1px rgba(0, 0, 0, 0.2)
        }
    </style>
    <script>
         /*For disappearing alert message*/
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID %>").style.display = "none";
            }, seconds * 1000);
        };
        /*For tooltip*/
        $(function () {
            $('[data-toggle="tooltip"]').tooltip()
        })
    </script>

    <%--Function for preventing back button--%>
    <script type="text/javascript">
      function DisableBackButton() {
       window.history.forward()
      }
      DisableBackButton();
       window.onload = DisableBackButton;
       window.onpageshow = function(evt) { if (evt.persisted) DisableBackButton() }
        window.onunload = function() { void (0) }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    
    <section class="book_section" style="background-image: url('../Images/payment-bg.png'); width: 100%; height: 100%; background-repeat: no-repeat; 
        background-size: auto; background-attachment: fixed; background-position: left;">

        <div class="container py-5">
            <div class="align-self-end">
                <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
            </div>
            <!-- For demo purpose -->
            <div class="row mb-4">
                <div class="col-lg-8 mx-auto text-center">
                    <h1 class="display-6">Cancele Aqui Casero(a)!!</h1>
                </div>
            </div>
            <!-- End -->
            <div class="row pb-5">
                <div class="col-lg-6 mx-auto">
                    <div class="card ">
                        <div class="card-header">
                            <div class="bg-white shadow-sm pt-4 pl-2 pr-2 pb-2">
                                <!-- Payment type tabs -->
                                <ul role="tablist" class="nav bg-light nav-pills rounded nav-fill mb-3">
                                    <li class="nav-item"><a data-toggle="pill" href="#credit-card" class="nav-link active "><i class="fa fa-credit-card mr-2"></i>Tarjeta de Credito </a></li>
                                    <li class="nav-item"><a data-toggle="pill" href="#paypal" class="nav-link "><i class="fa fa-money mr-2"></i>Delivery </a></li>
                                    <%--<li class="nav-item"><a data-toggle="pill" href="#net-banking" class="nav-link "><i class="fa fa-mobile mr-2"></i>Net Banking </a></li>--%>
                                </ul>
                                <!-- End -->
                            </div>
                            <!-- Credit card form content -->
                            <div class="tab-content">
                                <!-- credit card info-->
                                <div id="credit-card" class="tab-pane fade show active pt-3">
                                    <div role="form">
                                        <div class="form-group">
                                            <label for="txtName">
                                                <h6>Titular</h6>
                                            </label>
                                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Name is required"
                                                ControlToValidate="txtName" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"
                                                ValidationGroup="card">*</asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                                ErrorMessage="El nombre debe estar en caracteres." ForeColor="Red" Display="Dynamic" SetFocusOnError="true"
                                                ValidationExpression="^[a-zA-Z\s]+$" ControlToValidate="txtName" ValidationGroup="card">*
                                            </asp:RegularExpressionValidator>
                                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Nombre del Propietario"></asp:TextBox>
                                        </div>
                                        <div class="form-group">
                                            <label for="txtCardNo">
                                                <h6>Numero de Tarjeta</h6>
                                            </label>
                                            <asp:RequiredFieldValidator ID="rfvCardNo" runat="server" ErrorMessage="Card number is required"
                                                ControlToValidate="txtCardNo" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"
                                                ValidationGroup="card">*</asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                                                ErrorMessage="El número de tarjeta debe tener 16 dígitos." ForeColor="Red" Display="Dynamic" SetFocusOnError="true"
                                                ValidationExpression="[0-9]{16}" ControlToValidate="txtCardNo" ValidationGroup="card">*
                                            </asp:RegularExpressionValidator>
                                            <div class="input-group">
                                                <asp:TextBox ID="txtCardNo" runat="server" CssClass="form-control" placeholder="Numero de Tarjeta Valido"
                                                    TextMode="Number"></asp:TextBox>
                                                <div class="input-group-append">
                                                    <span class="input-group-text text-muted">
                                                        <i class="fa fa-cc-visa mx-1"></i>
                                                        <i class="fa fa-cc-mastercard mx-1"></i>
                                                        <i class="fa fa-cc-amex mx-1"></i>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-8">
                                                <div class="form-group">
                                                    <label>
                                                        <span class="hidden-xs">
                                                            <h6>Fecha de Expiracion</h6>
                                                        </span>
                                                    </label>
                                                    <asp:RequiredFieldValidator ID="rfvExpMonth" runat="server" ErrorMessage="Expiry month is required"
                                                        ControlToValidate="txtExpMonth" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"
                                                        ValidationGroup="card">*</asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" Display="Dynamic"
                                              ErrorMessage="El mes de vencimiento debe tener 2 dígitos." ForeColor="Red" SetFocusOnError="true"
                                                        ValidationExpression="[0-9]{2}" ControlToValidate="txtExpMonth" ValidationGroup="card">*
                                                    </asp:RegularExpressionValidator>
                                                    <asp:RequiredFieldValidator ID="rfvExpYear" runat="server" ErrorMessage="Expiry year is required"
                                                        ControlToValidate="txtExpYear" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"
                                                        ValidationGroup="card">*</asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" Display="Dynamic"
                                                        ErrorMessage="El año de caducidad debe tener 4 dígitos." ForeColor="Red" SetFocusOnError="true"
                                                        ValidationExpression="[0-9]{4}" ControlToValidate="txtExpYear" ValidationGroup="card">*
                                                    </asp:RegularExpressionValidator>
                                                    <div class="input-group">
                                                        <asp:TextBox ID="txtExpMonth" runat="server" CssClass="form-control" placeholder="MM"
                                                            TextMode="Number"></asp:TextBox>
                                                        <asp:TextBox ID="txtExpYear" runat="server" CssClass="form-control" placeholder="YYYY"
                                                            TextMode="Number"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="form-group mb-4">
                                                    <label data-toggle="tooltip" title="Código CV de tres dígitos en el reverso de su tarjeta">
                                                        <h6>CVV <i class="fa fa-question-circle d-inline"></i></h6>
                                                    </label>
                                                    <asp:RequiredFieldValidator ID="rfvCvv" runat="server" ErrorMessage="CVV no. is required"
                                                        ControlToValidate="txtCvv" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"
                                                        ValidationGroup="card">*</asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" Display="Dynamic"
                                                        ErrorMessage="CVV no. must be of 3 digits" ForeColor="Red" SetFocusOnError="true"
                                                        ValidationExpression="[0-9]{3}" ControlToValidate="txtCvv" ValidationGroup="card">*
                                                    </asp:RegularExpressionValidator>
                                                    <asp:TextBox ID="txtCvv" runat="server" CssClass="form-control" placeholder="CVV No."
                                                        TextMode="Number"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="txtAddress">
                                                <h6>Direccion de Entrega</h6>
                                            </label>
                                            <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ErrorMessage="La dirección es necesaria" ForeColor="Red"
                                                ControlToValidate="txtAddress" Display="Dynamic" SetFocusOnError="true" ValidationGroup="card">*
                                            </asp:RequiredFieldValidator>
                                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Direccion de Entrega"
                                                TextMode="MultiLine" ValidationGroup="card"></asp:TextBox>
                                        </div>
                                        <div class="card-footer">
                                            <asp:LinkButton ID="lbCardSubmit" runat="server" CssClass="subscribe btn btn-info btn-block shadow-sm"
                                                ValidationGroup="card" OnClick="lbCardSubmit_Click">Confirmar Compra</asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                                <!-- End -->
                                <!-- Cash On Delivery info -->
                                <div id="paypal" class="tab-pane fade pt-3">
                                    <div class="form-group">
                                        <label for="txtCODAddress">
                                            <h6>Direccion de Entrega Delivery</h6>
                                        </label>
                                        <asp:TextBox ID="txtCODAddress" runat="server" CssClass="form-control" placeholder="Direccion Delivery"
                                            TextMode="MultiLine"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCODAddress" runat="server" ErrorMessage="La dirección es necesaria" ForeColor="Red"
                                            ControlToValidate="txtCODAddress" Display="Dynamic" SetFocusOnError="true" ValidationGroup="cod"
                                            Font-Names="Segoe Script"></asp:RequiredFieldValidator>
                                    </div>
                                    <p>
                                        <asp:LinkButton ID="lbCodSubmit" runat="server" CssClass="btn btn-info" ValidationGroup="cod" OnClick="lbCodSubmit_Click">
                                            <i class="fa fa-cart-arrow-down mr-2"></i>Confirmar Orden</asp:LinkButton>
                                    </p>
                                    <p class="text-muted">
                                        Nota: Al recibir su pedido, debe realizar el pago completo.
                                        Después de completar el proceso de pago, puede verificar el estado actualizado de su pedido.
                                    </p>
                                </div>
                                <!-- End -->
                            </div>
                            <!-- End -->
                        </div>
                        <div class="card-footer">
                            <b class="badge badge-success badge-pill shadow-sm">Precio Total: Bs <% Response.Write(Session["TotalPrecio"]); %> </b>
                            <div class="pt-1">
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" ValidationGroup="card"
                                    HeaderText="Fix the following errors" Font-Names="Segoe Script" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>


</asp:Content>

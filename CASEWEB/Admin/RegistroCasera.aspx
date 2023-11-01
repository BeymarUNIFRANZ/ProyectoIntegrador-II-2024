<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="RegistroCasera.aspx.cs" Inherits="CASEWEB.Admin.RegistroCasera" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
                                                    <label>Caseta</label>
                                                    <div>
                                                        <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control"
                                                            placeholder="Ingrese Numero" required></asp:TextBox>
                                                        <asp:HiddenField ID="HiddenField1" Value="0" runat="server" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label>Nombre de Casera(o)</label>
                                                    <div>
                                                        <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control"
                                                            placeholder="Ingrese Numero" required></asp:TextBox>
                                                        <asp:HiddenField ID="HiddenField2" Value="0" runat="server" />
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
    </div>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Usuario/Usuario.Master" AutoEventWireup="true" CodeBehind="MapeoCasetas.aspx.cs" Inherits="CASEWEB.Usuario.MapeoCasetas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <!-- Primera fila de asientos -->
        <div class="row">
            <div class="col-2">
                <div class="btn btn-default btn-sm">
                    <asp:Button ID="Button1" runat="server" Text="1" OnClick="EntrarCaseta" />
                </div>
            </div>
            <div class="col-2">
                <div class="btn btn-default btn-sm">
                    <asp:Button ID="Button2" runat="server" Text="2" OnClick="EntrarCaseta" />
                </div>
            </div>
            <div class="col-2">
                <div class="btn btn-default btn-sm">
                    <asp:Button ID="Button3" runat="server" Text="3" OnClick="EntrarCaseta" />
                </div>
            </div>
            <div class="col-2">
                <div class="btn btn-default btn-sm">
                    <asp:Button ID="Button4" runat="server" Text="4" OnClick="EntrarCaseta" />
                </div>
            </div>
            <div class="col-2">
                <div class="btn btn-default btn-sm">
                    <asp:Button ID="Button5" runat="server" Text="5" OnClick="EntrarCaseta" />
                </div>
            </div>
        </div>

        <!-- Segunda fila de asientos -->
        <div class="row">
            <div class="col-2">
                <div class="btn btn-default btn-sm">
                    <asp:Button ID="Button6" runat="server" Text="6" OnClick="EntrarCaseta" />
                </div>
            </div>
            <div class="col-2">
                <div class="btn btn-default btn-sm">
                    <asp:Button ID="Button7" runat="server" Text="7" OnClick="EntrarCaseta" />
                </div>
            </div>
            <div class="col-2">
                <div class="btn btn-default btn-sm">
                    <asp:Button ID="Button8" runat="server" Text="8" OnClick="EntrarCaseta" />
                </div>
            </div>
            <div class="col-2">
                <div class="btn btn-default btn-sm">
                    <asp:Button ID="Button9" runat="server" Text="9" OnClick="EntrarCaseta" />
                </div>
            </div>
            <div class="col-2">
                <div class="btn btn-default btn-sm">
                    <asp:Button ID="Button10" runat="server" Text="10" OnClick="EntrarCaseta" />
                </div>
            </div>
        </div>
        
        <!-- Tercera fila de asientos (Repite el patrón según sea necesario) -->
        <div class="row">
            
     <div class="col-2">
         <div class="btn btn-default btn-sm">
             <asp:Button ID="Button11" runat="server" Text="11" OnClick="EntrarCaseta" />
         </div>
     </div>
     <div class="col-2">
         <div class="btn btn-default btn-sm">
             <asp:Button ID="Button12" runat="server" Text="12" OnClick="EntrarCaseta" />
         </div>
     </div>
     <div class="col-2">
         <div class="btn btn-default btn-sm">
             <asp:Button ID="Button13" runat="server" Text="13" OnClick="EntrarCaseta" />
         </div>
     </div>
     <div class="col-2">
         <div class="btn btn-default btn-sm">
             <asp:Button ID="Button14" runat="server" Text="14" OnClick="EntrarCaseta" />
         </div>
     </div>
     <div class="col-2">
         <div class="btn btn-default btn-sm">
             <asp:Button ID="Button15" runat="server" Text="15" OnClick="EntrarCaseta" />
         </div>
     </div>
 </div>
        </div>
</asp:Content>

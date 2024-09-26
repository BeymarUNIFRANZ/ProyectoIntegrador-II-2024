<%@ Page Title="" Language="C#" MasterPageFile="~/Usuario/Usuario.Master" AutoEventWireup="true" CodeBehind="Contacto.aspx.cs" Inherits="CASEWEB.Usuario.Contacto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

  <script>
      /*For disappearing alert message*/
      window.onload = function () {
          var seconds = 5;
          setTimeout(function () {
              document.getElementById("<%=lblMsg.ClientID %>").style.display = "none";
         }, seconds * 3000);
      };
  </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

      <!-- book section -->
 <section class="book_section layout_padding">
     <div class="container">
         <div class="heading_container">
             <div class="align-self-end">
                 <asp:Label runat="server" ID="lblMsg"></asp:Label>
             </div>
             <h2>¡Envíanos tu Consulta!</h2>
         </div>
         <div class="row">
             <div class="col-md-6">
                 <div class="form_container">

                     <div>

                         <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Nombre Completo"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Se requiere el nombre" ControlToValidate="txtName"
                             ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                     </div>
                     <div>

                         <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Correo Electronico" TextMode="Email"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="correo electronico es requerido" ControlToValidate="txtEmail"
                             ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                     </div>
                     
                     <div>
                         <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" placeholder="Ingrese su consulta/comentarios"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="rfvMessage" runat="server" ErrorMessage="Se requiere mensaje" ControlToValidate="txtMessage"
                             ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                     </div>
                     <div class="btn_box">
                         <asp:Button ID="btnSubmit" runat="server" Text="Enviar" CssClass="btn btn-warning rounded-pill pl-4 pr-4 text-black" 
                            onclick="btnSubmit_Click" />
                     </div>

                 </div>
             </div>
            <div class="col-md-6">
        <div class="map_container">
            <!-- Enlace directo a Google Maps con las coordenadas y la altitud de la ubicación exacta -->
           <iframe
           <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d235.7090102155581!2d-65.25755980907007!3d-19.048599987770814!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x93fbcf36ec49718d%3A0x9ab71e8f317d0fb9!2sAwaj%20Warmi!5e0!3m2!1ses-419!2sbo!4v1718620371838!5m2!1ses-419!2sbo" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
        ></iframe>
        </div>
    </div>
         </div>
     </div>
 </section>
 <!-- end book section -->


</asp:Content>

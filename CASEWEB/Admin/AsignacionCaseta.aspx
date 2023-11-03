<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AsignacionCaseta.aspx.cs" Inherits="CASEWEB.Admin.AsignacionCaseta" %>

<%@ Import Namespace="CASEWEB" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
    function CambiarColor(button) {
        // Cambia el color de fondo del botón a verde
        button.style.backgroundColor = 'green';
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
                                        <div class="col-sm-12">
                                            <h4 class="sub-title">Filtrar Caseras(os) por Nombre</h4>
                                            <div>
                                                <div class="form-group">
                                                    <label>Nombre de Casera(o)</label>
                                                    <div class="input-group">
                                                        <asp:TextBox ID="txtNombreBusqueda" runat="server" CssClass="form-control"
                                                            placeholder="Ingrese Nombre de Casera(o)"></asp:TextBox>
                                                        <span class="input-group-btn">
                                                            <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-primary"
                                                                OnClick="btnBuscar_Click" />
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <h4 class="sub-title">Lista de Caseras(os)</h4>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">
                                                    <asp:Repeater ID="rCasera" runat="server">
                                                        <HeaderTemplate>
                                                            <table class="table data-table-export table-hover nowrap">
                                                                <thead>
                                                                    <tr>
                                                                        <th class="table-plus">Nombre</th>
                                                                        <th>Imagen</th>
                                                                        <th>Teléfono</th>
                                                                        <th>Correo</th>
                                                                        <th>Dirección</th>
                                                                        <th>NIT</th>
                                                                        <th>Fecha de Creacion</th>
                                                                        <th class="datatable-nosort">Accion</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td class="table-plus"><%# Eval("Nombre_Cas") %></td>
                                                                <td>
                                                                    <img alt="" width="40" src="<%# Utils.GetImageUrl(Eval("ImagenUrl_Cas")) %>" />
                                                                </td>
                                                                <td><%# Eval("Telefono_Cas") %> </td>
                                                                <td><%# Eval("Correo_Cas") %> </td>
                                                                <td><%# Eval("Direccion_Cas") %> </td>
                                                                <th><%# Eval("Nit_Cas") %></th>
                                                                <td><%# Eval("CreadoFecha_Cas") %></td>
                                                                <td>
                                                                    <asp:LinkButton ID="lnkEdit" Text="Edit" runat="server" CssClass="badge badge-success"
                                                                        CommandArgument='<%# Eval("Cod_Cas") %>' CommandName="edit" data-toggle="modal" data-target="#exampleModal">
                                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hand-index" viewBox="0 0 16 16">
                                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hand-index" viewBox="0 0 16 16">
                                                                      <path d="M6.75 1a.75.75 0 0 1 .75.75V8a.5.5 0 0 0 1 0V5.467l.086-.004c.317-.012.637-.008.816.027.134.027.294.096.448.182.077.042.15.147.15.314V8a.5.5 0 1 0 1 0V6.435a4.9 4.9 0 0 1 .106-.01c.316-.024.584-.01.708.04.118.046.3.207.486.43.081.096.15.19.2.259V8.5a.5.5 0 0 0 1 0v-1h.342a1 1 0 0 1 .995 1.1l-.271 2.715a2.5 2.5 0 0 1-.317.991l-1.395 2.442a.5.5 0 0 1-.434.252H6.035a.5.5 0 0 1-.416-.223l-1.433-2.15a1.5 1.5 0 0 1-.243-.666l-.345-3.105a.5.5 0 0 1 .399-.546L5 8.11V9a.5.5 0 0 0 1 0V1.75A.75.75 0 0 1 6.75 1zM8.5 4.466V1.75a1.75 1.75 0 1 0-3.5 0v5.34l-1.2.24a1.5 1.5 0 0 0-1.196 1.636l.345 3.106a2.5 2.5 0 0 0 .405 1.11l1.433 2.15A1.5 1.5 0 0 0 6.035 16h6.385a1.5 1.5 0 0 0 1.302-.756l1.395-2.441a3.5 3.5 0 0 0 .444-1.389l.271-2.715a2 2 0 0 0-1.99-2.199h-.581a5.114 5.114 0 0 0-.195-.248c-.191-.229-.51-.568-.88-.716-.364-.146-.846-.132-1.158-.108l-.132.012a1.26 1.26 0 0 0-.56-.642 2.632 2.632 0 0 0-.738-.288c-.31-.062-.739-.058-1.05-.046l-.048.002zm2.094 2.025z"/>
                                                                    </svg>
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
                                                                                <div class="modal-body">

                                                                                       <div class="container">
       <!-- Primera fila de asientos -->
       <div class="row">
           <div class="col-2">
               <div class="btn btn-default btn-sm">
                   <asp:Button ID="Button1" runat="server" Text="1"  OnClientClick="CambiarColor(this);" />
               </div>
           </div>
           <div class="col-2">
               <div class="btn btn-default btn-sm">
                   <asp:Button ID="Button2" runat="server" Text="2"  OnClientClick="CambiarColor(this);"/>
               </div>
           </div>
           <div class="col-2">
               <div class="btn btn-default btn-sm">
                   <asp:Button ID="Button3" runat="server" Text="3"  OnClientClick="CambiarColor(this);"/>
               </div>
           </div>
           <div class="col-2">
               <div class="btn btn-default btn-sm">
                   <asp:Button ID="Button4" runat="server" Text="4" OnClientClick="CambiarColor(this);"/>
               </div>
           </div>
           <div class="col-2">
               <div class="btn btn-default btn-sm">
                   <asp:Button ID="Button5" runat="server" Text="5"  OnClientClick="CambiarColor(this);"/>
               </div>
           </div>
       </div>

       <!-- Segunda fila de asientos -->
       <div class="row">
           <div class="col-2">
               <div class="btn btn-default btn-sm">
                   <asp:Button ID="Button6" runat="server" Text="6"  OnClientClick="CambiarColor(this);"/>
               </div>
           </div>
           <div class="col-2">
               <div class="btn btn-default btn-sm">
                   <asp:Button ID="Button7" runat="server" Text="7"  OnClientClick="CambiarColor(this);"/>
               </div>
           </div>
           <div class="col-2">
               <div class="btn btn-default btn-sm">
                   <asp:Button ID="Button8" runat="server" Text="8"  OnClientClick="CambiarColor(this);"/>
               </div>
           </div>
           <div class="col-2">
               <div class="btn btn-default btn-sm">
                   <asp:Button ID="Button9" runat="server" Text="9"  OnClientClick="CambiarColor(this);"/>
               </div>
           </div>
           <div class="col-2">
               <div class="btn btn-default btn-sm">
                   <asp:Button ID="Button10" runat="server" Text="10"  OnClientClick="CambiarColor(this);"/>
               </div>
           </div>
       </div>
       
       <!-- Tercera fila de asientos (Repite el patrón según sea necesario) -->
       <div class="row">
           
    <div class="col-2">
        <div class="btn btn-default btn-sm">
            <asp:Button ID="Button11" runat="server" Text="11"  OnClientClick="CambiarColor(this);"/>
        </div>
    </div>
    <div class="col-2">
        <div class="btn btn-default btn-sm">
            <asp:Button ID="Button12" runat="server" Text="12" OnClientClick="CambiarColor(this);"/>
        </div>
    </div>
    <div class="col-2">
        <div class="btn btn-default btn-sm">
            <asp:Button ID="Button13" runat="server" Text="13"  OnClientClick="CambiarColor(this);"/>
        </div>
    </div>
    <div class="col-2">
        <div class="btn btn-default btn-sm">
            <asp:Button ID="Button14" runat="server" Text="14"  OnClientClick="CambiarColor(this);"/>
        </div>
    </div>
    <div class="col-2">
        <div class="btn btn-default btn-sm">
            <asp:Button ID="Button15" runat="server" Text="15"  OnClientClick="CambiarColor(this);"/>
        </div>
    </div>
</div>
       </div>
                                                                                    
                                                                                </div>
                                                                                <div class="modal-footer">
                                                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>



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

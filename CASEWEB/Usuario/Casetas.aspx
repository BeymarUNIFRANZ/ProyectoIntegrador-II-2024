<%@ Page Title="" Language="C#" MasterPageFile="~/Usuario/Usuario.Master" AutoEventWireup="true" CodeBehind="Casetas.aspx.cs" Inherits="CASEWEB.Usuario.Casetas" %>

<%@ Import Namespace="CASEWEB" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="food_section layout_padding">
        <div class="container">
            <div class="heading_container heading_center">
                <div class="align-self-end">
                    <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
                </div>
                <h2>CASETAS</h2>
            </div>
            <%--<ul class="filters_menu">
    <li class="active" data-filter="*" data-id="0">Todo</li>
    <asp:Repeater ID="rPiso" runat="server">
        <ItemTemplate>
            <li data-filter=".<%# Regex.Replace(Eval("Nombre_Cat").ToString().ToLower(),@"\s+","") %>"
                data-id="<%# Eval("Cod_Cat") %>"><%# Eval("Nombre_Cat") %></li>
        </ItemTemplate>
    </asp:Repeater>
            </ul>--%>

            <div class="filters-content">
                <div class="row grid">
                    <asp:Repeater ID="rCasetas" runat="server" OnItemCommand="rCasetas_ItemCommand">
                        <ItemTemplate>
                            <div class="col-sm-6 col-lg-4 all <%# Regex.Replace(Eval("Numero_Cast").ToString().ToLower(),@"\s+","") %>">
                                <div class="box">
                                    <div>
                                        <div class="img-box">
                                <img src="<%# Utils.GetImageUrl( Eval("ImagenUrl_Cast")) %>" alt="">
                            </div>
                                        <div class="detail-box">
                                            <h5><%# Eval("Nombre_Cast") %></h5>
                                            <div class="options">
                                                <h6><%# Eval("Piso_Cast") %></h6>
                                                <asp:LinkButton runat="server" ID="lbAddToCart" CommandName="addToCart"
                                                    CommandArgument='<%# Eval("Cod_Cast") %>'>
                                                <svg xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="100" height="100" viewBox="0 0 50 50">
                                                <path d="M25,2C12.297,2,2,12.297,2,25s10.297,23,23,23s23-10.297,23-23S37.703,2,25,2z M25,11c1.657,0,3,1.343,3,3s-1.343,3-3,3 s-3-1.343-3-3S23.343,11,25,11z M29,38h-2h-4h-2v-2h2V23h-2v-2h2h4v2v13h2V38z"></path>
                                                  </svg> 
                                            
                                            
                                            <g>
                                                <g>
                                                    <path d="M345.6,338.862c-29.184,0-53.248,23.552-53.248,53.248c0,29.184,23.552,53.248,53.248,53.248
                                                             c29.184,0,53.248-23.552,53.248-53.248C398.336,362.926,374.784,338.862,345.6,338.862z" />
                                                </g>
                                            </g>
                                            <g>
                                                <g>
                                                    <path d="M439.296,84.91c-1.024,0-2.56-0.512-4.096-0.512H112.64l-5.12-34.304C104.448,27.566,84.992,10.67,61.952,10.67H20.48
                                                        C9.216,10.67,0,19.886,0,31.15c0,11.264,9.216,20.48,20.48,20.48h41.472c2.56,0,4.608,2.048,5.12,4.608l31.744,216.064
                                                        c4.096,27.136,27.648,47.616,55.296,47.616h212.992c26.624,0,49.664-18.944,55.296-45.056l33.28-166.4
                                                        C457.728,97.71,450.56,86.958,439.296,84.91z" />
                                                </g>
                                            </g>
                                            <g>
                                                <g>
                                                    <path d="M215.04,389.55c-1.024-28.16-24.576-50.688-52.736-50.688c-29.696,1.536-52.224,26.112-51.2,55.296
                                                    c1.024,28.16,24.064,50.688,52.224,50.688h1.024C193.536,443.31,216.576,418.734,215.04,389.55z" />
                                                </g>
                                            </g>
                                            <g>
                                            </g>
                                            <g>
                                            </g>
                                            <g>
                                            </g>
                                            <g>
                                            </g>
                                            <g>
                                            </g>
                                            <g>
                                            </g>
                                            <g>
                                            </g>
                                            <g>
                                            </g>
                                            <g>
                                            </g>
                                            <g>
                                            </g>
                                            <g>
                                            </g>
                                            <g>
                                            </g>
                                            <g>
                                            </g>
                                            <g>
                                            </g>
                                            <g>
                                            </g>
                                        </svg>
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>


                </div>
            </div>

        </div>
    </section>
</asp:Content>

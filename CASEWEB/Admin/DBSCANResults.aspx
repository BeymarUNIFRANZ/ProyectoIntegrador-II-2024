<%@ Page Title="DBSCAN Results" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="DBSCANResults.aspx.cs" Inherits="CASEWEB.Admin.DBSCANResults" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script>
        // Esperar a que los datos de clusterData estén disponibles
        window.onload = function () {
            if (typeof clusterData !== 'undefined' && clusterData.length > 0) {
                // Crear el gráfico con Chart.js
                var ctx = document.getElementById('dbscanChart').getContext('2d');
                var chart = new Chart(ctx, {
                    type: 'scatter', // Tipo de gráfico
                    data: {
                        datasets: [{
                            label: 'Clusters',
                            data: clusterData.map(function (item) {
                                return {
                                    x: item.Cantidad_Ord, // Valor para el eje X
                                    y: item.Cod_Pro, // Valor para el eje Y
                                    r: 5 // Tamaño de los puntos
                                };
                            }),
                            backgroundColor: 'rgba(75, 192, 192, 0.6)',
                            borderColor: 'rgba(75, 192, 192, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: true,
                        scales: {
                            x: {
                                type: 'linear',
                                position: 'bottom',
                                title: {
                                    display: true,
                                    text: 'Cantidad Orden'
                                },
                                min: 0, // Ajustar según tus datos
                                max: 200 // Ajustar según tus datos
                            },
                            y: {
                                type: 'linear',
                                title: {
                                    display: true,
                                    text: 'Código Producto'
                                },
                                min: 90, // Ajustar según tus datos
                                max: 150 // Ajustar según tus datos
                            }
                        }
                    }
                });
            }
        };
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Resultados del Clustering con DBSCAN</h2>

    <!-- Contenedor para el gráfico -->
    <div style="width: 80%; margin: auto;">
        <canvas id="dbscanChart"></canvas>
    </div>

    <div class="table-responsive">
        <asp:GridView ID="GridViewDBSCANResults" runat="server" AutoGenerateColumns="False" 
            CssClass="table table-striped table-hover">
            <Columns>
                <asp:BoundField DataField="ClusterId" HeaderText="Cluster ID" />
                <asp:BoundField DataField="Cantidad_Ord" HeaderText="Cantidad Orden" />
                <asp:BoundField DataField="Cod_Pro" HeaderText="Código Producto" />
                <asp:BoundField DataField="Cod_Pag" HeaderText="Código Pago" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>

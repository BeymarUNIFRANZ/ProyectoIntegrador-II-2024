<%@ Page Title="Clustering Results" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ClusteringController.aspx.cs" Inherits="CASEWEB.Admin.ClusteringController" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .table-header {
            background-color: #007bff;
            color: black;
            text-align: center;
        }
        .table-row {
            text-align: center;
        }
        .table-hover tbody tr:hover {
            background-color: #f1f1f1;
        }
        h2 {
            margin-bottom: 20px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Resultados del Clustering de Pedidos</h2>

    <div class="table-responsive">
        <asp:GridView ID="GridViewClusteringResults" runat="server" AutoGenerateColumns="False" 
            CssClass="table table-striped table-hover"
            HeaderStyle-CssClass="table-header"
            RowStyle-CssClass="table-row">
            <Columns>
                <asp:BoundField DataField="ClusterId" HeaderText="N° Cluster" />
                <asp:BoundField DataField="Count" HeaderText="Cantidad" />
                <asp:BoundField DataField="AvgCantidadOrd" HeaderText="Promedio/Cantidad Pedidos" />
                <asp:BoundField DataField="AvgCodPro" HeaderText="Promedio/Producto" />
                <asp:BoundField DataField="AvgCodPag" HeaderText="Promedio/Paga" />
            </Columns>
        </asp:GridView>
    </div>

    <h2>Visualización de Resultados de Clustering</h2>
    <canvas id="clusteringChart" width="400" height="200"></canvas>
    <!-- Canvas para el gráfico de dispersión -->
<h3>Distribución de Clusters</h3>
<canvas id="scatterChart" width="400" height="200"></canvas>


    <script>
        // Datos de los clusters en formato JSON
        const clusterData = <%= ClusterDataJson %>;

        // Extraer datos para la gráfica
        const labels = clusterData.map(item => 'Cluster ' + item.ClusterId);
        const countData = clusterData.map(item => item.Count);

        const ctx = document.getElementById('clusteringChart').getContext('2d');
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Cantidad de Pedidos por Cluster',
                    data: countData,
                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>

    <script type="text/javascript">
        // Pasa los datos desde el código C# a JavaScript
        var scatterData = <%= ScatterDataJson %>;

        // Agrupa los puntos de datos por cluster
        var clusteredData = scatterData.reduce((acc, point) => {
            if (!acc[point.PredictedClusterId]) {
                acc[point.PredictedClusterId] = [];
            }
            acc[point.PredictedClusterId].push({ x: point.Cod_Pro, y: point.Cantidad_Ord });
            return acc;
        }, {});

        // Prepara los datos para el gráfico de dispersión
        var scatterDataSets = Object.keys(clusteredData).map(clusterId => ({
            label: 'Cluster ' + clusterId,
            data: clusteredData[clusterId],
            backgroundColor: `rgba(${Math.floor(Math.random() * 255)}, ${Math.floor(Math.random() * 255)}, ${Math.floor(Math.random() * 255)}, 0.6)`,
            borderColor: `rgba(${Math.floor(Math.random() * 255)}, ${Math.floor(Math.random() * 255)}, ${Math.floor(Math.random() * 255)}, 1)`,
            borderWidth: 1
        }));

        // Configuración del gráfico de dispersión
        var ctxScatter = document.getElementById('scatterChart').getContext('2d');
        var scatterChart = new Chart(ctxScatter, {
            type: 'scatter',
            data: {
                datasets: scatterDataSets
            },
            options: {
                scales: {
                    x: {
                        type: 'linear',
                        position: 'bottom',
                        title: {
                            display: true,
                            text: 'Producto (Cod_Pro)'
                        }
                    },
                    y: {
                        title: {
                            display: true,
                            text: 'Cantidad Pedidos (Cantidad_Ord)'
                        }
                    }
                },
                plugins: {
                    tooltip: {
                        callbacks: {
                            label: function (context) {
                                return `Producto: ${context.raw.x}, Cantidad: ${context.raw.y}`;
                            }
                        }
                    }
                }
            }
        });
    </script>

</asp:Content>

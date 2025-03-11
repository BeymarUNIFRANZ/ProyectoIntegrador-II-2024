using System;
using System.Linq;
using System.Web.Script.Serialization;
using CASEWEB.MachineLearning;
using System.Collections.Generic;

namespace CASEWEB.Admin
{
    public partial class ClusteringController : System.Web.UI.Page
    {
        protected string ClusterDataJson; // Variable para almacenar los datos en JSON

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MostrarResultadosClustering();
            }
        }

        protected string ScatterDataJson; // Variable para almacenar los datos de dispersión en JSON

        private void MostrarResultadosClustering()
        {
            DataAnalyzer dataAnalyzer = new DataAnalyzer();
            List<ClusterPrediction> clusterResults = dataAnalyzer.AnalyzeOrderData();

            var clusterSummary = clusterResults
                .GroupBy(p => p.PredictedClusterId)
                .Select(g => new
                {
                    ClusterId = g.Key,
                    Count = g.Count(),
                    AvgCantidadOrd = g.Average(p => p.Cantidad_Ord),
                    AvgCodPro = g.Average(p => p.Cod_Pro),
                    AvgCodPag = g.Average(p => p.Cod_Pag)
                })
                .OrderByDescending(c => c.Count)
                .ToList();

            GridViewClusteringResults.DataSource = clusterSummary;
            GridViewClusteringResults.DataBind();

            // Serializar los datos de los clusters para el gráfico de dispersión
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            ScatterDataJson = serializer.Serialize(clusterResults); // Convertimos los puntos individuales a JSON

            // Serializar los datos de resumen para el gráfico de barras
            ClusterDataJson = serializer.Serialize(clusterSummary);
        }

    }
}

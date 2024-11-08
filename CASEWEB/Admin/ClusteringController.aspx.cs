using System;
using System.Linq;
using CASEWEB.MachineLearning;  // Asegúrate de tener la ruta correcta a tu DataAnalyzer
using System.Collections.Generic;

namespace CASEWEB.Admin
{
    public partial class ClusteringController : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MostrarResultadosClustering();
            }
        }

        private void MostrarResultadosClustering()
        {
            // Crear una instancia de la clase DataAnalyzer para ejecutar el análisis de clustering
            DataAnalyzer dataAnalyzer = new DataAnalyzer();

            // Ejecutar el análisis de clustering y obtener los resultados
            List<ClusterPrediction> clusterResults = dataAnalyzer.AnalyzeOrderData();

            // Crear una lista para almacenar los resultados en un formato adecuado para el GridView
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

            // Asignar los resultados al GridView para mostrarlos en la interfaz
            GridViewClusteringResults.DataSource = clusterSummary;
            GridViewClusteringResults.DataBind();
        }

    }
}

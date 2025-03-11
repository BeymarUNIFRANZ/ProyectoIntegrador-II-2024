using System;
using System.Linq;
using CASEWEB.MachineLearning;
using System.Collections.Generic;

namespace CASEWEB.Admin
{
    public partial class GaussianClusteringController : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MostrarResultadosGaussianClustering();
            }
        }

        private void MostrarResultadosGaussianClustering()
        {
            // Instancia del analizador Gaussian Mixture
            GaussianMixtureAnalyzer gaussianAnalyzer = new GaussianMixtureAnalyzer();

            // Ejecuta el análisis de clustering
            List<GaussianClusterPrediction> clusterResults = gaussianAnalyzer.AnalyzeOrderData();

            // Resumen de resultados de los clusters
            var clusterSummary = clusterResults
                .GroupBy(p => p.ClusterId)
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

            // Asignar al GridView
            GridViewGaussianClusteringResults.DataSource = clusterSummary;
            GridViewGaussianClusteringResults.DataBind();
        }
    }
}

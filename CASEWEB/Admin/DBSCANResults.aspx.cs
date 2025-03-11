using System;
using System.Collections.Generic;
using System.Web.UI;
using CASEWEB.MachineLearning;
using Newtonsoft.Json;

namespace CASEWEB.Admin
{
    public partial class DBSCANResults : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MostrarResultadosDBSCAN();
            }
        }

        private void MostrarResultadosDBSCAN()
        {
            // Crear instancia del analizador de DBSCAN
            DBSCANAnalyzer analyzer = new DBSCANAnalyzer();
            List<DBSCANPrediction> results = analyzer.AnalyzeOrderData();

            // Vincular los resultados al GridView
            GridViewDBSCANResults.DataSource = results;
            GridViewDBSCANResults.DataBind();

            // Crear una lista de objetos anónimos con los datos a pasar al frontend
            var clusterResults = new List<object>();
            foreach (var result in results)
            {
                clusterResults.Add(new
                {
                    ClusterId = result.ClusterId,
                    Cantidad_Ord = result.Cantidad_Ord,
                    Cod_Pro = result.Cod_Pro,
                    Cod_Pag = result.Cod_Pag
                });
            }

            // Convertir los resultados a JSON y pasarlos al cliente
            string jsonClusterResults = JsonConvert.SerializeObject(clusterResults);

            // Registrar el script para pasar los datos al cliente
            Page.ClientScript.RegisterStartupScript(this.GetType(), "ClusterData",
                $"var clusterData = {jsonClusterResults};", true);
        }
    }
}

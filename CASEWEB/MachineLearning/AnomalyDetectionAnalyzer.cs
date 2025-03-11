using Microsoft.ML;
using Microsoft.ML.Data;
using System;
using System.Collections.Generic;
using System.Linq;

namespace CASEWEB.MachineLearning
{
    public class GaussianMixtureAnalyzer
    {
        private MLContext _mlContext;

        public GaussianMixtureAnalyzer()
        {
            _mlContext = new MLContext();
        }

        public List<GaussianClusterPrediction> AnalyzeOrderData()
        {
            // Cargar los datos desde el archivo CSV
            var orderData = _mlContext.Data.LoadFromTextFile<Order>(@"C:\\Users\\Usuario\\source\\repos\\CASEWEB\\CASEWEB\\MachineLearning\\ORDEN.csv",
                hasHeader: true,
                separatorChar: ',');

            // Pipeline de transformación de datos
            var pipeline = _mlContext.Transforms
                .Concatenate("Features",
                    nameof(Order.Cantidad_Ord),
                    nameof(Order.Cod_Pro),
                    nameof(Order.Cod_Pag))
                .Append(_mlContext.Transforms.NormalizeMinMax("Features"))
                .Append(_mlContext.Clustering.Trainers.KMeans("Features", numberOfClusters: 5));

            // Entrenar el modelo con K-Means para aproximar un comportamiento similar a GMM
            var model = pipeline.Fit(orderData);

            // Transformar y obtener predicciones
            var transformedData = model.Transform(orderData);
            var predictions = _mlContext.Data.CreateEnumerable<GaussianClusterPrediction>(
                transformedData,
                reuseRowObject: false
            ).ToList();

            return predictions;
        }
    }

    // Nueva clase para almacenar predicciones GMM-like
    public class GaussianClusterPrediction
    {
        [ColumnName("PredictedLabel")]
        public uint ClusterId { get; set; }

        [ColumnName("Score")]
        public float[] Distances { get; set; }

        public float Cantidad_Ord { get; set; }
        public float Cod_Pro { get; set; }
        public float Cod_Pag { get; set; }
    
    }
}
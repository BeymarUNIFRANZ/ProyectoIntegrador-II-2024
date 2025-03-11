using Microsoft.ML;
using Microsoft.ML.Data;
using System;
using System.Collections.Generic;
using System.Linq;


namespace CASEWEB.MachineLearning
{
    public class DBSCANAnalyzer
    {
        private MLContext _mlContext;

        public DBSCANAnalyzer()
        {
            _mlContext = new MLContext();
        }

        public List<DBSCANPrediction> AnalyzeOrderData()
        {
            // Cargar los datos desde el archivo CSV
            var orderData = _mlContext.Data.LoadFromTextFile<Order>(@"C:\\Users\\Usuario\\source\\repos\\CASEWEB\\CASEWEB\\MachineLearning\\ORDEN.csv",
                hasHeader: true,
                separatorChar: ',');

            // Pipeline para concatenar características
            var pipeline = _mlContext.Transforms
                .Concatenate("Features",
                    nameof(Order.Cantidad_Ord),
                    nameof(Order.Cod_Pro),
                    nameof(Order.Cod_Pag))
                .Append(_mlContext.Transforms.NormalizeMinMax("Features"));

            // Transformar los datos
            var transformedData = pipeline.Fit(orderData).Transform(orderData);

            // Convertir los datos transformados a una lista para DBSCAN
            var dataPoints = _mlContext.Data.CreateEnumerable<DataPoint>(
                transformedData,
                reuseRowObject: false).ToList();

            // Parámetros para DBSCAN
            float epsilon = 0.5f; // Distancia máxima entre puntos en el mismo cluster
            int minPoints = 3;    // Número mínimo de puntos para formar un cluster

            // Aplicar DBSCAN
            var dbscanResults = ApplyDBSCAN(dataPoints, epsilon, minPoints);

            // Crear las predicciones en el formato esperado
            var predictions = dbscanResults.Select(result => new DBSCANPrediction
            {
                ClusterId = result.ClusterId,
                Cantidad_Ord = result.Cantidad_Ord,
                Cod_Pro = result.Cod_Pro,
                Cod_Pag = result.Cod_Pag
            }).ToList();

            return predictions;
        }

        private List<DBSCANResult> ApplyDBSCAN(List<DataPoint> dataPoints, float epsilon, int minPoints)
        {
            var clusters = new List<DBSCANResult>();
            var visited = new HashSet<int>();
            int clusterId = 0;

            for (int i = 0; i < dataPoints.Count; i++)
            {
                if (visited.Contains(i)) continue;

                visited.Add(i);
                var neighbors = FindNeighbors(dataPoints, i, epsilon);

                if (neighbors.Count < minPoints)
                {
                    clusters.Add(new DBSCANResult
                    {
                        ClusterId = -1,
                        Cantidad_Ord = dataPoints[i].Cantidad_Ord,
                        Cod_Pro = dataPoints[i].Cod_Pro,
                        Cod_Pag = dataPoints[i].Cod_Pag
                    });
                    continue;
                }

                clusterId++;
                ExpandCluster(dataPoints, clusters, visited, neighbors, clusterId, epsilon, minPoints);
            }

            return clusters;
        }

        private void ExpandCluster(List<DataPoint> dataPoints, List<DBSCANResult> clusters, HashSet<int> visited,
            List<int> neighbors, int clusterId, float epsilon, int minPoints)
        {
            foreach (var neighborIndex in neighbors)
            {
                if (!visited.Contains(neighborIndex))
                {
                    visited.Add(neighborIndex);
                    var newNeighbors = FindNeighbors(dataPoints, neighborIndex, epsilon);
                    if (newNeighbors.Count >= minPoints)
                    {
                        neighbors.AddRange(newNeighbors);
                    }
                }

                clusters.Add(new DBSCANResult
                {
                    ClusterId = clusterId,
                    Cantidad_Ord = dataPoints[neighborIndex].Cantidad_Ord,
                    Cod_Pro = dataPoints[neighborIndex].Cod_Pro,
                    Cod_Pag = dataPoints[neighborIndex].Cod_Pag
                });
            }
        }

        private List<int> FindNeighbors(List<DataPoint> dataPoints, int pointIndex, float epsilon)
        {
            var neighbors = new List<int>();
            var currentPoint = dataPoints[pointIndex];

            for (int i = 0; i < dataPoints.Count; i++)
            {
                if (i == pointIndex) continue;

                float distance = EuclideanDistance(currentPoint, dataPoints[i]);
                if (distance <= epsilon)
                {
                    neighbors.Add(i);
                }
            }

            return neighbors;
        }

        private float EuclideanDistance(DataPoint a, DataPoint b)
        {
            return (float)Math.Sqrt(
                Math.Pow(a.Cantidad_Ord - b.Cantidad_Ord, 2) +
                Math.Pow(a.Cod_Pro - b.Cod_Pro, 2) +
                Math.Pow(a.Cod_Pag - b.Cod_Pag, 2));
        }
    }

    // Clases auxiliares
    public class DataPoint
    {
        public float Cantidad_Ord { get; set; }
        public float Cod_Pro { get; set; }
        public float Cod_Pag { get; set; }
    }

    public class DBSCANResult
    {
        public int ClusterId { get; set; }
        public float Cantidad_Ord { get; set; }
        public float Cod_Pro { get; set; }
        public float Cod_Pag { get; set; }
    }

    public class DBSCANPrediction
    {
        public int ClusterId { get; set; }
        public float Cantidad_Ord { get; set; }
        public float Cod_Pro { get; set; }
        public float Cod_Pag { get; set; }
    }
}
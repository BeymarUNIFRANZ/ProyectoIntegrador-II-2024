using Microsoft.ML;
using Microsoft.ML.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.ML.Transforms;

public class DataAnalyzer
{
    private MLContext _mlContext;

    public DataAnalyzer()
    {
        _mlContext = new MLContext();
    }

    // Cambiamos el tipo de retorno a List<ClusterPrediction>
    public List<ClusterPrediction> AnalyzeOrderData()
    {
        // Preparar los datos para el clustering
        var orderData = _mlContext.Data.LoadFromTextFile<Order>(@"C:\\Users\\Usuario\\source\\repos\\CASEWEB\\CASEWEB\\MachineLearning\\ORDEN.csv",
            hasHeader: true,
            separatorChar: ',');

        // Definir la pipeline de transformación de datos
        var pipeline = _mlContext.Transforms
            .Concatenate("Features",
                nameof(Order.Cantidad_Ord), // Solo características numéricas
                nameof(Order.Cod_Pro),      // Solo características numéricas
                nameof(Order.Cod_Pag))      // Solo características numéricas
            .Append(_mlContext.Transforms.NormalizeMinMax("Features"))
            .Append(_mlContext.Clustering.Trainers.KMeans("Features", numberOfClusters: 5));

        // Entrenar el modelo
        var model = pipeline.Fit(orderData);

        // Transformar los datos y obtener las predicciones
        var transformedData = model.Transform(orderData);
        var predictions = _mlContext.Data.CreateEnumerable<ClusterPrediction>(
            transformedData,
            reuseRowObject: false
        ).ToList();

        // Devolver las predicciones
        return predictions;
    }
}

// Clase para los datos de entrada
public class Order
{
    [LoadColumn(3)]
    public float Cantidad_Ord { get; set; } // Asegúrate de que se puede convertir a float

    [LoadColumn(2)]
    public float Cod_Pro { get; set; } // Asegúrate de que se puede convertir a float

    [LoadColumn(6)]
    public float Cod_Pag { get; set; } // Asegúrate de que se puede convertir a float
}

// Clase para las predicciones
public class ClusterPrediction
{
    [ColumnName("PredictedLabel")]
    public uint PredictedClusterId { get; set; }

    [ColumnName("Score")]
    public float[] Distances { get; set; }

    public float Cantidad_Ord { get; set; }
    public float Cod_Pro { get; set; }
    public float Cod_Pag { get; set; }
}


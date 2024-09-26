using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using CrystalDecisions.Web;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CASEWEB.Admin
{
    public partial class pediclien1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnExportPDF_Click(object sender, EventArgs e)
        {
            ExportarReporte("PDF");
        }

        protected void btnExportWord_Click(object sender, EventArgs e)
        {
            ExportarReporte("Word");
        }

        protected void btnExportExcel_Click(object sender, EventArgs e)
        {
            ExportarReporte("Excel");
        }

        protected void btnExportCSV_Click(object sender, EventArgs e)
        {
            ExportarReporte("CSV");
        }

        protected void btnExportText_Click(object sender, EventArgs e)
        {
            ExportarReporte("Texto");
        }

        private void ExportarReporte(string formato)
        {
            try
            {
                // Obtener la cadena de conexión desde web.config
                string cadenaConexion = System.Configuration.ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

                // Resto del código sigue igual
                using (SqlConnection conexion = new SqlConnection(cadenaConexion))
                {
                    // Abrir la conexión
                    conexion.Open();

                    // Crear un comando SQL para obtener datos
                    string consultaSQL = "SELECT ORDEN.NumOrden_Ord, USUARIOS.Nombre_Usu, USUARIOS.Telefono_Usu, ORDEN.Estado_Ord, ORDEN.Fecha_Ord FROM ORDEN INNER JOIN USUARIOS ON ORDEN.Cod_Usu = USUARIOS.Cod_Usu";
                    using (SqlCommand comando = new SqlCommand(consultaSQL, conexion))
                    {
                        // Crear un adaptador de datos
                        using (SqlDataAdapter adaptador = new SqlDataAdapter(comando))
                        {
                            // Crear un conjunto de datos para almacenar los resultados de la consulta
                            DataSet dataSet = new DataSet();

                            // Llenar el conjunto de datos con los resultados de la consulta
                            adaptador.Fill(dataSet);

                            // Crear un informe Crystal Reports
                            ReportDocument reportDocument = new ReportDocument();
                            reportDocument.Load(Server.MapPath("pedidclien.rpt"));

                            // Configurar el origen de datos del informe
                            reportDocument.SetDataSource(dataSet.Tables[0]);

                            // Obtener el nombre del archivo
                            string nombreArchivo = $"Pedidoporcliente_{DateTime.Now.ToString("yyyyMMddHHmmss")}";

                            // Exportar el informe en el formato deseado con el nombre del archivo
                            reportDocument.ExportToHttpResponse(GetFormatoExportacion(formato), Response, true, nombreArchivo);
                            Response.End();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Manejar la excepción, por ejemplo, mostrar un mensaje de error o registrarla.
                Response.Write($"Error al exportar el informe: {ex.Message}");
            }
        }

        private ExportFormatType GetFormatoExportacion(string formato)
        {
            switch (formato.ToLower())
            {
                case "pdf":
                    return ExportFormatType.PortableDocFormat;
                case "word":
                    return ExportFormatType.WordForWindows;
                case "excel":
                    return ExportFormatType.Excel;
                case "csv":
                    return ExportFormatType.CharacterSeparatedValues;
                case "texto":
                    return ExportFormatType.Text;
                default:
                    throw new ArgumentOutOfRangeException(nameof(formato), formato, null);
            }
        }

        private string ObtenerTipoContenido(string formato)
        {
            switch (formato.ToLower())
            {
                case "pdf":
                    return "application/pdf";
                case "word":
                    return "application/msword";
                case "excel":
                    return "application/vnd.ms-excel";
                case "csv":
                    return "text/csv";
                case "texto":
                    return "text/plain";
                default:
                    throw new ArgumentOutOfRangeException(nameof(formato), formato, null);
            }
        }
    }
}
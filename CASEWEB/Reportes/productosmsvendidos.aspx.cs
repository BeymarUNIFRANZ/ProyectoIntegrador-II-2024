using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;


namespace CASEWEB.Vendedor
{
    public partial class productosmsvendidos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
             try
            {
                // Tu código existente aquí
            }
            catch (Exception ex)
            {
                // Registra el error o imprímelo en la consola de salida
                Console.WriteLine(ex.ToString());
            }
        }

        protected void CrystalReportViewer1_Init(object sender, EventArgs e)
        {

            CrystalReportViewer1.ReportSource = CrystalReportSource1;
        }

        protected void btnDescargarPDF_Click(object sender, EventArgs e)
        {
       
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["OficialConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT TOP (10) Cod_Pro, Nombre_Pro, Precio_Pro, Cantidad_Pro AS TotalVendido FROM PRODUCTOS ORDER BY Cantidad_Pro DESC", con))
                    {
                        cmd.CommandType = CommandType.Text;
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = cmd;
                        DataTable datatable = new DataTable();
                        da.Fill(datatable); // Obtiene toda la información

                        ReportDocument crystalReport = new ReportDocument(); // Crear el crystal report
                        crystalReport.Load(Server.MapPath("productomsvendidos.rpt")); // Ruta del reporte 
                        crystalReport.SetDataSource(datatable); // Cargar datos al reporte
                        CrystalReportViewer1.ReportSource = crystalReport;

                        crystalReport.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "ProductosMasVendidos_" + DateTime.Now.ToString());//Exportar pdf
                    }
                }
            }
            catch (Exception ex)
            {
                // Manejar la excepción, registrarla o mostrar un mensaje de error al usuario.
                // Por ejemplo:
                Response.Write("Se produjo un error: " + ex.Message);
            }


        }
    }
}
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Web;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace CASEWEB.Admin
{
    public partial class masvendido1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string connectionString = ConfigurationManager.ConnectionStrings["CaseBDConnectionString"].ToString();
                SqlConnection connection = new SqlConnection(connectionString);

                // Create a new DataSet
                DataSet data = new DataSet();

                // Define the structure of the table
                DataTable table = new DataTable("TablaDatos");
                table.Columns.Add("Producto", typeof(string));
                table.Columns.Add("Precio", typeof(decimal));
                table.Columns.Add("Cantidad", typeof(int));
                table.Columns.Add("Orden", typeof(int));
                data.Tables.Add(table);

                string sql = "SELECT dbo.PRODUCTOS.Nombre_Pro, dbo.PRODUCTOS.Precio_Pro, dbo.PRODUCTOS.Cantidad_Pro, dbo.ORDEN.Cantidad_Ord FROM dbo.PRODUCTOS INNER JOIN dbo.ORDEN ON dbo.PRODUCTOS.Cod_Pro = dbo.ORDEN.Cod_Pro";

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(sql, conn);
                    adapter.Fill(data, "TablaDatos");
                }

                // Supposing that 'masvendido' is the report file
                masvendido reporte = new masvendido();

                // Assign data to the report
                reporte.SetDataSource(data);

                // Bind the report to CrystalReportViewer
                CrystalReportViewer1.ReportSource = reporte;
            }
        }
    }
}
 
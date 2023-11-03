using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Web;

namespace CASEWEB.Admin
{
    public partial class ventacat1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string connectionString = ConfigurationManager.ConnectionStrings["CaseBDConnectionString"].ToString();

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string sql = "SELECT dbo.CATEGORIAS.Nombre_Cat AS Categoria, dbo.PRODUCTOS.Nombre_Pro AS Producto, dbo.PRODUCTOS.Precio_Pro AS Precio, dbo.PRODUCTOS.Cantidad_Pro AS Cantidad, dbo.ORDEN.Cantidad_Ord AS Orden " +
                        "FROM dbo.CATEGORIAS INNER JOIN " +
                        "dbo.PRODUCTOS ON dbo.CATEGORIAS.Cod_Cat = dbo.PRODUCTOS.Cod_Cat INNER JOIN " +
                        "dbo.ORDEN ON dbo.PRODUCTOS.Cod_Pro = dbo.ORDEN.Cod_Pro";

                    SqlDataAdapter adapter = new SqlDataAdapter(sql, connection);
                    DataSet datos = new DataSet();
                    adapter.Fill(datos, "TablaDatos");

                    // Suponiendo que CrystalReport1 está definido en el proyecto y es un informe válido
                    ventacat reporte = new ventacat();

                    // Asignar los datos al informe
                    reporte.SetDataSource(datos.Tables["ventacat.rpt"]);

                    // Enlazar el informe al CrystalReportViewer
                    CrystalReportViewer1.ReportSource = reporte;
                }
            }
        }
    }
}

using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using CrystalDecisions.CrystalReports.Engine;

namespace CASEWEB.Vendedor
{
    public partial class pedidos1 : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string connectionString = ConfigurationManager.ConnectionStrings["CaseBDConnectionString"].ToString();

                // Crear una instancia del DataSet
                DataSet datos = new DataSet();

                // Define la estructura de la tabla
                DataTable tabla = new DataTable("TablaDatos");
                tabla.Columns.Add("Nombre_Usu", typeof(string));
                tabla.Columns.Add("Nombre_Cat", typeof(string));
                tabla.Columns.Add("Nombre_Pro", typeof(string));
                tabla.Columns.Add("Precio_Pro", typeof(decimal));
                tabla.Columns.Add("NumOrden_Ord", typeof(int));
                tabla.Columns.Add("Fecha_Ord", typeof(DateTime));
                datos.Tables.Add(tabla);

                // Consulta SQL para recuperar datos
                string sql = "SELECT dbo.USUARIOS.Nombre_Usu, dbo.CATEGORIAS.Nombre_Cat, dbo.PRODUCTOS.Nombre_Pro, dbo.PRODUCTOS.Precio_Pro, dbo.ORDEN.NumOrden_Ord, dbo.ORDEN.Fecha_Ord " +
                             "FROM dbo.CATEGORIAS " +
                             "INNER JOIN dbo.PRODUCTOS ON dbo.CATEGORIAS.Cod_Cat = dbo.PRODUCTOS.Cod_Cat " +
                             "INNER JOIN dbo.ORDEN ON dbo.PRODUCTOS.Cod_Pro = dbo.ORDEN.Cod_Pro " +
                             "INNER JOIN dbo.USUARIOS ON dbo.ORDEN.Cod_Usu = dbo.USUARIOS.Cod_Usu";

                // Conexión a la base de datos y llenado del DataSet
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(sql, conn);
                    adapter.Fill(datos, "TablaDatos");
                }

                // Suponiendo que tienes un informe en Crystal Reports llamado "pedidos.rpt" en tu proyecto
                ReportDocument reporte = new ReportDocument();
                reporte.Load(Server.MapPath("CrystalReport1.rpt")); // Ajusta la ruta del informe

                // Asignar los datos al informe
                reporte.SetDataSource(datos.Tables["TablaDatos"]);

                // Enlazar el informe al CrystalReportViewer
                CrystalReportViewer1.ReportSource = reporte;
            }
        }
    }
}

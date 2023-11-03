using CrystalDecisions.Web;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CASEWEB.Vendedor
{
    public partial class masven : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string cadena = ConfigurationManager.ConnectionStrings["CaseBDConnectionString"].ToString();
                SqlConnection conexion = new SqlConnection(cadena);

                // Crear una instancia del DataSet
                DataSet datos = new DataSet();

                // Define la estructura de la tabla
                DataTable tabla = new DataTable("TablaDatos");
                tabla.Columns.Add("Categoria", typeof(string));
                tabla.Columns.Add("Producto", typeof(string));
                tabla.Columns.Add("Precio", typeof(decimal));
                tabla.Columns.Add("Cantidad", typeof(int));
                tabla.Columns.Add("Orden", typeof(int));
                datos.Tables.Add(tabla);

                string sql = "SELECT dbo.CATEGORIAS.Nombre_Cat AS Categoria, dbo.PRODUCTOS.Nombre_Pro AS Producto, dbo.PRODUCTOS.Precio_Pro AS Precio, dbo.PRODUCTOS.Cantidad_Pro AS Cantidad, dbo.ORDEN.Cantidad_Ord AS Orden " +
                    "FROM dbo.CATEGORIAS INNER JOIN " +
                    "dbo.PRODUCTOS ON dbo.CATEGORIAS.Cod_Cat = dbo.PRODUCTOS.Cod_Cat INNER JOIN " +
                    "dbo.ORDEN ON dbo.PRODUCTOS.Cod_Pro = dbo.ORDEN.Cod_Pro";

                using (SqlConnection conn = new SqlConnection(cadena))
                {
                    conn.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(sql, conn);
                    adapter.Fill(datos, "TablaDatos");
                }

                // Suponiendo que CrystalReport1 está definido en el proyecto y es un informe válido
                masven reporte = new masven();

                // Asignar los datos al informe
                reporte.SetDataSource(datos.Tables["CrystalReport1.rpt"]);

                // Enlazar el informe al CrystalReportViewer
                CrystalReportViewer1.ReportSource = reporte;
            }
        }

    }
}
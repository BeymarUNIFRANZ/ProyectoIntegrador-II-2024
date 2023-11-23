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

        protected void btnDescargarPDF_Click(object sender, EventArgs e)
        {

            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CaseBDConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT ORDEN.NumOrden_Ord, USUARIOS.Nombre_Usu, USUARIOS.Telefono_Usu, ORDEN.Estado_Ord, ORDEN.Fecha_Ord FROM ORDEN INNER JOIN USUARIOS ON ORDEN.Cod_Usu = USUARIOS.Cod_Usu", con))
                    {
                        cmd.CommandType = CommandType.Text;
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = cmd;
                        DataTable datatable = new DataTable();
                        da.Fill(datatable); // Obtiene toda la información

                        ReportDocument crystalReport = new ReportDocument(); // Crear el crystal report
                        crystalReport.Load(Server.MapPath("pedidclien.rpt")); // Ruta del reporte 
                        crystalReport.SetDataSource(datatable); // Cargar datos al reporte
                        CrystalReportViewer1.ReportSource = crystalReport;

                        crystalReport.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "pedidoscliente_" + DateTime.Now.ToString());//Exportar pdf
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
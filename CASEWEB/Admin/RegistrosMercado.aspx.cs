using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace CASEWEB.Admin
{
    public partial class RegistrosMercado : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Define la cadena de conexión a la base de datos
                string connectionString = "Data Source=DESKTOP-EB93L0E\\SQLEXPRESS01;Initial Catalog=CaseBD;Integrated Security=True";

                // Crea una consulta SQL para obtener los datos de las cuatro tablas
                string query = @"
                        INSERT INTO MERCADO (Cod_Niv, Cod_Cast, Cod_Cat, Cod_Cas)
                        SELECT
                            N.Cod_Niv,
                            C.Cod_Cast,
                            CAT.Cod_Cat,
                            CAS.Cod_Cas
                        FROM MERCADO N
                        JOIN CASETAS C ON N.Cod_Cast = C.Cod_Cast
                        JOIN CATEGORIAS CAT ON N.Cod_Cat = CAT.Cod_Cat
                        JOIN CASERA CAS ON N.Cod_Cas = CAS.Cod_Cas;
                        ";
                // Crea una conexión a la base de datos y un adaptador
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // Ejecuta la consulta y obtén los resultados en un DataTable
                        using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                        {
                            DataTable dataTable = new DataTable();
                            adapter.Fill(dataTable);

                            // Vincula los datos al control Repeater
                            rMercado.DataSource = dataTable;
                            rMercado.DataBind();
                        }
                    }
                }
            }
        }
    }
}

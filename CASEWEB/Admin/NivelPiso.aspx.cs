using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CASEWEB.Admin
{
    public partial class NivelPiso : Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            // Tu código de carga de página, si lo tienes
        }

        protected void btnSubterraneo_Click(object sender, EventArgs e)
        {
            // Manejar el clic del botón Subterraneo
        }

        protected void btnPlantaBaja_Click(object sender, EventArgs e)
        {
            // Obtener el texto del botón (nombre del nivel)
            string nombreNivel = btnPlantaBaja.Text;


            // Aquí puedes guardar los datos en tu base de datos
            // Debes usar tu conexión a la base de datos y una consulta SQL para insertar los datos.

            // Ejemplo de consulta SQL (debes ajustarla según tu esquema de base de datos)
            string consultaSql = "INSERT INTO NIVELES (Nombre_Niv) VALUES (@nombreNivel)";

            // Aquí configura y ejecuta la consulta SQL
            con = new SqlConnection(Connetion.GetConnectionString());
            {
                using (SqlCommand comando = new SqlCommand(consultaSql, con))
                {
                    // Configura los parámetros de la consulta
                    comando.Parameters.AddWithValue("@nombreNivel", nombreNivel);
                    

                    // Abre la conexión y ejecuta la consulta
                    con.Open();
                    comando.ExecuteNonQuery();
                }
            }

            // Redirige a la página deseada (CasetasPBaja.aspx en este caso)
            Response.Redirect("CasetasPBaja.aspx");
        }


        protected void btnPiso1_Click(object sender, EventArgs e)
        {
            // Manejar el clic del botón Piso 1
        }

        protected void btnPiso2_Click(object sender, EventArgs e)
        {
            // Manejar el clic del botón Piso 2
        }
    }
}

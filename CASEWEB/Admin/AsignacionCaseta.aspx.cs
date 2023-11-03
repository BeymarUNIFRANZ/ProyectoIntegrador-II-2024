using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace CASEWEB.Admin
{
    public partial class AsignacionCaseta : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            string nombreBusqueda = txtNombreBusqueda.Text.Trim();
            FiltrarCaserasPorNombre(nombreBusqueda);
        }

        private void FiltrarCaserasPorNombre(string nombre)
        {
            con = new SqlConnection(Connetion.GetConnectionString());
            cmd = new SqlCommand("Casera_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT4ADMIN"); // Asegúrate de tener esta acción definida en tu procedimiento almacenado.
            cmd.Parameters.AddWithValue("@Nombre", nombre);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rCasera.DataSource = dt;
            rCasera.DataBind();
        }
        protected void EntrarCaseta(object sender, EventArgs e)
        {
            
        }

        // ... Otras partes de tu código ...
    }
}

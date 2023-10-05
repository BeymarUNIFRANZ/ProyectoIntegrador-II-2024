using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CASEWEB
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string correo = txtCorreo.Text;
            string contraseña = txtContraseña.Text;

            string connectionString = "TuCadenaDeConexion"; // Actualiza con tu cadena de conexión a SQL Server
            string selectQuery = "SELECT PersonaID FROM Persona WHERE correoelectronico = @Correo AND Contraseña = @Contraseña";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(selectQuery, connection))
                {
                    command.Parameters.AddWithValue("@Correo", correo);
                    command.Parameters.AddWithValue("@Contraseña", contraseña);

                    connection.Open();
                    object result = command.ExecuteScalar();

                    if (result != null)
                    {
                        // Inicio de sesión exitoso
                        // Puedes redirigir a otra página o mostrar un mensaje de éxito
                        Response.Redirect("Dashboard.aspx");
                    }
                    else
                    {
                        // Inicio de sesión fallido
                        // Puedes mostrar un mensaje de error
                        Response.Write("Inicio de sesión fallido. Por favor, verifica tus credenciales.");
                    }
                }
            }
        }
    }
}
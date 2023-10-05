using System;
using System.Data.SqlClient;

namespace CASEWEB
{
    public partial class WebForm2 : System.Web.UI.Page
    {

        private string connectionString = "Data Source=LAPTOP-53765GT0\\SQLSERVER01;Initial Catalog=SupermarketDB;User ID=sa;Password=henrymayta;";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Esta función se ejecuta cuando la página se carga inicialmente.
            // Puedes realizar operaciones de inicialización aquí si es necesario.
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            try
            {
                string nombre = txtNombre.Text;
                int ci = Convert.ToInt32(txtCI.Text);
                string apellidoPaterno = txtApellidoPaterno.Text;
                string apellidoMaterno = txtApellidoMaterno.Text;
                string correoElectronico = txtCorreoElectronico.Text;
                string direccion = txtDireccion.Text;
                string contrasena = txtContrasena.Text;
                string confirmarContrasena = txtConfirmarContrasena.Text;

                // Verificar si las contraseñas coinciden
                if (contrasena != confirmarContrasena)
                {
                    Response.Write("Las contraseñas no coinciden.");
                    return;
                }

                // Verificar si la CI ya existe en la base de datos
                if (VerificarExistenciaCI(ci))
                {
                    Response.Write("La CI ingresada ya está en uso. Por favor, ingresa otra CI.");
                    return;
                }

                // Verificar si el correo electrónico ya existe en la base de datos
                if (VerificarExistenciaCorreo(correoElectronico))
                {
                    Response.Write("El correo electrónico ingresado ya está en uso. Por favor, ingresa otro correo electrónico.");
                    return;
                }

                // Query de inserción
                string insertQuery = "INSERT INTO Persona (Nombre, ci, apellidopaterno, apellidomaterno, correoelectronico, Direccion, Contraseña, RolID) " +
                                     "VALUES (@Nombre, @CI, @ApellidoPaterno, @ApellidoMaterno, @CorreoElectronico, @Direccion, @Contraseña, @RolID)";

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    // Crear el comando con la consulta de inserción y la conexión
                    SqlCommand command = new SqlCommand(insertQuery, connection);

                    // Asignar los parámetros con los valores del formulario
                    command.Parameters.AddWithValue("@Nombre", nombre);
                    command.Parameters.AddWithValue("@CI", ci);
                    command.Parameters.AddWithValue("@ApellidoPaterno", apellidoPaterno);
                    command.Parameters.AddWithValue("@ApellidoMaterno", apellidoMaterno);
                    command.Parameters.AddWithValue("@CorreoElectronico", correoElectronico);
                    command.Parameters.AddWithValue("@Direccion", direccion);
                    command.Parameters.AddWithValue("@Contraseña", contrasena);
                    command.Parameters.AddWithValue("@RolID", 1); // 1 es el ID del rol 'Usuario'

                    // Abrir la conexión y ejecutar la consulta
                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();

                    // Cerrar la conexión
                    connection.Close();

                    // Mostrar mensaje de éxito si se insertaron filas
                    if (rowsAffected > 0)
                    {
                        Response.Write("Registro exitoso.");
                    }
                    else
                    {
                        Response.Write("No se pudo registrar la persona.");
                    }
                }
            }
            catch (Exception ex)
            {
                // Manejar la excepción (puedes registrarla, mostrar un mensaje de error, etc.)
                Response.Write("Error durante el registro: " + ex.Message);
            }
        }

        private bool VerificarExistenciaCI(int ci)
        {
            // Lógica para verificar si la CI ya existe en la base de datos
            // Retorna true si la CI existe, false si no existe
            string query = "SELECT COUNT(*) FROM Persona WHERE ci = @CI";

            using (SqlConnection connection = new SqlConnection(connectionString))
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@CI", ci);
                connection.Open();
                int count = (int)command.ExecuteScalar();
                return count > 0;
            }
        }

        private bool VerificarExistenciaCorreo(string correo)
        {
            // Lógica para verificar si el correo electrónico ya existe en la base de datos
            // Retorna true si el correo existe, false si no existe
            string query = "SELECT COUNT(*) FROM Persona WHERE correoelectronico = @CorreoElectronico";

            using (SqlConnection connection = new SqlConnection(connectionString))
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@CorreoElectronico", correo);
                connection.Open();
                int count = (int)command.ExecuteScalar();
                return count > 0;
            }
        }
    }
}
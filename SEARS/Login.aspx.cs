using System;
using System.Data.SqlClient;
using System.Text;
using System.Web.Configuration;

namespace SEARS
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["SEARSConnectionString"].ConnectionString;
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            bool isAuthenticated = AuthenticateUser(username, password, connectionString);

            if (isAuthenticated)
            {
                // Iniciar sesión exitoso, redirigir a la página principal
                Response.Redirect("Default.aspx");
            }
            else
            {
                lblMessage.Text = "Credenciales inválidas, por favor intente nuevamente.";
            }
        }

        private bool AuthenticateUser(string username, string password, string connectionString)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM Usuario WHERE NombreUsuario = @Username AND PasswordHash = HASHBYTES('SHA2_256', @Password)";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Username", username);
                    command.Parameters.AddWithValue("@Password", Encoding.UTF8.GetBytes(password));
                    connection.Open();
                    int count = (int)command.ExecuteScalar();

                    if (count > 0)
                    {
                        // Credenciales de inicio de sesión válidas
                        return true;
                    }
                }
            }

            return false;
        }
    }
}

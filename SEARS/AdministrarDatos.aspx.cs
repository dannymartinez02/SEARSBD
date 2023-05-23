using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace SEARS
{
    public partial class AdministrarDatos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
            }
        }

        private void BindData()
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["SEARSConnectionString"].ConnectionString;
            string query = "SELECT * FROM Usuario";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);

                    GridView1.DataSource = dataTable;
                    GridView1.DataBind();
                }
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["SEARSConnectionString"].ConnectionString;
            string insertQuery = "INSERT INTO Usuario (NombreUsuario, PasswordHash, Salt) VALUES (@NombreUsuario, CONVERT(varbinary, @PasswordHash), @Salt)";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(insertQuery, connection))
                {
                    command.Parameters.AddWithValue("@NombreUsuario", txtNombreUsuario.Text);
                    command.Parameters.AddWithValue("@PasswordHash", GetPasswordHash(txtPassword.Text)); // Reemplaza GetPasswordHash con la lógica adecuada para obtener el hash de la contraseña
                    command.Parameters.AddWithValue("@Salt", GetSalt()); // Reemplaza GetSalt con la lógica adecuada para generar la sal

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }

            BindData();
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["SEARSConnectionString"].ConnectionString;
            string updateQuery = "UPDATE Usuario SET NombreUsuario = @NombreUsuario, PasswordHash = CONVERT(varbinary, @PasswordHash), Salt = @Salt WHERE IDusuario = @IDusuario";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(updateQuery, connection))
                {
                    command.Parameters.AddWithValue("@IDusuario", txtIDusuario.Text);
                    command.Parameters.AddWithValue("@NombreUsuario", txtNombreUsuario.Text);
                    command.Parameters.AddWithValue("@PasswordHash", GetPasswordHash(txtPassword.Text)); // Reemplaza GetPasswordHash con la lógica adecuada para obtener el hash de la contraseña
                    command.Parameters.AddWithValue("@Salt", GetSalt()); // Reemplaza GetSalt con la lógica adecuada para generar la sal

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }

            BindData();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["SEARSConnectionString"].ConnectionString;
            string deleteQuery = "DELETE FROM Usuario WHERE IDusuario = @IDusuario";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(deleteQuery, connection))
                {
                    command.Parameters.AddWithValue("@IDusuario", txtIDusuario.Text);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }

            BindData();
        }

        private string GetPasswordHash(string password)
        {
            // Implementa la lógica para obtener el hash de la contraseña
            // Puedes usar una función de hash como SHA256, bcrypt, etc.
            // Aquí se muestra un ejemplo básico utilizando SHA256:

            using (var sha256 = System.Security.Cryptography.SHA256.Create())
            {
                byte[] bytes = System.Text.Encoding.UTF8.GetBytes(password);
                byte[] hash = sha256.ComputeHash(bytes);
                return Convert.ToBase64String(hash);
            }
        }

        private byte[] GetSalt()
        {
            // Implementa la lógica para generar una sal
            // Puedes generar una sal aleatoria de longitud fija
            // Aquí se muestra un ejemplo básico de generación de sal aleatoria de 16 bytes:

            byte[] salt = new byte[16];
            using (var rng = new System.Security.Cryptography.RNGCryptoServiceProvider())
            {
                rng.GetBytes(salt);
            }
            return salt;
        }
    }
}


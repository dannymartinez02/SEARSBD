using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI.WebControls;

namespace SEARS
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            // Redirigir al usuario a la página de inicio de sesión (Login.aspx)
            Response.Redirect("Login.aspx");
        }

        protected void btnTable_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string tableName = btn.CommandArgument;

            // Obtener los datos de la tabla seleccionada y mostrarlos en la página
            DataTable tableData = GetTableData(tableName);

            // Asignar los datos al GridView correspondiente
            GridView gridView = null;
            if (tableName == "Usuario")
            {
                gridView = GridView1;
            }
            else if (tableName == "ConteoDeTarjetas")
            {
                gridView = GridView2;
            }
            else if (tableName == "EntregaDeTarjetas")
            {
                gridView = GridView3;
            }

            if (gridView != null)
            {
                gridView.DataSource = tableData;
                gridView.DataBind();
            }
        }

        protected void btnAdministrarDatos_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string tableName = btn.CommandArgument;

            // Redirigir al usuario a la página de administración de datos correspondiente
            if (tableName == "Usuario")
            {
                Response.Redirect("AdministrarDatos.aspx");
            }
            else if (tableName == "ConteoDeTarjetas")
            {
                Response.Redirect("AdministrarDatos2.aspx");
            }
            else if (tableName == "EntregaDeTarjetas")
            {
                Response.Redirect("AdministrarDatos3.aspx");
            }
        }

        private DataTable GetTableData(string tableName)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["SEARSConnectionString"].ConnectionString;
            string query = "SELECT * FROM " + tableName;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);
                    return dataTable;
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("ComprobarValidez.aspx");
        }
    }
}

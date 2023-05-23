using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SEARS
{
    public partial class AdministrarDatos2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        protected void BindGrid()
        {
            DataTable tableData = GetTableData();
            GridView1.DataSource = tableData;
            GridView1.DataBind();
        }

        protected DataTable GetTableData()
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["SEARSConnectionString"].ConnectionString;
            string query = "SELECT * FROM ConteoDeTarjetas";

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

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            BindGrid();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GridView1.Rows[e.RowIndex];

            if (e.RowIndex >= 0 && e.RowIndex < GridView1.Rows.Count)
            {
                int tarjetaDeCreditoID = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values["TarjetaDeCreditoID"]);
                string correlativo = ((TextBox)row.FindControl("txtEditCorrelativo")).Text;
                string tipoDeTarjeta = ((TextBox)row.FindControl("txtEditTipoTarjeta")).Text;

                UpdateTableData(tarjetaDeCreditoID, correlativo, tipoDeTarjeta);

                GridView1.EditIndex = -1;
                BindGrid();
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            if (e.RowIndex >= 0 && e.RowIndex < GridView1.Rows.Count)
            {
                int tarjetaDeCreditoID = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values["TarjetaDeCreditoID"]);

                DeleteTableData(tarjetaDeCreditoID);

                BindGrid();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string correlativo = txtCorrelativo.Text;
            string tipoDeTarjeta = txtTipoTarjeta.Text;

            InsertTableData(correlativo, tipoDeTarjeta);

            ClearForm();
            BindGrid();
        }

        protected void InsertTableData(string correlativo, string tipoDeTarjeta)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["SEARSConnectionString"].ConnectionString;
            string query = "INSERT INTO ConteoDeTarjetas (Correlativo, TipoDeTarjeta) " +
                           "VALUES (@Correlativo, @TipoDeTarjeta)";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Correlativo", correlativo);
                    command.Parameters.AddWithValue("@TipoDeTarjeta", tipoDeTarjeta);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        protected void UpdateTableData(int tarjetaDeCreditoID, string correlativo, string tipoDeTarjeta)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["SEARSConnectionString"].ConnectionString;
            string query = "UPDATE ConteoDeTarjetas " +
                           "SET Correlativo = @Correlativo, TipoDeTarjeta = @TipoDeTarjeta " +
                           "WHERE TarjetaDeCreditoID = @TarjetaDeCreditoID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Correlativo", correlativo);
                    command.Parameters.AddWithValue("@TipoDeTarjeta", tipoDeTarjeta);
                    command.Parameters.AddWithValue("@TarjetaDeCreditoID", tarjetaDeCreditoID);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        protected void DeleteTableData(int tarjetaDeCreditoID)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["SEARSConnectionString"].ConnectionString;
            string query = "DELETE FROM ConteoDeTarjetas WHERE TarjetaDeCreditoID = @TarjetaDeCreditoID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@TarjetaDeCreditoID", tarjetaDeCreditoID);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        protected void ClearForm()
        {
            txtCorrelativo.Text = string.Empty;
            txtTipoTarjeta.Text = string.Empty;
        }
    }
}

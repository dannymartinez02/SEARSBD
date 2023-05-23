using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.UI.WebControls;

namespace SEARS
{
    public partial class AdministrarDatos3 : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["SEARSConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
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
            int tarjetaDeCreditoID = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
            TextBox txtEditTitularTarjeta = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtEditTitularTarjeta");
            TextBox txtEditNumCuenta = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtEditNumCuenta");
            TextBox txtEditFechaExpiracion = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtEditFechaExpiracion");
            TextBox txtEditCorrelativo = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtEditCorrelativo");
            TextBox txtEditTipoTarjeta = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtEditTipoTarjeta");

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "UPDATE EntregaDeTarjetas SET TitularTarjeta=@TitularTarjeta, NumCuenta=@NumCuenta, FechaExpiracion=@FechaExpiracion, Correlativo=@Correlativo, TipoDeTarjeta=@TipoDeTarjeta WHERE TarjetaDeCreditoID=@TarjetaDeCreditoID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@TitularTarjeta", txtEditTitularTarjeta.Text);
                cmd.Parameters.AddWithValue("@NumCuenta", txtEditNumCuenta.Text);
                cmd.Parameters.AddWithValue("@FechaExpiracion", txtEditFechaExpiracion.Text);
                cmd.Parameters.AddWithValue("@Correlativo", txtEditCorrelativo.Text);
                cmd.Parameters.AddWithValue("@TipoDeTarjeta", txtEditTipoTarjeta.Text);
                cmd.Parameters.AddWithValue("@TarjetaDeCreditoID", tarjetaDeCreditoID);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            GridView1.EditIndex = -1;
            BindGrid();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int tarjetaDeCreditoID = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM EntregaDeTarjetas WHERE TarjetaDeCreditoID=@TarjetaDeCreditoID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@TarjetaDeCreditoID", tarjetaDeCreditoID);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            GridView1.EditIndex = -1;
            BindGrid();
        }

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM EntregaDeTarjetas";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                GridView1.DataSource = rdr;
                GridView1.DataBind();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string titularTarjeta = txtTitularTarjeta.Text;
            string numCuenta = txtNumCuenta.Text;
            string fechaExpiracion = txtFechaExpiracion.Text;
            string correlativo = txtCorrelativo.Text;
            string tipoTarjeta = txtTipoTarjeta.Text;

            try
            {
                DateTime fechaExpiracionDateTime;
                if (!DateTime.TryParseExact(fechaExpiracion, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out fechaExpiracionDateTime))
                {
                    // Mostrar un mensaje de error al usuario si la fecha no tiene el formato correcto.
                    lblErrorMessage.Text = "La fecha de expiración no tiene el formato correcto. Por favor, ingrese la fecha en el formato dd/MM/yyyy.";
                    lblErrorMessage.Visible = true;
                    return;
                }

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "INSERT INTO EntregaDeTarjetas (TitularTarjeta, NumCuenta, FechaExpiracion, Correlativo, TipoDeTarjeta, FechaDeEntrega) VALUES (@TitularTarjeta, @NumCuenta, @FechaExpiracion, @Correlativo, @TipoDeTarjeta, @FechaDeEntrega)";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@TitularTarjeta", titularTarjeta);
                    cmd.Parameters.AddWithValue("@NumCuenta", numCuenta);
                    cmd.Parameters.AddWithValue("@FechaExpiracion", fechaExpiracionDateTime);
                    cmd.Parameters.AddWithValue("@Correlativo", correlativo);
                    cmd.Parameters.AddWithValue("@TipoDeTarjeta", tipoTarjeta);
                    cmd.Parameters.AddWithValue("@FechaDeEntrega", DateTime.Now); // Puedes utilizar la fecha actual o proporcionar otro valor apropiado.

                    con.Open();
                    try
                    {
                        cmd.ExecuteNonQuery();
                        // El comando se ejecutó correctamente, no se produjo ninguna excepción.
                        lblErrorMessage.Text = "Tarjeta de crédito agregada correctamente.";
                        lblErrorMessage.Visible = true;
                    }
                    catch (SqlException ex)
                    {
                        // Se produjo una excepción de SQL, verifica si el error fue causado por el trigger.
                        if (ex.Message.Contains("Fecha de entrega no válida"))
                        {
                            lblErrorMessage.Text = "No se puede agregar la tarjeta de crédito. La fecha de entrega no es válida.";
                            lblErrorMessage.Visible = true;
                        }
                        else
                        {
                            // Otras excepciones de SQL, puedes manejarlas según tus necesidades.
                            lblErrorMessage.Text = "Se produjo un error al agregar la tarjeta de crédito.";
                            lblErrorMessage.Visible = true;
                        }
                    }
                }

                txtTitularTarjeta.Text = "";
                txtNumCuenta.Text = "";
                txtFechaExpiracion.Text = "";
                txtCorrelativo.Text = "";
                txtTipoTarjeta.Text = "";

                BindGrid();
            }
            catch (FormatException)
            {
                lblErrorMessage.Text = "La fecha de expiración no tiene el formato correcto. Por favor, ingrese la fecha en el formato dd/MM/yyyy.";
                lblErrorMessage.Visible = true;
            }
        }

    }
}

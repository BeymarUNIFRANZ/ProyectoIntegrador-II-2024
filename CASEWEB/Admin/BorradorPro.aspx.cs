using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CASEWEB.Admin
{
    public partial class BorradorPro : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadInactiveProducts();
            }
            lblMsg.Visible = false;
        }

        private void LoadInactiveProducts()
        {
            con = new SqlConnection(Connetion.GetConnectionString());
            string query = "SELECT * FROM PRODUCTOS WHERE Activo_Pro = 0";
            cmd = new SqlCommand(query, con);
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rInactiveProducts.DataSource = dt;
            rInactiveProducts.DataBind();
        }


        protected void rInactiveProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblMsg.Visible = false;
            if (e.CommandName == "activate")
            {
                con = new SqlConnection(Connetion.GetConnectionString());
                cmd = new SqlCommand("UPDATE PRODUCTOS SET Activo_Pro = 1 WHERE Cod_Pro = @ProductId", con);
                cmd.Parameters.AddWithValue("@ProductId", e.CommandArgument);
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Visible = true;
                    lblMsg.Text = "Producto activado correctamente.";
                    lblMsg.CssClass = "alert alert-success";
                    LoadInactiveProducts();
                }
                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Error - " + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";
                }
                finally
                {
                    con.Close();
                }
            }
            else if (e.CommandName == "delete")
            {
                con = new SqlConnection(Connetion.GetConnectionString());
                cmd = new SqlCommand("DELETE FROM PRODUCTOS WHERE Cod_Pro = @ProductId", con);
                cmd.Parameters.AddWithValue("@ProductId", e.CommandArgument);
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Visible = true;
                    lblMsg.Text = "Producto eliminado correctamente.";
                    lblMsg.CssClass = "alert alert-success";
                    LoadInactiveProducts();
                }
                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Error - " + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";
                }
                finally
                {
                    con.Close();
                }
            }
        }
    }
}

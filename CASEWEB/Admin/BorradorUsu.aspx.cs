using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CASEWEB.Admin
{
    public partial class BorradorUsu : System.Web.UI.Page
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
            string query = "SELECT * FROM USUARIOS WHERE Activo_Usu = 0";
            cmd = new SqlCommand(query, con);
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rInactiveUsers.DataSource = dt;
            rInactiveUsers.DataBind();
        }


        protected void rInactiveUsers_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblMsg.Visible = false;
            if (e.CommandName == "activate")
            {
                con = new SqlConnection(Connetion.GetConnectionString());
                cmd = new SqlCommand("UPDATE USUARIOS SET Activo_Usu = 1 WHERE Cod_Usu = @UserId", con);
                cmd.Parameters.AddWithValue("@UserId", e.CommandArgument);
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Visible = true;
                    lblMsg.Text = "Usuario activado correctamente.";
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
                cmd = new SqlCommand("DELETE FROM USUARIOS WHERE Cod_Usu = @UserId", con);
                cmd.Parameters.AddWithValue("@UserId", e.CommandArgument);
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Visible = true;
                    lblMsg.Text = "Usuario eliminado correctamente.";
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
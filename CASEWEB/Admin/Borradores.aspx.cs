using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace CASEWEB.Admin
{
    public partial class Borradores : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDraftCategories();
            }
            lblMsg.Visible = false;
        }

        private void LoadDraftCategories()
        {
            con = new SqlConnection(Connetion.GetConnectionString());
            string query = "SELECT * FROM CATEGORIAS WHERE Activo_Cat = 0";  // Filtra solo las categorías inactivas
            cmd = new SqlCommand(query, con);
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rDraftCategories.DataSource = dt;
            rDraftCategories.DataBind();
        }

        protected void rDraftCategories_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblMsg.Visible = false;
            if (e.CommandName == "activate")
            {
                con = new SqlConnection(Connetion.GetConnectionString());
                cmd = new SqlCommand("UPDATE CATEGORIAS SET Activo_Cat = 1 WHERE Cod_Cat = @CategoryId", con);
                cmd.Parameters.AddWithValue("@CategoryId", e.CommandArgument);
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Visible = true;
                    lblMsg.Text = "Categoria activada correctamente.";
                    lblMsg.CssClass = "alert alert-success";
                    LoadDraftCategories();
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
            else if (e.CommandName == "edit")
            {
                // Lógica para editar una categoría inactiva
            }
            else if (e.CommandName == "delete")
            {
                con = new SqlConnection(Connetion.GetConnectionString());
                cmd = new SqlCommand("Category_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "DELETE");
                cmd.Parameters.AddWithValue("@CategoryId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    LoadDraftCategories();
                }
                catch (Exception ex)
                {
                    // Manejo de errores
                }
                finally
                {
                    con.Close();
                }
            }
        }

        protected void rDraftCategories_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                // Obtener el control Label dentro del Repeater
                Label lblIsActive = e.Item.FindControl("lblIsActive") as Label;
                if (lblIsActive != null)
                {
                    // Obtener el valor del texto del Label
                    string isActiveText = lblIsActive.Text;
                    // Realizar alguna lógica basada en el valor del Label
                    if (isActiveText == "True")
                    {
                        lblIsActive.Text = "Activo";
                        lblIsActive.CssClass = "badge badge-success";
                    }
                    else
                    {
                        lblIsActive.Text = "Inactivo";
                        lblIsActive.CssClass = "badge badge-danger";
                    }
                }
            }
        }
    }
}

using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace CASEWEB.Admin
{
    public partial class CasetasPBaja : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["breadCrum"] = "Casetas";
                GetCasetas();
            }
            lblMsg.Visible = false;
        }

        protected void btnAddOrUpdate_Click(object sender, EventArgs e)
        {
            string actionName = string.Empty, imagePath = string.Empty, fileExtension = string.Empty;
            bool isValidToExecute = true;
            int casetaId = Convert.ToInt32(hdnId.Value);
            con = new SqlConnection(Connetion.GetConnectionString());
            cmd = new SqlCommand("Casetas_Crud", con);
            cmd.Parameters.AddWithValue("@Action", casetaId == 0 ? "INSERT" : "UPDATE");
            cmd.Parameters.AddWithValue("@CasetasId", casetaId);
            cmd.Parameters.AddWithValue("@Numero", txtName.Text.Trim());
            cmd.Parameters.AddWithValue("@IsActive", cbIsActive.Checked);
            cmd.Parameters.AddWithValue("@Color", ddlColorCaseta.SelectedValue); // Cambio aquí
            if (string.IsNullOrWhiteSpace(txtName.Text))
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Por favor, ingresa un nombre válido.";
                lblMsg.CssClass = "alert alert-danger";
                isValidToExecute = false; // Si hay un problema, establece isValidToExecute en false
            }
            if (isValidToExecute)
            {
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    actionName = casetaId == 0 ? "inserted" : "updated";
                    lblMsg.Visible = true;
                    lblMsg.Text = "La caseta se ha actualizado!";
                    lblMsg.CssClass = "alert alert-success";
                    GetCasetas();
                    clear();
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

        private void GetCasetas()
        {
            con = new SqlConnection(Connetion.GetConnectionString());
            cmd = new SqlCommand("Casetas_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rCasetas.DataSource = dt;
            rCasetas.DataBind();
        }

        private void clear()
        {
            txtName.Text = string.Empty;
            ddlColorCaseta.SelectedValue = string.Empty;
            cbIsActive.Checked = false;
            hdnId.Value = "0";
            btnAddOrUpdate.Text = "Agregar";

        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            clear();
        }

        protected void rCasetas_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblMsg.Visible = false;
            con = new SqlConnection(Connetion.GetConnectionString());
            if (e.CommandName == "edit")
            {
                cmd = new SqlCommand("Casetas_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "GETBYID");
                cmd.Parameters.AddWithValue("@CasetasId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                btnAddOrUpdate.Text = "Actualizar";
                LinkButton btn = e.Item.FindControl("lnkEdit") as LinkButton;
                btn.CssClass = "badge badge-warning";
            }
            else if (e.CommandName == "delete")
            {
                cmd = new SqlCommand("Casetas_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "DELETE");
                cmd.Parameters.AddWithValue("@CasetasId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Visible = true;
                    lblMsg.Text = "Caseta eliminada exitosamente";
                    lblMsg.CssClass = "alert alert-success";
                    GetCasetas();
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

        protected void rCasetas_ItemDataBound1(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lbl = e.Item.FindControl("lblIsActive") as Label;
                if (lbl.Text == "True")
                {
                    lbl.Text = "Activo";
                    lbl.CssClass = "badge badge-success";
                }
                else
                {
                    lbl.Text = "Inactivo";
                    lbl.CssClass = "badge badge-danger";
                }
            }
        }
        protected void btnRedirect_Click(object sender, EventArgs e)
        {
            // Aquí realizamos la redirección a Category.aspx
            Response.Redirect("Category.aspx");
        }

    }
}
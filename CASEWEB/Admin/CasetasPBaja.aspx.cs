using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using static System.Net.Mime.MediaTypeNames;

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
            cmd.Parameters.AddWithValue("@Piso", txtPiso.Text.Trim());
            cmd.Parameters.AddWithValue("@Numero", txtName.Text.Trim());
            cmd.Parameters.AddWithValue("@Nombre", txtNombre.Text.Trim());
            cmd.Parameters.AddWithValue("@IsActive", cbIsActive.Checked);
            cmd.Parameters.AddWithValue("@Color", ddlColorCaseta.SelectedValue);// Cambio aquí
            cmd.Parameters.AddWithValue("@CategoryId", ddlCategories.SelectedValue);
            cmd.Parameters.AddWithValue("@CaseraId", ddlCaseras.SelectedValue);
            if (string.IsNullOrWhiteSpace(txtName.Text))
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Por favor, ingresa un nombre válido.";
                lblMsg.CssClass = "alert alert-danger";
                isValidToExecute = false; // Si hay un problema, establece isValidToExecute en false
            }
            if (fuCasetaImage.HasFile)
            {
                if (Utils.IsValidExtension(fuCasetaImage.FileName))
                {
                    Guid obj = Guid.NewGuid();
                    fileExtension = Path.GetExtension(fuCasetaImage.FileName);
                    imagePath = "Images/Casetas/" + obj.ToString() + fileExtension;
                    fuCasetaImage.PostedFile.SaveAs(Server.MapPath("~/Images/Casetas/") + obj.ToString() + fileExtension);
                    cmd.Parameters.AddWithValue("@ImageUrl", imagePath);
                    isValidToExecute = true;
                }
                else
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Por favor solo formatos .jpg, .jpeg or png image";
                    lblMsg.CssClass = "alert alert-danger";
                    isValidToExecute = false;
                }
            }
            else
            {
                isValidToExecute = true;
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
            txtNombre.Text = string.Empty;
            ddlColorCaseta.SelectedValue = string.Empty;
            cbIsActive.Checked = false;
            hdnId.Value = "0";
            btnAddOrUpdate.Text = "Agregar";
            imgCaseta.ImageUrl = String.Empty;
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
                txtPiso.Text = dt.Rows[0]["Piso_Cast"].ToString();
                ddlCategories.SelectedValue = dt.Rows[0]["Cod_Cat"].ToString();
                ddlCaseras.SelectedValue = dt.Rows[0]["Cod_Cas"].ToString();
                txtName.Text = dt.Rows[0]["Numero_Cast"].ToString();
                txtNombre.Text = dt.Rows[0]["Nombre_Cast"].ToString();
                ddlColorCaseta.SelectedValue = dt.Rows[0]["Color_Cast"].ToString();
                cbIsActive.Checked = Convert.ToBoolean(dt.Rows[0]["Activo_Cast"]);
                imgCaseta.ImageUrl = string.IsNullOrEmpty(dt.Rows[0]["ImagenUrl_Cast"].ToString()) ?
                    "..//Images/No_image.png" : "../" + dt.Rows[0]["ImagenUrl_Cast"].ToString();
                imgCaseta.Height = 200;
                imgCaseta.Width = 200;
                hdnId.Value = dt.Rows[0]["Cod_Cast"].ToString();
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

    }
}
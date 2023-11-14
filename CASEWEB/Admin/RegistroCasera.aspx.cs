using System;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.IO;
using System.Data;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace CASEWEB.Admin
{
    public partial class RegistroCasera : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["breadCrum"] = "Casera";
                getCaseras();
            }
            lblMsg.Visible = false;
        }

        protected void btnAddOrUpdate_Click(object sender, EventArgs e)
        {
            string actionName = string.Empty, imagePath = string.Empty, fileExtension = string.Empty;
            bool isValidToExecute = false;
            int caseraId = Convert.ToInt32(hdnId.Value);
            con = new SqlConnection(Connetion.GetConnectionString());
            cmd = new SqlCommand("Casera_Crud", con);
            cmd.Parameters.AddWithValue("@Action", caseraId == 0 ? "INSERT" : "UPDATE");
            cmd.Parameters.AddWithValue("@CaseraId", caseraId);
            cmd.Parameters.AddWithValue("@Nombre", txtNombre.Text.Trim());
            cmd.Parameters.AddWithValue("@Telefono", txtTelefono.Text);
            cmd.Parameters.AddWithValue("@Correo", txtCorreo.Text);
            cmd.Parameters.AddWithValue("@Direccion", txtDireccion.Text);
            cmd.Parameters.AddWithValue("@NitCas", txtNitCas.Text);

            string imageUrl = null;

            if (fuCaseraImage.HasFile)
            {
                if (Utils.IsValidExtension(fuCaseraImage.FileName))
                {
                    Guid obj = Guid.NewGuid();
                    fileExtension = Path.GetExtension(fuCaseraImage.FileName);
                    imagePath = "Images/Casera/" + obj.ToString() + fileExtension;
                    fuCaseraImage.PostedFile.SaveAs(Server.MapPath("~/Images/Casera/") + obj.ToString() + fileExtension);
                    imageUrl = imagePath;
                    cmd.Parameters.AddWithValue("@ImageNUrl", imagePath);
                    isValidToExecute = true;
                }
                else
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Por favor solo formatos .jpg, .jpeg o .png de imagen";
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
                    actionName = caseraId == 0 ? "inserted" : "updated";
                    lblMsg.Visible = true;
                    lblMsg.Text = "La Casera se actualizó!";
                    lblMsg.CssClass = "alert alert-success";
                    getCaseras();
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

        private void getCaseras()
        {
            con = new SqlConnection(Connetion.GetConnectionString());
            cmd = new SqlCommand("Casera_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT4ADMIN");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rCasera.DataSource = dt;
            rCasera.DataBind();
        }

        private void clear()
        {
            txtNombre.Text = string.Empty;
            txtTelefono.Text = string.Empty;
            txtCorreo.Text = string.Empty;
            txtDireccion.Text = string.Empty;
            txtNitCas.Text = string.Empty;
            hdnId.Value = "0";
            btnAddOrUpdate.Text = "Añadir";
            imgCasera.ImageUrl = String.Empty;
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            clear();
        }

        protected void rCasera_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblMsg.Visible = false;
            con = new SqlConnection(Connetion.GetConnectionString());
            if (e.CommandName == "edit")
            {
                cmd = new SqlCommand("Casera_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "SELECT4PROFILE");
                cmd.Parameters.AddWithValue("@CaseraId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                txtNombre.Text = dt.Rows[0]["Nombre_Cas"].ToString();
                txtTelefono.Text = dt.Rows[0]["Telefono_Cas"].ToString();
                txtCorreo.Text = dt.Rows[0]["Correo_Cas"].ToString();
                txtDireccion.Text = dt.Rows[0]["Direccion_Cas"].ToString();
                txtNitCas.Text = dt.Rows[0]["Nit_Cas"].ToString();
                imgCasera.ImageUrl = string.IsNullOrEmpty(dt.Rows[0]["ImagenUrl_Cas"].ToString()) ?
                    "../Images/No_image.png" : "../" + dt.Rows[0]["ImagenUrl_Cas"].ToString();
                imgCasera.Height = 200;
                imgCasera.Width = 200;
                hdnId.Value = dt.Rows[0]["Cod_Cas"].ToString();
                btnAddOrUpdate.Text = "Actualizar";
                LinkButton btn = e.Item.FindControl("lnkEdit") as LinkButton;
                btn.CssClass = "badge badge-warning";
            }
            else if (e.CommandName == "delete")
            {
                cmd = new SqlCommand("Casera_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "DELETE");
                cmd.Parameters.AddWithValue("@CaseraId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Visible = true;
                    lblMsg.Text = "Casera eliminada exitosamente!";
                    lblMsg.CssClass = "alert alert-success";
                    getCaseras();
                }
                catch (SqlException ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Error SQL: " + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";
                }
                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Error: " + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";
                }
                finally
                {
                    con.Close();
                }
            }
        }

        protected void rCasera_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lbl = e.Item.FindControl("lblIsActive") as Label;
                if (lbl != null)
                {
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
}

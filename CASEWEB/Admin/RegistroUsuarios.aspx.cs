using System;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.IO;
using System.Data;
using System.Web.UI.WebControls;

namespace CASEWEB.Admin
{
    public partial class RegistroUsuarios : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["breadCrum"] = "Usuario";
                getUsuarios();
            }
            lblMsg.Visible = false;
        }

        protected void btnAddOrUpdate_Click(object sender, EventArgs e)
        {
            string actionName = string.Empty, imagePath = string.Empty, fileExtension = string.Empty;
            bool isValidToExecute = false;
            int userId = Convert.ToInt32(hdnId.Value);
            con = new SqlConnection(Connetion.GetConnectionString());
            cmd = new SqlCommand("User_Crud", con);
            cmd.Parameters.AddWithValue("@Action", userId == 0 ? "INSERT" : "UPDATE");
            cmd.Parameters.AddWithValue("@UserId", userId);
            cmd.Parameters.AddWithValue("@Name", txtNombre.Text.Trim());
            cmd.Parameters.AddWithValue("@Mobile", txtTelefono.Text);
            cmd.Parameters.AddWithValue("@Email", txtCorreo.Text);
            cmd.Parameters.AddWithValue("@Address", txtDireccion.Text);
            cmd.Parameters.AddWithValue("@Password", txtClave.Text.Trim());
            cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
            cmd.Parameters.AddWithValue("@Activo_Usu", cbIsActive.Checked);
            cmd.Parameters.AddWithValue("@Role", ddlRoles.SelectedValue);

            string imageUrl = null;

            if (fuUsuarioImage.HasFile)
            {
                if (Utils.IsValidExtension(fuUsuarioImage.FileName))
                {
                    Guid obj = Guid.NewGuid();
                    fileExtension = Path.GetExtension(fuUsuarioImage.FileName);
                    imagePath = "Images/User/" + obj.ToString() + fileExtension;
                    fuUsuarioImage.PostedFile.SaveAs(Server.MapPath("~/Images/User/") + obj.ToString() + fileExtension);
                    imageUrl = imagePath;
                    cmd.Parameters.AddWithValue("@ImageUrl", imagePath);
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
                    actionName = userId == 0 ? "inserted" : "updated";
                    lblMsg.Visible = true;
                    lblMsg.Text = "El usuario se actualizó!";
                    lblMsg.CssClass = "alert alert-success";
                    if (userId != 0)
                    {
                        Response.AddHeader("REFRESH", "1;");
                    }
                    getUsuarios();
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

        private void getUsuarios()
        {
            try
            {
                con = new SqlConnection(Connetion.GetConnectionString());
                cmd = new SqlCommand("User_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "SELECT4ADMIN");
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                rUsuarios.DataSource = dt;
                rUsuarios.DataBind();
            }
            catch (Exception ex)
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Error al obtener los usuarios: " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
        }

        private void clear()
        {
            txtNombre.Text = string.Empty;
            txtUsername.Text = string.Empty;
            txtClave.Text = string.Empty;
            txtTelefono.Text = string.Empty;
            txtCorreo.Text = string.Empty;
            txtDireccion.Text = string.Empty;
            cbIsActive.Checked = false;
            hdnId.Value = "0";
            btnAddOrUpdate.Text = "Añadir";
            imgCasera.ImageUrl = string.Empty;
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            clear();
        }

        protected void rUsuario_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblMsg.Visible = false;
            con = new SqlConnection(Connetion.GetConnectionString());
            if (e.CommandName == "edit")
            {
                cmd = new SqlCommand("User_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "SELECT4PROFILE");
                cmd.Parameters.AddWithValue("@UserId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                txtNombre.Text = dt.Rows[0]["Nombre_Usu"].ToString();
                txtUsername.Text = dt.Rows[0]["NombreUsuario_Usu"].ToString();
                txtClave.TextMode = TextBoxMode.SingleLine;
                txtClave.Text = dt.Rows[0]["Clave_Usu"].ToString();
                txtTelefono.Text = dt.Rows[0]["Telefono_Usu"].ToString();
                txtCorreo.Text = dt.Rows[0]["Correo_Usu"].ToString();
                txtDireccion.Text = dt.Rows[0]["Direccion_Usu"].ToString();
                object activoCasValue = dt.Rows[0]["Activo_Usu"];
                if (activoCasValue != DBNull.Value)
                {
                    cbIsActive.Checked = Convert.ToBoolean(activoCasValue);
                }
                else
                {
                    cbIsActive.Checked = true;
                }
                ddlRoles.SelectedValue = dt.Rows[0]["Roles"].ToString();
                imgCasera.ImageUrl = string.IsNullOrEmpty(dt.Rows[0]["ImagenUrl_Usu"].ToString()) ?
                    "../Images/No_image.png" : "../" + dt.Rows[0]["ImagenUrl_Usu"].ToString();
                imgCasera.Height = 200;
                imgCasera.Width = 200;
                hdnId.Value = dt.Rows[0]["Cod_Usu"].ToString();
                btnAddOrUpdate.Text = "Actualizar";
                LinkButton btn = e.Item.FindControl("lnkEdit") as LinkButton;
                btn.CssClass = "badge badge-warning";
            }
            else if (e.CommandName == "delete")
            {
                cmd = new SqlCommand("User_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "DELETE");
                cmd.Parameters.AddWithValue("@UserId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Visible = true;
                    lblMsg.Text = "Usuario eliminada exitosamente!";
                    lblMsg.CssClass = "alert alert-success";
                    getUsuarios();
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

        protected void rUsuario_ItemDataBound(object sender, RepeaterItemEventArgs e)
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

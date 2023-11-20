using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Web.Services.Description;
using System.Drawing;
using System.Xml.Linq;

namespace CASEWEB.Usuario
{
    public partial class Registro : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null) /*&& Session["userId"] != null*/
                {
                    getUserDetails();
                }
                else if (Session["userId"] != null)
                {
                    Response.Redirect("Default.aspx");
                }
            }
        }
        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            string actionName = string.Empty, imagePath = string.Empty, fileExtension = string.Empty;
            bool isValidToExecute = false;
            int userId = Convert.ToInt32(Request.QueryString["id"]); 
            con = new SqlConnection(Connetion.GetConnectionString());
            cmd = new SqlCommand("User_Crud", con);
            cmd.Parameters.AddWithValue("@Action", userId == 0 ? "INSERT" : "UPDATE");
            cmd.Parameters.AddWithValue("@UserId", userId);
            cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
            cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
            cmd.Parameters.AddWithValue("@Mobile", txtTelefono.Text.Trim());
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
            cmd.Parameters.AddWithValue("@Address", txtDireccion.Text.Trim());
            cmd.Parameters.AddWithValue("@Password", txtClave.Text.Trim());
            if (fuImagenUsuario.HasFile)
            {
                if (Utils.IsValidExtension(fuImagenUsuario.FileName))
                {
                    Guid obj = Guid.NewGuid();
                    fileExtension = Path.GetExtension(fuImagenUsuario.FileName);
                    imagePath = "Images/User/" + obj.ToString() + fileExtension;
                    fuImagenUsuario.PostedFile.SaveAs(Server.MapPath("~/Images/User/") + obj.ToString() + fileExtension);
                    cmd.Parameters.AddWithValue("@ImageUrl", imagePath);
                    isValidToExecute = true;
                }
                else
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Solo formatos .jpg, .jpeg o png";
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
                    actionName = userId == 0 ?
                    "Su registro se completo exitosamente <b><a href='Login.aspx'>Click Aqui</a></b> para ir al login":
                    "Se Hicieron los Cambios Correctamente! <b><a href='Profile.aspx'>Dale Click para Verlo</a></b>";
                    lblMsg.Visible = true;
                    lblMsg.Text = "<b>" + txtUsername.Text.Trim() + "</b> " + actionName; 
                    lblMsg.CssClass = "alert alert-success";
                    if (userId != 0)
                    {
                        Response.AddHeader("REFRESH", "1; URL=Perfil.aspx");
                    }
                    clear();
                }

                catch (SqlException ex)
                {
                    if (ex.Message.Contains("Violation of UNIQUE KEY constraint"))
                    {
                        lblMsg.Visible = true;
                        lblMsg.Text = "<b>" + txtUsername.Text.Trim() + "</b> Este Usuario ya Existe..!";
                        lblMsg.CssClass = "alert alert-danger";
                    }
                }
                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Error-" + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";
                }
                finally
                {
                    con.Close();
                }
            }
        }

        void getUserDetails()
        {
            con = new SqlConnection(Connetion.GetConnectionString()); 
            cmd = new SqlCommand("User_Crud", con);
            
            cmd.Parameters.AddWithValue("@Action", "SELECT4PROFILE");
            cmd.Parameters.AddWithValue("@UserId", Request.QueryString["id"]);
            cmd.CommandType = CommandType.StoredProcedure; sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count == 1)
            {
                txtName.Text = dt.Rows[0]["Nombre_Usu"].ToString();
                txtUsername.Text = dt.Rows[0]["NombreUsuario_Usu"].ToString();
                txtTelefono.Text = dt.Rows[0]["Telefono_Usu"].ToString();
                txtEmail.Text = dt.Rows[0]["Correo_Usu"].ToString();
                txtDireccion.Text = dt.Rows[0]["Direccion_Usu"].ToString();
                imgUser.ImageUrl = string.IsNullOrEmpty(dt.Rows[0]["ImagenUrl_Usu"].ToString())
                    ? "../Images/No_image.png" : "../" + dt.Rows[0]["ImagenUrl_Usu"].ToString();
                imgUser.Height = 200;
                imgUser.Width = 200;
                txtClave.TextMode = TextBoxMode.SingleLine;
                txtClave.ReadOnly = true;
                txtClave.Text = dt.Rows[0]["Clave_Usu"].ToString();
            }
            lblHeaderMsg.Text = "<h2>Editar Perfil</h2>";
            btnRegister.Text = "Actualizar";
            lblAlreadyUser.Text = "";
        }



            private void clear()
            {
                txtName.Text = string.Empty;
                txtUsername.Text = string.Empty;
                txtTelefono.Text = string.Empty; txtEmail.Text = string.Empty;
                txtDireccion.Text = string.Empty;
                txtClave.Text = string.Empty;
            }
    }
}

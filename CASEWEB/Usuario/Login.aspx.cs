using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;

namespace CASEWEB.Usuario
{
    public partial class Login : System.Web.UI.Page
    {

        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Cod_Usu"] != null || Session["Cod_Cas"] != null) 
            {
                Response.Redirect("Default.aspx");
            }
         
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (txtUsername.Text.Trim() == "Admin" && txtClave.Text.Trim() == "123")
            {
                Session["admin"] = txtUsername.Text.Trim();
                Response.Redirect("../Admin/Dashboard2.aspx");
            }
            bool encontrado = false;
            if (!encontrado)
            {
                con = new SqlConnection(Connetion.GetConnectionString());
                cmd = new SqlCommand("User_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "SELECT4LOGIN");
                cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
                cmd.Parameters.AddWithValue("@Password", txtClave.Text.Trim());
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                if (dt.Rows.Count == 1)
                {
                    encontrado = true;
                    Session["username"] = txtUsername.Text.Trim();
                    Session["Cod_Usu"] = dt.Rows[0]["Cod_Usu"]; 
                    Response.Redirect("Default.aspx");
                }
                else
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Usuario o Contraseña Incorrecta..!";
                    lblMsg.CssClass = "alert alert-danger";
                }

            }
            if (!encontrado)
            {
                con = new SqlConnection(Connetion.GetConnectionString());
                cmd = new SqlCommand("Casera_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "SELECT4LOGIN");
                cmd.Parameters.AddWithValue("@NombreUsuC", txtUsername.Text.Trim());
                cmd.Parameters.AddWithValue("@ClaveC", txtClave.Text.Trim());
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                if (dt.Rows.Count == 1)
                {
                    Session["usernameC"] = txtUsername.Text.Trim();
                    Session["Cod_Cas"] = dt.Rows[0]["Cod_Cas"];
                    Response.Redirect("..\\Vendedor\\Dashboard.aspx");
                }
                else
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Usuario o Contraseña Incorrecta..!";
                    lblMsg.CssClass = "alert alert-danger";
                }

            }


        }

    }
}
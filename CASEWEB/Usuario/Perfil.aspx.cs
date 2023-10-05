using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace CASEWEB.Usuario
{
    public partial class Perfil : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Cod_Usu"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    getUserDetails();
                }
            }
        }

        void getUserDetails()
        {
            con = new SqlConnection(Connetion.GetConnectionString());
            cmd = new SqlCommand("User_Crud", con);

            cmd.Parameters.AddWithValue("@Action", "SELECT4PROFILE");
            cmd.Parameters.AddWithValue("@UserId", Session["Cod_Usu"]);
            cmd.CommandType = CommandType.StoredProcedure; sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rUserProfile.DataSource = dt;
            rUserProfile.DataBind(); 
            if (dt.Rows.Count == 1)
            {
                Session["Nombre_Usu"] = dt.Rows[0]["Nombre_Usu"].ToString();
                Session["Correo_Usu"] = dt.Rows[0]["Correo_Usu"].ToString();
                Session["ImagenUrl_Usu"] = dt.Rows[0]["ImagenUrl_Usu"].ToString();
                Session["CreadoFecha_Usu"] = dt.Rows[0]["CreadoFecha_Usu"].ToString();
            }
           
        }

    }
}
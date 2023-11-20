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

namespace CASEWEB.Usuario
{
    public partial class PerfilCasero : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string casetaId = Request.QueryString["casetaId"];
                string casetaIdQueryString = Request.QueryString["casetaId"];
                string casetaIdSession = Session["Cod_Cas"] as string;

                System.Diagnostics.Debug.WriteLine($"QueryString: {casetaIdQueryString}, Session: {casetaIdSession}");

                if (string.IsNullOrEmpty(casetaId) || Session["Cod_Cas"] == null || casetaId != Session["Cod_Cas"].ToString())
                {
                    getUserDetails();
                }
                else
                {
                    Response.Redirect("Login.aspx");
                    
                }
            }
        }

        void getUserDetails()
        {
            con = new SqlConnection(Connetion.GetConnectionString());
            cmd = new SqlCommand("Casera_Crud", con);

            cmd.Parameters.AddWithValue("@Action", "SELECT4PROFILE");
            cmd.Parameters.AddWithValue("@CaseraId", Session["Cod_Cas"]);
            cmd.CommandType = CommandType.StoredProcedure; sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rCaseraProfile.DataSource = dt;
            rCaseraProfile.DataBind();
            if (dt.Rows.Count == 1)
            {
                Session["Nombre_Cas"] = dt.Rows[0]["Nombre_Cas"].ToString();
                Session["Correo_Cas"] = dt.Rows[0]["Correo_Cas"].ToString();
                Session["ImagenUrl_Cas"] = dt.Rows[0]["ImagenUrl_Cas"].ToString();
                Session["CreadoFecha_Cas"] = dt.Rows[0]["CreadoFecha_Cas"].ToString();
            }

        }
    }
}
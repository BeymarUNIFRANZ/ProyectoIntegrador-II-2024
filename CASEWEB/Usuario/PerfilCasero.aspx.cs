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
                /*string casetaId = Request.QueryString["Cod_Cast"].ToString();*/ // Cambiado a "Cod_Cast"
                string casetaId = Request.QueryString["casetaId"];
                System.Diagnostics.Debug.WriteLine($"CasetaId: {casetaId}");
                MostrarInformacionCaseta(casetaId);
                string casetaIdQueryString = Request.QueryString["casetaId"];
                string casetaIdSession = Session["Cod_Cas"] as string;

                System.Diagnostics.Debug.WriteLine($"QueryString: {casetaIdQueryString}, Session: {casetaIdSession}");

                if (string.IsNullOrEmpty(casetaId) || Session["Cod_Cas"] == null || casetaId != Session["Cod_Cas"].ToString())
                {

                    MostrarInformacionCaseta(casetaId);
                    ProductosPerfilCasero(casetaId);
                }
                else
                {
                    Response.Redirect("Login.aspx");
                    
                }
            }
            rCaseraProducts.ItemCommand += new RepeaterCommandEventHandler(rProducts_ItemCommand);
        }

        private void MostrarInformacionCaseta(string casetaId)
        {
            con = new SqlConnection(Connetion.GetConnectionString());
            cmd = new SqlCommand("Casetas_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "GETCaserasID"); // Cambia "ACTIVECAT" por el nombre de tu acción para obtener por ID
            cmd.Parameters.AddWithValue("@CasetasId", casetaId); // Añade parámetro para filtrar por ID
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
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
        void ProductosPerfilCasero(string casetaId)
        {
            con = new SqlConnection(Connetion.GetConnectionString());
            cmd = new SqlCommand("Casetas_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "GETProductosID");
            cmd.Parameters.AddWithValue("@CasetasId", casetaId);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);

            // Almacena la información de los productos en un DataTable
            if (dt.Rows.Count > 0)
            {
                rCaseraProducts.DataSource = dt;
                rCaseraProducts.DataBind();
            }
        }
        protected void rProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

            if (Session["Cod_Usu"] != null)
            {
                bool isCartItemUpdate = false;
                int i = isItemExistInCart(Convert.ToInt32(e.CommandArgument));
                if (i == 0)
                {
                    //Adding new item in cart
                    con = new SqlConnection(Connetion.GetConnectionString());
                    cmd = new SqlCommand("Carro_Crud", con);
                    cmd.Parameters.AddWithValue("@Action", "INSERT");
                    cmd.Parameters.AddWithValue("@ProductId", e.CommandArgument);
                    cmd.Parameters.AddWithValue("@Quantity", 1);
                    cmd.Parameters.AddWithValue("@UserId", Session["Cod_Usu"]);
                    cmd.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        Response.Write("<script>alert('Error - " + ex.Message + " ');<script>");
                    }
                    finally
                    {
                        con.Close();
                    }
                }
                else
                {
                    //adding existing item into cart
                    Utils utils = new Utils();
                    isCartItemUpdate = utils.updateCartQuantity(i + 1, Convert.ToInt32(e.CommandArgument),
                        Convert.ToInt32(Session["Cod_Usu"]));
                }
                lblMsg.Visible = true;
                lblMsg.Text = "¡El Prodcuto se agrego a tu Carrito!";
                lblMsg.CssClass = "alert alert-success";
                Response.AddHeader("REFRESH", "1;");
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        int isItemExistInCart(int productId)
        {
            con = new SqlConnection(Connetion.GetConnectionString());
            cmd = new SqlCommand("Carro_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "GETBYID");
            cmd.Parameters.AddWithValue("@ProductId", productId);
            cmd.Parameters.AddWithValue("@UserId", Session["Cod_Usu"]);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            int quantity = 0;
            if (dt.Rows.Count > 0)
            {
                quantity = Convert.ToInt32(dt.Rows[0]["Cantidad_Car"]);
            }
            return quantity;
        }

    }
}
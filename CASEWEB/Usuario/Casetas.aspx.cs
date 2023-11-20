using CASEWEB.Admin;
using CASEWEB.Vendedor;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CASEWEB.Usuario
{
    public partial class Casetas : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                getCasetas();
            }
            if (Request.QueryString["Cod_Cast"] != null)
            {
                string casetaId = Request.QueryString["Cod_Cast"].ToString();
                System.Diagnostics.Debug.WriteLine($"CasetaId: {casetaId}");
                MostrarInformacionCaseta(casetaId);
                //getCategories();
            }
        }

        //private void getCategories()
        //{
        //    con = new SqlConnection(Connetion.GetConnectionString());
        //    cmd = new SqlCommand("Category_Crud", con);
        //    cmd.Parameters.AddWithValue("@Action", "ACTIVECAT");
        //    cmd.CommandType = CommandType.StoredProcedure;
        //    sda = new SqlDataAdapter(cmd);
        //    dt = new DataTable();
        //    sda.Fill(dt);
        //    rPiso.DataSource = dt;
        //    rPiso.DataBind();
        //}
        private void MostrarInformacionCaseta(string casetaId)
        {
            con = new SqlConnection(Connetion.GetConnectionString());
            cmd = new SqlCommand("Casetas_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "GETBYID"); // Cambia "ACTIVECAT" por el nombre de tu acción para obtener por ID
            cmd.Parameters.AddWithValue("@Cod_Cast", casetaId); // Añade parámetro para filtrar por ID
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);

            rCasetas.DataSource = dt;
            rCasetas.DataBind();
        }
        private void getCasetas()
        {
            con = new SqlConnection(Connetion.GetConnectionString());
            cmd = new SqlCommand("Casetas_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "ACTIVECAT");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rCasetas.DataSource = dt;
            rCasetas.DataBind();
        }

        protected void rCasetas_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

            try
            {
                if (e.CommandName == "MostrarInformacionCaseta")
                {
                    string codCaseta = e.CommandArgument.ToString();
                    Response.Redirect($"PerfilCasero.aspx?casetaId={codCaseta}");
                }
            }
            catch (Exception ex)
            {
                // Agrega una impresión de depuración o registra el error en el registro de eventos.
                System.Diagnostics.Debug.WriteLine($"Error en rCasetas_ItemCommand: {ex.Message}");
            }
        }
        protected void rProduct_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lblIsActive = e.Item.FindControl("lblIsActive") as Label;
                Label lblQuantity = e.Item.FindControl("lblQuantity") as Label;
                if (lblIsActive.Text == "True")
                {
                    lblIsActive.Text = "Active";
                    lblIsActive.CssClass = "badge badge-success";
                }
                else
                {
                    lblIsActive.Text = "In-Active";
                    lblIsActive.CssClass = "badge badge-danger";
                }

                if (Convert.ToInt32(lblQuantity.Text) <= 5)
                {
                    lblQuantity.CssClass = "badge badge-danger";
                    lblQuantity.ToolTip = "El Producto!";
                }
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Drawing;
namespace CASEWEB.Vendedor
{
    public partial class Venta : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["breadCrum"] = "Productos";
                getProducts();
            }
            lblMsg.Visible = false;
        }

        private void getProducts()
        {
            SqlConnection con = new SqlConnection(Connetion.GetConnectionString());
            SqlCommand cmd = new SqlCommand("Product_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT");
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            rVenta.DataSource = dt;
            rVenta.DataBind();
        }
        protected void rProduct_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "select")
            {
                // Obtener el producto seleccionado
                string productId = e.CommandArgument.ToString();

                // Guardar el producto seleccionado en una variable de sesión
                Session["selectedProductId"] = productId;

                // Mostrar un mensaje u otra acción según sea necesario
                // Por ejemplo:
                lblMsg.Visible = true;
                lblMsg.Text = "Producto seleccionado: " + productId;
                lblMsg.CssClass = "alert alert-success";
            }
        }

    }
}

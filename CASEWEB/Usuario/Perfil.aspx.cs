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
                    getPurchaseHistory();
                }
            }
        }

        void getUserDetails()
        {
            con = new SqlConnection(Connetion.GetConnectionString());
            cmd = new SqlCommand("User_Crud", con);

            cmd.Parameters.AddWithValue("@Action", "SELECT4PROFILE");
            cmd.Parameters.AddWithValue("@UserId", Session["Cod_Usu"]);
            cmd.CommandType = CommandType.StoredProcedure; 
            sda = new SqlDataAdapter(cmd);
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

        void getPurchaseHistory()
        {
            int sr = 1;
            con = new SqlConnection(Connetion.GetConnectionString());
            cmd = new SqlCommand("Recibo", con);
            cmd.Parameters.AddWithValue("@Action", "ODRHISTORY");
            cmd.Parameters.AddWithValue("@UserId", Session["Cod_Usu"]);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            dt.Columns.Add("NumOrden_Ord", typeof(Int32));
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dataRow in dt.Rows)
                {
                    dataRow["NumOrden_Ord"] = sr;
                    sr++;
                }
            }
            if (dt.Rows.Count == 0)
            {
                rPurchaseHistory.FooterTemplate = null;
                rPurchaseHistory.FooterTemplate = new CustomTemplate(ListItemType.Footer);
            }
            rPurchaseHistory.DataSource = dt;
            rPurchaseHistory.DataBind();
        }

        protected void rPurchaseHistory_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                double grandTotal = 0;
                HiddenField paymentId = e.Item.FindControl("hdnPaymentId") as HiddenField;
                Repeater repOrders = e.Item.FindControl("rOrders") as Repeater;
                con = new SqlConnection(Connetion.GetConnectionString());
                cmd = new SqlCommand("Recibo", con);
                cmd.Parameters.AddWithValue("@Action", "INVOICBYID");
                cmd.Parameters.AddWithValue("@PaymentId", Convert.ToInt32(paymentId.Value));
                cmd.Parameters.AddWithValue("@UserId", Session["Cod_Usu"]);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    foreach (DataRow dataRow in dt.Rows)
                    {
                        grandTotal += Convert.ToDouble(dataRow["TotalPrice"]);
                    }

                    DataRow dr = dt.NewRow();
                    dr["TotalPrice"] = grandTotal;
                    dt.Rows.Add(dr);

                    repOrders.DataSource = dt;
                    repOrders.DataBind();
                }
            }
        }


        //custom template class to add controls to the repeaters header, item and footer sections
        private sealed class CustomTemplate : ITemplate
        {
            private ListItemType ListItemType { get; set; }

            public CustomTemplate(ListItemType type)
            {
                ListItemType = type;
            }

            public void InstantiateIn(Control container)
            {
                if (ListItemType == ListItemType.Footer)
                {
                    var footer = new LiteralControl("<tr><td><b>¡Hambriento! ¿Por qué no pedir comida? </b><a href='Menu.aspx' class='badge badge-info ml-2'>Haga Clic Aqui para Ordenar </a></td></tr></tbody></table>");
                }
            }
        }

    }
}
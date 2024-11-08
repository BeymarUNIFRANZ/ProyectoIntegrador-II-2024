﻿using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CASEWEB.Usuario
{
    public partial class Usuario : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Request.Url.AbsoluteUri.ToString().Contains("Default.aspx"))
            {
                form1.Attributes.Add("class", "sub_page");
            }
            else
            {
                form1.Attributes.Remove("class");
                //cargar el control
                Control SliderUserControl1 = (Control)Page.LoadControl("SliderUserControl1.ascx");

                //añadir el control al panel
                pnlSliderUC.Controls.Add(SliderUserControl1);

            }

            if (Session["Cod_Usu"] != null)
            {
                LbLoginOrLogout.Text = "Cerrar Sesión";
                Utils utils = new Utils();
                Session["cartCount"] = utils.cartCount(Convert.ToInt32(Session["Cod_Usu"])).ToString();
            }

            else
            {
                LbLoginOrLogout.Text = "Iniciar Sesión";
                Session["cartCount"] = "0";
            }
        }
        protected void LbLoginOrLogout_Click(object sender, EventArgs e)
        {

            if (Session["Cod_Usu"] == null && Session["Cod_Cas"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                Session.Abandon();
                Response.Redirect("Login.aspx");
            }
        }

        protected void lbRegisterOrProfile_Click(object sender, EventArgs e)
        {
            if (Session["Cod_Usu"] != null)
            {
                lbRegisterOrProfile.ToolTip = "Perfil de Usuario"; 
                Response.Redirect("Perfil.aspx");
            }
            else
            {
                lbRegisterOrProfile.ToolTip = "Usuario ya registrado";
                Response.Redirect("Registro.aspx");

            }
        }
    }
}
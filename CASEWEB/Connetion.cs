﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Security.Cryptography;
using System.Security.Policy;
using System.Web;

namespace CASEWEB
{
    public class Connetion
    {
        public static string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        }
    }

    public class Utils
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        public static bool IsValidExtension(string fileName)
        {
            bool isValid = false;
            string[] fileExtension = { ".jpg", ".png", ".jpeg" };
            for (int i = 0; i <= fileExtension.Length - 1; i++)
            {
                if (fileName.Contains(fileExtension[i]))
                {
                    isValid = true;
                    break;

                }
            }
            return isValid;
        }

        public static string GetImageUrl(Object url)
        {
            string url1 = "";
            if (string.IsNullOrEmpty(url.ToString()) || url == DBNull.Value)
            {
                url1 = "../Images/No_image.png";
            }
            else
            {
                url1 = string.Format("../{0}", url);
            }

            return url1;
        }

        public bool updateCartQuantity(int quantity, int productId, int userId)
        {
            bool isUpdate = false;
            con = new SqlConnection(Connetion.GetConnectionString());
            cmd = new SqlCommand("Carro_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "UPDATE");
            cmd.Parameters.AddWithValue("@ProductId", productId);
            cmd.Parameters.AddWithValue("@Quantity", quantity);
            cmd.Parameters.AddWithValue("@UserId", userId);
            cmd.CommandType = CommandType.StoredProcedure;
            try
            { 
                con.Open();
                cmd.ExecuteNonQuery();
                isUpdate = true;
            }
            catch (Exception ex)
            {
                isUpdate = false;
                System.Web.HttpContext.Current.Response.Write("<script>alert('Error - " + ex.Message + " ');<script>");
            }
            finally
            {
                con.Close();
            }
            return isUpdate;
        }

        public int cartCount(int userId)
        {
            con = new SqlConnection(Connetion.GetConnectionString());
            cmd = new SqlCommand("Carro_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT");
            cmd.Parameters.AddWithValue("@UserId", userId);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            return dt.Rows.Count;
        }

        public static string GetUniqueId()
        {
            Guid guid = Guid.NewGuid();
            String uniqueId = guid.ToString();
            return uniqueId;
        }

    }
}
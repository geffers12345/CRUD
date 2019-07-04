using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CRUD
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string get()
        {
            var html = "";

            using (var dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString))
            {
                if (dbconn.State == ConnectionState.Open)
                    dbconn.Close();
                dbconn.Open();

                using (var cmd = new SqlCommand("SELECT * FROM users_tbl", dbconn))
                {
                    try
                    {
                        cmd.CommandType = CommandType.Text;

                        var reader = cmd.ExecuteReader();

                        while (reader.Read())
                        {
                            html += "<tr>" +
                                        "<td>" + reader["UserID"] + "</td>" +
                                        "<td>" + reader["Firstname"] + " </td>" +
                                        "<td>" + reader["Lastname"] + " </td>" +
                                        "<td>" + reader["Email"] + " </td>" +
                                        "<td>" +
                                            "<button data-id=\"" + reader["UserID"] + "\" class=\"btn btn-primary view\" data-toggle='modal' data-target='#viewModal'> " +
                                                "View" +
                                            "</button>" +
                                        "<button data-id=\"" + reader["UserID"] + "\" class=\"btn btn-success edit\" data-toggle='modal' data-target='#editModal'>" +
                                                "Edit" +
                                            "</button>" +
                                            "<button data-id=\"" + reader["UserID"] + "\" class=\"btn btn-danger remove\">" +
                                                "Delete" +
                                            "</button></td>" +
                                        "</tr>";
                        }
                    }
                    catch (Exception ex)
                    {
                        ex.ToString();
                    }
                }
            }

            return html;
        }

        [WebMethod]
        public static string insert(string fname, string lname, string email)
        {
            var html = "";

            using (var dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString))
            {
                if (dbconn.State == ConnectionState.Open)
                    dbconn.Close();
                dbconn.Open();

                using (var cmd = new SqlCommand("INSERT INTO users_tbl VALUES(@fname, @lname, @email)", dbconn))
                {
                    try
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.Parameters.AddWithValue("fname", fname);
                        cmd.Parameters.AddWithValue("lname", lname);
                        cmd.Parameters.AddWithValue("email", email);

                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        ex.ToString();
                    }
                }
            }

            return html;
        }

        [WebMethod]
        public static List<string> find(int id)
        {
            var html = new List<string>();

            using (var dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString))
            {
                if (dbconn.State == ConnectionState.Open)
                    dbconn.Close();
                dbconn.Open();

                using (var cmd = new SqlCommand("SELECT * FROM users_tbl WHERE UserID = " + id + "", dbconn))
                {
                    try
                    {
                        cmd.CommandType = CommandType.Text;

                        var reader = cmd.ExecuteReader();

                        while (reader.Read())
                        {
                            html.Add(reader["UserID"].ToString());
                            html.Add(reader["Firstname"].ToString());
                            html.Add(reader["Lastname"].ToString());
                            html.Add(reader["Email"].ToString());
                        }
                    }
                    catch (Exception ex)
                    {
                        ex.ToString();
                    }
                }
            }

            return html;
        }

        [WebMethod]
        public static string update(int id, string fname, string lname, string email)
        {
            var html = "";

            using (var dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString))
            {
                if (dbconn.State == ConnectionState.Open)
                    dbconn.Close();
                dbconn.Open();

                using (var cmd = new SqlCommand("UPDATE users_tbl SET Firstname = @fname, " +
                    "Lastname = @lname, Email = @email WHERE UserID = @id", dbconn))
                {
                    try
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.Parameters.AddWithValue("id", id);
                        cmd.Parameters.AddWithValue("fname", fname);
                        cmd.Parameters.AddWithValue("lname", lname);
                        cmd.Parameters.AddWithValue("email", email);

                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        ex.ToString();
                    }
                }
            }

            return html;
        }

        [WebMethod]
        public static string delete(int id)
        {
            var html = "";

            using (var dbconn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString))
            {
                if (dbconn.State == ConnectionState.Open)
                    dbconn.Close();
                dbconn.Open();

                using (var cmd = new SqlCommand("DELETE FROM users_tbl WHERE UserID = @id", dbconn))
                {
                    try
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.Parameters.AddWithValue("id", id);

                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        ex.ToString();
                    }
                }
            }

            return html;
        }
    }
}
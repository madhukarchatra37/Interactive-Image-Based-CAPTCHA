using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class Account_Register : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["CV"].ToString());
    SqlCommand cmd = null; // Fire the Query
    SqlDataReader dr = null; // Select Query
    protected void Page_Load(object sender, EventArgs e)
    {
        //RegisterUser.ContinueDestinationPageUrl = Request.QueryString["ReturnUrl"];
        
    }

    protected void RegisterUser_CreatedUser(object sender, EventArgs e)
    {
        
        //FormsAuthentication.SetAuthCookie(RegisterUser.UserName, false /* createPersistentCookie */);

        //string continueUrl = RegisterUser.ContinueDestinationPageUrl;
        //if (String.IsNullOrEmpty(continueUrl))
        //{
        //    continueUrl = "~/";
        //}
        //Response.Write("UserRegisteredSuccessfully");
        //Response.Redirect("Login.aspx");
    }

    protected void RegisterButton_Click(object sender, EventArgs e)
    {
       
    }
    protected void CreateUserButton_Click(object sender, EventArgs e)
    {
        try
        {
                con.Close();
                con.Open();
                cmd = new SqlCommand("select count(Id) from LogIn WHERE UserName = '" + UserName.Text + "'", con);
                int temp = Convert.ToInt32(cmd.ExecuteScalar().ToString());
                if (temp == 1)
                {
                    //con.Open();
                    //cmd = new SqlCommand("select Password from LogIn WHERE Password = '" + Password.Text + "'", con);
                    //string password = cmd.ExecuteScalar().ToString();
                    //if (password == Password.Text)
                    //{
                    //Response.Write("User Registered Successfully");
                    ErrorMessage.Text = "UserName Already Registered, Please enter a new UserName";
                    //}

                }
                else
                {
                    Guid Id = Guid.NewGuid();
                    string insertquery = "INSERT INTO LogIn (Id,Username,Password) VALUES(@Id,@Uname,@Pswd)";
                    cmd = new SqlCommand(insertquery, con);
                    cmd.Parameters.AddWithValue("@Id", Id.ToString());
                    cmd.Parameters.AddWithValue("@Uname", UserName.Text);
                    cmd.Parameters.AddWithValue("@Pswd", Password.Text);
                    cmd.ExecuteNonQuery();
                    ErrorMessage.Text = "User Registered Successfully";
                    Response.Redirect("Login.aspx");
                    
                }
            }
            catch (Exception err)
            {
                //LblMsg.Text = err.ToString();
            }
            finally
            {
                con.Close();
            }
        }
    }
using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using System.Text;
using System.Web.Script.Services;
using System.Web.Services;


public partial class Account_Login : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["CV"].ToString());
    SqlCommand cmd = null; // Fire the Query
    SqlDataReader dr = null; // Select Query
    protected void Page_Load(object sender, EventArgs e)
    {

        RegisterHyperLink.NavigateUrl = "Register.aspx?ReturnUrl=" + HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);

        //if (!IsPostBack) // At Once & First 
        //{
        //    changecap(); // Call
        //}
    }
    //public void changecap() // Define
    //{
    //    try
    //    {
    //        con.Close();
    //        con.Open();
    //        int noofpic = 0;
    //        cmd = new SqlCommand("select count(SrNo) from Capture", con);
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {
    //            noofpic = dr.GetInt32(0);
    //        }
    //        Random r = new Random();
    //        int rno = r.Next(1, noofpic + 1);
    //        dr.Close();
    //        cmd = new SqlCommand("select CapPic from Capture where SrNo = " + rno + "", con);
    //        dr = cmd.ExecuteReader();
    //        if (dr.Read())
    //        {

    //            //ImgCap.ImageUrl = "~/images/" + dr.GetString(0);
    //            //LblCap.Text = dr.GetString(0);
    //        }
    //    }
    //    catch (Exception err)
    //    {
    //        //LblMsg.Text = err.ToString();
    //    }
    //    finally
    //    {
    //        con.Close();
    //    }
    //}

    protected void LoginUser_Authenticate(object sender, System.Web.UI.WebControls.AuthenticateEventArgs e)
    {
        //try
        //{
        //    con.Close();
        //    con.Open();
        //    cmd = new SqlCommand("select count(Id) from LogIn WHERE UserName = '" + UserName.Text + "'", con);
        //    int temp = Convert.ToInt32(cmd.ExecuteScalar().ToString());
        //    if (temp == 1)
        //    {
        //        cmd = new SqlCommand("select Password from LogIn WHERE Password = '" + Password.Text + "'", con);
        //        string password = cmd.ExecuteScalar().ToString();
        //        if (password == Password.Text)
        //        {
        //            string jQueryCode = getjQueryCode("");
        //            FailureText.Text = "Login Successfull";
        //            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(),
        //                "myfunction",
        //                "$(document).ready(function(){});"
        //                , true);
        //        }
        //        else
        //        {
        //            FailureText.Text = "UserName Found, But IncorrectPassword, Please try again";
        //        }
        //    }
        //    else
        //    {
        //        FailureText.Text = "Invalid UserName";
        //    }
        //}
        //catch (Exception err)
        //{
        //    //LblMsg.Text = err.ToString();
        //}
        //finally
        //{
        //    con.Close();
        //}
    }

    private string getjQueryCode(string jsCodetoRun)
    {
        StringBuilder sb = new StringBuilder();
        sb.AppendLine("$(document).ready(function() {");
        sb.AppendLine(jsCodetoRun);
        sb.AppendLine(" });");
        return sb.ToString();
    }
    protected void Login_Click(object sender, EventArgs e)
    {
        //try
        //{
        //    con.Close();
        //    con.Open();
        //    cmd = new SqlCommand("select count(Id) from LogIn WHERE UserName = '" + UserName.Text + "'", con);
        //    int temp = Convert.ToInt32(cmd.ExecuteScalar().ToString());
        //    if (temp == 1)
        //    {
        //        con.Close();
        //        con.Open();
        //        SqlCommand cmd1 = new SqlCommand("select Password from LogIn WHERE Password = '" + Password.Text + "'", con);
        //        string password = cmd1.ExecuteScalar().ToString().Trim();
        //        if (password == Password.Text)
        //        {
        //            string jQueryCode = getjQueryCode("");
        //            FailureText.Text = "Login Successfull";
        //            //ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(),
        //            //    "myfunction",
        //            //    "$(document).ready(function(){});"
        //            //    , true);
        //        }
        //        else
        //        {
        //            FailureText.Text = "UserName Found, But IncorrectPassword, Please try again";
        //        }
        //    }
        //    else
        //    {
        //        FailureText.Text = "Invalid UserName";
        //    }
        //}
        //catch (Exception err)
        //{
        //    //LblMsg.Text = err.ToString();
        //}
        //finally
        //{
        //    con.Close();
        //}
    }

    [WebMethod]
    [ScriptMethod]

    public static string LoginValidation(string userName, string password, string firstNumber, string secondNumber, string captchaAnswer,string token)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["CV"].ToString());
        SqlCommand cmd = null; // Fire the Query
        SqlDataReader dr = null; // Select Query
        Account_Login accObj = new Account_Login();
        accObj.FailureText = new Literal();
        try
        {
            if (token == "")
            {
                con.Close();
                con.Open();
                cmd = new SqlCommand("select count(Id) from LogIn WHERE UserName = @Uname", con);

                cmd.Parameters.AddWithValue("@Uname", userName);
                int temp = Convert.ToInt32(cmd.ExecuteScalar().ToString());
                if (temp == 1)
                {
                    con.Close();
                    con.Open();
                    SqlCommand cmd1 = new SqlCommand("select Password from LogIn WHERE Password = @pswd", con);
                    cmd1.Parameters.AddWithValue("@pswd", password);
                    string passwd = cmd1.ExecuteScalar().ToString();
                    if (passwd != null || passwd != "")
                    {
                        passwd = passwd.Trim();

                        if (passwd == password)
                        {
                            int captchaValue1 = Convert.ToInt32(firstNumber);
                            int captchaValue2 = Convert.ToInt32(secondNumber);
                            int enteredCaptchaValue = Convert.ToInt32(captchaAnswer);
                            int totalCaptchaValue = captchaValue1 + captchaValue2;
                            if (totalCaptchaValue == enteredCaptchaValue)
                            {
                                return "Login Credentials are correct, CAPTCHA Verification Successfull!";
                            }
                            else
                            {
                                return "You have entered a wrong value for the CAPTCHA! Please retry logging in!!";
                            }
                        }
                        else
                        {
                            return "UserName Found, But IncorrectPassword, Please try again";
                        }

                    }
                    else
                    {
                        return "UserName Found, But IncorrectPassword, Please try again";
                    }
                }
                else
                {
                    return "Invalid UserName";
                }
            }
            else
            {
                return "Bot Found";
            }
        }
        
        catch (Exception err)
        {
            return "UserName Found, But IncorrectPassword, Please try again";
        }
    }
}


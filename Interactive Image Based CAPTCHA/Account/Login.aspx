<%@ Page Title="Log In" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Login.aspx.cs" Inherits="Account_Login" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

<%--<% string hiddenToken = AntiForgeryToken().ToString(); %>--%>

    <script type="text/javascript">
        $(document).ready(function () {
            var imageNames1 = new Array("baboon", "bear", "buffalo", "cat", "chamelion", "cheetah", "chicken");
            var imageNames2 = new Array("deer", "dog", "donkey", "dove", "duck", "eagle", "elephant", "fox", "peacock", "penguin");
            var imageNames3 = new Array("frog", "giraffe", "hampster", "horse", "kangaroo", "lion", "lizard");
            var imageNames4 = new Array("monkey", "owl", "panda", "rhinocerous", "rooster", "sealion", "shark", "snake", "squirrel", "swann", "tiger");
            var randImage1 = Math.floor(Math.random() * imageNames1.length);
            var randImage2 = Math.floor(Math.random() * imageNames2.length);
            var randImage3 = Math.floor(Math.random() * imageNames3.length);
            var randImage4 = Math.floor(Math.random() * imageNames4.length);

            var randImageTile1 = "../images/" + imageNames1[randImage1] + ".jpg";
            var randImageTile2 = "../images/" + imageNames2[randImage2] + ".jpg";
            var randImageTile3 = "../images/" + imageNames3[randImage3] + ".jpg";
            var randImageTile4 = "../images/" + imageNames4[randImage4] + ".jpg";

            $('#FirstImage').attr("src", randImageTile1);
            $('#FirstImage').attr("class", "");
            $('#FirstImage').attr("class", imageNames1[randImage1]);
            $('#SecondImage').attr("src", randImageTile2);
            $('#SecondImage').attr("class", "");
            $('#SecondImage').attr("class", imageNames2[randImage2]);
            $('#ThirdImage').attr("src", randImageTile3);
            $('#ThirdImage').attr("class", "");
            $('#ThirdImage').attr("class", imageNames3[randImage3]);
            $('#FourImage').attr("src", randImageTile4);
            $('#FourImage').attr("class", "");
            $('#FourImage').attr("class", imageNames4[randImage4]);

            var x = Math.floor((Math.random() * 10) + 1);
            $('#Caption1').text(x);
            var x = Math.floor((Math.random() * 10) + 1);
            $('#Caption2').text(x);

            var x = Math.floor((Math.random() * 10) + 1);
            $('#Caption3').text(x);
            var x = Math.floor((Math.random() * 10) + 1);
            $('#Caption4').text(x);

            var x = Math.floor((Math.random() * 10) + 1);
            $('#Caption5').text(x);
            var x = Math.floor((Math.random() * 10) + 1);
            $('#Caption6').text(x);

            var x = Math.floor((Math.random() * 10) + 1);
            $('#Caption7').text(x);
            var x = Math.floor((Math.random() * 10) + 1);
            $('#Caption8').text(x);

            var questionNames = new Array(imageNames1[randImage1], imageNames2[randImage2], imageNames3[randImage3], imageNames4[randImage4]);
            var questionName = Math.floor(Math.random() * questionNames.length);
            $('.captchaQuestion').text("Please enter the sum of two numbers adjacent to " + questionNames[questionName] + " image:");
            $('#currentCaptchaQuestion').val("");
            $('#currentCaptchaQuestion').val(questionNames[questionName]);

            $('#Login').click(function () {
                //if (($('#MainContent_UserName')[0].value !== "") && ($('#MainContent_Password')[0].value !== "")) {

                var usName = $('#MainContent_UserName')[0].value;
                var pswd = $('#MainContent_Password')[0].value;
                if (usName === null || usName === "") {
                    alert("Please enter value for UserName");
                    return false;
                }
                if (pswd === null || pswd === "") {
                    alert("Please enter value for Passsword");
                    return false;
                }
                if ($('#CaptchaAnswer')[0].value === "") {
                    alert("Please enter value for CAPTCHA");
                    return false;
                }
                var captchaAnswer = $('#CaptchaAnswer')[0].value;
                var currentCaptchaImageName = $('#currentCaptchaQuestion')[0].value;
                var firstValue = $("." + currentCaptchaImageName).parent().find('figcaption')[0].innerHTML;
                var secondValue = $("." + currentCaptchaImageName).parent().find('figcaption')[1].innerHTML;
                var firstNumber = parseInt(firstValue);
                var secondNumber = parseInt(secondValue);


                //                var token = "<?= $_SESSION['token'] ?>";
                
                var token = $('#token')[0].value;

                $.ajax({
                    type: "POST",
                    url: "Login.aspx/LoginValidation",
                    data: "{'userName':'" + usName + "' , 'password': '" + pswd + "', 'firstNumber': '" + firstNumber + "', 'secondNumber': '" + secondNumber + "', 'captchaAnswer': '" + captchaAnswer + "' , 'token': '" + token + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (resp) {
                        data = resp;

                        //checking data for CAPTCHA
                        if (data.d === "Login Credentials are correct, CAPTCHA Verification Successfull!") {
                            alert("Login Credentials are correct, CAPTCHA Verification Successfull!");
                        }
                        else if (data.d === "UserName Found, But IncorrectPassword, Please try again") {
                            alert("UserName Found, But IncorrectPassword, Please try again");
                        }
                        else if (data.d === "Invalid UserName") {
                            alert("Invalid UserName");
                        }
                        else if (data.d === "You have entered a wrong value for the CAPTCHA! Please retry logging in!!") {
                            alert("You have entered a wrong value for the CAPTCHA! Please retry logging in!!");
                        }
                        else if (data.d === "Bot Found") {
                            alert("Bot Found");
                        }
                    }
                })
            });

        });

       

    </script>
    <h2>
        Log In
    </h2>
    <p>
        Please enter your username and password.
        <asp:HyperLink ID="RegisterHyperLink" runat="server" EnableViewState="false">Register</asp:HyperLink>
        if you don't have an account.
    </p>
            <span class="failureNotification">
                <asp:Literal ID="FailureText" runat="server"></asp:Literal>
            </span>
            <asp:ValidationSummary ID="LoginUserValidationSummary" runat="server" CssClass="failureNotification"
                ValidationGroup="LoginUserValidationGroup" />
            <div class="accountInfo">
                <%--<table>
            <td>--%>
                <fieldset class="login">
                    <legend>Account Information</legend>
                    <p>
                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Username:</asp:Label>
                        <asp:TextBox ID="UserName" runat="server" CssClass="textEntry"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                            CssClass="failureNotification" ErrorMessage="User Name is required." ToolTip="User Name is required."
                            ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
                    </p>
                    <p>
                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                        <asp:TextBox ID="Password" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                            CssClass="failureNotification" ErrorMessage="Password is required." ToolTip="Password is required."
                            ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
                    </p>
                    <p>
                        <asp:CheckBox ID="RememberMe" runat="server" />
                        <asp:Label ID="RememberMeLabel" runat="server" AssociatedControlID="RememberMe" CssClass="inline">Keep me logged in</asp:Label>
                    </p>
                    <input style = 'display:none' id="token" />
                </fieldset>
                <fieldset class="Captcha">
                    <legend>CAPTCHA</legend>
                    <table>
                        <tr>
                            <td>
                                <figcaption id="Caption1" class="imagecaptions">1</figcaption>
                                <figcaption id="Caption2" class="alignleft">1</figcaption>
                                <img style="width: 150px;" class="imgClass" src="../images/Penquin.jpg" alt="Image not available in database"
                                    id="FirstImage" />
                            </td>
                            <td>
                                <figcaption id="Caption3" class="imagecaptions">2</figcaption>
                                <figcaption id="Caption4" class="alignright">2</figcaption>
                                <img style="width: 150px;" src="../images/deer.jpg" alt="Image not available in database"
                                    id="SecondImage" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <figcaption id="Caption5" class="alignleft">3</figcaption>
                                <img style="width: 150px;" src="../images/Monkey.jpg" alt="Image not available in database"
                                    id="ThirdImage" />
                                <figcaption id="Caption6" class="imagecaptions">3</figcaption>
                            </td>
                            <td>
                                <figcaption id="Caption7" class="alignright">4</figcaption>
                                <img style="width: 150px;" src="../images/Dog1.jpg" alt="Image not available in database"
                                    id="FourImage" />
                                <figcaption id="Caption8" class="imagecaptions">4</figcaption>
                            </td>
                        </tr>
                    </table>
                    <label style="margin: 15px" class="CaptchaAnswerArea captchaQuestion">
                        Please enter the sum of two numbers adjacent to "string" image :</label>
                    <div class="clear">
                    </div>
                    <input style="margin: 15px" type="text" id="CaptchaAnswer" class="textEntry CaptchaAnswerArea" />
                    <p>
                    </p>
                </fieldset>

                <%--</td>
                <td>--%>
                <%--</td>
                </table>--%>
                <%-- Below code Commented Reason : Previously added below the login credentials, then moved the CAPTCHA beside the login credentials 
                Change made by Deepak Sundar Viajyan On 14th Nov 2014--%>
                <%-- <fieldset class = "Captcha">
                    <legend>CAPTCHA</legend>
                    <p>
                        <img class="imgClass" src="../images/Penquin.jpg" alt="captchA" />
                        <img class="imgClass" src="../images/Panda.jpg" alt="captchA" />
                        <br />
                        <img class="imgClass" src="../images/Monkey.jpg" alt="captchA" />
                        <img class="imgClass" src="../images/Dog1.jpg" alt="captchA" />
                    </p>
                    <p>
                    <asp:Label runat="server" ID="captchaLabel" AssociatedControlID="CaptchaAnswer">Please type in the answer in the below text box:</asp:Label>
                    <div class="clear"></div>
                    <asp:TextBox runat="server" ID="CaptchaAnswer" CssClass="captchaEntry"></asp:TextBox>
                    </p>
                </fieldset>--%>
                <p class="submitButton">
                    <button id="Login">
                        Login</button>
                    <%--<asp:Button ID="Login" runat="server" Text="Login" onclick="loginclick" />--%>
                </p>
                <input style="display: none" id="currentCaptchaQuestion" />
            </div>
            <%--Initally CAPTCHA part was added here
            If we uncomment this below code captcha part will appear below the login button--%>
            <%--<div class="captchaHolder">
                <a>
                    <img class="imgClass" src="../images/dpk.JPG" alt="captchA" />
                    <img class="imgClass" src="../images/win7.JPG" alt="captchA" />
                    <img class="imgClass" src="../images/Comedy.JPG" alt="captchA" /><br />
                    <img class="imgClass" src="../images/viv1.JPG" alt="captchA" />
                    <img class="imgClass" src="../images/viv2.JPG" alt="captchA" />
                    <img class="imgClass" src="../images/viv3.JPG" alt="captchA" />
                </a>
            </div>--%>
        
</asp:Content>

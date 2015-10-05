<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="About.aspx.cs" Inherits="About" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        About
    </h2>
    <p>
        The main purpose of our project is to enhance authentication mechanism to provide
        increased security against bot attacks; also to overcome the disadvantages of existing
        test based CAPTCHA. Our idea introduces addition parameters to existing login functionality.
        Existing image based CAPTCHA display a set of images and request input from user
        on the nature or type of the image. The above layout of image based CAPTCHA prompts
        user to click on an image based on the question present at the top. These image
        based CAPTCHA are still vulnerable since the HTML source code deploying these images
        can be traced and a bot can answer the question mimicking a human.
    </p>
    <p>
        We implement an enhancing variation of existing image based CAPTCHA mechanism by
        introducing a grid of pictures with random alphanumeric values assigned to each
        grid coordinate corresponding to a picture. The simple questions are based on the
        grid position values and prompts users to answers the questions. Once the values
        for the required fields are entered, the user submits the request. The CAPTCHA is
        validated for correctness and the desired action is performed based on the result.
        In this approach the probability of bots passing the test is very slim to none.
        It also reduces the complexity and time consumed for performing the introduced additional
        tasks compared to the earlier mechanisms. To be more precise, the image based CAPTCHA
        overcomes various challenges faced by the text based CAPTCHA systems such as user’s
        ability to recognize and understand blurred and distorted texts.
    </p>
    Many websites have secure data which requires users to sign up and login using their
    credentials. All these website are exposed to constant threats and attacks from
    remotely controller botnets. We can enforce this security mechanism to any web application
    to create a more secure login. This will prevent the attacks directed from bots
    and aids the system to differentiate between a bot and a human.
    <p>
        Our idea enforces authentication policies to existing security measures which prevents
        unauthorized access or disclosure of information.
    </p>
</asp:Content>

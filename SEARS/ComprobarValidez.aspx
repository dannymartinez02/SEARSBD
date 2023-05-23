<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ComprobarValidez.aspx.cs" Inherits="SEARS.ComprobarValidez" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Comprobar Validez de Tarjeta de Crédito</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
        }

        h2 {
            font-size: 24px;
            margin-bottom: 20px;
        }

        .textbox {
            padding: 8px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .button {
            padding: 8px 16px;
            font-size: 16px;
            font-weight: bold;
            text-align: center;
            text-decoration: none;
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
        }

        .result-label {
            margin-top: 20px;
            font-size: 18px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Comprobar Validez de Tarjeta de Crédito</h2>
            <asp:TextBox ID="CreditCardNumberTextBox" runat="server" CssClass="textbox"></asp:TextBox>
            <asp:Button ID="CheckButton" runat="server" Text="Comprobar" OnClick="CheckButton_Click" CssClass="button" />
            <br />
            <asp:Label ID="ResultLabel" runat="server" Text="" CssClass="result-label"></asp:Label>
        </div>
    </form>
</body>
</html>

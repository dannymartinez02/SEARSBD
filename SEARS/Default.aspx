<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SEARS.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Página predeterminada</title>
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

        h3 {
            font-size: 20px;
            margin-top: 40px;
        }

        .button-container {
            text-align: center;
            margin-bottom: 20px;
        }

        .button {
            display: inline-block;
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
            margin-right: 10px;
        }

        .gridview {
            margin-top: 20px;
            border-collapse: collapse;
            width: 100%;
        }

        .gridview th,
        .gridview td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        .gridview th {
            background-color: #4CAF50;
            color: #fff;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Página predeterminada</h2>
            <div class="button-container">
                <asp:Button ID="btnBack" runat="server" Text="Volver al inicio de sesión" OnClick="btnBack_Click" CssClass="button" />
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Comprobar Datos tarjeta" CssClass="button" />
            </div>

            <h3>Usuarios</h3>
            <asp:GridView ID="GridView1" runat="server" CssClass="gridview"></asp:GridView>
            <div class="button-container">
                <asp:Button ID="btnTable1" runat="server" Text="Mostrar Tabla 1" CommandArgument="Usuario" OnClick="btnTable_Click" CssClass="button" />
                <asp:Button ID="btnAdministrarDatos" runat="server" Text="Administrar Datos" CommandArgument="Usuario" OnClick="btnAdministrarDatos_Click" CssClass="button" />
            </div>

            <h3>Conteo De Tarjetas</h3>
            <asp:GridView ID="GridView2" runat="server" CssClass="gridview"></asp:GridView>
            <div class="button-container">
                <asp:Button ID="btnTable2" runat="server" Text="Mostrar Tabla 2" CommandArgument="ConteoDeTarjetas" OnClick="btnTable_Click" CssClass="button" />
                <asp:Button ID="btnAdministrarDatos2" runat="server" Text="Administrar Datos" CommandArgument="ConteoDeTarjetas" OnClick="btnAdministrarDatos_Click" CssClass="button" />
            </div>

            <h3>Entrega de Tarjetas</h3>
            <asp:GridView ID="GridView3" runat="server" CssClass="gridview"></asp:GridView>
            <div class="button-container">
                <asp:Button ID="btnTable3" runat="server" Text="Mostrar Tabla 3" CommandArgument="EntregaDeTarjetas" OnClick="btnTable_Click" CssClass="button" />
                <asp:Button ID="btnAdministrarDatos3" runat="server" Text="Administrar Datos" CommandArgument="EntregaDeTarjetas" OnClick="btnAdministrarDatos_Click" CssClass="button" />
            </div>
        </div>
    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarDatos.aspx.cs" Inherits="SEARS.AdministrarDatos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Administrar Datos</title>
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
            margin-top: 30px;
            margin-bottom: 10px;
        }

        .label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .textbox {
            padding: 8px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-bottom: 10px;
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

        .gridview {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Administrar Datos</h2>
            <h3>Agregar Usuario</h3>
            <asp:Label ID="lblNombreUsuario" runat="server" Text="Nombre de Usuario" CssClass="label"></asp:Label>
            <asp:TextBox ID="txtNombreUsuario" runat="server" CssClass="textbox"></asp:TextBox>
            <br />
            <asp:Label ID="lblPassword" runat="server" Text="Contraseña" CssClass="label"></asp:Label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="textbox"></asp:TextBox>
            <br />
            <asp:Button ID="btnAdd" runat="server" Text="Agregar" OnClick="btnAdd_Click" CssClass="button" />
            <br />
            <br />
            <h3>Actualizar Usuario</h3>
            <asp:Label ID="lblIDusuario" runat="server" Text="ID de Usuario" CssClass="label"></asp:Label>
            <asp:TextBox ID="txtIDusuario" runat="server" CssClass="textbox"></asp:TextBox>
            <br />
            <asp:Button ID="btnUpdate" runat="server" Text="Actualizar" OnClick="btnUpdate_Click" CssClass="button" />
            <br />
            <br />
            <h3>Eliminar Usuario</h3>
            <asp:Label ID="lblIDusuarioDelete" runat="server" Text="ID de Usuario" CssClass="label"></asp:Label>
            <asp:TextBox ID="txtIDusuarioDelete" runat="server" CssClass="textbox"></asp:TextBox>
            <br />
            <asp:Button ID="btnDelete" runat="server" Text="Eliminar" OnClick="btnDelete_Click" CssClass="button" />
            <br />
            <br />
            <h3>Usuarios</h3>
            <asp:GridView ID="GridView1" runat="server" CssClass="gridview"></asp:GridView>
        </div>
    </form>
</body>
</html>

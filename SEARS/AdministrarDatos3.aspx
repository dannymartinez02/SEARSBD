<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarDatos3.aspx.cs" Inherits="SEARS.AdministrarDatos3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Administrar Datos Tabla 3</title>
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
            margin-bottom: 10px;
        }

        table {
            border-collapse: collapse;
            width: 100%;
        }

        table td {
            padding: 8px;
            border: 1px solid #ccc;
        }

        table td:first-child {
            font-weight: bold;
            width: 200px;
        }

        .textbox {
            width: 100%;
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

        .error-message {
            color: red;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Administrar Datos Tabla 3</h2>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" OnRowEditing="GridView1_RowEditing"
                OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowUpdating="GridView1_RowUpdating"
                OnRowDeleting="GridView1_RowDeleting" DataKeyNames="TarjetaDeCreditoID">
                <Columns>
                    <asp:BoundField DataField="TarjetaDeCreditoID" HeaderText="ID" ReadOnly="True" />
                    <asp:TemplateField HeaderText="Titular de Tarjeta">
                        <ItemTemplate>
                            <asp:Label ID="lblTitularTarjeta" runat="server" Text='<%# Bind("TitularTarjeta") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditTitularTarjeta" runat="server" Text='<%# Bind("TitularTarjeta") %>' CssClass="textbox"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Número de Cuenta">
                        <ItemTemplate>
                            <asp:Label ID="lblNumCuenta" runat="server" Text='<%# Bind("NumCuenta") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditNumCuenta" runat="server" Text='<%# Bind("NumCuenta") %>' CssClass="textbox"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Fecha de Expiración">
                        <ItemTemplate>
                            <asp:Label ID="lblFechaExpiracion" runat="server" Text='<%# Bind("FechaExpiracion") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditFechaExpiracion" runat="server" Text='<%# Bind("FechaExpiracion") %>' CssClass="textbox"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Correlativo">
                        <ItemTemplate>
                            <asp:Label ID="lblCorrelativo" runat="server" Text='<%# Bind("Correlativo") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditCorrelativo" runat="server" Text='<%# Bind("Correlativo") %>' CssClass="textbox"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Tipo de Tarjeta">
                        <ItemTemplate>
                            <asp:Label ID="lblTipoTarjeta" runat="server" Text='<%# Bind("TipoDeTarjeta") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditTipoTarjeta" runat="server" Text='<%# Bind("TipoDeTarjeta") %>' CssClass="textbox"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>
            <br />
            <h3>Agregar Nueva Tarjeta</h3>
            <table>
                <tr>
                    <td>Titular de Tarjeta:</td>
                    <td><asp:TextBox ID="txtTitularTarjeta" runat="server" CssClass="textbox"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Número de Cuenta:</td>
                    <td><asp:TextBox ID="txtNumCuenta" runat="server" CssClass="textbox"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Fecha de Expiración:</td>
                    <td><asp:TextBox ID="txtFechaExpiracion" runat="server" CssClass="textbox"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Correlativo:</td>
                    <td><asp:TextBox ID="txtCorrelativo" runat="server" CssClass="textbox"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Tipo de Tarjeta:</td>
                    <td><asp:TextBox ID="txtTipoTarjeta" runat="server" CssClass="textbox"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Fecha de Entrega:</td>
                    <td><asp:TextBox ID="txtFechaEntrega" runat="server" CssClass="textbox"></asp:TextBox></td>
                </tr>
            </table>
            <br />
            <asp:Button ID="btnSave" runat="server" Text="Guardar" OnClick="btnSave_Click" CssClass="button" />
            <br />
            <br />
            <asp:Label ID="lblErrorMessage" runat="server" CssClass="error-message" Visible="false"></asp:Label>
        </div>
    </form>
</body>
</html>

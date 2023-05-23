<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministrarDatos2.aspx.cs" Inherits="SEARS.AdministrarDatos2" %>

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
            width: 150px;
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

        .gridview {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Administrar Datos</h2>
            <table>
                <tr>
                    <td>Correlativo:</td>
                    <td>
                        <asp:TextBox ID="txtCorrelativo" runat="server" CssClass="textbox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Tipo de Tarjeta:</td>
                    <td>
                        <asp:TextBox ID="txtTipoTarjeta" runat="server" CssClass="textbox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="btnSave" runat="server" Text="Guardar" OnClick="btnSave_Click" CssClass="button" />
                    </td>
                </tr>
            </table>
            <br />
            <asp:GridView ID="GridView1" runat="server" CssClass="gridview" AutoGenerateColumns="False" OnRowEditing="GridView1_RowEditing" 
                OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowUpdating="GridView1_RowUpdating" 
                OnRowDeleting="GridView1_RowDeleting" DataKeyNames="TarjetaDeCreditoID">
                <Columns>
                    <asp:BoundField DataField="TarjetaDeCreditoID" HeaderText="ID" ReadOnly="True" />
                    <asp:TemplateField HeaderText="Correlativo">
                        <ItemTemplate>
                            <asp:Label ID="lblCorrelativo" runat="server" Text='<%# Eval("Correlativo") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditCorrelativo" runat="server" Text='<%# Eval("Correlativo") %>' CssClass="textbox"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Tipo de Tarjeta">
                        <ItemTemplate>
                            <asp:Label ID="lblTipoTarjeta" runat="server" Text='<%# Eval("TipoDeTarjeta") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditTipoTarjeta" runat="server" Text='<%# Eval("TipoDeTarjeta") %>' CssClass="textbox"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>

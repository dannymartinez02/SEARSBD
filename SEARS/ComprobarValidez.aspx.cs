using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SEARS
{
    public partial class ComprobarValidez : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void CheckButton_Click(object sender, EventArgs e)
        {
            // Obtener el número de tarjeta de crédito ingresado por el usuario
            string creditCardNumber = CreditCardNumberTextBox.Text;

            if (!string.IsNullOrEmpty(creditCardNumber))
            {
                // Comprobar la validez del número de tarjeta utilizando el algoritmo de Luhn
                bool isValid = IsCreditCardNumberValid(creditCardNumber);

                // Mostrar el resultado al usuario
                if (isValid)
                {
                    ResultLabel.Text = "El número de tarjeta de crédito es válido.";
                }
                else
                {
                    ResultLabel.Text = "El número de tarjeta de crédito no es válido.";
                }
            }
            else
            {
                ResultLabel.Text = "Por favor, ingresa un número de tarjeta de crédito.";
            }
        }

        private bool IsCreditCardNumberValid(string creditCardNumber)
        {
            // Eliminar los espacios en blanco y caracteres no numéricos del número de tarjeta
            string cleanedNumber = new string(creditCardNumber.Where(char.IsDigit).ToArray());

            // Convertir el número de tarjeta a un array de dígitos
            int[] digits = cleanedNumber.Select(c => int.Parse(c.ToString())).ToArray();

            // Aplicar el algoritmo de Luhn para comprobar la validez del número de tarjeta
            int sum = 0;
            bool isEven = false;
            for (int i = digits.Length - 1; i >= 0; i--)
            {
                int digit = digits[i];
                if (isEven)
                {
                    digit *= 2;
                    if (digit > 9)
                    {
                        digit -= 9;
                    }
                }
                sum += digit;
                isEven = !isEven;
            }

            return sum % 10 == 0;
        }
    }
}


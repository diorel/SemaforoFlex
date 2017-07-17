using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
namespace FlexAccesFloor
{
    public partial class Acces : System.Web.UI.Page
    {
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				Label1.Visible = false;
				lblIdEmpleado.Visible = false;
				imgAproval.Visible = false;
				imgDecline.Visible = false;
				Label2.Visible = false;
				lblDiasEmpleado.Visible = false;
				Label3.Visible = false;
				lblFechaActual.Visible = false;
				Label4.Visible = false;
				lblTurno.Visible = false;
				Label5.Visible = false;
				lblSite.Visible = false;
				Label6.Visible = false;
				lblNombreEmpleado.Visible = false;
				Label7.Visible = false;
				lblHorasEmpleado.Visible = false;
				imgEmpleado.Visible = false;
			}
			else
			{}
		}

        protected void Button1_Click(object sender, EventArgs e)
        {
			Label1.Visible = true;
			lblIdEmpleado.Visible = true;
			imgAproval.Visible = true;
			imgDecline.Visible = true;
			Label2.Visible = true;
			lblDiasEmpleado.Visible = true;
			Label3.Visible = true;
			lblFechaActual.Visible = true;
			Label4.Visible = true;
			lblTurno.Visible = true;
			Label5.Visible = true;
			lblSite.Visible = true;
			Label6.Visible = true;
			lblNombreEmpleado.Visible = true;
			Label7.Visible = true;
			lblHorasEmpleado.Visible = true;
			imgEmpleado.Visible = true;


			dsDias.DataBind();            
            gdvDias.DataBind();
            gdvDias.Visible = false;

			if (gdvDias.Rows.Count == 0)
			{
				//Si el empleado tiene correctas sus dias y sus horas
				lblIdEmpleado.Text = "1"; 
			}
			else
			{
				//Si el empleado tiene incorrectos sus dias y sus horas
				lblIdEmpleado.Text = gdvDias.Rows[0].Cells[0].Text;
            lblFechaActual.Text = gdvDias.Rows[0].Cells[1].Text;
            lblDiasEmpleado.Text = gdvDias.Rows[0].Cells[2].Text;
            int dias;
            dias = Convert.ToInt32(lblDiasEmpleado.Text);
            lblTurno.Text = gdvDias.Rows[0].Cells[3].Text;
            lblSite.Text = gdvDias.Rows[0].Cells[4].Text;
            lblNombreEmpleado.Text = gdvInfoEmpleado.Rows[0].Cells[1].Text;
            //imgEnpleado.ImageUrl = gdvInfoEmpleado.Rows[0].Cells[2].Text;
            lblHorasEmpleado.Text = gdvHoras.Rows[0].Cells[3].Text;
            int Horas;
            Horas = Convert.ToInt32(lblHorasEmpleado.Text);

            //Validar si tiene acceso  
            imgAproval.Style.Add("display", "none");
            imgDecline.Style.Add("display", "none");
            if (dias >= 7)
            {
                imgDecline.Style["display"] = "";

                if (Horas >= 60)
                {
                    imgDecline.Style["display"] = "";
                }               
            }
            else
            {
                imgAproval.Style["display"] = "";
            }
			}





        }
    }
}
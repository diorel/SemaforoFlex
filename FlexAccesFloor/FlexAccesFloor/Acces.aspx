<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Acces.aspx.cs" Inherits="FlexAccesFloor.Acces" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Bootstrap/css/bootstrap.css" rel="stylesheet" />
    <link href="Bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Bootstrap/css/bootstrap-theme.css" rel="stylesheet" />
</head>
<body style="padding-left: 20%; padding-right:20%; padding-top: 10%; background-color:#E6E6E6;">
    
    <form id="form1" runat="server">
        <div>
            <asp:TextBox ID="txtIdEmpleado" runat="server"></asp:TextBox>
            <asp:Button ID="btn" runat="server" Text="Button" OnClick="Button1_Click" />
            <br />

            <div style="box-shadow: 10px 10px 5px 0px rgba(0,0,0,0.75); background-color:#FFFFFF;">


            <table>
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="Workday ID:" Font-Bold="True"></asp:Label></td>
                    <td><asp:Label ID="lblIdEmpleado" runat="server" Text=""></asp:Label></td>
                    <td rowspan="7">
                        <asp:Image ID="imgAproval" runat="server" ImageUrl="~/Images/good.png" />
                        <asp:Image ID="imgDecline" runat="server" ImageUrl="~/Images/bad.png" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="Dias Laborados:" Font-Bold="True"></asp:Label></td>
                    <td><asp:Label ID="lblDiasEmpleado" runat="server" Text=""></asp:Label></td>
                </tr>
                <tr>
                    <td><asp:Label ID="Label3" runat="server" Text="Fecha Actual:" Font-Bold="True"></asp:Label></td>
                    <td><asp:Label ID="lblFechaActual" runat="server" Text=""></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label4" runat="server" Text="Turno:" Font-Bold="True"></asp:Label></td>
                    <td><asp:Label ID="lblTurno" runat="server" Text=""></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label5" runat="server" Text="Edificio:" Font-Bold="True"></asp:Label></td>
                    <td><asp:Label ID="lblSite" runat="server" Text=""></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label6" runat="server" Text="Nombre:" Font-Bold="True"></asp:Label></td>
                    <td><asp:Label ID="lblNombreEmpleado" runat="server" Text=""></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label7" runat="server" Text="Horas Laboradas:" Font-Bold="True"></asp:Label></td>
                    <td><asp:Label ID="lblHorasEmpleado" runat="server" Text=""></asp:Label></td>
                </tr>
                <tr>
                    <td><asp:Image ID="imgEmpleado" runat="server" /></td>
                </tr>
            </table>
            
            </div>
            
            
            
            
            
            <asp:GridView ID="gdvDias" runat="server" AutoGenerateColumns="False" DataSourceID="dsDias">
                <Columns>
                    <asp:BoundField DataField="workdayid" HeaderText="workdayid" SortExpression="workdayid" />
                    <asp:BoundField DataField="date" HeaderText="date" SortExpression="date" />
                    <asp:BoundField DataField="cuenta" HeaderText="cuenta" ReadOnly="True" SortExpression="cuenta" />
                    <asp:BoundField DataField="turno" HeaderText="turno" SortExpression="turno" />
                    <asp:BoundField DataField="businesssite" HeaderText="businesssite" SortExpression="businesssite" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="dsDias" runat="server" ConnectionString="<%$ ConnectionStrings:KioscoConnectionString %>" SelectCommand="SELECT workdayid, date, cuenta, turno, BusinessSite FROM (SELECT WR.workdayid, WR.date, (SELECT COUNT(DISTINCT date) AS Expr1 FROM kioscorw.GandA_Kronos60Horas AS WRA WHERE (workdayid = WR.workdayid) AND (date BETWEEN DATEADD(dd, - 5, WR.date) AND WR.date) AND (paycode IN ('MEX-Permiso CG Trabajo fuera pta', 'MEX-Viaje', 'MEX-Asistencia Forzada', 'MEX-Festivo Trabajado Horas', 'MEX-Descanso Trabajado Horas', 'MEX-Dia Laborado'))) AS cuenta, e.turno, e.BusinessSite FROM kioscorw.GandA_Kronos60Horas AS WR INNER JOIN EmployeeData AS e ON WR.workdayid = e.empleado WHERE (WR.paycode IN ('MEX-Permiso CG Trabajo fuera pta', 'MEX-Viaje', 'MEX-Asistencia Forzada', 'MEX-Festivo Trabajado Horas', 'MEX-Descanso Trabajado Horas', 'MEX-Dia Laborado')) AND (e.dim4 LIKE 'GMP%') AND (WR.date &gt; DATEADD(dd, - 1, CONVERT (char(12), GETDATE(), 101)))) AS A WHERE (cuenta &gt;= 6) AND (workdayid = @IdEmpleado)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtIdEmpleado" Name="IdEmpleado" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="gdvHoras" runat="server" AutoGenerateColumns="False" DataSourceID="dsHoras" Visible ="False">
                <Columns>
                    <asp:BoundField DataField="year" HeaderText="year" SortExpression="year" />
                    <asp:BoundField DataField="week" HeaderText="week" SortExpression="week" />
                    <asp:BoundField DataField="workdayid" HeaderText="workdayid" SortExpression="workdayid" />
                    <asp:BoundField DataField="hourbyweek" HeaderText="hourbyweek" ReadOnly="True" SortExpression="hourbyweek" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="dsHoras" runat="server" ConnectionString="<%$ ConnectionStrings:KioscoConnectionString %>" SelectCommand="select * from 
(select year, week, workdayid, 
      sum(case    
    when paycode in('MEX-Horas Extras Triples', 'MEX-Horas Extras Dobles', 'MEX-Festivo Trabajado Horas', 'MEX-Descanso Trabajado Horas') then value    
    when paycode in('MEX-Horas Extras T3', 'MEX-Horas Extras T2','MEX-Horas Extras T12 1.5' ) then value*-1
    when paycode in('MEX-Permiso CG Funeral', 'Ausencia injustificada','MEX-Incap. Interna','MEX-Permiso CG Cumpleanos',    
        'MEX-Permiso CG Nacimiento', 'MEX-Permiso CG Matrimonio','MEX-Falta', 'MEX-Incap. Accidente Trabajo',    
        'MEX-Suspension', 'MEX-Incap. Maternidad', 'MEX-Permiso Sin Goce pd',     
        'MEX-Incap. Enfermedad General' ) then -value * sh.hoursbyday    
    when paycode in('MEX-Dia Laborado') AND value &gt; 1 THEN 1 * hoursbyday
      WHEN paycode in('MEX-Dia Laborado') THEN value * hoursbyday    
    else 0    
   end) as hourbyweek     
 from GandA_Kronos60Horas K60 join employeedata e  on k60.workdayid = e.empleado
join ganda_shifts sh  
  on sh.shiftcode= e.turno
where year = datepart( yyyy, getdate())
and week = datepart( wk, getdate())
and e.dim4 like 'GMP%'
group by year, week, workdayid) A
where hourbyweek &gt;= 50
AND workdayid = @IdEmpleado">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtIdEmpleado" Name="IdEmpleado" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="gdvInfoEmpleado" runat="server" AutoGenerateColumns="False" DataSourceID="dsInfoEmpleados" Visible="false">
                <Columns>
                    <asp:BoundField DataField="EmployeeNumber" HeaderText="EmployeeNumber" SortExpression="EmployeeNumber" />
                    <asp:BoundField DataField="name" HeaderText="name" ReadOnly="True" SortExpression="name" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="dsInfoEmpleados" runat="server" ConnectionString="<%$ ConnectionStrings:Multimax %>" SelectCommand="SELECT c.EmployeeNumber, c.LastName + ' ' + c.FirstName AS name, F.Face FROM CardHolderTable AS c WITH (nolock) INNER JOIN CardHolderFaceTable AS F WITH (nolock) ON c.CardID = F.CardID WHERE (c.EmployeeNumber = @IdEmpleado)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtIdEmpleado" Name="IdEmpleado" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>
			<asp:GridView ID="gdvDiasCorrectos" runat="server" AutoGenerateColumns="False" DataSourceID="dsDiasCorrectos">
				<Columns>
					<asp:BoundField DataField="workdayid" HeaderText="workdayid" SortExpression="workdayid" />
					<asp:BoundField DataField="date" HeaderText="date" SortExpression="date" />
					<asp:BoundField DataField="cuenta" HeaderText="cuenta" ReadOnly="True" SortExpression="cuenta" />
					<asp:BoundField DataField="turno" HeaderText="turno" SortExpression="turno" />
					<asp:BoundField DataField="businesssite" HeaderText="businesssite" SortExpression="businesssite" />
				</Columns>
			</asp:GridView>
        	<asp:SqlDataSource ID="dsDiasCorrectos" runat="server" ConnectionString="<%$ ConnectionStrings:KioscoConnectionString %>" SelectCommand="select * from 
(select workdayid, [date],  
  cuenta =  (select count(distinct WRA.date) from GandA_Kronos60Horas WRA where WRA.workdayid = WR.workdayid  
    and WRA.date between dateadd(dd, -5, WR.date) and WR.date 
    and WRA.paycode in('MEX-Permiso CG Trabajo fuera pta',
                                    'MEX-Viaje',
                                    'MEX-Asistencia Forzada',
                                    'MEX-Festivo Trabajado Horas',
                                    'MEX-Descanso Trabajado Horas',
                                    'MEX-Dia Laborado') ) , e.turno, e.businesssite 
  from GandA_Kronos60Horas WR join employeedata e on  WR.workdayid = e.empleado
  where WR.paycode in('MEX-Permiso CG Trabajo fuera pta',
                                    'MEX-Viaje',
                                    'MEX-Asistencia Forzada',
                                    'MEX-Festivo Trabajado Horas',
                                    'MEX-Descanso Trabajado Horas',
                                    'MEX-Dia Laborado')
       and e.dim4 like 'GMP%'
       and [date] &gt; dateadd(dd, -1, convert(char(12), getdate(),101))
       ) A
where
workdayid = @IdEmpleado">
				<SelectParameters>
					<asp:ControlParameter ControlID="txtIdEmpleado" Name="IdEmpleado" PropertyName="Text" />
				</SelectParameters>
			</asp:SqlDataSource>
        </div>
    </form>
</body>
</html>

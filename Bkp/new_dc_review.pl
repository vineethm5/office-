#!/usr/bin/perl

require "/var/www/cgi-bin/greettech/database.pl";
&database;
require "/var/www/cgi-bin/greettech/request.pl";
&request;
require "/var/www/cgi-bin/greettech/variable_index.pl";

$datalength=$ENV{'QUERY_STRING'};
@qpairs=split(/&/,$datalength);
for ($i=0; @qpairs[$i]; $i++) {
($name,$value) = split(/=/,@qpairs[$i]);
$value =~ tr/+/ /;
$value =~ s/%([\da-fA-F][\da-fA-F])/pack("C", hex ($1))/eg;
$name =~ tr/+/ /;
$name =~ s/%([\da-fA-F][\da-fA-F])/pack("C", hex ($1))/eg;
$qpairs{$name} = $value;
}

use DBI;

	my $database="hrs";
	my $hostname="localhost";
	my $username="root";
	my $password="rsvp1260";

	my $db = DBI->connect("DBI:mysql:$database:$hostname",$username,$password)
	or die ("can't connect to the database");

$idelement=$qpairs{idelement};
$empl_name=$qpairs{empl_name};
$user=$qpairs{user};
$access=$qpairs{access};
$random=$qpairs{random};
$file=$qpairs{file};

 $category=$category;
# $category=$qpairs{category};
$teamwise=$qpairs{teamwise};

# $idelement = '1511';
# $empl_name = 'Sreenath .P';

if($teamwise == 1)
{
	$teamwise= 1;
}
else
{
	$teamwise= 0;
}


#require "/var/www/cgi-bin/greettech/cookie_per_page.pl";
#&pass($qpairs{random});

$nowtime = time;
my($todaysecond, $todayminute, $todayhour, $todaydayofmonth, $todaymonth, $todayyear, $todayweekday, $todaydayofyear, $todayisdst)=localtime($nowtime);
$todaymonth++;
if($todaydayofmonth < 10){
$currDay .= '0'.$todaydayofmonth;
}else{
$currDay=$todaydayofmonth;
}if($todaymonth < 10){
$currMonth = '0'.$todaymonth;
}else{
$currMonth=$todaymonth;
}
$currYear = $todayyear+1900;
$currentdate=$currYear."-".$currMonth."-".$currDay;

for($i=1; $i<=31; $i++){
  if($i == $currDay){
  $cmbDay = $cmbDay . "<option value=".$i." selected>".$i."</option>\n";
  }else{
   $cmbDay = $cmbDay . "<option value=".$i.">".$i."</option>\n";
   }
}
for($i=1; $i<=12; $i++){
 if($i == $todaymonth){
 $cmbMonth = $cmbMonth . "<option value=".$i." selected>".$i."</option>\n";
 }else{
  $cmbMonth = $cmbMonth . "<option value=".$i.">".$i."</option>\n";
  }
}
for($i=2008; $i<=$currYear+1; $i++){
  if($i == $currYear){
  $cmbYear = $cmbYear . "<option value=".$i." selected>".$i."</option>\n";
  }else{
   $cmbYear = $cmbYear . "<option value=".$i.">".$i."</option>\n";
   }
}

# $Feedback_Date=$cmbYear.'-'.$cmbMonth.'-'.$cmbDay;
$evaldate = $currYear."-".$currMonth;

$ph1 = $db->prepare("select fname,mname,lname,1 from employee_details where empl_no ='$idelement'");
$ph1->execute();
$ph1->bind_columns(\$fname,\$mname,\$lname,\$dummy);
while($resgatepass1=$ph1->fetchrow_array)
{
	$empl_name = $fname." ".$mname." ".$lname;
}
	

###########################################################################################



############################################################################################

$sql1="select curdate() as Feedback_Date";
$ph21= $db->prepare($sql1);
$ph21->execute();
$ph21->bind_columns(\$Feedback_Date);
while($resgataepass1=$ph21->fetchrow_array)
{}


$ph2= $db->prepare("select  id,empl_no from new_mailing_eval_2015 where onsite_flag=1 and service_flag=0 and empl_no='$idelement' limit 1");

$ph2->execute();
$ph2->bind_columns(\$id,\$empl_no);
while($resgatepass1=$ph2->fetchrow_array)
{


	
	
	#if(onsite_flag==1 && service_flag=0)


}

$tr .="<tr style=display:none;>
		<td>
			<input type='text' id='file' name='file' value='$file'>
			<input type='text' id='user' name='user' value='$user'>
			<input type='text' id='access' name='access' value='$access'>
			<input type='text' id='random' name='random' value='$random'>
			<input type='text' id='teamwise' name='teamwise' value='$teamwise'>
			<input type='text' id='category' name='category' value='$category'>
			<input type='text' id='idelement' name='idelement' value='$idelement'>
		</td>
	</tr>";




$tr .="<tr><td align=center><font face=Arial><b><u>Communication</u></b></font></td><td><font face=Arial><b><u>Score</u></b></font></td><td><font face=Arial><b><u>Not&nbsp;Applicable</u></b></font></td></tr>";

#****************************Opening of call****************************************
$tr .="<tr><td align=center><font face=Arial><b><u>Greetings</u></b></font></td></tr>";


$tr .= "<tr><td><font face=Arial><b> Agent adhered to the call opening greeting script :</b></font></td></tr>";

$tr .= "<tr><td><input type=radio id='sect1_1' name='sect1_1'  value='5/5' checked onclick='sect1()'><font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font>";
$tr .= "<input type=radio id='sect1_1' name= 'sect1_1'  value='0/5' onclick='sect1()'><font face=Arial>No</font></td>
			<td align=center><input class='style8' type=text disabled name='disp_text1' id='disp_text1' value='0/5' size=1></font></td>
			<td align=center ><input type=checkbox name='sect1_na' id='sect1_na' value=1 onclick='sect1()'></font></td>




 <td><p id='show_hide1' style='visibility: hidden'><textarea id='remarks1' name='remarks1' cols=10 rows=5 ></textarea></p></td>";


#----------------------------------------END----------------------------------------


#****************************Etiquette->Sentence Formation****************************************
$tr .= "<tr><td><font face=Arial><b> Agent introduction & Confirming Customer name</b></font></td></tr>";
$tr .= "<tr><td><input type=radio id='sect2_2' name='sect2_2'  value='5/5' checked onclick='sect2()'><font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font>";
$tr .= "<input type=radio id='sect2_2' name= 'sect2_2'  value='0/5' onclick='sect2()'><font face=Arial>No</font></td>
<td align=center><input class='style8' type=text disabled name='disp_text2' id='disp_text2' value='0/5' size=1></font></td>
<td align=center ><input type=checkbox name='sect2_na' id='sect2_na' value=1 onclick='sect2()'></font></td>

 <td><p id='show_hide2' style='visibility: hidden'><textarea id='remarks2' name='remarks2' cols=10 rows=5 ></textarea></p></td>";
#**************************** Clarity of speech ***************************************

$tr .= "<tr><td><font face=Arial><b>  Seek Permission/ Purpose of the call :</b></font></td></tr>";
$tr .= "<tr><td><input type=radio id='sect3_3' name= 'sect3_3'  value='5/5' checked onclick='sect3()'><font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font>";
$tr .= "<input type=radio id='sect3_3' name= 'sect3_3'  value='0/5' onclick='sect3()'><font face=Arial>No</font></td><td align=center><input class='style8' type=text disabled name='disp_text3' id='disp_text3' value='0/5' size=1></font></td><td align=center ><input type=checkbox name='sect3_na' id='sect3_na' value=1 onclick='sect3()'></font></td>

 <td><p id='show_hide3' style='visibility: hidden'><textarea id='remarks3' name='remarks3' cols=10 rows=5 ></textarea></p></td>";
#----------------------------------------END--------------------------------------------



#**************************** Grammar and Spelling ***************************************

$tr .= "<tr><td><font face=Arial><b>Brand Pitching/DC History</b></font></td></tr>";
$tr .= "<tr><td><input type=radio id='sect4_4' name= 'sect4_4'  value='5/5' checked onclick='sect4()'><font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font>";
$tr .= "<input type=radio id='sect4_4' name= 'sect4_4'  value='0/5' onclick='sect4()'><font face=Arial>No</font></td><td align=center><input class='style8' type=text disabled name='disp_text4' id='disp_text4' value='0/5' size=1></font></td><td align=center ><input type=checkbox name='sect4_na' id='sect4_na' value=1 onclick='sect4()'></font></td>

 <td><p id='show_hide4' style='visibility: hidden'><textarea id='remarks4' name='remarks4' cols=10 rows=5 ></textarea></p></td>";
#----------------------------------------END--------------------------------------------

#**************************** Agent maintained proper formation ***************************************

$tr .= "<tr><td><font face=Arial><b>Capturing Customer's and Property Details</b></font></td></tr>";
$tr .= "<tr><td><input type=radio id='sect5_5' name= 'sect5_5'  value='5/5' checked onclick='sect5()'><font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font>";

$tr .= "<input type=radio id='sect5_5' name= 'sect5_5'  value='0/5' onclick='sect5()'><font face=Arial>No</font></td><td align=center><input class='style8' type=text disabled name='disp_text5' id='disp_text5' value='0/5' size=1></font></td>
<td align=center ><input type=checkbox name='sect5_na' id='sect5_na' value=1 onclick='sect5()'></font></td>

 <td><p id='show_hide5' style='visibility: hidden'><textarea id='remarks5' name='remarks5' cols=10 rows=5 ></textarea></p></td>";
#----------------------------------------END--------------------------------------------

#**************************** asertive, polite and professional on Call ***************************************

$tr .= "<tr><td><font face=Arial><b> Confirming Call Back date and time </b></font></td></tr>";
$tr .= "<tr><td><input type=radio id='sect6_6' name= 'sect6_6'  value='5/5' checked onclick='sect6()'><font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font>";
$tr .= "<input type=radio id='sect6_6' name= 'sect6_6'  value='0/5' onclick='sect6()'><font face=Arial>No</font></td><td align=center><input class='style8' type=text disabled name='disp_text6' id='disp_text6' value='0/5' size=1></font></td><td align=center ><input type=checkbox name='sect6_na' id='sect6_na' value=1 onclick='sect6()'></font></td>

 <td><p id='show_hide6' style='visibility: hidden'><textarea id='remarks6' name='remarks6' cols=10 rows=5 ></textarea></p></td>";
#----------------------------------------END--------------------------------------------

#**************************** The agent used effective active listening skills ***************************************
$tr .="<tr><td align=center><font face=Arial><b><u>Phone Etiquettes</u></b></font></td></tr>";

$tr .= "<tr><td><font face=Arial><b> Framing proper Sentence/  Interruption or talk over the customer</b></font></td></tr>";
$tr .= "<tr><td><input type=radio id='sect7_7' name= 'sect7_7'  value='5/5' checked onclick='sect7()'><font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font>";

$tr .= "<input type=radio id='sect7_7' name= 'sect7_7'  value='0/5' onclick='sect7()'><font face=Arial>Poor</font></td><td align=center><input class='style8' type=text disabled name='disp_text7' id='disp_text7' value='0/5' size=1></font></td><td align=center ><input type=checkbox name='sect7_na' id='sect7_na' value=1 onclick='sect7()'></font></td>

 <td><p id='show_hide7' style='visibility: hidden'><textarea id='remarks7' name='remarks7' cols=10 rows=5 ></textarea></p></td>";
#----------------------------------------END--------------------------------------------


#****************************The agent was efficient in convincing the customer ***************************************

$tr .= "<tr><td><font face=Arial><b>Tone And Energy/ Asertive/Polite and Professional </b></font></td></tr>";
$tr .= "<tr><td><input type=radio id='sect8_8' name= 'sect8_8'  value='5/5' checked onclick='sect8()'><font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font>";
$tr .= "<input type=radio id='sect8_8' name= 'sect8_8'  value='0/5' onclick='sect8()'><font face=Arial>No</font></td><td align=center><input class='style8' type=text disabled name='disp_text8' id='disp_text8' value='0/5' size=1></font></td><td align=center ><input type=checkbox name='sect8_na' id='sect8_na' value=1 onclick='sect8()'></font></td>

 <td><p id='show_hide8' style='visibility: hidden'><textarea id='remarks8' name='remarks8' cols=10 rows=5 ></textarea></p></td>";
#----------------------------------------END--------------------------------------------



#**************************·	Did the agent address the customer appropriately ***************************************

$tr .= "<tr><td><font face=Arial><b> Followed proper Hold Procedure and Verbiage</b></font></td></tr>";
$tr .= "<tr><td><input type=radio id='sect9_9' name= 'sect9_9'  value='5/5' checked onclick='sect9()'><font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font>";
$tr .= "<input type=radio id='sect9_9' name= 'sect9_9'  value='0/5' onclick='sect9()'><font face=Arial>No</font></td><td align=center><input class='style8' type=text disabled name='disp_text9' id='disp_text9' value='0/5' size=1></font></td>
<td align=center ><input type=checkbox name='sect9_na' id='sect9_na' value=1 onclick='sect9()'></font></td>

<td><p id='show_hide9' style='visibility: hidden'><textarea id='remarks9' name='remarks9' cols=10 rows=5 ></textarea></p></td>";
#----------------------------------------END--------------------------------------------

#**************************·	Did the agent show empathy and sympathy ***************************************
$tr .="<tr><td align=center><font face=Arial><b><u>Rebuttal</u></b></font></td></tr>";

$tr .= "<tr><td><font face=Arial><b>Agent was attentive on call/ Active listening skills</b></font></td></tr>";
$tr .= "<tr><td><input type=radio id='sect10_10' name= 'sect10_10'  value='5/5' checked onclick='sect10()'><font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font>";
$tr .= "<input type=radio id='sect10_10' name= 'sect10_10'  value='0/5' onclick='sect10()'><font face=Arial>No</font></td><td align=center><input class='style8' type=text disabled name='disp_text10' id='disp_text10' value='0/5' size=1></font></td>
<td align=center ><input type=checkbox name='sect10_na' id='sect10_na' value=1 onclick='sect10()'></font></td>

 <td><p id='show_hide10' style='visibility: hidden'><textarea id='remarks10' name='remarks10' cols=10 rows=5 ></textarea></p></td>";

#**************************·	Clarity of speech/Rate of speech (pace) ***************************************

$tr .= "<tr><td><font face=Arial><b>Appropriate rebuttal given/Effective in convincing </b></font></td></tr>";
$tr .= "<tr><td><input type=radio id='sect11_11' name= 'sect11_11'  value='10/10' checked onclick='sect11()'><font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font>";
$tr .= "<input type=radio id='sect11_11' name= 'sect11_11'  value='0/10' onclick='sect11()'><font face=Arial>No</font></td><td align=center><input class='style8' type=text disabled name='disp_text11' id='disp_text11' value='0/5' size=1></font></td><td align=center ><input type=checkbox name='sect11_na' id='sect11_na' value=1 onclick='sect11()'></font></td>

 <td><p id='show_hide11' style='visibility: hidden'><textarea id='remarks11' name='remarks11' cols=10 rows=5 ></textarea></p></td>";
#----------------------------------------END--------------------------------------------

#**************************·Did the agent show frustration or was rude on call***************************************

$tr .= "<tr><td><font face=Arial><b>Agent given proper Acknowledgement/Point by point replies</b></font></td></tr>";
$tr .= "<tr><td><input type=radio id='sect12_12' name= 'sect12_12'  value='5/5' checked onclick='sect12()'><font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font>";
$tr .= "<input type=radio id='sect12_12' name= 'sect12_12'  value='0/5' onclick='sect12()'><font face=Arial>No</font></td><td align=center><input class='style8' type=text disabled name='disp_text12' id='disp_text12' value='0/5' size=1></font></td><td align=center ><input type=checkbox name='sect12_na' id='sect12_na' value=1 onclick='sect12()'></font></td>

<td><p id='show_hide12' style='visibility: hidden'><textarea id='remarks12' name='remarks12' cols=10 rows=5 ></textarea></p></td>";
#----------------------------------------END--------------------------------------------





#****************************Pitched for Sales/Explained the complete product features with examples****************************************
$tr .="<tr><td><font face=Arial><b>Agent adhered to Closing Script</b></font></td></tr>";
$tr .= "<tr><td><input type=radio id='sect13_13' name='sect13_13'  value='5/5' checked onclick='sect13()'><font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font>";
$tr .= "<input type=radio id='sect13_13' name='sect13_13'  value='0/5' onclick='sect13()'><font face=Arial>No&nbsp;&nbsp;&nbsp;</font></td><td align=center><input class='style8' type=text disabled name='disp_text13' id='disp_text13' value='0/5' size=1></font></td><td align=center><input type=checkbox name='sect13_na' id='sect13_na' value=1 onclick='sect13()'></font></td>

 <td><p id='show_hide13' style='visibility: hidden'><textarea id='remarks13' name='remarks13' cols=10 rows=5 ></textarea></p></td>";
#----------------------------------------END----------------------------------------


#****************************Explained on GMB & Google Ads Benefits****************************************
$tr .="<tr><td align=center><font face=Arial><b><u>Protocol Compliance</u></b></font></td></tr>";

$tr .="<tr><td><font face=Arial><b>Updated additional information in Sales Force</b></font></td></tr>";
$tr .= "<tr><td><input type=radio id='sect14_14' name='sect14_14'  value='5/5' checked onclick='sect14()'><font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font>";
$tr .= "<input type=radio id='sect14_14' name='sect14_14'  value='0/5' onclick='sect14()'><font face=Arial>No&nbsp;&nbsp;&nbsp;</font></td><td align=center><input class='style8' type=text disabled name='disp1_text14' id='disp1_text14' value='0/5' size=1></font></td><td align=center><input type=checkbox name='sect14_na' id='sect14_na' value=1 onclick='sect14()'></font></td>

 <td><p id='show_hide14' style='visibility: hidden'><textarea id='remarks14' name='remarks14' cols=10 rows=5 ></textarea></p></td>";
#----------------------------------------END----------------------------------------


#****************************Detailed Product Explanation was given to customer****************************************
$tr .="<tr><td><font face=Arial><b>Capturing Meeting Type, Date, Time & Venue (only MS leads)/Re-Confirming the details</b></font></td></tr>";
$tr .= "<tr><td><input type=radio id='sect15_15' name='sect15_15'  value='10/10' checked onclick='sect15()'><font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font>";
$tr .= "<input type=radio id='sect15_15' name='sect15_15'  value='0/10' onclick='sect15()'><font face=Arial>No&nbsp;&nbsp;&nbsp;</font></td><td align=center><input class='style8' type=text disabled name='disp1_text15' id='disp1_text15' value='0/10' size=1></font></td>
<td align=center><input type=checkbox name='sect15_na' id='sect15_na' value=1 onclick='sect15()'></font></td>
 <td><p id='show_hide15' style='visibility: hidden'><textarea id='remarks15' name='remarks15' cols=10 rows=5 ></textarea></p></td>";


$tr .="<tr><td><font face=Arial><b>Agent checked on Customer Requirements/Budget and quoted correct price</b></font></td></tr>";
$tr .= "<tr><td><input type=radio id='sect16_16' name='sect16_16'  value='5/5' checked onclick='sect16()'><font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font>";
$tr .= "<input type=radio id='sect16_16' name='sect16_16'  value='0/5' onclick='sect16()'><font face=Arial>No&nbsp;&nbsp;&nbsp;</font></td><td align=center><input class='style8' type=text disabled name='disp1_text16' id='disp1_text16' value='0/5' size=1></font></td>
<td align=center><input type=checkbox name='sect16_na' id='sect16_na' value=1 onclick='sect16()'></font></td>
 <td><p id='show_hide16' style='visibility: hidden'><textarea id='remarks16' name='remarks16' cols=10 rows=5 ></textarea></p></td>";


$tr .="<tr><td><font face=Arial><b>Agent checked on Floor plan/ complete property details like (Project name,  address, Possession status)</b></font></td></tr>";
$tr .= "<tr><td><input type=radio id='sect17_17' name='sect17_17'  value='5/5' checked onclick='sect17()'><font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font>";
$tr .= "<input type=radio id='sect17_17' name='sect17_17'  value='0/5' onclick='sect17()'><font face=Arial>No&nbsp;&nbsp;&nbsp;</font></td><td align=center><input class='style8' type=text disabled name='disp1_text17' id='disp1_text17' value='0/5' size=1></font></td>
<td align=center><input type=checkbox name='sect17_na' id='sect17_na' value=1 onclick='sect17()'></font></td>
 <td><p id='show_hide17' style='visibility: hidden'><textarea id='remarks17' name='remarks17' cols=10 rows=5 ></textarea></p></td>";



$tr .="<tr><td><font face=Arial><b>Accurate Disposition in SF & BSS</b></font></td></tr>";
$tr .= "<tr><td><input type=radio id='sect18_18' name='sect18_18'  value='5/5' checked onclick='sect18()'><font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font>";
$tr .= "<input type=radio id='sect18_18' name='sect18_18'  value='0/5' onclick='sect18()'><font face=Arial>No&nbsp;&nbsp;&nbsp;</font></td><td align=center><input class='style8' type=text disabled name='disp1_text18' id='disp1_text18' value='0/5' size=1></font></td>
<td align=center><input type=checkbox name='sect18_na' id='sect18_na' value=1 onclick='sect18()'></font></td>
 <td><p id='show_hide18' style='visibility: hidden'><textarea id='remarks18' name='remarks18' cols=10 rows=5 ></textarea></p></td>";



$tr .="<tr>
		<td><font face=Arial>&nbsp;<b>Call Observation</b></font></td>
		<td><textarea id='evaluator_comment' name='evaluator_comment' cols=25 rows=3 ></textarea></td>
		</tr>";		
		
		$tr .="<tr>
		<td><font face=Arial>&nbsp;<b>Area Of Improvement</b></font></td>
		<td><textarea id='area_of_improvement' name='area_of_improvement' cols=25 rows=3 ></textarea></td>
		</tr>";		
		
$tr .="<tr>
		<td><font face=Arial>&nbsp;<b>Briefing Required</b></font></td>
		<td>
			<input type='radio' name='Briefing_required' id='Briefing_required' value=1>Yes
			<input type='radio' name='Briefing_required' id='Briefing_required' value=2>No
		</td>
		</tr>";	
		
		
		$tr .="<tr>
		<td><font face=Arial>&nbsp;<b>Updated Disposition in BSS</b></font></td>
		<td>
			<input type='radio' name='updated_disposition' id='updated_disposition' value=1>Yes
			<input type='radio' name='updated_disposition' id='updated_disposition' value=2>No
		</td>
		</tr>";	

$tr .="<tr>
		<td><font face=Arial>&nbsp;<b>AHT</b></font></td>
		<td>
		
		<font face=Arial><b>Hour</b></font>&nbsp;<input type=number name='hours' id='hours' style='width:50px'>
	        <font face=Arial><b>min</b></font>&nbsp;<input type=number name='min' id='min'  style='width:50px'>
		</td>
		</tr>";	

$tr .="<tr><br><br><br><br><td align=center colspan=3><font face=Arial><b><u>Mark Fatal Anyway</u></b></font></td></tr>";
$tr .= "<tr ><td align = center colspan=3><input type=checkbox name='check_12' id='check_12' value=1  onclick='sectFatal()' ><font face=Arial>Mark As Fatal</font></td></tr>";
$tr .= "<tr ><td align = center colspan=3><select name='fatal_reason' id='fatal_reason' class='hide'><option value='None'>None</option><option value='Incorrect/Wrong information'>Incorrect/Wrong information</option><option value='Incomplete Information'>Incomplete Information</option><option value='Inccorect Disposition/Tagging'>Inccorect Disposition/Tagging</option><option value='Rude secastic in the call'>Rude secastic in the call</option><option value='Agent Disconnection'>Agent Disconnection</option></select></td></tr>";

$tr .="<tr><td align=center colspan=3><font face=Arial><b><u>Score</u></b></font></td></tr>";

#$tr .= "<tr><td><table><tr><td><font face=Arial><b>(11)Mark Call Fatal Anyway</b></font></td></tr><tr><td><textarea id='mk_fatal_anyway' name='mk_fatal_anyway' rows='3' cols='40' style='visibility: hidden'></textarea></td></tr></table>";
$val=0;

#$tr .= "<tr><td colspan=3><font face=Arial><b>Note:</b> In this section, points (a) and (c) need to be adhered else it would lead to a Critical Fault & the score of the entire transaction would be marked '0'</font></td></tr>";

$tr .= "<tr><td align=center colspan=3><font face=Arial><b>Total Score&nbsp;&nbsp;&nbsp;&nbsp;<input class='style8' type=text disabled name='lbl_total' id='lbl_total' size=1><b> outof</b><input class='style8' type=text disabled name='outof' id='outof' size=1></font></tr>";
$tr .= "<tr><td align=center colspan=3><font face=Arial><b>Total Percentage&nbsp;&nbsp;&nbsp;&nbsp;<input class='style8' type=text disabled name='lbl_perc' id='lbl_perc' size=1></b></font></tr>";

#$tr .= "<tr><td align=center><font face=Arial><b>Total&nbsp;&nbsp;===>&nbsp;&nbsp;<p name='lbl_perc' id='lbl_perc' ></p></b></font></tr>";





for($x=0; $x<=200; $x++)
{
	 $hrs = $hrs . "<option value=$x>".$x."</option>\n";
}

for($y=0; $y<=200; $y++)
{
	 $first_hours = $first_hours . "<option value=$y>".$y."</option>\n";
}

# print "Content-type: text/html;\n\n";


#########################################################
$RE="select Call_Stage from DailyHuntCallDisposition where Call_Stage not in('New','') group by Call_Stage";
# print $RE."<br>";
$ph1 = $db->prepare($RE);
$ph1->execute();
$ph1->bind_columns(\$Call_Stage);
while($resph1=$ph1->fetchrow_array)
{
	push @Call_Stage, $Call_Stage;
	
	
}
$module_len = @Call_Stage;
for($x=0; $x<=$module_len-1; $x++)
{

	
	 $cmb_eval = $cmb_eval . "<option value='$Call_Stage[$x]'>".$Call_Stage[$x]."</option>\n";
}


print "Content-type: text/html;\n\n";
print <<HTMLEND;

<HTML><HEAD><TITLE>DailyHunt Evaluation</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<STYLE type=text/css>
TABLE {
FONT-SIZE: 12px; COLOR: #000000; FONT-FAMILY: Arial, Helvetica, sans-serif
}
BODY {
MARGIN-TOP: 0px; SCROLLBAR-FACE-COLOR: #ffdfa0; BACKGROUND-IMAGE: url(/tantia/images/bg1.gif); MARGIN-LEFT: 0px; SCROLLBAR-ARROW-COLOR: #cc0000
}
.style6 {
 BORDER-RIGHT: #ffcc00 1px outset; BORDER-TOP: #ffcc00 1px outset; FONT-WEIGHT: bold; FONT-SIZE: 10px; BORDER-LEFT: #ffcc00 1px outset; COLOR: #cc0000; BORDER-BOTTOM: #ffcc00 1px outset; FONT-FAMILY: verdana, Helvetica, sans-serif; BACKGROUND-COLOR: #ffdfa0
}
.style7 {
 font-family: Verdana, Arial, Helvetica, sans-serif;
 font-size: 14px;

 text-align: right; 
 width: 425px; 
 padding-right: 0px; 
}
.style8 {
 font-family: Arial, Helvetica, sans-serif;
 font-weight:bold;
}
.style9 {font-family: Verdana, Arial, Helvetica, sans-serif}
.style19 {
 color: #FFFFFF;
 font-weight: bold;
}
.style20 {
 font-family: Verdana, Arial, Helvetica, sans-serif;
 font-weight: bold;
 text-align: left;


}
.no-border {
  border: none; /* Remove the border */
  outline: none; /* Remove the outline */
  /* Additional styling (optional) */
  background-color: transparent; /* Make background transparent */
}

</STYLE>
</head>
<script type="text/javascript">

var overall = 0;

var overall_1   = 0;
var overall_2  = 0;
var overall_3  = 0;
var overall_4  = 0;
var overall_5  = 0;
var overall_6  = 0;
var overall_7  = 0;
var overall_8  = 0;
var overall_9  = 0;
var overall_10  = 0;
var overall_11  = 0;
var overall_12 = 0;
var overall_13 = 0;
var overall_14 = 0;
var overall_15 = 0;
var overall_16 = 0;
var overall_17 = 0;
var overall_18 = 0;



var overall_1a   = 0;
var overall_2a = 0;
var overall_3a  = 0;
var overall_4a  = 0;
var overall_5a  = 0;
var overall_6a  = 0;
var overall_7a  = 0;
var overall_8a  = 0;
var overall_9a  = 0;
var overall_10a  = 0;
var overall_11a  = 0;
var overall_12a = 0;

var overall_151=0;

var min_1 = 0;
var min_flag1= 0;

//*************OPENING OF CALL***********************
function sect1()
{
	if(document.getElementsByName('sect1_1')[0].checked == true)
	{
		var dd = document.getElementsByName('sect1_1')[0].value;
		document.getElementById('disp_text1').setAttribute("value",dd); 
		document.getElementById('sect1_hidden').value = 5;
	}
	if(document.getElementsByName('sect1_1')[1].checked == true)
	{
		var dd = document.getElementsByName('sect1_1')[1].value;
		document.getElementById('disp_text1').setAttribute("value",dd); 
		document.getElementById('sect1_hidden').value = 0;
	}
	
	
	
	if(document.getElementsByName('sect1_na')[0].checked == true)
	{		    
			document.getElementById('disp_text1').setAttribute("value","0");
			document.getElementById('sect1_hidden').value = 'NA';
			document.getElementById('sect1_na').value = 1;
			document.getElementById("sect1_na").disabled = true;
			overall_1 = 5;

 
			document.getElementById('show_hide1').style.visibility="visible";
	}	
	
	
	
	sectTotal();
}

//************** End of opening of call**************************



//**************  The agent identified him/herself, Company brand,confirmed right party and Business**************************


function sect2()
{
	if(document.getElementsByName('sect2_2')[0].checked == true)
	{
		var dd = document.getElementsByName('sect2_2')[0].value;
		document.getElementById('disp_text2').setAttribute("value",dd); 
		document.getElementById('sect2_hidden').value = 5;
	}
	if(document.getElementsByName('sect2_2')[1].checked == true)
	{
		var dd = document.getElementsByName('sect2_2')[1].value;
		document.getElementById('disp_text2').setAttribute("value",dd); 
		document.getElementById('sect2_hidden').value = 0;
	}
	
	if(document.getElementsByName('sect2_na')[0].checked == true)
	{		    
			document.getElementById('disp_text2').setAttribute("value","0");
			document.getElementById('sect2_hidden').value = 'NA';
			document.getElementById('sect2_na').value = 1;
			document.getElementById("sect2_na").disabled = true;
			overall_2 = 5;

			document.getElementById('show_hide2').style.visibility="visible";
	}	
	
	sectTotal();
}




//********************************  END sect2()  ************************

//********************************   Seek Permission/ Purpose of the call  ************************

function sect3()
{
	if(document.getElementsByName('sect3_3')[0].checked == true)
	{
		var ss = document.getElementsByName('sect3_3')[0].value;
		document.getElementById('disp_text3').setAttribute("value",ss); 
		document.getElementById('sect3_hidden').value = 5;
	}
	if(document.getElementsByName('sect3_3')[1].checked == true)
	{
		var ss = document.getElementsByName('sect3_3')[1].value;
		document.getElementById('disp_text3').setAttribute("value",ss); 
		document.getElementById('sect3_hidden').value = 0;
	}
	
	if(document.getElementsByName('sect3_na')[0].checked == true)
	{		    
			document.getElementById('disp_text3').setAttribute("value","0");
			document.getElementById('sect3_hidden').value = 'NA';
			document.getElementById('sect3_na').value = 1;
			document.getElementById("sect3_na").disabled = true;
			overall_3 = 5;

			document.getElementById('show_hide3').style.visibility = "visible";
	}	
	
	sectTotal();
}

//******************************** END sect3() *********************************************

//*****************************Tone And Energy (Sound excited and active on calls)************************************

function sect4()
{
	if(document.getElementsByName('sect4_4')[0].checked == true)
	{
		var fg = document.getElementsByName('sect4_4')[0].value;
		document.getElementById('disp_text4').setAttribute("value",fg); 
		document.getElementById('sect4_hidden').value = 5;
	}
	if(document.getElementsByName('sect4_4')[1].checked == true)
	{
		var fg = document.getElementsByName('sect4_4')[1].value;
		document.getElementById('disp_text4').setAttribute("value",fg); 
		document.getElementById('sect4_hidden').value = 0;
	}
	
	if(document.getElementsByName('sect4_na')[0].checked == true)
	{		    
			document.getElementById('disp_text4').setAttribute("value","0");
			document.getElementById('sect4_hidden').value = 'NA';
			document.getElementById('sect4_na').value = 1;
			document.getElementById("sect4_na").disabled = true;
			overall_4 = 5;

             

		document.getElementById('show_hide4').style.visibility = "visible";
	}	
	
	sectTotal();
}

//******************************** END sect4() *********************************************


//******************************** The agent maintained proper Sentenece formation/ Did the agent interupt or talk over the customer *********************************************

function sect5() 
{
	if(document.getElementsByName('sect5_5')[0].checked == true)
	{
		var fg = document.getElementsByName('sect5_5')[0].value;
		document.getElementById('disp_text5').setAttribute("value",fg); 
		document.getElementById('sect5_hidden').value = 5;
	}
	if(document.getElementsByName('sect5_5')[1].checked == true)
	{
		var fg = document.getElementsByName('sect5_5')[1].value;
		document.getElementById('disp_text5').setAttribute("value",fg); 
		document.getElementById('sect5_hidden').value = 0;
	}
	
	
	if(document.getElementsByName('sect5_na')[0].checked == true)
	{		    
			document.getElementById('disp_text5').setAttribute("value","0");
			document.getElementById('sect5_hidden').value = 'NA';
			document.getElementById('sect5_na').value = 1;
			document.getElementById("sect5_na").disabled = true;
			overall_5 = 5;

			document.getElementById('show_hide5').style.visibility = "visible";
	}	
	
	sectTotal();
	
}
//********************************  END sect5()  ************************

//********************************   The agent was asertive, polite and professional on Call  ************************

function sect6()
{
	if(document.getElementsByName('sect6_6')[0].checked == true)
	{
		var fg = document.getElementsByName('sect6_6')[0].value;
		document.getElementById('disp_text6').setAttribute("value",fg); 
		document.getElementById('sect6_hidden').value=5;
		document.getElementById('sect6_na').value = 0;
    }
	if(document.getElementsByName('sect6_6')[1].checked == true)
	{
		var fg = document.getElementsByName('sect6_6')[1].value;
		document.getElementById('disp_text6').setAttribute("value",fg); 
		document.getElementById('sect6_hidden').value = 0;
		document.getElementById('sect6_na').value = 0;
	}

	
	if(document.getElementsByName('sect6_na')[0].checked == true)
	{
			document.getElementById('disp_text6').setAttribute("value","0");
			document.getElementById('sect6_hidden').value = 'NA';
			document.getElementById('sect6_na').value = 1;
			document.getElementById("sect6_na").disabled = true;
			overall_6 = 5;

			document.getElementById('show_hide6').style.visibility = "visible";
	}
	sectTotal();
}

//********************************  END sect6()  ************************


//********************************  The agent used effective active listening skills  ************************
function sect7()
{
	if(document.getElementsByName('sect7_7')[0].checked == true)
	{
		var kk = document.getElementsByName('sect7_7')[0].value;
		document.getElementById('disp_text7').setAttribute("value",kk); 
		document.getElementById('sect7_hidden').value=5;
		document.getElementById('sect7_na').value = 0;
    }
	if(document.getElementsByName('sect7_7')[1].checked == true)
	{
		var kk = document.getElementsByName('sect7_7')[1].value;
		document.getElementById('disp_text7').setAttribute("value",kk); 
		document.getElementById('sect7_hidden').value = 0;
		document.getElementById('sect7_na').value = 0;
	}
	
	


	if(document.getElementsByName('sect7_na')[0].checked == true)
	{
			document.getElementById('disp_text7').setAttribute("value","0");
			document.getElementById('sect7_hidden').value = 'NA';
			document.getElementById('sect7_na').value = 1;
			document.getElementById("sect7_na").disabled = true;
			overall_7 = 5;

			document.getElementById('show_hide7').style.visibility = "visible";
	}
	sectTotal();
}

//********************************  END sect7()  ************************

//********************************  sect8()  ************************
function sect8()
{
	if(document.getElementsByName('sect8_8')[0].checked == true)
	{
		var gh = document.getElementsByName('sect8_8')[0].value;
		document.getElementById('disp_text8').setAttribute("value",gh); 
		document.getElementById('sect8_hidden').value=5;
		document.getElementById('sect8_na').value = 0;
    }
	if(document.getElementsByName('sect8_8')[1].checked == true)
	{
		var gh = document.getElementsByName('sect8_8')[1].value;
		document.getElementById('disp_text8').setAttribute("value",gh); 
		document.getElementById('sect8_hidden').value = 0;
		document.getElementById('sect8_na').value = 0;
	}

	


	
	if(document.getElementsByName('sect8_na')[0].checked == true)
	{
			document.getElementById('disp_text8').setAttribute("value","0");
			document.getElementById('sect8_hidden').value = 'NA';
			document.getElementById('sect8_na').value = 1;
			document.getElementById("sect8_na").disabled = true;
			overall_8 = 5;

			document.getElementById('show_hide8').style.visibility = "visible";
	}
	sectTotal();
}

//********************************  END sect8()  ************************

//********************************  END sect9()  ************************




function sect9()
{
	if(document.getElementsByName('sect9_9')[0].checked == true)
	{
		var ad = document.getElementsByName('sect9_9')[0].value;
		document.getElementById('disp_text9').setAttribute("value",ad); 
		document.getElementById('sect9_hidden').value = 5;
	}
	if(document.getElementsByName('sect9_9')[1].checked == true)
	{
		var ad = document.getElementsByName('sect9_9')[1].value;
		document.getElementById('disp_text9').setAttribute("value",ad); 
		document.getElementById('sect9_hidden').value = 0;
	}
	
	
	if(document.getElementsByName('sect9_na')[0].checked == true)
	{		    
			document.getElementById('disp_text9').setAttribute("value","0");
			document.getElementById('sect9_hidden').value = 'NA';
			document.getElementById('sect9_na').value = 1;
			document.getElementById("sect9_na").disabled = true;
			overall_9 = 5;

			document.getElementById('show_hide9').style.visibility = "visible";
	}	
	
	sectTotal();
}


//********************************  END sect9()  ************************

//********************************   sect10()  ************************

function sect10()
{

	if(document.getElementsByName('sect10_10')[0].checked == true)
	{
		var ad = document.getElementsByName('sect10_10')[0].value;
		document.getElementById('disp_text10').setAttribute("value",ad); 
		document.getElementById('sect10_hidden').value = 5;
	}
	if(document.getElementsByName('sect10_10')[1].checked == true)
	{
		var ad = document.getElementsByName('sect10_10')[1].value;
		document.getElementById('disp_text10').setAttribute("value",ad); 
		document.getElementById('sect10_hidden').value = 0;
	}
	
	if(document.getElementsByName('sect10_na')[0].checked == true)
	{		    
			document.getElementById('disp_text10').setAttribute("value","0");
			document.getElementById('sect10_hidden').value = 'NA';
			document.getElementById('sect10_na').value = 1;
			document.getElementById("sect10_na").disabled = true;
			overall_10 = 5;

			document.getElementById('show_hide10').style.visibility = "visible";
	}	
	
	sectTotal();
}
//********************************  END sect10()  ************************

//********************************  sect11()  ************************
function sect11()
{

	if(document.getElementsByName('sect11_11')[0].checked == true)
	{
		var qw = document.getElementsByName('sect11_11')[0].value;
		document.getElementById('disp_text11').setAttribute("value",qw); 
		document.getElementById('sect11_hidden').value=10;
		document.getElementById('sect11_na').value = 0;

	

    }
	if(document.getElementsByName('sect11_11')[1].checked == true)
	{
		var qw = document.getElementsByName('sect11_11')[1].value;
		document.getElementById('disp_text11').setAttribute("value",qw); 
		document.getElementById('sect11_hidden').value = 0;
		document.getElementById('sect11_na').value = 0;
	
	}
	
	if(document.getElementsByName('sect11_na')[0].checked == true)
	{
		document.getElementById('disp_text11').setAttribute("value","0");
		document.getElementById('sect11_hidden').value = 'NA';
		document.getElementById('sect11_na').value = 1;

		document.getElementById("sect11_na").disabled = true;
		overall_11 = 10;

		document.getElementById('show_hide11').style.visibility = "visible";
	}

	sectTotal();
}
//********************************  END sect11()  ************************

//********************************  sect12()  ************************
function sect12()
{

	if(document.getElementsByName('sect12_12')[0].checked == true)
	{
		var qw = document.getElementsByName('sect12_12')[0].value;
		document.getElementById('disp_text12').setAttribute("value",qw); 
		document.getElementById('sect12_hidden').value=5;
		document.getElementById('sect12_na').value = 0;

	

    }
	if(document.getElementsByName('sect12_12')[1].checked == true)
	{
		var qw = document.getElementsByName('sect12_12')[1].value;
		document.getElementById('disp_text12').setAttribute("value",qw); 
		document.getElementById('sect12_hidden').value = 0;
		document.getElementById('sect12_na').value = 0;
	
	}
	
	if(document.getElementsByName('sect12_na')[0].checked == true)
	{
		document.getElementById('disp_text12').setAttribute("value","0");
		document.getElementById('sect12_hidden').value = 'NA';
		document.getElementById('sect12_na').value = 1;

		document.getElementById("sect12_na").disabled = true;
		overall_12 = 5;

		document.getElementById('show_hide12').style.visibility = "visible";
	}

	sectTotal();
}
//********************************  END sect12()  ************************




function sect13()
{
	//alert("Hello");
	if(document.getElementsByName('sect13_13')[0].checked == true)
	{
		//alert("sdfsd");
		var qw = document.getElementsByName('sect13_13')[0].value;
		//alert(qw);
		document.getElementById('disp_text13').setAttribute("value",qw); 
		document.getElementById('sect13_hidden').value=5;
		document.getElementById('sect13_na').value = 0;

	

    }
	if(document.getElementsByName('sect13_13')[1].checked == true)
	{
		var qw = document.getElementsByName('sect13_13')[1].value;
		document.getElementById('disp_text13').setAttribute("value",qw); 
		document.getElementById('sect13_hidden').value = 0;
		document.getElementById('sect13_na').value = 0;
	
	}
	if(document.getElementsByName('sect13_na')[0].checked == true)
	{
		document.getElementById('disp_text13').setAttribute("value","0");
		document.getElementById('sect13_hidden').value = 'NA';
		document.getElementById('sect13_na').value = 1;

		document.getElementById("sect13_na").disabled = true;
		overall_13 = 5;

		document.getElementById('show_hide13').style.visibility = "visible";
	}

	sectTotal();
}
//*****************************End sect13************************************


function sect14()
{

	if(document.getElementsByName('sect14_14')[0].checked == true)
	{
		var sd = document.getElementsByName('sect14_14')[0].value;
		document.getElementById('disp1_text14').setAttribute("value",sd); 
		document.getElementById('sect14_hidden').value=5;
		document.getElementById('sect14_na').value = 0;
    }
	if(document.getElementsByName('sect14_14')[1].checked == true)
	{
		var sd = document.getElementsByName('sect14_14')[1].value;
		document.getElementById('disp1_text14').setAttribute("value",sd); 
		document.getElementById('sect14_hidden').value = 0;
		document.getElementById('sect14_na').value = 0;
	}
	if(document.getElementsByName('sect14_na')[0].checked == true)
	{
		document.getElementById('disp1_text14').setAttribute("value","0");;
		document.getElementById('sect14_hidden').value = 'NA';
		document.getElementById("sect14_na").disabled = true;
		overall_14 = 5;

		document.getElementById('show_hide14').style.visibility = "visible";
	}

	sectTotal();
}
//*****************************End sect14************************************

function sect15()
{
	if(document.getElementsByName('sect15_15')[0].checked == true)
	{
		var sd = document.getElementsByName('sect15_15')[0].value;
		document.getElementById('disp1_text15').setAttribute("value",sd); 
		document.getElementById('sect15_hidden').value=10;
		document.getElementById('sect15_na').value = 0;
    }
	if(document.getElementsByName('sect15_15')[1].checked == true)
	{
		var sd = document.getElementsByName('sect15_15')[1].value;
		document.getElementById('disp1_text15').setAttribute("value",sd); 
		document.getElementById('sect15_hidden').value = 0;
		document.getElementById('sect15_na').value = 0;
	}
	
	
	if(document.getElementsByName('sect15_na')[0].checked == true)
	{
		document.getElementById('disp1_text15').setAttribute("value","0");;
		document.getElementById('sect15_hidden').value = 'NA';
		document.getElementById('sect15_na').value = 1;
		document.getElementById("sect15_na").disabled = true;
		overall_15 = 10;

		document.getElementById('show_hide15').style.visibility = "visible";
	}

	sectTotal();
}

//******************************** End  sect15()  ************************



function sect16()
{
	if(document.getElementsByName('sect16_16')[0].checked == true)
	{
		var sd = document.getElementsByName('sect16_16')[0].value;
		document.getElementById('disp1_text16').setAttribute("value",sd); 
		document.getElementById('sect16_hidden').value=5;
		document.getElementById('sect16_na').value = 0;
    }
	if(document.getElementsByName('sect16_16')[1].checked == true)
	{
		var sd = document.getElementsByName('sect16_16')[1].value;
		document.getElementById('disp1_text16').setAttribute("value",sd); 
		document.getElementById('sect16_hidden').value = 0;
		document.getElementById('sect16_na').value = 0;
	}
	
	
	if(document.getElementsByName('sect16_na')[0].checked == true)
	{
		document.getElementById('disp1_text16').setAttribute("value","0");;
		document.getElementById('sect16_hidden').value = 'NA';
		document.getElementById('sect16_na').value = 1;
		document.getElementById("sect16_na").disabled = true;
		overall_16 = 5;

		document.getElementById('show_hide16').style.visibility = "visible";
	}

	sectTotal();
}

function sect17()
{
	if(document.getElementsByName('sect17_17')[0].checked == true)
	{
		var sd = document.getElementsByName('sect17_17')[0].value;
		document.getElementById('disp1_text17').setAttribute("value",sd); 
		document.getElementById('sect17_hidden').value=5;
		document.getElementById('sect17_na').value = 0;
    }
	if(document.getElementsByName('sect17_17')[1].checked == true)
	{
		var sd = document.getElementsByName('sect17_17')[1].value;
		document.getElementById('disp1_text17').setAttribute("value",sd); 
		document.getElementById('sect17_hidden').value = 0;
		document.getElementById('sect17_na').value = 0;
	}
	
	
	if(document.getElementsByName('sect17_na')[0].checked == true)
	{
		document.getElementById('disp1_text17').setAttribute("value","0");;
		document.getElementById('sect17_hidden').value = 'NA';
		document.getElementById('sect17_na').value = 1;
		document.getElementById("sect17_na").disabled = true;
		overall_17 = 5;

		document.getElementById('show_hide17').style.visibility = "visible";
	}

	sectTotal();
}

function sect18()
{
	if(document.getElementsByName('sect18_18')[0].checked == true)
	{
		var sd = document.getElementsByName('sect18_18')[0].value;
		document.getElementById('disp1_text18').setAttribute("value",sd); 
		document.getElementById('sect18_hidden').value=5;
		document.getElementById('sect18_na').value = 0;
    }
	if(document.getElementsByName('sect18_18')[1].checked == true)
	{
		var sd = document.getElementsByName('sect18_18')[1].value;
		document.getElementById('disp1_text18').setAttribute("value",sd); 
		document.getElementById('sect18_hidden').value = 0;
		document.getElementById('sect18_na').value = 0;
	}
	
	
	if(document.getElementsByName('sect18_na')[0].checked == true)
	{
		document.getElementById('disp1_text18').setAttribute("value","0");;
		document.getElementById('sect18_hidden').value = 'NA';
		document.getElementById('sect18_na').value = 1;
		document.getElementById("sect18_na").disabled = true;
		overall_18 = 5;

		document.getElementById('show_hide18').style.visibility = "visible";
	}

	sectTotal();
}


function sectFatal()
{

	if(document.getElementsByName('check_12')[0].checked == true )
	{
		//	alert("Hello");
	    document.getElementById('disp_text1').setAttribute("value","0/5");
	    document.getElementById('disp_text2').setAttribute("value","0/5");
	    document.getElementById('disp_text3').setAttribute("value","0/5");
	    document.getElementById('disp_text4').setAttribute("value","0/5");
	    document.getElementById('disp_text5').setAttribute("value","0/5");
		document.getElementById('disp_text6').setAttribute("value","0/5");
		document.getElementById('disp_text7').setAttribute("value","0/5");
	    document.getElementById('disp_text8').setAttribute("value","0/5");
		document.getElementById('disp_text9').setAttribute("value","0/5");
		document.getElementById('disp_text10').setAttribute("value","0/5");
		document.getElementById('disp_text11').setAttribute("value","0/10");
		document.getElementById('disp_text12').setAttribute("value","0/5");
		
		//alert("jkhj");
		document.getElementById('disp_text13').setAttribute("value","0/5");
		document.getElementById('disp1_text14').setAttribute("value","0/5");
		document.getElementById('disp1_text15').setAttribute("value","0/10");
		document.getElementById('disp1_text16').setAttribute("value","0/5");
		document.getElementById('disp1_text17').setAttribute("value","0/5");
		document.getElementById('disp1_text18').setAttribute("value","0/5");
		
		
	


	    document.getElementsByName('sect1_1')[0].checked = false;
	    document.getElementsByName('sect1_1')[1].checked = false;
	
		document.getElementsByName('sect2_2')[0].checked = false;
	    document.getElementsByName('sect2_2')[1].checked = false;
	

		document.getElementsByName('sect3_3')[0].checked = false;
		document.getElementsByName('sect3_3')[1].checked = false;
		
	    document.getElementsByName('sect4_4')[0].checked = false;
	    document.getElementsByName('sect4_4')[1].checked = false;
	  
		document.getElementsByName('sect5_5')[0].checked = false;
	    document.getElementsByName('sect5_5')[1].checked = false;
	   
	   



		document.getElementsByName('sect6_6')[0].checked = false;
		document.getElementsByName('sect6_6')[1].checked = false;
		
		
		document.getElementsByName('sect7_7')[0].checked = false;
		document.getElementsByName('sect7_7')[1].checked = false;
		
		document.getElementsByName('sect8_8')[0].checked = false;
		document.getElementsByName('sect8_8')[1].checked = false;
		

		document.getElementsByName('sect9_9')[0].checked = false;
		document.getElementsByName('sect9_9')[1].checked = false;
		
		document.getElementsByName('sect10_10')[0].checked = false;
		document.getElementsByName('sect10_10')[1].checked = false;

		document.getElementsByName('sect11_11')[0].checked = false;
		document.getElementsByName('sect11_11')[1].checked = false;
	

		document.getElementsByName('sect12_12')[0].checked = false;
		document.getElementsByName('sect12_12')[1].checked = false;

		document.getElementsByName('sect13_13')[0].checked = false;
		document.getElementsByName('sect13_13')[1].checked = false;
		
		document.getElementsByName('sect14_14')[0].checked = false;
		document.getElementsByName('sect14_14')[1].checked = false;
		
		document.getElementsByName('sect15_15')[0].checked = false;
		document.getElementsByName('sect15_15')[1].checked = false;
		
		
		document.getElementsByName('sect16_16')[0].checked = false;
		document.getElementsByName('sect16_16')[1].checked = false;
		
		document.getElementsByName('sect17_17')[0].checked = false;
		document.getElementsByName('sect17_17')[1].checked = false;
		
		document.getElementsByName('sect18_18')[0].checked = false;
		document.getElementsByName('sect18_18')[1].checked = false;
		
	

			document.getElementById('sect1_hidden').value=0;
			document.getElementById('sect2_hidden').value=0;
			document.getElementById('sect3_hidden').value=0;
			document.getElementById('sect4_hidden').value=0;
			document.getElementById('sect5_hidden').value=0;
			document.getElementById('sect6_hidden').value=0;
			document.getElementById('sect7_hidden').value=0;
			document.getElementById('sect8_hidden').value=0;
			document.getElementById('sect9_hidden').value=0;
			document.getElementById('sect10_hidden').value=0;
			document.getElementById('sect11_hidden').value=0;
			
			document.getElementById('sect12_hidden').value=0;
			document.getElementById('sect13_hidden').value=0;
			document.getElementById('sect14_hidden').value=0;
			document.getElementById('sect15_hidden').value=0;
			document.getElementById('sect16_hidden').value=0;
			document.getElementById('sect17_hidden').value=0;
			document.getElementById('sect18_hidden').value=0;
		
		
		total_sect = 0;
		perc = 0;
		var overall=0;
		//alert(total_sect);
		document.getElementById('lbl_total').setAttribute("value",total_sect);
		document.getElementById('lbl_perc').setAttribute("value",perc);
		document.getElementById('outof').setAttribute("value",overall);
		
		document.getElementById('overall_totScore').value = total_sect;
		document.getElementById('overall_percentage').value = perc;
		
   document.getElementById('sect25_hidden').setAttribute("value","1");

		var select = document.getElementById('fatal_reason');
		select.className = 'show';
		
		document.getElementById('overall_hidden').setAttribute("value","100");
	}
	else
	{
		var select = document.getElementById('fatal_reason');
		select.className = 'hide';
		document.getElementById('sect25_hidden').setAttribute("value","0");
		
	}
        
		
}


function sectTotal()
{
	document.getElementById('lbl_total').setAttribute("value","");
	//document.getElementById('sect9_hidden').value = "";

	var sect_1= 0;
	
	var sect_1 = parseInt(document.getElementById('sect1_hidden').value);
	
	if(!(sect_1 >= 0))
	{
		var sect_1= 0;
	}
	
	var sect_2 = parseInt(document.getElementById('sect2_hidden').value);

	if(!(sect_2 >= 0))
	{
		var sect_2= 0;
	}

	var sect_3 = parseInt(document.getElementById('sect3_hidden').value);

	if(!(sect_3 >= 0))
	{
		var sect_3= 0;
	}

	var sect_4 = parseInt(document.getElementById('sect4_hidden').value);

	if(!(sect_4 >= 0))
	{
		var sect_4 = 0;
	}



	var sect_5 = parseInt(document.getElementById('sect5_hidden').value);

	if(!(sect_5 >= 0))
	{
		var sect_5 = 0;
	}

	var sect_6 = parseInt(document.getElementById('sect6_hidden').value);

	if(!(sect_6 >= 0))
	{
		var sect_6 = 0;
	}

	var sect_7 = parseInt(document.getElementById('sect7_hidden').value);

	if(!(sect_7 >= 0))
	{
		var sect_7= 0;
	}	

	var sect_8 = parseInt(document.getElementById('sect8_hidden').value);

	if(!(sect_8 >= 0))
	{
		var sect_8= 0;
	}

	var sect_9 = parseInt(document.getElementById('sect9_hidden').value);

	if(!(sect_9 >= 0))
	{
		var sect_9= 0;
	}


	var sect_10 = parseInt(document.getElementById('sect10_hidden').value);
	if(!(sect_10 >= 0))
	{
		var sect_10= 0;
	}

	var sect_11 = parseInt(document.getElementById('sect11_hidden').value);
	if(!(sect_11 >= 0))
	{
		var sect_11= 0;
	}
	var sect_12 = parseInt(document.getElementById('sect12_hidden').value);
	if(!(sect_12 >= 0))
	{
		var sect_12= 0;
	}
	var sect_13 = parseInt(document.getElementById('sect13_hidden').value);
	if(!(sect_13 >= 0))
	{
		var sect_13= 0;
	}
	var sect_14 = parseInt(document.getElementById('sect14_hidden').value);
	if(!(sect_14 >= 0))
	{
		var sect_14= 0;
	}
	var sect_15 = parseInt(document.getElementById('sect15_hidden').value);
	if(!(sect_15 >= 0))
	{
		var sect_15= 0;
	}
	
	var sect_16 = parseInt(document.getElementById('sect16_hidden').value);
	if(!(sect_16 >= 0))
	{
		var sect_16= 0;
	}

var sect_17 = parseInt(document.getElementById('sect17_hidden').value);
	if(!(sect_17 >= 0))
	{
		var sect_17= 0;
	}

var sect_18 = parseInt(document.getElementById('sect18_hidden').value);
	if(!(sect_18 >= 0))
	{
		var sect_18= 0;
	}



	var total_sect = 0;
	var overalla = 0;

	total_sect = sect_1  +sect_2  + sect_3 + sect_4  + sect_5 + sect_6 + sect_7 + sect_8 + sect_9 +  sect_10 +  sect_11 + sect_12 + sect_13 + sect_14 + sect_15 + sect_16 + sect_17 + sect_18;


	overall =  100  - overall_1 - overall_2 - overall_3 - overall_4 - overall_5 - overall_6 - overall_7 - overall_8 - overall_9 - overall_10 - overall_11 - overall_12 - overall_13 - overall_14 - overall_15 - overall_16 - overall_17  - overall_18   ;

	perc = total_sect * 100 / overall;
	perc = Math.round(perc);
                                   

	document.getElementById('lbl_total').setAttribute("value",total_sect);
	document.getElementById('lbl_perc').setAttribute("value",perc);

	document.getElementById('outof').setAttribute("value",overall);

	document.getElementById('overall_hidden').value = overall;
	document.getElementById('overall_totScore').value = total_sect;
	document.getElementById('overall_percentage').value = perc;
}


function unique()
{
	
	if(document.getElementById('customer_phno').value==''){
		alert("Please Enter Customer Number");
		 document.getElementById('customer_phno').focus();
		 return false;
	}
	
	if(document.getElementById('call_type').value=="select"){
		alert("Please Select Call Type");
		 document.getElementById('call_type').focus();
		 return false;
	}
	
	
	
//return true;
    var file = document.getElementById('file').value;
    var user = document.getElementById('user').value;
    var access = document.getElementById('access').value;
    var random = document.getElementById('random').value;
	    var idelement = document.getElementById('idelement').value;

   
	//alert(category);
	document.getElementById('fedt').setAttribute("action",'new_dc_review_insert.pl?file='+file+'&user='+user+'&access='+access+'&random='+random+'&idelement='+idelement+'');
}



</script>


<META content="MSHTML 6.00.2900.2180" name=GENERATOR></HEAD>
<BODY onload='sect1(); sect2(); sect3(); sect4(); sect5();  sect6();  sect7(); sect8(); sect9(); sect10(); sect11(); sect12(); sect13(); sect14(); sect15(); sect16(); sect17(); sect18(); sect19(); sect20(); sect21(); sect22();'>

HTMLEND
require "/var/www/cgi-bin/greettech/menu_body_greettech.pl";
print <<HTMLEND;

<br><br>
<CENTER><table width="64%"  border=0 cellpadding="0" cellspacing="0" bordercolor="#990000"><tr>
<td height="20" bgcolor="#990000"><div align="center" class="style19">DesignCafe TeleCall Review Form</div></td>
</tr>

</table><BR>

<form id='fedt' name='fedt'  method='POST'   onsubmit="return unique();">
<br><h4>$td2</h4>
<br><h4>$td3</h4>
<!-- Ticket and Evaluation Details -->

<fieldset style="width: 1000px; BORDER-COLOR: #E0FFFF;">
<legend align="center"><font color=#7E2217 size=3><b>Review Form<b></font></legend>
<br>
<table border=0 width=900>
<tr>
	<td><font face=Arial><b>Name:&nbsp;</b></font></td><td><font face=Arial>$empl_name&nbsp;</font></td>
	<td><font face=Arial><b>Call Date:&nbsp;</b></font></td>
	<td>&nbsp;<select id ='cmbDay' name='cmbDay' style="width=40">$cmbDay</select>&nbsp;
			<select id ='cmbMonth' name='cmbMonth' style="width=40">$cmbMonth</select>&nbsp;
			<select id ='cmbYear' name='cmbYear' style="width=60">$cmbYear</select></td>
</tr>
<tr>
	<td><font face=Arial><b>EmplNO:&nbsp;</b></font></td>
	<td><font face=Arial>$idelement&nbsp;</font></td>
	 
	 <td>
		<div class='input-group mb-3'>
			<div class='input-group-prepend'>
				<span class='input-group-text'id='basic-addon1'><b>Lead Stage:</b>&nbsp;</span>
			</div>
			<td><select class='form-control' aria-describedby='basic-addon1' name='lead_stage' id='lead_stage'>
				<option value=''>--select--</option> 
				<option value='Meeting Schedule'>Meeting Schedule</option>
				<option value='Follow Up'>Follow Up</option>
				<option value='PQL'>PQL</option>
				<option value='QL'>QL</option>
				<option value='Junk'>Junk</option>
				<option value='CC Error'>CC Error</option>
			</select></td>
		</div>
	</td>
	 
</tr>
<tr>
	
		<td><font face=Arial><b>Feedback Date:&nbsp;</b></font></td><td><input type='text' name='Feed_Back' id='Feed_Back' value='$Feedback_Date'  class='no-border' readonly/></td>	

			<td><font face=Arial><b>Region:&nbsp;</b></font></td>
	<td><font face=Arial><select name='Region' id='Region'>
				<option value=''>--select--</option> 
				<option value='Bangalore'>Bangalore</option>
				<option value='Hyderabad'>Hyderabad</option>
				<option value='Mumbai'>Mumbai</option>
				<option value='Unknown'>Unknown</option>
				<option value='OutStation'>OutStation</option>
				<option value='Chennai'>Chennai</option>
				<option value='Thane'>Thane</option>
				<option value='Pune'>Pune</option>
				<option value='Navi Mumbai'>Navi Mumbai</option>
				<option value='Mysore'>Mysore</option>
				<option value='Visakhapatnam'>Visakhapatnam</option>
				<option value='Coimbatore'>Coimbatore</option>
				<option value='Kolkata'>Kolkata</option>
				<option value='Ahmedabad'>Ahmedabad</option>
				</select></font></td>
</tr>


<tr>
	<td><font face=Arial><b>Customer Phno:&nbsp;</b></font></td>
	<td><font face=Arial><input type=number name='customer_phno' id='customer_phno'></font></td>
	
	<td><font face=Arial><b>Channel:&nbsp;</b></font></td>
	<td><font face=Arial><select name='Channel' id='Channel'>
				<option value=''>--select--</option> 
				<option value='Online'>Online</option>
				<option value='Offline'>Offline</option>
				<option value='Referral'>Referral</option>
				</select></font></td>
	
</tr>
	
	

	
<tr>
	<td><font face=Arial><b>Call Type:&nbsp;</b></font></td>
	<td><font face=Arial><select name='call_type' id='call_type'>
				<option value=''>--select--</option> 
				<option value='Outbound'>Outbound</option>
				<option value='Inbound'>Inbound</option>
				<option value='Manual'>Manual</option>
				</select></font></td>
	
	
</tr>
<tr>
	<td><font face=Arial><b>Source:&nbsp;</b></font></td>
	<td><font face=Arial><input type=text name='source' id='source'></font></td>

	
</tr>



</table>

<br><br><br>
<legend><font color='#7E2217' size=3><b><u>Review Criteria</u></b></font></legend>
<center><table border=0 cellspacing=0 cellpadding=7 width=900>
$tr
</table></center>
<br>

<table width=900>



<!-- ************************************************************ NEW COLUMNS ************************************************ -->




<!--#####################################Comments###########################################-->


</table>
<br>
<br>
<br><input class=style6 type=submit name=submit value=ENTER>
<input type=hidden id='sect1_hidden' name=sect1_hidden>
<input type=hidden id='sect2_hidden' name=sect2_hidden>
<input type=hidden id='sect3_hidden' name=sect3_hidden>
<input type=hidden id='sect4_hidden' name=sect4_hidden>
<input type=hidden id='sect5_hidden' name=sect5_hidden>
<input type=hidden id='sect6_hidden' name=sect6_hidden>
<input type=hidden id='sect7_hidden' name=sect7_hidden>
<input type=hidden id='sect8_hidden' name=sect8_hidden>
<input type=hidden id='sect9_hidden' name=sect9_hidden>
<input type=hidden id='sect10_hidden' name=sect10_hidden>
<input type=hidden id='sect11_hidden' name=sect11_hidden>
<input type=hidden id='sect12_hidden' name=sect12_hidden>

<input type=hidden id='sect13_hidden' name=sect13_hidden>
<input type=hidden id='sect14_hidden' name=sect14_hidden>
<input type=hidden id='sect15_hidden' name=sect15_hidden>
<input type=hidden id='sect16_hidden' name=sect16_hidden>
<input type=hidden id='sect17_hidden' name=sect17_hidden>
<input type=hidden id='sect18_hidden' name=sect18_hidden>


<input type=hidden id='sect25_hidden' name=sect25_hidden>






<input type=hidden id='overall_hidden' name=overall_hidden>
<input type=hidden id='overall_totScore' name=overall_totScore>
<input type=hidden id='overall_percentage' name=overall_percentage>

<input type=hidden id='sect1_hidden15' name=sect1_hidden15>


</form>
</body>
</html>

HTMLEND
;
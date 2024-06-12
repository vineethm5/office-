#!/usr/bin/perl

require "/var/www/cgi-bin/greettech/database.pl";
&database;
require "/var/www/cgi-bin/greettech/request.pl";
&request;
require "/var/www/cgi-bin/greettech/variable_index.pl";

# print "Content-type: text/html;\n\n";

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
for($i=2005; $i<=$currYear+1; $i++){
  if($i == $currYear){
  $cmbYear = $cmbYear . "<option value=".$i." selected>".$i."</option>\n";
  }else{
   $cmbYear = $cmbYear . "<option value=".$i.">".$i."</option>\n";
   }
}


$qry="select DISTINCT(Lead_Stage) as leadstage from Atria_Power_upload";
$run=$db->prepare($qry);
$run->execute();
$run->bind_columns(\$leadstage);
while($row=$run->fetchrow_array)
{
  push @leadstage,$leadstage;
}

for($i=0;$i<@leadstage;$i++)
{
  $leadop.="<option value='$leadstage[$i]'>$leadstage[$i]</option>";
}



$qry1="select DISTINCT(Channel) as Channel from Atria_Power_upload";
$run1=$db->prepare($qry1);
$run1->execute();
$run1->bind_columns(\$Channel);
while($row1=$run1->fetchrow_array)
{
  push @Channel,$Channel;
}

for($i=0;$i<@Channel;$i++)
{
  $chandop.="<option value='$Channel[$i]'>$Channel[$i]</option>";
}




$qry2="select DISTINCT(Source) as Source from Atria_Power_upload";
$run2=$db->prepare($qry2);
$run2->execute();
$run2->bind_columns(\$Source);
while($row2=$run2->fetchrow_array)
{
  push @Source,$Source;
}

for($i=0;$i<@Source;$i++)
{
  $sourcedop.="<option value='$Source[$i]'>$Source[$i]</option>";
}


$tr .="<tr><td align=center><font face=Arial><b><u>Communication</u></b></font></td><td><font face=Arial><b><u>Score</u></b></font></td><td><font face=Arial><b><u>Not&nbsp;Applicable</u></b></font></td></tr>";

#****************************Opening of call****************************************
$tr .="<tr cellspacing=30 cellpadding=30><td ><font face=Arial><b><u>Greeting:</u></b></font></td></tr>";
$tr .="<tr><td><font face=Arial>Did the agent introduce themselves and the company?</font></td></tr>";
$tr .="<tr><td><input type=radio id='sect1_1' name=sect1_1 value='Yes'  onclick='sect1()'>&nbsp;<font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font><input type=radio id='sect1_1' name='sect1_1'  value='No' onclick='sect1()'><font face=Arial>&nbsp;No</font><td align=center><input class='style8' type=text disabled name='disp_text1' id='disp_text1' value='0/5' size=1></td><td  align=center><input type=checkbox name='sect1_na' id='sect1_na' value='NA' onclick='sect1()'><td><textarea id='remarks1' name='remarks1' cols=10 rows=5 class='hide'></textarea></td></td></tr>";

$tr .="<tr><td><font face=Arial>Did the agent establish the reason for the call?</font></td></tr>";
$tr .="<tr><td><input type=radio id='sect1_2' name=sect1_2 value='Yes'  onclick='sect2()'>&nbsp;<font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font><input type=radio id='sect1_2' name='sect1_2'  value='No' onclick='sect2()'><font face=Arial>&nbsp;No</font><td align=center><input class='style8' type=text disabled name='disp_text2' id='disp_text2' value='0/5' size=1></td><td  align=center><input type=checkbox name='sect2_na' id='sect2_na' value='NA' onclick='sect2()'><td><textarea id='remarks2' name='remarks2' cols=10 rows=5 class='hide'></textarea></td></td></tr>";

# $tr .="<tr><td><font face=Arial>&nbsp;&nbsp&nbspIs it a CLI call&nbsp&nbsp&nbsp&nbsp&nbsp<input type=checkbox name='check_cli' id='check_cli'  value='1' >&nbsp&nbsp&nbsp&nbsp(GIVE WARNING IF NON CLI CALL AND PHONE NUMBER NOT ENTERED.)</font></td></tr><tr></tr>";

#----------------------------------------END----------------------------------------


#****************************Detail Collection****************************************

$tr .= "<tr><td><font face=Arial><b><u>Detail Collection:</u></b></font></td></tr>";
$tr .="<tr><td><font face=Arial>Did the agent ask for e-bill/ confirm E-Bill?</font></td></tr>";
$tr .="<tr><td><input type=radio id='sect1_3' name=sect1_3 value='Yes' onclick='sect3()'>&nbsp;<font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font><input type=radio id='sect1_3' name='sect1_3'  value='No' onclick='sect3()'><font face=Arial>&nbsp;No</font><td align=center><input class='style8' type=text disabled name='disp_text3' id='disp_text3' value='0/5' size=1></td><td  align=center><input type=checkbox name='sect3_na' id='sect3_na' value='NA' onclick='sect3()'><td><textarea id='remarks3' name='remarks3' cols=10 rows=5 class='hide'></textarea></td></td></tr>";

$tr .="<tr><td><font face=Arial>Did the agent ask for sanction load and phase?</font></td></tr>";
$tr .="<tr><td><input type=radio id='sect1_4' name=sect1_4 value='Yes' onclick='sect4()'>&nbsp;<font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font><input type=radio id='sect1_4' name='sect1_4'  value='No' onclick='sect4()'><font face=Arial>&nbsp;No</font><td align=center><input class='style8' type=text disabled name='disp_text4' id='disp_text4' value='0/5' size=1></td><td  align=center><input type=checkbox name='sect4_na' id='sect4_na' value='NA' onclick='sect4()'><td><textarea id='remarks4' name='remarks4' cols=10 rows=5 class='hide'></textarea></td></td></tr>";

#**************************** Brand Pitch ***************************************

$tr .= "<tr><td><font face=Arial><b><u>Brand Pitch</u>:</b></font></td></tr>";
$tr .="<tr><td><font face=Arial>Did the agent ask for sanction load and phase?</font></td></tr>";
$tr .="<tr><td><input type=radio id='sect1_5' name=sect1_5 value='Yes'  onclick='sect5()'>&nbsp;<font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font><input type=radio id='sect1_5' name='sect1_5'  value='No' onclick='sect5()'><font face=Arial>&nbsp;No</font><td align=center><input class='style8' type=text disabled name='disp_text5' id='disp_text5' value='0/10' size=1></td><td  align=center><input type=checkbox name='sect5_na' id='sect5_na' value='NA' onclick='sect5()'><td><textarea id='remarks5' name='remarks5' cols=10 rows=5 class='hide'></textarea></td></td></tr>";  

#----------------------------------------END--------------------------------------------

#****************************  System Sizing and Pricing ***************************************7777777777

$tr .= "<tr><td><font face=Arial><b><u>System Sizing and Pricing</u></b></font></td></tr>";
$tr .="<tr><td><font face=Arial>Did the agent suggest correct system size and Pricing?</font></td></tr>";
$tr .="<tr><td><input type=radio id='sect1_6' name=sect1_6 value='Yes'  onclick='sect6()'>&nbsp;<font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font><input type=radio id='sect1_6' name='sect1_6'  value='No' onclick='sect6()'><font face=Arial>&nbsp;No</font><td align=center><input class='style8' type=text disabled name='disp_text6' id='disp_text6' value='0/5' size=1></td><td  align=center><input type=checkbox name='sect6_na' id='sect6_na' value='NA' onclick='sect6()'><td><textarea id='remarks6' name='remarks6' cols=10 rows=5 class='hide'></textarea></td></td></tr>";

#----------------------------------------END--------------------------------------------

#****************************  Financing Pitch ***************************************7777777777

$tr .= "<tr><td><font face=Arial><b><u>Financing Pitch</u></b></font></td></tr>";
$tr .="<tr><td><font face=Arial>Did the agent pitch for financing properly?</font></td></tr>";
$tr .="<tr><td><input type=radio id='sect1_7' name=sect1_7 value='Yes'  onclick='sect7()'>&nbsp;<font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font><input type=radio id='sect1_7' name='sect1_7'  value='No' onclick='sect7()'><font face=Arial>&nbsp;No</font><td align=center><input class='style8' type=text disabled name='disp_text7' id='disp_text7' value='0/5' size=1></td><td  align=center><input type=checkbox name='sect7_na' id='sect7_na' value='NA' onclick='sect7()'><td><textarea id='remarks7' name='remarks7' cols=10 rows=5 class='hide'></textarea></td></td></tr>";

#----------------------------------------END--------------------------------------------

#****************************  Recap and Roof type ***************************************7777777777

$tr .= "<tr><td><font face=Arial><b><u>Recap and Roof type</u></b></font></td></tr>";
$tr .="<tr><td><font face=Arial>Did the agent recap the system sizing and pricing according to script?</font></td></tr>";
$tr .="<tr><td><input type=radio id='sect1_8' name=sect1_8 value='Yes'  onclick='sect8()'>&nbsp;<font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font><input type=radio id='sect1_8' name='sect1_8'  value='No' onclick='sect8()'><font face=Arial>&nbsp;No</font><td align=center><input class='style8' type=text disabled name='disp_text8' id='disp_text8' value='0/5' size=1></td><td  align=center><input type=checkbox name='sect8_na' id='sect8_na' value='NA' onclick='sect8()'><td><textarea id='remarks8' name='remarks8' cols=10 rows=5 class='hide'></textarea></td></td></tr>";


$tr .="<tr><td><font face=Arial>Did the agent mention the roof type?</font></td></tr>";
$tr .="<tr><td><input type=radio id='sect1_9' name=sect1_9 value='Yes'  onclick='sect9()'>&nbsp;<font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font><input type=radio id='sect1_9' name='sect1_9'  value='No' onclick='sect9()'><font face=Arial>&nbsp;No</font><td align=center><input class='style8' type=text disabled name='disp_text9' id='disp_text9' value='0/5' size=1></td><td  align=center><input type=checkbox name='sect9_na' id='sect9_na' value='NA' onclick='sect9()'><td><textarea id='remarks9' name='remarks9' cols=10 rows=5 class='hide'></textarea></td></td></tr>";

#----------------------------------------END--------------------------------------------


#****************************  Booking  ***************************************7777777777

$tr .= "<tr><td><font face=Arial><b><u>Booking</u></b></font></td></tr>";
$tr .="<tr><td><font face=Arial>Did the agent mention booking amount and asked for booking?</font></td></tr>";
$tr .="<tr><td><input type=radio id='sect1_10' name=sect1_10 value='Yes' onclick='sect10()'>&nbsp;<font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font><input type=radio id='sect1_10' name='sect1_10'  value='No' onclick='sect10()'><font face=Arial>&nbsp;No</font><td align=center><input class='style8' type=text disabled name='disp_text10' id='disp_text10' value='0/5' size=1></td><td  align=center><input type=checkbox name='sect10_na' id='sect10_na' value='NA' onclick='sect10()'><td><textarea id='remarks10' name='remarks10' cols=10 rows=5 class='hide'></textarea></td></td></tr>";

#----------------------------------------END--------------------------------------------


#****************************  Accuracy of USPs  ***************************************7777777777

$tr .= "<tr><td><font face=Arial><b><u>Accuracy of USPs</u></b></font></td></tr>";
$tr .="<tr><td><font face=Arial>Did the agent mention about the USPs (differentiators) of Atria Renewable?</font></td></tr>";
$tr .="<tr><td><input type=radio id='sect1_11' name=sect1_11 value='Yes'  onclick='sect11()'>&nbsp;<font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font><input type=radio id='sect1_11' name='sect1_11'  value='No' onclick='sect11()'><font face=Arial>&nbsp;No</font><td align=center><input class='style8' type=text disabled name='disp_text11' id='disp_text11' value='0/5' size=1></td><td  align=center><input type=checkbox name='sect11_na' id='sect11_na' value='NA' onclick='sect11()'><td><textarea id='remarks11' name='remarks11' cols=10 rows=5 class='hide'></textarea></td></td></tr>";

#----------------------------------------END--------------------------------------------



#****************************  Technical Details:  ***************************************7777777777

$tr .= "<tr><td><font face=Arial><b><u>Technical Details</u></b></font></td></tr>";
$tr .="<tr><td><font face=Arial>Did the agent correctly convey technical details about solar panels, installations, and warranty?</font></td></tr>";
$tr .="<tr><td><input type=radio id='sect1_12' name=sect1_12 value='Yes'  onclick='sect12()'>&nbsp;<font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font><input type=radio id='sect1_12' name='sect1_12'  value='No' onclick='sect12()'><font face=Arial>&nbsp;No</font><td align=center><input class='style8' type=text disabled name='disp_text12' id='disp_text12' value='0/5' size=1></td><td  align=center><input type=checkbox name='sect12_na' id='sect12_na' value='NA' onclick='sect12()'><td><textarea id='remarks12' name='remarks12' cols=10 rows=5 class='hide'></textarea></td></td></tr>";

#----------------------------------------END--------------------------------------------

#****************************  Mention of Proposal  ***************************************7777777777

$tr .= "<tr><td><font face=Arial><b><u>Mention of Proposal</u></b></font></td></tr>";
$tr .="<tr><td><font face=Arial>Did the agent mention about sending of proposal?</font></td></tr>";
$tr .="<tr><td><input type=radio id='sect1_13' name=sect1_13 value='Yes'  onclick='sect13()'>&nbsp;<font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font><input type=radio id='sect1_13' name='sect1_13'  value='No' onclick='sect13()'><font face=Arial>&nbsp;No</font><td align=center><input class='style8' type=text disabled name='disp_text13' id='disp_text13' value='0/5' size=1></td><td  align=center><input type=checkbox name='sect13_na' id='sect13_na' value='NA' onclick='sect13()'><td><textarea id='remarks13' name='remarks13' cols=10 rows=5 class='hide'></textarea></td></td></tr>";

#----------------------------------------END--------------------------------------------


#****************************  Active Listening  ***************************************7777777777

$tr .= "<tr><td><font face=Arial><b><u>Active Listening</u></b></font></td></tr>";
$tr .="<tr><td><font face=Arial>Did the agent actively listen to the customer's needs and concerns?</font></td></tr>";
$tr .="<tr><td><input type=radio id='sect1_14' name=sect1_14 value='Yes' onclick='sect14()'>&nbsp;<font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font><input type=radio id='sect1_14' name='sect1_14'  value='No' onclick='sect14()'><font face=Arial>&nbsp;No</font><td align=center><input class='style8' type=text disabled name='disp_text14' id='disp_text14' value='0/5' size=1></td><td  align=center><input type=checkbox name='sect14_na' id='sect14_na' value='NA' onclick='sect14()'><td><textarea id='remarks14' name='remarks14' cols=10 rows=5 class='hide'></textarea></td></td></tr>";

#----------------------------------------END--------------------------------------------

#****************************  Closing  ***************************************7777777777

$tr .= "<tr><td><font face=Arial><b><u>Closing</u></b></font></td></tr>";
$tr .="<tr><td><font face=Arial>Did the agent close the call effectively</font></td></tr>";
$tr .="<tr><td><input type=radio id='sect1_15' name=sect1_15 value='Yes'  onclick='sect15()'>&nbsp;<font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font><input type=radio id='sect1_15' name='sect1_15'  value='No' onclick='sect15()'><font face=Arial>&nbsp;No</font><td align=center><input class='style8' type=text disabled name='disp_text15' id='disp_text15' value='0/5' size=1></td><td  align=center><input type=checkbox name='sect15_na' id='sect15_na' value='NA' onclick='sect15()'><td><textarea id='remarks15' name='remarks15' cols=10 rows=5 class='hide'></textarea></td></td></tr>";

#----------------------------------------END--------------------------------------------


$tr .= "<tr><td align=center colspan=3><b><u>Phone Etiquette</u></b></td></tr>";

#****************************  Tone and Manner  ***************************************7777777777
$tr .= "<tr><td><font face=Arial><b><u>Tone and Manner</u></b></font></td></tr>";
$tr .="<tr><td><font face=Arial>Did the agent maintain a professional tone and displayed confidence and patience throughout the call?</font></td></tr>";
$tr .="<tr><td><input type=radio id='sect1_16' name=sect1_16 value='Yes'  onclick='sect16()'>&nbsp;<font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font><input type=radio id='sect1_16' name='sect1_16'  value='No' onclick='sect16()'><font face=Arial>&nbsp;No</font><td align=center><input class='style8' type=text disabled name='disp_text16' id='disp_text16' value='0/5' size=1></td><td  align=center><input type=checkbox name='sect16_na' id='sect16_na' value='NA' onclick='sect16()'><td><textarea id='remarks16' name='remarks16' cols=10 rows=5 class='hide'></textarea></td></td></tr>";
#----------------------------------------END--------------------------------------------

#****************************  Language and Speech ***************************************7777777777
$tr .= "<tr><td><font face=Arial><b><u>Language and Speech</u></b></font></td></tr>";
$tr .="<tr><td><font face=Arial>Was the agent's language clear and easy to understand (refrained from using slang and jargon)?</font></td></tr>";
$tr .="<tr><td><input type=radio id='sect1_17' name=sect1_17 value='Yes'  onclick='sect17()'>&nbsp;<font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font><input type=radio id='sect1_17' name='sect1_17'  value='No' onclick='sect17()'><font face=Arial>&nbsp;No</font><td align=center><input class='style8' type=text disabled name='disp_text17' id='disp_text17' value='0/5' size=1></td><td  align=center><input type=checkbox name='sect17_na' id='sect17_na' value='NA' onclick='sect17()'><td><textarea id='remarks17' name='remarks17' cols=10 rows=5 class='hide'></textarea></td></td></tr>";
#----------------------------------------END--------------------------------------------




$tr .= "<tr><td align=center colspan=3><b><u>Rebuttal</u></b></td></tr>";
#****************************  Handling Objections  ***************************************7777777777
$tr .= "<tr><td><font face=Arial><b><u>Handling Objections</u></b></font></td></tr>";
$tr .="<tr><td><font face=Arial>Did the agent effectively address any objections raised by the customer?</font></td></tr>";
$tr .="<tr><td><input type=radio id='sect1_18' name=sect1_18 value='Yes'  onclick='sect18()'>&nbsp;<font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font><input type=radio id='sect1_18' name='sect1_18'  value='No' onclick='sect18()'><font face=Arial>&nbsp;No</font><td align=center><input class='style8' type=text disabled name='disp_text18' id='disp_text18' value='0/5' size=1></td><td  align=center><input type=checkbox name='sect18_na' id='sect18_na' value='NA' onclick='sect18()'><td><textarea id='remarks18' name='remarks18' cols=10 rows=5 class='hide'></textarea></td></td></tr>";
#----------------------------------------END--------------------------------------------

#****************************  Offering Solutions  ***************************************7777777777
$tr .= "<tr><td><font face=Arial><b><u>Offering Solutions</u></b></font></td></tr>";
$tr .="<tr><td><font face=Arial>Did the agent provide relevant solutions to overcome objections?</font></td></tr>";
$tr .="<tr><td><input type=radio id='sect1_19' name=sect1_19 value='Yes'  onclick='sect19()'>&nbsp;<font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font><input type=radio id='sect1_19' name='sect1_19'  value='No' onclick='sect19()'><font face=Arial>&nbsp;No</font><td align=center><input class='style8' type=text disabled name='disp_text19' id='disp_text19' value='0/5' size=1></td><td  align=center><input type=checkbox name='sect19_na' id='sect19_na' value='NA' onclick='sect19()'><td><textarea id='remarks19' name='remarks19' cols=10 rows=5 class='hide'></textarea></td></td></tr>";
#----------------------------------------END--------------------------------------------

$tr .= "<tr><td align=center colspan=3><b><u>Call Experience</u></b></td></tr>";

#****************************  Hold Time  ***************************************7777777777
$tr .= "<tr><td><font face=Arial><b><u>Hold Time</u></b></font></td></tr>";
$tr .="<tr><td><font face=Arial>Was the customer placed on hold for an acceptable duration?</font></td></tr>";
$tr .="<tr><td><input type=radio id='sect1_20' name=sect1_20 value='Yes'  onclick='sect20()'>&nbsp;<font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font><input type=radio id='sect1_20' name='sect1_20'  value='No' onclick='sect20()'><font face=Arial>&nbsp;No</font><td align=center><input class='style8' type=text disabled name='disp_text20' id='disp_text20' value='0/5' size=1></td><td  align=center><input type=checkbox name='sect20_na' id='sect20_na' value='NA' onclick='sect20()'><td><textarea id='remarks20' name='remarks20' cols=10 rows=5 class='hide'></textarea></td></td></tr>";
#----------------------------------------END--------------------------------------------


#****************************  Overall Experience  ***************************************7777777777
$tr .= "<tr><td><font face=Arial><b><u>Overall Experience</u></b></font></td></tr>";
$tr .="<tr><td><font face=Arial>How would you rate the overall experience provided by the agent?</font></td></tr>";
$tr .="<tr><td><input type=radio id='sect1_21' name=sect1_21 value='Yes'  onclick='sect21()'>&nbsp;<font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font><input type=radio id='sect1_21' name='sect1_21'  value='No' onclick='sect21()'><font face=Arial>&nbsp;No</font><td align=center><input class='style8' type=text disabled name='disp_text21' id='disp_text21' value='0/10' size=1></td><td  align=center><input type=checkbox name='sect21_na' id='sect21_na' value='NA' onclick='sect21()'><td><textarea id='remarks21' name='remarks21' cols=10 rows=5 class='hide'></textarea></td></td></tr>";
#----------------------------------------END--------------------------------------------

$tr .= "<tr><td align=center colspan=3><b><u>Product Knowledge</u></b></td></tr>";

#****************************  Understanding of Solar Power  ***************************************7777777777
$tr .= "<tr><td><font face=Arial><b><u>Understanding of Solar Power</u></b></font></td></tr>";
$tr .="<tr><td><font face=Arial>Did the agent demonstrate a strong understanding of solar power and its benefits?</font></td></tr>";
$tr .="<tr><td><input type=radio id='sect1_22' name=sect1_22 value='Yes'  onclick='sect22()'>&nbsp;<font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font><input type=radio id='sect1_22' name='sect1_22'  value='No' onclick='sect22()'><font face=Arial>&nbsp;No</font><td align=center><input class='style8' type=text disabled name='disp_text22' id='disp_text22' value='0/10' size=1></td><td  align=center><input type=checkbox name='sect22_na' id='sect22_na' value='NA' onclick='sect22()'><td><textarea id='remarks22' name='remarks22' cols=10 rows=5 class='hide'></textarea></td></td></tr>";
#----------------------------------------END--------------------------------------------

#****************************  Answering Queries  ***************************************7777777777
$tr .= "<tr><td><font face=Arial><b><u>Answering Queries</u></b></font></td></tr>";
$tr .="<tr><td><font face=Arial>Was the agent able to answer customer queries regarding solar power effectively?</font></td></tr>";
$tr .="<tr><td><input type=radio id='sect1_23' name=sect1_23 value='Yes'  onclick='sect23()'>&nbsp;<font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font><input type=radio id='sect1_23' name='sect1_23'  value='No' onclick='sect23()'><font face=Arial>&nbsp;No</font><td align=center><input class='style8' type=text disabled name='disp_text23' id='disp_text23' value='0/10' size=1></td><td  align=center><input type=checkbox name='sect23_na' id='sect23_na' value='NA' onclick='sect23()'><td><textarea id='remarks23' name='remarks23' cols=10 rows=5 class='hide'></textarea></td></td></tr>";
#----------------------------------------END--------------------------------------------


$tr .= "<tr><td align=center colspan=3><b><u>Process Adherence</u></b></td></tr>";

#****************************  Answering Queries  ***************************************7777777777
$tr .= "<tr><td><font face=Arial><b><u>Adherence to Call Script</u></b></font></td></tr>";
$tr .="<tr><td><font face=Arial>Did the agent follow the prescribed call script and process guidelines?</font></td></tr>";
$tr .="<tr><td><input type=radio id='sect1_24' name=sect1_24 value='Yes'  onclick='sect24()'>&nbsp;<font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font><input type=radio id='sect1_24' name='sect1_24'  value='No' onclick='sect24()'><font face=Arial>&nbsp;No</font><td align=center><input class='style8' type=text disabled name='disp_text24' id='disp_text24' value='0/5' size=1></td><td  align=center><input type=checkbox name='sect24_na' id='sect24_na' value='NA' onclick='sect24()'><td><textarea id='remarks24' name='remarks24' cols=10 rows=5 class='hide'></textarea></td></td></tr>";
#----------------------------------------END--------------------------------------------

#****************************  Answering Queries  ***************************************7777777777
$tr .= "<tr><td><font face=Arial><b><u>Lead Management</u></b></font></td></tr>";
$tr .="<tr><td><font face=Arial>Did the agent accurately capture and update lead information in the CRMs?</font></td></tr>";
$tr .="<tr><td><input type=radio id='sect1_25' name=sect1_25 value='Yes'  onclick='sect25()'>&nbsp;<font face=Arial>Yes&nbsp;&nbsp;&nbsp;</font><input type=radio id='sect1_25' name='sect1_25'  value='No' onclick='sect25()'><font face=Arial>&nbsp;No</font><td align=center><input class='style8' type=text disabled name='disp_text25' id='disp_text25' value='0/10' size=1></td><td  align=center><input type=checkbox name='sect25_na' id='sect25_na' value='NA' onclick='sect25()'><td><textarea id='remarks25' name='remarks25' cols=10 rows=5 class='hide'></textarea></td></td></tr>";
#----------------------------------------END--------------------------------------------

$tdsub.="<input class=style6 type='submit' name='submit' value='ENTER'>";

print "Content-type: text/html;\n\n";

print <<HTMLEND;

<HTML><HEAD><TITLE>New THD Evaluation</TITLE>
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
</STYLE>

<style type="text/css">
.show { display: block;  }
.hide { display: none; }
</style>

<script type="text/javascript">
  
function sect1()
{

  if(document.getElementsByName('sect1_1')[0].checked == true)
  {
    var cl = document.getElementsByName('sect1_1')[0].value;
    console.log(cl+"this is yes");
    document.getElementById('disp_text1').setAttribute("value","5/5"); 
    document.getElementById('sect1_hidden').setAttribute("value","5");
    document.getElementById('sect1_na').setAttribute("value","0");

    var select = document.getElementById('remarks1');
      select.className = 'hide';
  }
  if(document.getElementsByName('sect1_1')[1].checked == true)
  {
    var cl = document.getElementsByName('sect1_1')[1].value;
    console.log(cl+"this is No");
    document.getElementById('disp_text1').setAttribute("value","0/5"); 
    document.getElementById('sect1_hidden').setAttribute("value","0");
    document.getElementById('sect1_na').setAttribute("value","0");

    var select = document.getElementById('remarks1');
      select.className = 'show';
  }

  if(document.getElementsByName('sect1_na')[0].checked == true)
  {
      document.getElementById('disp_text1').setAttribute("value","0");
      document.getElementById('sect1_hidden').setAttribute("value",'NA');
      document.getElementById('sect1_na').setAttribute("value","1");
      document.getElementById("sect1_na").disabled = true;
      overall_1 = 10;

      var select = document.getElementById('remarks1');
      select.className = 'show';
  }
}
  
function sect2()
{
  if(document.getElementsByName('sect1_2')[0].checked == true)
  {
    var cl = document.getElementsByName('sect1_2')[0].value;
    document.getElementById('disp_text2').setAttribute("value",cl); 
    document.getElementById('sect2_hidden').setAttribute("value","5");
    document.getElementById('sect2_na').setAttribute("value","0");

    var select = document.getElementById('remarks2');
      select.className = 'hide';
  }
  if(document.getElementsByName('sect1_2')[1].checked == true)
  {
    var cl = document.getElementsByName('sect1_2')[1].value;
    document.getElementById('disp_text2').setAttribute("value",cl); 
    document.getElementById('sect2_hidden').setAttribute("value","0");
    document.getElementById('sect2_na').setAttribute("value","0");

    var select = document.getElementById('remarks2');
      select.className = 'show';
  }

  if(document.getElementsByName('sect2_na')[0].checked == true)
  {
      document.getElementById('disp_text2').setAttribute("value","0");
      document.getElementById('sect2_hidden').setAttribute("value",'NA');
      document.getElementById('sect2_na').setAttribute("value","1");
      document.getElementById("sect2_na").disabled = true;
      overall_1 = 10;

      var select = document.getElementById('remarks2');
      select.className = 'show';
  }

}


function sect3()
{
  if(document.getElementsByName('sect1_3')[0].checked == true)
  {
    var cl = document.getElementsByName('sect1_3')[0].value;
    document.getElementById('disp_text3').setAttribute("value",cl); 
    document.getElementById('sect3_hidden').setAttribute("value","5");
    document.getElementById('sect3_na').setAttribute("value","0");

    var select = document.getElementById('remarks3');
      select.className = 'hide';
  }
  if(document.getElementsByName('sect1_3')[1].checked == true)
  {
    var cl = document.getElementsByName('sect1_3')[1].value;
    document.getElementById('disp_text3').setAttribute("value",cl); 
    document.getElementById('sect3_hidden').setAttribute("value","0");
    document.getElementById('sect3_na').setAttribute("value","0");

    var select = document.getElementById('remarks3');
      select.className = 'show';
  }

  if(document.getElementsByName('sect3_na')[0].checked == true)
  {
      document.getElementById('disp_text3').setAttribute("value","0");
      document.getElementById('sect3_hidden').setAttribute("value",'NA');
      document.getElementById('sect3_na').setAttribute("value","1");
      document.getElementById("sect3_na").disabled = true;
      overall_1 = 10;

      var select = document.getElementById('remarks3');
      select.className = 'show';
  }

}
function sect4()
{
  if(document.getElementsByName('sect1_4')[0].checked == true)
    {
      var cl = document.getElementsByName('sect1_4')[0].value;
      document.getElementById('disp_text4').setAttribute("value",cl); 
      document.getElementById('sect4_hidden').setAttribute("value","5");
      document.getElementById('sect4_na').setAttribute("value","0");

      var select = document.getElementById('remarks4');
        select.className = 'hide';
    }
    if(document.getElementsByName('sect1_4')[1].checked == true)
    {
      var cl = document.getElementsByName('sect1_4')[1].value;
      document.getElementById('disp_text4').setAttribute("value",cl); 
      document.getElementById('sect4_hidden').setAttribute("value","0");
      document.getElementById('sect4_na').setAttribute("value","0");

      var select = document.getElementById('remarks4');
        select.className = 'show';
    }

    if(document.getElementsByName('sect4_na')[0].checked == true)
    {
        document.getElementById('disp_text4').setAttribute("value","0");
        document.getElementById('sect4_hidden').setAttribute("value",'NA');
        document.getElementById('sect4_na').setAttribute("value","1");
        document.getElementById("sect4_na").disabled = true;
        overall_1 = 10;

        var select = document.getElementById('remarks4');
        select.className = 'show';
    }

}


function sect5()
{
  if(document.getElementsByName('sect1_5')[0].checked == true)
    {
      var cl = document.getElementsByName('sect1_5')[0].value;
      document.getElementById('disp_text5').setAttribute("value",cl); 
      document.getElementById('sect5_hidden').setAttribute("value","5");
      document.getElementById('sect5_na').setAttribute("value","0");

      var select = document.getElementById('remarks5');
        select.className = 'hide';
    }
    if(document.getElementsByName('sect1_5')[1].checked == true)
    {
      var cl = document.getElementsByName('sect1_5')[1].value;
      document.getElementById('disp_text5').setAttribute("value",cl); 
      document.getElementById('sect5_hidden').setAttribute("value","0");
      document.getElementById('sect5_na').setAttribute("value","0");

      var select = document.getElementById('remarks5');
        select.className = 'show';
    }

    if(document.getElementsByName('sect5_na')[0].checked == true)
    {
        document.getElementById('disp_text5').setAttribute("value","0");
        document.getElementById('sect5_hidden').setAttribute("value",'NA');
        document.getElementById('sect5_na').setAttribute("value","1");
        document.getElementById("sect5_na").disabled = true;
        overall_1 = 10;

        var select = document.getElementById('remarks5');
        select.className = 'show';
    }

}



function sect6()
{
  if(document.getElementsByName('sect1_6')[0].checked == true)
    {
      var cl = document.getElementsByName('sect1_6')[0].value;
      document.getElementById('disp_text6').setAttribute("value",cl); 
      document.getElementById('sect6_hidden').setAttribute("value","5");
      document.getElementById('sect6_na').setAttribute("value","0");

      var select = document.getElementById('remarks6');
        select.className = 'hide';
    }
    if(document.getElementsByName('sect1_6')[1].checked == true)
    {
      var cl = document.getElementsByName('sect1_6')[1].value;
      document.getElementById('disp_text6').setAttribute("value",cl); 
      document.getElementById('sect6_hidden').setAttribute("value","0");
      document.getElementById('sect6_na').setAttribute("value","0");

      var select = document.getElementById('remarks6');
        select.className = 'show';
    }

    if(document.getElementsByName('sect6_na')[0].checked == true)
    {
        document.getElementById('disp_text6').setAttribute("value","0");
        document.getElementById('sect6_hidden').setAttribute("value",'NA');
        document.getElementById('sect6_na').setAttribute("value","1");
        document.getElementById("sect6_na").disabled = true;
        overall_1 = 10;

        var select = document.getElementById('remarks6');
        select.className = 'show';
    }

}

function sect7()
{
  if(document.getElementsByName('sect1_7')[0].checked == true)
    {
      var cl = document.getElementsByName('sect1_7')[0].value;
      document.getElementById('disp_text7').setAttribute("value",cl); 
      document.getElementById('sect7_hidden').setAttribute("value","5");
      document.getElementById('sect7_na').setAttribute("value","0");

      var select = document.getElementById('remarks7');
        select.className = 'hide';
    }
    if(document.getElementsByName('sect1_7')[1].checked == true)
    {
      var cl = document.getElementsByName('sect1_7')[1].value;
      document.getElementById('disp_text7').setAttribute("value",cl); 
      document.getElementById('sect7_hidden').setAttribute("value","0");
      document.getElementById('sect7_na').setAttribute("value","0");

      var select = document.getElementById('remarks7');
        select.className = 'show';
    }

    if(document.getElementsByName('sect7_na')[0].checked == true)
    {
        document.getElementById('disp_text7').setAttribute("value","0");
        document.getElementById('sect7_hidden').setAttribute("value",'NA');
        document.getElementById('sect7_na').setAttribute("value","1");
        document.getElementById("sect7_na").disabled = true;
        overall_1 = 10;

        var select = document.getElementById('remarks7');
        select.className = 'show';
    }

}


function sect8()
{
  if(document.getElementsByName('sect1_8')[0].checked == true)
    {
      var cl = document.getElementsByName('sect1_8')[0].value;
      document.getElementById('disp_text8').setAttribute("value",cl); 
      document.getElementById('sect8_hidden').setAttribute("value","5");
      document.getElementById('sect8_na').setAttribute("value","0");

      var select = document.getElementById('remarks8');
        select.className = 'hide';
    }
    if(document.getElementsByName('sect1_8')[1].checked == true)
    {
      var cl = document.getElementsByName('sect1_8')[1].value;
      document.getElementById('disp_text8').setAttribute("value",cl); 
      document.getElementById('sect8_hidden').setAttribute("value","0");
      document.getElementById('sect8_na').setAttribute("value","0");

      var select = document.getElementById('remarks8');
        select.className = 'show';
    }

    if(document.getElementsByName('sect8_na')[0].checked == true)
    {
        document.getElementById('disp_text8').setAttribute("value","0");
        document.getElementById('sect8_hidden').setAttribute("value",'NA');
        document.getElementById('sect8_na').setAttribute("value","1");
        document.getElementById("sect8_na").disabled = true;
        overall_1 = 10;

        var select = document.getElementById('remarks8');
        select.className = 'show';
    }

}



function sect9()
{
  if(document.getElementsByName('sect1_9')[0].checked == true)
    {
      var cl = document.getElementsByName('sect1_9')[0].value;
      document.getElementById('disp_text9').setAttribute("value",cl); 
      document.getElementById('sect9_hidden').setAttribute("value","5");
      document.getElementById('sect9_na').setAttribute("value","0");

      var select = document.getElementById('remarks9');
        select.className = 'hide';
    }
    if(document.getElementsByName('sect1_9')[1].checked == true)
    {
      var cl = document.getElementsByName('sect1_9')[1].value;
      document.getElementById('disp_text9').setAttribute("value",cl); 
      document.getElementById('sect9_hidden').setAttribute("value","0");
      document.getElementById('sect9_na').setAttribute("value","0");

      var select = document.getElementById('remarks9');
        select.className = 'show';
    }

    if(document.getElementsByName('sect9_na')[0].checked == true)
    {
        document.getElementById('disp_text9').setAttribute("value","0");
        document.getElementById('sect9_hidden').setAttribute("value",'NA');
        document.getElementById('sect9_na').setAttribute("value","1");
        document.getElementById("sect9_na").disabled = true;
        overall_1 = 10;

        var select = document.getElementById('remarks9');
        select.className = 'show';
    }

}

function sect10()
{
  if(document.getElementsByName('sect1_10')[0].checked == true)
    {
      var cl = document.getElementsByName('sect1_10')[0].value;
      document.getElementById('disp_text10').setAttribute("value",cl); 
      document.getElementById('sect10_hidden').setAttribute("value","5");
      document.getElementById('sect10_na').setAttribute("value","0");

      var select = document.getElementById('remarks10');
        select.className = 'hide';
    }
    if(document.getElementsByName('sect1_10')[1].checked == true)
    {
      var cl = document.getElementsByName('sect1_10')[1].value;
      document.getElementById('disp_text10').setAttribute("value",cl); 
      document.getElementById('sect10_hidden').setAttribute("value","0");
      document.getElementById('sect10_na').setAttribute("value","0");

      var select = document.getElementById('remarks10');
        select.className = 'show';
    }

    if(document.getElementsByName('sect10_na')[0].checked == true)
    {
        document.getElementById('disp_text10').setAttribute("value","0");
        document.getElementById('sect10_hidden').setAttribute("value",'NA');
        document.getElementById('sect10_na').setAttribute("value","1");
        document.getElementById("sect10_na").disabled = true;
        overall_1 = 10;

        var select = document.getElementById('remarks10');
        select.className = 'show';
    }

}

function sect11()
{

  if(document.getElementsByName('sect1_11')[0].checked == true)
  {
    var cl = document.getElementsByName('sect1_11')[0].value;
    document.getElementById('disp_text11').setAttribute("value",cl); 
    document.getElementById('sect11_hidden').setAttribute("value","5");
    document.getElementById('sect11_na').setAttribute("value","0");

    var select = document.getElementById('remarks11');
      select.className = 'hide';
  }
  if(document.getElementsByName('sect1_11')[1].checked == true)
  {
    var cl = document.getElementsByName('sect1_11')[1].value;
    document.getElementById('disp_text11').setAttribute("value",cl); 
    document.getElementById('sect11_hidden').setAttribute("value","0");
    document.getElementById('sect11_na').setAttribute("value","0");

    var select = document.getElementById('remarks11');
      select.className = 'show';
  }

  if(document.getElementsByName('sect11_na')[0].checked == true)
  {
      document.getElementById('disp_text11').setAttribute("value","0");
      document.getElementById('sect11_hidden').setAttribute("value",'NA');
      document.getElementById('sect11_na').setAttribute("value","1");
      document.getElementById("sect11_na").disabled = true;
      overall_1 = 10;

      var select = document.getElementById('remarks11');
      select.className = 'show';
  }
}


function sect12()
{

  if(document.getElementsByName('sect1_12')[0].checked == true)
  {
    var cl = document.getElementsByName('sect1_12')[0].value;
    document.getElementById('disp_text12').setAttribute("value",cl); 
    document.getElementById('sect12_hidden').setAttribute("value","5");
    document.getElementById('sect12_na').setAttribute("value","0");

    var select = document.getElementById('remarks12');
      select.className = 'hide';
  }
  if(document.getElementsByName('sect1_12')[1].checked == true)
  {
    var cl = document.getElementsByName('sect1_12')[1].value;
    document.getElementById('disp_text12').setAttribute("value",cl); 
    document.getElementById('sect12_hidden').setAttribute("value","0");
    document.getElementById('sect12_na').setAttribute("value","0");

    var select = document.getElementById('remarks12');
      select.className = 'show';
  }

  if(document.getElementsByName('sect12_na')[0].checked == true)
  {
      document.getElementById('disp_text12').setAttribute("value","0");
      document.getElementById('sect12_hidden').setAttribute("value",'NA');
      document.getElementById('sect12_na').setAttribute("value","1");
      document.getElementById("sect12_na").disabled = true;
      overall_1 = 10;

      var select = document.getElementById('remarks12');
      select.className = 'show';
  }
}


function sect13()
{

  if(document.getElementsByName('sect1_13')[0].checked == true)
  {
    var cl = document.getElementsByName('sect1_13')[0].value;
    document.getElementById('disp_text13').setAttribute("value",cl); 
    document.getElementById('sect13_hidden').setAttribute("value","5");
    document.getElementById('sect13_na').setAttribute("value","0");

    var select = document.getElementById('remarks13');
      select.className = 'hide';
  }
  if(document.getElementsByName('sect1_13')[1].checked == true)
  {
    var cl = document.getElementsByName('sect1_13')[1].value;
    document.getElementById('disp_text13').setAttribute("value",cl); 
    document.getElementById('sect13_hidden').setAttribute("value","0");
    document.getElementById('sect13_na').setAttribute("value","0");

    var select = document.getElementById('remarks13');
      select.className = 'show';
  }

  if(document.getElementsByName('sect13_na')[0].checked == true)
  {
      document.getElementById('disp_text13').setAttribute("value","0");
      document.getElementById('sect13_hidden').setAttribute("value",'NA');
      document.getElementById('sect13_na').setAttribute("value","1");
      document.getElementById("sect13_na").disabled = true;
      overall_1 = 10;

      var select = document.getElementById('remarks13');
      select.className = 'show';
  }
}


function sect14()
{

  if(document.getElementsByName('sect1_14')[0].checked == true)
  {
    var cl = document.getElementsByName('sect1_14')[0].value;
    document.getElementById('disp_text14').setAttribute("value",cl); 
    document.getElementById('sect14_hidden').setAttribute("value","5");
    document.getElementById('sect14_na').setAttribute("value","0");

    var select = document.getElementById('remarks14');
      select.className = 'hide';
  }
  if(document.getElementsByName('sect1_14')[1].checked == true)
  {
    var cl = document.getElementsByName('sect1_14')[1].value;
    document.getElementById('disp_text14').setAttribute("value",cl); 
    document.getElementById('sect14_hidden').setAttribute("value","0");
    document.getElementById('sect14_na').setAttribute("value","0");

    var select = document.getElementById('remarks14');
      select.className = 'show';
  }

  if(document.getElementsByName('sect14_na')[0].checked == true)
  {
      document.getElementById('disp_text14').setAttribute("value","0");
      document.getElementById('sect14_hidden').setAttribute("value",'NA');
      document.getElementById('sect14_na').setAttribute("value","1");
      document.getElementById("sect14_na").disabled = true;
      overall_1 = 10;

      var select = document.getElementById('remarks14');
      select.className = 'show';
  }
}


function sect15()
{

  if(document.getElementsByName('sect1_15')[0].checked == true)
  {
    var cl = document.getElementsByName('sect1_15')[0].value;
    document.getElementById('disp_text15').setAttribute("value",cl); 
    document.getElementById('sect15_hidden').setAttribute("value","5");
    document.getElementById('sect15_na').setAttribute("value","0");

    var select = document.getElementById('remarks15');
      select.className = 'hide';
  }
  if(document.getElementsByName('sect1_15')[1].checked == true)
  {
    var cl = document.getElementsByName('sect1_15')[1].value;
    document.getElementById('disp_text15').setAttribute("value",cl); 
    document.getElementById('sect15_hidden').setAttribute("value","0");
    document.getElementById('sect15_na').setAttribute("value","0");

    var select = document.getElementById('remarks15');
      select.className = 'show';
  }

  if(document.getElementsByName('sect15_na')[0].checked == true)
  {
      document.getElementById('disp_text15').setAttribute("value","0");
      document.getElementById('sect15_hidden').setAttribute("value",'NA');
      document.getElementById('sect15_na').setAttribute("value","1");
      document.getElementById("sect15_na").disabled = true;
      overall_1 = 10;

      var select = document.getElementById('remarks15');
      select.className = 'show';
  }
}


function sect16()
{

  if(document.getElementsByName('sect1_16')[0].checked == true)
  {
    var cl = document.getElementsByName('sect1_16')[0].value;
    document.getElementById('disp_text16').setAttribute("value",cl); 
    document.getElementById('sect16_hidden').setAttribute("value","5");
    document.getElementById('sect16_na').setAttribute("value","0");

    var select = document.getElementById('remarks16');
      select.className = 'hide';
  }
  if(document.getElementsByName('sect1_16')[1].checked == true)
  {
    var cl = document.getElementsByName('sect1_16')[1].value;
    document.getElementById('disp_text16').setAttribute("value",cl); 
    document.getElementById('sect16_hidden').setAttribute("value","0");
    document.getElementById('sect16_na').setAttribute("value","0");

    var select = document.getElementById('remarks16');
      select.className = 'show';
  }

  if(document.getElementsByName('sect16_na')[0].checked == true)
  {
      document.getElementById('disp_text16').setAttribute("value","0");
      document.getElementById('sect16_hidden').setAttribute("value",'NA');
      document.getElementById('sect16_na').setAttribute("value","1");
      document.getElementById("sect16_na").disabled = true;
      overall_1 = 10;

      var select = document.getElementById('remarks16');
      select.className = 'show';
  }
}


function sect17()
{

  if(document.getElementsByName('sect1_17')[0].checked == true)
  {
    var cl = document.getElementsByName('sect1_17')[0].value;
    document.getElementById('disp_text17').setAttribute("value",cl); 
    document.getElementById('sect17_hidden').setAttribute("value","5");
    document.getElementById('sect17_na').setAttribute("value","0");

    var select = document.getElementById('remarks17');
      select.className = 'hide';
  }
  if(document.getElementsByName('sect1_17')[1].checked == true)
  {
    var cl = document.getElementsByName('sect1_17')[1].value;
    document.getElementById('disp_text17').setAttribute("value",cl); 
    document.getElementById('sect17_hidden').setAttribute("value","0");
    document.getElementById('sect17_na').setAttribute("value","0");

    var select = document.getElementById('remarks17');
      select.className = 'show';
  }

  if(document.getElementsByName('sect17_na')[0].checked == true)
  {
      document.getElementById('disp_text17').setAttribute("value","0");
      document.getElementById('sect17_hidden').setAttribute("value",'NA');
      document.getElementById('sect17_na').setAttribute("value","1");
      document.getElementById("sect17_na").disabled = true;
      overall_1 = 10;

      var select = document.getElementById('remarks17');
      select.className = 'show';
  }
}


function sect18()
{

  if(document.getElementsByName('sect1_18')[0].checked == true)
  {
    var cl = document.getElementsByName('sect1_18')[0].value;
    document.getElementById('disp_text18').setAttribute("value",cl); 
    document.getElementById('sect18_hidden').setAttribute("value","5");
    document.getElementById('sect18_na').setAttribute("value","0");

    var select = document.getElementById('remarks18');
      select.className = 'hide';
  }
  if(document.getElementsByName('sect1_18')[1].checked == true)
  {
    var cl = document.getElementsByName('sect1_18')[1].value;
    document.getElementById('disp_text18').setAttribute("value",cl); 
    document.getElementById('sect18_hidden').setAttribute("value","0");
    document.getElementById('sect18_na').setAttribute("value","0");

    var select = document.getElementById('remarks18');
      select.className = 'show';
  }

  if(document.getElementsByName('sect18_na')[0].checked == true)
  {
      document.getElementById('disp_text18').setAttribute("value","0");
      document.getElementById('sect18_hidden').setAttribute("value",'NA');
      document.getElementById('sect18_na').setAttribute("value","1");
      document.getElementById("sect18_na").disabled = true;
      overall_1 = 10;

      var select = document.getElementById('remarks18');
      select.className = 'show';
  }
}


function sect19()
{

  if(document.getElementsByName('sect1_19')[0].checked == true)
  {
    var cl = document.getElementsByName('sect1_19')[0].value;
    document.getElementById('disp_text19').setAttribute("value",cl); 
    document.getElementById('sect19_hidden').setAttribute("value","5");
    document.getElementById('sect19_na').setAttribute("value","0");

    var select = document.getElementById('remarks19');
      select.className = 'hide';
  }
  if(document.getElementsByName('sect1_19')[1].checked == true)
  {
    var cl = document.getElementsByName('sect1_19')[1].value;
    document.getElementById('disp_text19').setAttribute("value",cl); 
    document.getElementById('sect19_hidden').setAttribute("value","0");
    document.getElementById('sect19_na').setAttribute("value","0");

    var select = document.getElementById('remarks19');
      select.className = 'show';
  }

  if(document.getElementsByName('sect19_na')[0].checked == true)
  {
      document.getElementById('disp_text19').setAttribute("value","0");
      document.getElementById('sect19_hidden').setAttribute("value",'NA');
      document.getElementById('sect19_na').setAttribute("value","1");
      document.getElementById("sect19_na").disabled = true;
      overall_1 = 10;

      var select = document.getElementById('remarks19');
      select.className = 'show';
  }
}


function sect20()
{

  if(document.getElementsByName('sect1_20')[0].checked == true)
  {
    var cl = document.getElementsByName('sect1_20')[0].value;
    document.getElementById('disp_text20').setAttribute("value",cl); 
    document.getElementById('sect20_hidden').setAttribute("value","5");
    document.getElementById('sect20_na').setAttribute("value","0");

    var select = document.getElementById('remarks20');
      select.className = 'hide';
  }
  if(document.getElementsByName('sect1_20')[1].checked == true)
  {
    var cl = document.getElementsByName('sect1_20')[1].value;
    document.getElementById('disp_text20').setAttribute("value",cl); 
    document.getElementById('sect20_hidden').setAttribute("value","0");
    document.getElementById('sect20_na').setAttribute("value","0");

    var select = document.getElementById('remarks20');
      select.className = 'show';
  }

  if(document.getElementsByName('sect20_na')[0].checked == true)
  {
      document.getElementById('disp_text20').setAttribute("value","0");
      document.getElementById('sect20_hidden').setAttribute("value",'NA');
      document.getElementById('sect20_na').setAttribute("value","1");
      document.getElementById("sect20_na").disabled = true;
      overall_1 = 10;

      var select = document.getElementById('remarks20');
      select.className = 'show';
  }
}



function sect21()
{

  if(document.getElementsByName('sect1_21')[0].checked == true)
  {
    var cl = document.getElementsByName('sect1_21')[0].value;
    document.getElementById('disp_text21').setAttribute("value",cl); 
    document.getElementById('sect21_hidden').setAttribute("value","5");
    document.getElementById('sect21_na').setAttribute("value","0");

    var select = document.getElementById('remarks21');
      select.className = 'hide';
  }
  if(document.getElementsByName('sect1_21')[1].checked == true)
  {
    var cl = document.getElementsByName('sect1_21')[1].value;
    document.getElementById('disp_text21').setAttribute("value",cl); 
    document.getElementById('sect21_hidden').setAttribute("value","0");
    document.getElementById('sect21_na').setAttribute("value","0");

    var select = document.getElementById('remarks21');
      select.className = 'show';
  }

  if(document.getElementsByName('sect21_na')[0].checked == true)
  {
      document.getElementById('disp_text21').setAttribute("value","0");
      document.getElementById('sect21_hidden').setAttribute("value",'NA');
      document.getElementById('sect21_na').setAttribute("value","1");
      document.getElementById("sect21_na").disabled = true;
      overall_1 = 10;

      var select = document.getElementById('remarks21');
      select.className = 'show';
  }
}



function sect22()
{

  if(document.getElementsByName('sect1_22')[0].checked == true)
  {
    var cl = document.getElementsByName('sect1_22')[0].value;
    document.getElementById('disp_text22').setAttribute("value",cl); 
    document.getElementById('sect22_hidden').setAttribute("value","5");
    document.getElementById('sect22_na').setAttribute("value","0");

    var select = document.getElementById('remarks22');
      select.className = 'hide';
  }
  if(document.getElementsByName('sect1_22')[1].checked == true)
  {
    var cl = document.getElementsByName('sect1_22')[1].value;
    document.getElementById('disp_text22').setAttribute("value",cl); 
    document.getElementById('sect22_hidden').setAttribute("value","0");
    document.getElementById('sect22_na').setAttribute("value","0");

    var select = document.getElementById('remarks22');
      select.className = 'show';
  }

  if(document.getElementsByName('sect22_na')[0].checked == true)
  {
      document.getElementById('disp_text22').setAttribute("value","0");
      document.getElementById('sect22_hidden').setAttribute("value",'NA');
      document.getElementById('sect22_na').setAttribute("value","1");
      document.getElementById("sect22_na").disabled = true;
      overall_1 = 10;

      var select = document.getElementById('remarks22');
      select.className = 'show';
  }
}


function sect23()
{

  if(document.getElementsByName('sect1_23')[0].checked == true)
  {
    var cl = document.getElementsByName('sect1_23')[0].value;
    document.getElementById('disp_text23').setAttribute("value",cl); 
    document.getElementById('sect23_hidden').setAttribute("value","5");
    document.getElementById('sect23_na').setAttribute("value","0");

    var select = document.getElementById('remarks23');
      select.className = 'hide';
  }
  if(document.getElementsByName('sect1_23')[1].checked == true)
  {
    var cl = document.getElementsByName('sect1_23')[1].value;
    document.getElementById('disp_text23').setAttribute("value",cl); 
    document.getElementById('sect23_hidden').setAttribute("value","0");
    document.getElementById('sect23_na').setAttribute("value","0");

    var select = document.getElementById('remarks23');
      select.className = 'show';
  }

  if(document.getElementsByName('sect23_na')[0].checked == true)
  {
      document.getElementById('disp_text23').setAttribute("value","0");
      document.getElementById('sect23_hidden').setAttribute("value",'NA');
      document.getElementById('sect23_na').setAttribute("value","1");
      document.getElementById("sect23_na").disabled = true;
      overall_1 = 10;

      var select = document.getElementById('remarks23');
      select.className = 'show';
  }
}



function sect24()
{

  if(document.getElementsByName('sect1_24')[0].checked == true)
  {
    var cl = document.getElementsByName('sect1_24')[0].value;
    document.getElementById('disp_text24').setAttribute("value",cl); 
    document.getElementById('sect24_hidden').setAttribute("value","5");
    document.getElementById('sect24_na').setAttribute("value","0");

    var select = document.getElementById('remarks24');
      select.className = 'hide';
  }
  if(document.getElementsByName('sect1_24')[1].checked == true)
  {
    var cl = document.getElementsByName('sect1_24')[1].value;
    document.getElementById('disp_text24').setAttribute("value",cl); 
    document.getElementById('sect24_hidden').setAttribute("value","0");
    document.getElementById('sect24_na').setAttribute("value","0");

    var select = document.getElementById('remarks24');
      select.className = 'show';
  }

  if(document.getElementsByName('sect24_na')[0].checked == true)
  {
      document.getElementById('disp_text24').setAttribute("value","0");
      document.getElementById('sect24_hidden').setAttribute("value",'NA');
      document.getElementById('sect24_na').setAttribute("value","1");
      document.getElementById("sect24_na").disabled = true;
      overall_1 = 10;

      var select = document.getElementById('remarks24');
      select.className = 'show';
  }
}


function sect25()
{

  if(document.getElementsByName('sect1_25')[0].checked == true)
  {
    var cl = document.getElementsByName('sect1_25')[0].value;
    document.getElementById('disp_text25').setAttribute("value",cl); 
    document.getElementById('sect25_hidden').setAttribute("value","5");
    document.getElementById('sect25_na').setAttribute("value","0");

    var select = document.getElementById('remarks25');
      select.className = 'hide';
  }
  if(document.getElementsByName('sect1_25')[1].checked == true)
  {
    var cl = document.getElementsByName('sect1_25')[1].value;
    document.getElementById('disp_text25').setAttribute("value",cl); 
    document.getElementById('sect25_hidden').setAttribute("value","0");
    document.getElementById('sect25_na').setAttribute("value","0");

    var select = document.getElementById('remarks25');
      select.className = 'show';
  }

  if(document.getElementsByName('sect25_na')[0].checked == true)
  {
      document.getElementById('disp_text25').setAttribute("value","0");
      document.getElementById('sect25_hidden').setAttribute("value",'NA');
      document.getElementById('sect25_na').setAttribute("value","1");
      document.getElementById("sect25_na").disabled = true;
      overall_1 = 10;

      var select = document.getElementById('remarks25');
      select.className = 'show';
  }
}



</script>

</head>

<META content="MSHTML 6.00.2900.2180" name=GENERATOR></HEAD>
<!-- <BODY onload='sect1(); sect2(); sect3(); sect4(); sect5(); sect51(); sect41(); sect6(); sect7(); sect8(); sect9(); sect10(); sect11(); sect12(); sect121();'> -->
<BODY >

HTMLEND
require "/var/www/cgi-bin/greettech/menu_body_greettech.pl";
print <<HTMLEND;


<br><br>
<!-- <marquee style='color: red;font-size: 25px;'>Application Under Maintenance</marquee> -->
<CENTER><table width="64%"  border=0 cellpadding="0" cellspacing="0" bordercolor="#990000"><tr>
<td height="20" bgcolor="#990000"><div align="center" class="style19">Atria Power Quality Evaluation Sheet</div></td>
</tr>



</table><BR>

<form id='fedt' name='fedt'  method='GET'  onsubmit="return unique1();" novalidate>
<!-- <br><h4>$td2</h4>
<br><h4>$td3</h4> -->
<!-- Ticket and Evaluation Details -->

<fieldset style="width: 1000px; height: 3000px; BORDER-COLOR: #E0FFFF;">
<legend align="center"><font color=#7E2217 size=3><b>Review Form<b></font></legend>
<br>
<table border=0 width=900>
<tr><td><font face=Arial><b>Name:&nbsp;</b></font></td><td><font face=Arial>$empl_name&nbsp;</font></td><td><font face=Arial><b>Call Date:&nbsp;</b></font></td><td>&nbsp;<select id ='cmbDay' name='cmbDay' style="width=40">$cmbDay</select>&nbsp;<select id ='cmbMonth' name='cmbMonth' style="width=40">$cmbMonth</select>&nbsp;<select id ='cmbYear' name='cmbYear' style="width=60">$cmbYear</select></td></tr>
<tr><td><font face=Arial><b>EmplNO:&nbsp;</b></font></td><td><font face=Arial>$idelement&nbsp;</font></td><td><font face=Arial><b>Lead Stage:&nbsp;</b></font></td><td><font face=Arial><select name='leadstage'><option value="">Select</option>$leadop</select></font></td></tr>
<tr><td><font face=Arial><b>Feedback Date and Time:&nbsp;</b></font></td><td>&nbsp;<select id ='cmbDay' name='cmbDay' style="width=40">$cmbDay</select>&nbsp;<select id ='cmbMonth' name='cmbMonth' style="width=40">$cmbMonth</select>&nbsp;<select id ='cmbYear' name='cmbYear' style="width=60">$cmbYear</select></td><td><font face=Arial><b>Channel:&nbsp;</b></font></td><td><font face=Arial><select name='channel'><option value="">Select</option>$chandop</select></font></td></tr>
<tr>
<td><font face=Arial><b>Customer Name:</b></font></td><td><font face=Arial> <input type="text" name="customer_name"></br></td>

<td><font face=Arial><b>Source</b></font></td>
<td><font face=Arial> <select id='source' name='source' >
<option value="">Select</option>
$sourcedop
</select></br></td></tr>



<!-- ------------------------------------------- ADDITIONAL CATEGORIES -------------------------------- -->

<tr>
	<td><font face=Arial><b>Customer Phone No:</b></font></td>
	<td>
		<input type="text" name="cust_ph_no">
	</td>
	
	<td><font face=Arial><b>Call Type</b></font></td>
	<td>
		<select id='pro_type' name='pro_type'>
			<option value='Select'>Select</option>
      <option value='Inbound'>Inbound</option>
      <option value='Outbound'>Outbound</option>
			
		</select>
	</td>
</tr>

<tr >
  <td><font face=Arial><b>Lead Id:&nbsp;</b></font></td><td><font face=Arial><input type=text id=leadid name=leadid></font></td>
  <td><font face=Arial><b>Call Duration:</b></font></td><td><font face=Arial><input type=text id=calltype name=calltype></font></td>

</tr>

<tr>
  <td><font face=Arial><b>Evaluation Type:&nbsp;</b></font></td><td><font face=Arial><input type=text id=evalutiontype name=evalutiontype></font></td>
  <td><font face=Arial><b>Evalutor Name:</b></font></td><td><font face=Arial><input type=text id=callduration name=callduration></font></td>

</tr>
<!-- ------------------------------------------- ADDITIONAL CATEORIES -------------------------------- -->


</table>
<br><br><br>
<!--#####################################Comments###########################################-->
<legend><font color='#7E2217' size=3><b><u>Evaluation Criteria</u></b></font></legend>
<center><table border=0 cellspacing=0 cellpadding=7 width=900>
$tr

</table>
$tdsub
</center>
<br>
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
<input type=hidden id='sect15_hidden' name=sect15_hidden>
<input type=hidden id='sect16_hidden' name=sect16_hidden>
<input type=hidden id='sect17_hidden' name=sect17_hidden>
<input type=hidden id='sect18_hidden' name=sect18_hidden>
<input type=hidden id='sect19_hidden' name=sect19_hidden>
<input type=hidden id='sect20_hidden' name=sect20_hidden>
<input type=hidden id='sect21_hidden' name=sect21_hidden>
<input type=hidden id='sect22_hidden' name=sect22_hidden>
<input type=hidden id='sect23_hidden' name=sect23_hidden>
<input type=hidden id='sect24_hidden' name=sect24_hidden>
<input type=hidden id='sect25_hidden' name=sect25_hidden>
</form>
</body>
</html>

HTMLEND
;
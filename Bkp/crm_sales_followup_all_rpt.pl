#!/usr/bin/perl

require "/var/www/cgi-bin/greettech/database.pl";
&database;
require "/var/www/cgi-bin/greettech/request.pl";
&request;
require "/var/www/cgi-bin/greettech/timediff.pl";
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
$user=$qpairs{user};
$access=$qpairs{access};
$random=$qpairs{random};
$file=$qpairs{file};



#Compares Date 
$cmprdayfrom=$qpairs{cmprdayfrom};
$cmprmonthfrom=$qpairs{cmprmonthfrom};
$cmpryearfrom=$qpairs{cmpryearfrom};
$cmprdayto=$qpairs{cmprdayto};
$cmprmonthto=$qpairs{cmprmonthto};
$cmpryearto=$qpairs{cmpryearto};



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

$date1 =  "$currYear"."-"."$currMonth"."-"."$currDay";
$time1 =  "$todayhour:$todayminute:$todaysecond";



for($i=1; $i<=31; $i++){
 if($i == $cmprdayfrom){
 $cmbDay = $cmbDay . "<option value=".$i." selected>".$i."</option>\n";
 }elsif($i == $currDay && $cmprdayfrom eq ''){
  $cmbDay = $cmbDay . "<option value=".$i." selected>".$i."</option>\n";
  }else{
   $cmbDay = $cmbDay . "<option value=".$i.">".$i."</option>\n";
   }
}
for($i=1; $i<=12; $i++){
 if($i == $cmprmonthfrom){
 $cmbMonth = $cmbMonth . "<option value=".$i." selected>".$i."</option>\n";
 }elsif($i == $todaymonth && $cmprmonthfrom eq ''){
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

for($i=1; $i<=31; $i++){
 if($i == $cmprdayto){
 $cmbDayTo = $cmbDayTo . "<option value=".$i." selected>".$i."</option>\n";
 }elsif($i == $currDay && $cmprdayto eq ''){
  $cmbDayTo = $cmbDayTo . "<option value=".$i." selected>".$i."</option>\n";
  }else{
   $cmbDayTo = $cmbDayTo . "<option value=".$i.">".$i."</option>\n";
   }
}
for($i=1; $i<=12; $i++){
 if($i == $cmprmonthto){
 $cmbMonthTo = $cmbMonthTo . "<option value=".$i." selected>".$i."</option>\n";
 }elsif($i == $todaymonth && $cmprmonthto eq ''){
  $cmbMonthTo = $cmbMonthTo . "<option value=".$i." selected>".$i."</option>\n";
  }else{
   $cmbMonthTo = $cmbMonthTo . "<option value=".$i.">".$i."</option>\n";
   }
}
for($i=2005; $i<=$currYear+1; $i++){
  if($i == $currYear){
  $cmbYearTo = $cmbYearTo . "<option value=".$i." selected>".$i."</option>\n";
  }else{
   $cmbYearTo = $cmbYearTo . "<option value=".$i.">".$i."</option>\n";
   }
}

if($cmprdayfrom < 10){
$cmprdayfrom = "0".$cmprdayfrom;
}if($cmprmonthfrom < 10){
$cmprmonthfrom = "0".$cmprmonthfrom;
}
if($cmprdayto < 10){
$cmprdayto = "0".$cmprdayto;
}if($cmprmonthto < 10){
$cmprmonthto = "0".$cmprmonthto;
}


	$cmprdatefrom = $cmpryearfrom."-".$cmprmonthfrom."-".$cmprdayfrom." 00:00:00";
	$cmprdateto = $cmpryearto."-".$cmprmonthto."-".$cmprdayto." 23:59:59";

if($cmprdayfrom == 0)
{
	$cmprdatefrom = $date1." 00:00:00";
	$cmprdateto = $date1." 23:59:59";
}


$sel_empl_no = $qpairs{empl_no};


#****************************** To Display The Employee Name in the Drop Down **********************#


$empl_name1 ='All Executives';
$empl_id ='1';
push @empl_name1, $empl_name1;
push @empl_id, $empl_id;



$sp = "select empl_no as empl_id,fname,mname,lname,1 from employee_details where quit_no=0 and category in(9) order by empl_no";
$sp = $db->prepare($sp);
$sp->execute();
$rowssp=$sp->rows;
$sp->bind_columns(\$empl_id,\$fname,\$mname,\$lname,\$dummy);
while($res3sp=$sp->fetchrow_array)
{

$empl_name1 = $fname." ".$mname." ".$lname;

push @empl_name1,$empl_name1;
push @empl_id,$empl_id;

$len_empl = @empl_id;






}






#$none='Select';
#$employee_name = $employee_name. "<option selected>".$none."</option>\n";


for($i=0; $i<$len_empl; $i++)
{


if($sel_empl_no == $empl_id[$i])
{
$employee_name = $employee_name. "<option value=".$empl_id[$i]." selected>".$empl_name1[$i]."</option>\n";
}

else
{

$employee_name = $employee_name. "<option value=".$empl_id[$i].">".$empl_name1[$i]."</option>\n";

}

}



#****************************************************************************************************#




$empl_cat=$qpairs{empl_cat};


if($empl_cat == 1)
	{
		$combo .= "<option value=1 selected>Follow up</option>";
		$combo .= "<option value=2>Closed</option>";
		$combo .= "<option value=3>Dropped</option>";
		$combo .= "<option value=4>Confirmed</option>";
		$combo .= "<option value=0>All</option>";
	}
	elsif($empl_cat == 2)
	{
		$combo .= "<option value=1>Follow up</option>";
		$combo .= "<option value=2 selected>Closed</option>";
		$combo .= "<option value=3>Dropped</option>";
		$combo .= "<option value=4>Confirmed</option>";
		$combo .= "<option value=0 >All</option>";
	}
	
	
	elsif($empl_cat == 3)
	{
		$combo .= "<option value=1>Follow up</option>";
		$combo .= "<option value=2 >Closed</option>";
		$combo .= "<option value=3 selected>Dropped</option>";
		$combo .= "<option value=4>Confirmed</option>";
		$combo .= "<option value=0 >All</option>";
	}
	elsif($empl_cat == 4)
	{
		$combo .= "<option value=1>Follow up</option>";
		$combo .= "<option value=2 >Closed</option>";
		$combo .= "<option value=3>Dropped</option>";
		$combo .= "<option value=4 selected>Confirmed</option>";
		$combo .= "<option value=0 >All</option>";
	}
	
	
	else
	{		
		$combo .= "<option value=1>Follow up</option>";
		$combo .= "<option value=2>Closed</option>";
		$combo .= "<option value=3>Dropped</option>";
		$combo .= "<option value=4>Confirmed</option>";
		$combo .= "<option value=0 selected>All</option>";
	}	

	$dept .="<font face=Arial size=2px><b>&nbsp;From&nbsp;:&nbsp;&nbsp;</b></font><select name=cmbDayFrom id=cmbDayFrom>$cmbDay</select>&nbsp;<select name=cmbMonthFrom id=cmbMonthFrom>$cmbMonth</select>&nbsp;<select name=cmbYearFrom id=cmbYearFrom>$cmbYear</select>&nbsp;<font face=Arial size=2px><b>&nbsp;To&nbsp;:&nbsp;&nbsp;</b></font><select name=cmbDayTo id=cmbDayTo>$cmbDayTo</select>&nbsp;<select name=cmbMonthTo id=cmbMonthTo>$cmbMonthTo</select>&nbsp;<select name=cmbYearTo id=cmbYearTo>$cmbYearTo</select>&nbsp;<font face=Arial size=2px><b>&nbsp;Name&nbsp;:&nbsp;&nbsp;</b></font>&nbsp;<select name=cmbName id=cmbName style= 'width=150'>$employee_name</select>&nbsp;<font face=Arial size=2px><b>&nbsp;Status&nbsp;:&nbsp;&nbsp;</b></font><select name='cat_no' id='cat_no' width=10 >$combo</select>&nbsp;&nbsp;<input class=style6 type=button name=addmore value='GO' onclick='redirback();'>";




#**********************************************************************************#




if($sel_empl_no == 1)
{


#*************************** For Pending ****************************#


if($empl_cat == 1)
{


# $q1="select lead_no,1 from crm_sales_followup where  pending_flag='1' and closed_flag = '0' and droped_flag='0' and confirmed_flag='0'  and entered_date >='$cmprdatefrom' and entered_date <='$cmprdateto' group by lead_no";
$q1="select lead_no,1 from crm_sales_followup where  pending_flag='1' and closed_flag = '0' and droped_flag='0' and confirmed_flag='0'  and call_back_date >='$cmprdatefrom' and call_back_date <='$cmprdateto' group by lead_no";
# print $q1."<br>";
$ph1 = $db->prepare($q1);
$ph1->execute();
$rows1=$ph1->rows;
$ph1->bind_columns(\$lead_no,\$dummy);
while($res1ph=$ph1->fetchrow_array){

push @lead_no,$lead_no;

}




$len=@lead_no;
print $len."<br>";


for($p=0;$p<$len;$p++)
{
	


	$te1 = $db->prepare("select entered_by_transfered_to,pending_flag,closed_flag,droped_flag,confirmed_flag,1 from crm_sales_followup where lead_no='$lead_no[$p]' order by id desc limit 1");
	$te1->execute();
	$rowsa1=$te1->rows;
	$te1->bind_columns(\$last_empl_no,\$pending_flag,\$closed_flag,\$droped_flag,\$confirmed_flag,\$dummy);
	while($resgatepass1=$te1->fetchrow_array){}

	


	if(($pending_flag == 1) && ($closed_flag == 0) && ($droped_flag == 0) && ($confirmed_flag == 0) )
	{

	$m++;
	
	$te1 = $db->prepare("select cust_reply,call_back_date,call_back_time,entered_by_transfered_to,entered_date,1 from crm_sales_followup where lead_no='$lead_no[$p]'");
	$te1->execute();
	$rowsa1=$te1->rows;
	$te1->bind_columns(\$cust_reply,\$call_back_date,\$call_back_time,\$entered_by_transfered_to,\$entered_date,\$dummy);
	while($resgatepass1=$te1->fetchrow_array){
	

	

	$cust_reply_all .=$cust_reply."<br><br>";

	$call_back_date_all .=$call_back_date."<br><br>";

	$call_back_time_all .=$call_back_time."<br><br>";


	$entered_date_all .=$entered_date."<br><br>";

$edtgatepass= $db->prepare("select  fname,mname,lname,1 from employee_details where empl_no='$entered_by_transfered_to'" );
$edtgatepass->execute();
$edtgatepass->bind_columns(\$fname1,\$mname1,\$lname1,\$dummy);
while($resgatepass=$edtgatepass->fetchrow_array)
{
}

	$empl_name_all .= $fname1." ".$mname1." ".$lname1."<br><br>";




	
	
	
	}
	
	
	$status = 'Follow up.';

	$td .="<tr><td align='center'>".$m."</td><td align='center'>".$lead_no[$p]."</td><td align='center'>".$cust_reply_all."</td><td align='center'>".$call_back_date_all."</td><td align='center'>".$call_back_time_all."</td><td align='center'>".$entered_date_all."</td><td align='center'>".$empl_name_all."</td><td align='center'><b>".$status."</b></td></tr>";
	
	
	$cust_reply_all = "";
	$call_back_date_all = "";
	$call_back_time_all = "";
	$entered_date_all = "";
	$empl_name_all = "";

	
	
	}


}



}









#*************************** For Closed ****************************#

elsif($empl_cat == 2)
{




$q1="select lead_no,1 from crm_sales_followup where  pending_flag='0' and closed_flag = '1' and droped_flag='0' and confirmed_flag='0' and entered_date >='$cmprdatefrom' and entered_date <='$cmprdateto' group by lead_no";
$ph1 = $db->prepare($q1);
$ph1->execute();
$rows1=$ph1->rows;
$ph1->bind_columns(\$lead_no,\$dummy);
while($res1ph=$ph1->fetchrow_array){

push @lead_no,$lead_no;

}




$len=@lead_no;



for($q=0;$q<$len;$q++)
{
	


	$te1 = $db->prepare("select entered_by_transfered_to,pending_flag,closed_flag,droped_flag,confirmed_flag,1 from crm_sales_followup where lead_no='$lead_no[$q]' order by id desc limit 1");
	$te1->execute();
	$rowsa1=$te1->rows;
	$te1->bind_columns(\$last_empl_no,\$pending_flag,\$closed_flag,\$droped_flag,\$confirmed_flag,\$dummy);
	while($resgatepass1=$te1->fetchrow_array){}

	


	if(($pending_flag == 0) && ($closed_flag == 1) && ($droped_flag == 0) && ($confirmed_flag == 0) )
	{

	$m++;
	
	$te1 = $db->prepare("select cust_reply,call_back_date,call_back_time,entered_by_transfered_to,entered_date,1 from crm_sales_followup where lead_no='$lead_no[$q]'");
	$te1->execute();
	$rowsa1=$te1->rows;
	$te1->bind_columns(\$cust_reply,\$call_back_date,\$call_back_time,\$entered_by_transfered_to,\$entered_date,\$dummy);
	while($resgatepass1=$te1->fetchrow_array){
	

	

	$cust_reply_all .=$cust_reply."<br><br>";

	$call_back_date_all .=$call_back_date."<br><br>";

	$call_back_time_all .=$call_back_time."<br><br>";

	$entered_date_all .=$entered_date."<br><br>";
	

$edtgatepass= $db->prepare("select  fname,mname,lname,1 from employee_details where empl_no='$entered_by_transfered_to'" );
$edtgatepass->execute();
$edtgatepass->bind_columns(\$fname1,\$mname1,\$lname1,\$dummy);
while($resgatepass=$edtgatepass->fetchrow_array)
{
}

	$empl_name_all .= $fname1." ".$mname1." ".$lname1."<br><br>";




	
	
	
	}
	
	
	$status = 'Closed.';

	$td .="<tr><td align='center'>".$m."</td><td align='center'>".$lead_no[$q]."</td><td align='center'>".$cust_reply_all."</td><td align='center'>".$call_back_date_all."</td><td align='center'>".$call_back_time_all."</td><td align='center'>".$entered_date_all."</td><td align='center'>".$empl_name_all."</td><td align='center'><b>".$status."</b></td></tr>";
	
	
	$cust_reply_all = "";
	$call_back_date_all = "";
	$call_back_time_all = "";
	$entered_date_all = "";
	$empl_name_all = "";

	
	
	}


}






}







#*************************** For Dropped ****************************#


elsif($empl_cat == 3)
{




$q1="select lead_no,1 from crm_sales_followup where  pending_flag='0' and closed_flag = '0' and droped_flag='1' and confirmed_flag='0' and entered_date >='$cmprdatefrom' and entered_date <='$cmprdateto' group by lead_no";
$ph1 = $db->prepare($q1);
$ph1->execute();
$rows1=$ph1->rows;
$ph1->bind_columns(\$lead_no,\$dummy);
while($res1ph=$ph1->fetchrow_array){

push @lead_no,$lead_no;

}




$len=@lead_no;



for($q=0;$q<$len;$q++)
{
	


	$te1 = $db->prepare("select entered_by_transfered_to,pending_flag,closed_flag,droped_flag,confirmed_flag,1 from crm_sales_followup where lead_no='$lead_no[$q]' order by id desc limit 1");
	$te1->execute();
	$rowsa1=$te1->rows;
	$te1->bind_columns(\$last_empl_no,\$pending_flag,\$closed_flag,\$droped_flag,\$confirmed_flag,\$dummy);
	while($resgatepass1=$te1->fetchrow_array){}

	


	if(($pending_flag == 0) && ($closed_flag == 0) && ($droped_flag == 1) && ($confirmed_flag == 0) )
	{

	$m++;
	
	#$te1 = $db->prepare("select cust_reply,call_back_date,call_back_time,entered_by_transfered_to,entered_date,1 from crm_sales_followup where lead_no='$lead_no[$q]'");
	$te1 = $db->prepare("select cust_reply,call_back_date,call_back_time,entered_by_transfered_to,entered_date,droped_reason,1 from crm_sales_followup where lead_no='$lead_no[$q]'");
	$te1->execute();
	$rowsa1=$te1->rows;
	$te1->bind_columns(\$cust_reply,\$call_back_date,\$call_back_time,\$entered_by_transfered_to,\$entered_date,\$droped_reason,\$dummy);
	while($resgatepass1=$te1->fetchrow_array){
	

	

	$cust_reply_all .=$cust_reply."<br><br>";

	$call_back_date_all .=$call_back_date."<br><br>";

	$call_back_time_all .=$call_back_time."<br><br>";

	$entered_date_all .=$entered_date."<br><br>";
	

$edtgatepass= $db->prepare("select  fname,mname,lname,1 from employee_details where empl_no='$entered_by_transfered_to'" );
$edtgatepass->execute();
$edtgatepass->bind_columns(\$fname1,\$mname1,\$lname1,\$dummy);
while($resgatepass=$edtgatepass->fetchrow_array)
{
}

	$empl_name_all .= $fname1." ".$mname1." ".$lname1."<br><br>";




	
	
	
	}
	
	
#*********************************** To Take up the Dropped Reason ***********************************#

#	$te119 = $db->prepare("select cust_reply,call_back_date,call_back_time,entered_by_transfered_to,entered_date,1 from crm_sales_followup where lead_no='$lead_no[$q]'");
#	$te119->execute();
#	$rowsa119=$te119->rows;
#	$te119->bind_columns(\$cust_reply,\$call_back_date,\$call_back_time,\$entered_by_transfered_to,\$entered_date,\$dummy);
#	while($resgatepass119=$te119->fetchrow_array){	}


	

#*****************************************************************************************************#
	
	
	
	$status = 'Dropped.';

	#$td .="<tr><td align='center'>".$m."</td><td align='center'>".$lead_no[$q]."</td><td align='center'>".$cust_reply_all."</td><td align='center'>".$call_back_date_all."</td><td align='center'>".$call_back_time_all."</td><td align='center'>".$entered_date_all."</td><td align='center'>".$empl_name_all."</td><td align='center'><b>".$status."</b></td></tr>";
	
	$td .="<tr><td align='center'>".$m."</td><td align='center'><p><a href=\"#\" onMouseover=\"ddrivetip(\'$droped_reason\',\'#F3F3F3\', 170)\"; onMouseout=\"hideddrivetip()\">".$lead_no[$q]."</a></p></td><td align='center'>".$cust_reply_all."</td><td align='center'>".$call_back_date_all."</td><td align='center'>".$call_back_time_all."</td><td align='center'>".$entered_date_all."</td><td align='center'>".$empl_name_all."</td><td align='center'><b>".$status."</b></td></tr>";
	
	$cust_reply_all = "";
	$call_back_date_all = "";
	$call_back_time_all = "";
	$entered_date_all = "";
	$empl_name_all = "";

	
	
	}


}






}











#*************************** For Confirmed ****************************#

elsif($empl_cat == 4)
{




$q1="select lead_no,1 from crm_sales_followup where  pending_flag='0' and closed_flag = '0' and droped_flag='0' and confirmed_flag='1' and entered_date >='$cmprdatefrom' and entered_date <='$cmprdateto' group by lead_no";
$ph1 = $db->prepare($q1);
$ph1->execute();
$rows1=$ph1->rows;
$ph1->bind_columns(\$lead_no,\$dummy);
while($res1ph=$ph1->fetchrow_array){

push @lead_no,$lead_no;

}




$len=@lead_no;



for($q=0;$q<$len;$q++)
{
	


	$te1 = $db->prepare("select entered_by_transfered_to,pending_flag,closed_flag,droped_flag,confirmed_flag,1 from crm_sales_followup where lead_no='$lead_no[$q]' order by id desc limit 1");
	$te1->execute();
	$rowsa1=$te1->rows;
	$te1->bind_columns(\$last_empl_no,\$pending_flag,\$closed_flag,\$droped_flag,\$confirmed_flag,\$dummy);
	while($resgatepass1=$te1->fetchrow_array){}

	


	if(($pending_flag == 0) && ($closed_flag == 0) && ($droped_flag == 0) && ($confirmed_flag == 1) )
	{

	$m++;
	
	$te1 = $db->prepare("select cust_reply,call_back_date,call_back_time,entered_by_transfered_to,entered_date,1 from crm_sales_followup where lead_no='$lead_no[$q]'");
	$te1->execute();
	$rowsa1=$te1->rows;
	$te1->bind_columns(\$cust_reply,\$call_back_date,\$call_back_time,\$entered_by_transfered_to,\$entered_date,\$dummy);
	while($resgatepass1=$te1->fetchrow_array){
	

	

	$cust_reply_all .=$cust_reply."<br><br>";

	$call_back_date_all .=$call_back_date."<br><br>";

	$call_back_time_all .=$call_back_time."<br><br>";

	$entered_date_all .=$entered_date."<br><br>";
	

$edtgatepass= $db->prepare("select  fname,mname,lname,1 from employee_details where empl_no='$entered_by_transfered_to'" );
$edtgatepass->execute();
$edtgatepass->bind_columns(\$fname1,\$mname1,\$lname1,\$dummy);
while($resgatepass=$edtgatepass->fetchrow_array)
{
}

	$empl_name_all .= $fname1." ".$mname1." ".$lname1."<br><br>";




	
	
	
	}
	
	
	$status = 'Confirmed.';

	$td .="<tr><td align='center'>".$m."</td><td align='center'>".$lead_no[$q]."</td><td align='center'>".$cust_reply_all."</td><td align='center'>".$call_back_date_all."</td><td align='center'>".$call_back_time_all."</td><td align='center'>".$entered_date_all."</td><td align='center'>".$empl_name_all."</td><td align='center'><b>".$status."</b></td></tr>";
	
	
	$cust_reply_all = "";
	$call_back_date_all = "";
	$call_back_time_all = "";
	$entered_date_all = "";
	$empl_name_all = "";

	
	
	}


}






}







#************************************** For All ***********************************#



else
{

$q1="select lead_no,1 from crm_sales_followup where entered_date >='$cmprdatefrom' and entered_date <='$cmprdateto' group by lead_no";
$ph1 = $db->prepare($q1);
$ph1->execute();
$rows1=$ph1->rows;
$ph1->bind_columns(\$lead_no,\$dummy);
while($res1ph=$ph1->fetchrow_array){

push @lead_no,$lead_no;

}



$len=@lead_no;


for($r=0;$r<$len;$r++)
{


	$te1 = $db->prepare("select entered_by_transfered_to,pending_flag,closed_flag,droped_flag,confirmed_flag,1 from crm_sales_followup where lead_no='$lead_no[$r]' order by id desc limit 1");
	$te1->execute();
	$rowsa1=$te1->rows;
	$te1->bind_columns(\$last_empl_no,\$pending_flag,\$closed_flag,\$droped_flag,\$confirmed_flag,\$dummy);
	while($resgatepass1=$te1->fetchrow_array){}





$m++;




	$te1 = $db->prepare("select cust_reply,call_back_date,call_back_time,entered_by_transfered_to,entered_date,droped_reason,1 from crm_sales_followup where lead_no='$lead_no[$r]'");
	$te1->execute();
	$rowsa1=$te1->rows;
	$te1->bind_columns(\$cust_reply,\$call_back_date,\$call_back_time,\$entered_by_transfered_to,\$entered_date,\$droped_reason,\$dummy);
	while($resgatepass1=$te1->fetchrow_array){
	

	

	$cust_reply_all .=$cust_reply."<br><br>";

	$call_back_date_all .=$call_back_date."<br><br>";

	$call_back_time_all .=$call_back_time."<br><br>";
	
	$entered_date_all .=$entered_date."<br><br>";

$edtgatepass= $db->prepare("select  fname,mname,lname,1 from employee_details where empl_no='$entered_by_transfered_to'" );
$edtgatepass->execute();
$edtgatepass->bind_columns(\$fname1,\$mname1,\$lname1,\$dummy);
while($resgatepass=$edtgatepass->fetchrow_array)
{
}

	$empl_name_all .= $fname1." ".$mname1." ".$lname1."<br><br>";




	
	
	
}
	



if(($pending_flag == 1) && ($closed_flag == 0) && ($droped_flag == 0) && ($confirmed_flag == 0))
{

$status = 'Followup.';

}


elsif(($pending_flag == 0) && ($closed_flag == 1) && ($droped_flag == 0) && ($confirmed_flag == 0))
{

$status = 'Closed.';

}


elsif(($pending_flag == 0) && ($closed_flag == 0) && ($droped_flag == 1) && ($confirmed_flag == 0))
{

$status = 'Dropped.';

}


elsif(($pending_flag == 0) && ($closed_flag == 0) && ($droped_flag == 0) && ($confirmed_flag == 1))
{

$status = 'Confirmed.';

}










else
{

$status = '';

}



if(($pending_flag == 0) && ($closed_flag == 0) && ($droped_flag == 1) && ($confirmed_flag == 0))
	{

$td .="<tr><td align='center'>".$m."</td><td align='center'><p><a href=\"#\" onMouseover=\"ddrivetip(\'$droped_reason\',\'#F3F3F3\', 170)\"; onMouseout=\"hideddrivetip()\">".$lead_no[$r]."</a></p></td><td align='center'>".$cust_reply_all."</td><td align='center'>".$call_back_date_all."</td><td align='center'>".$call_back_time_all."</td><td align='center'>".$entered_date_all."</td><td align='center'>".$empl_name_all."</td><td align='center'><b>".$status."</b></td></tr>";
	}

else
	{

	$td .="<tr><td align='center'>".$m."</td><td align='center'>".$lead_no[$r]."</td><td align='center'>".$cust_reply_all."</td><td align='center'>".$call_back_date_all."</td><td align='center'>".$call_back_time_all."</td><td align='center'>".$entered_date_all."</td><td align='center'>".$empl_name_all."</td><td align='center'><b>".$status."</b></td></tr>";
	
	}

$cust_reply_all = "";
$call_back_date_all = "";
$call_back_time_all = "";
$entered_date_all = "";
$empl_name_all = "";




}





}



#**********************************************************************************#



}  #End Of All Executive





#*****************************For Selected Executives **************************#

else

{








#*************************** For Pending ****************************#


if($empl_cat == 1)
{


$q1="select lead_no,1 from crm_sales_followup where entered_by_transfered_to='$sel_empl_no' and pending_flag='1' and closed_flag = '0' and droped_flag='0' and confirmed_flag='0'  and entered_date >='$cmprdatefrom' and entered_date <='$cmprdateto' group by lead_no";
$ph1 = $db->prepare($q1);
$ph1->execute();
$rows1=$ph1->rows;
$ph1->bind_columns(\$lead_no,\$dummy);
while($res1ph=$ph1->fetchrow_array){

push @lead_no,$lead_no;

}




$len=@lead_no;



for($p=0;$p<$len;$p++)
{
	


	$te1 = $db->prepare("select entered_by_transfered_to,pending_flag,closed_flag,droped_flag,confirmed_flag,1 from crm_sales_followup where lead_no='$lead_no[$p]' order by id desc limit 1");
	$te1->execute();
	$rowsa1=$te1->rows;
	$te1->bind_columns(\$last_empl_no,\$pending_flag,\$closed_flag,\$droped_flag,\$confirmed_flag,\$dummy);
	while($resgatepass1=$te1->fetchrow_array){}

	


	if(($sel_empl_no == $last_empl_no) && ($pending_flag == 1) && ($closed_flag == 0) && ($droped_flag == 0) && ($confirmed_flag == 0) )
	{

	$m++;
	
	$te1 = $db->prepare("select cust_reply,call_back_date,call_back_time,entered_by_transfered_to,entered_date,1 from crm_sales_followup where lead_no='$lead_no[$p]'");
	$te1->execute();
	$rowsa1=$te1->rows;
	$te1->bind_columns(\$cust_reply,\$call_back_date,\$call_back_time,\$entered_by_transfered_to,\$entered_date,\$dummy);
	while($resgatepass1=$te1->fetchrow_array){
	

	

	$cust_reply_all .=$cust_reply."<br><br>";

	$call_back_date_all .=$call_back_date."<br><br>";

	$call_back_time_all .=$call_back_time."<br><br>";

	$entered_date_all .=$entered_date."<br><br>";

$edtgatepass= $db->prepare("select  fname,mname,lname,1 from employee_details where empl_no='$entered_by_transfered_to'" );
$edtgatepass->execute();
$edtgatepass->bind_columns(\$fname1,\$mname1,\$lname1,\$dummy);
while($resgatepass=$edtgatepass->fetchrow_array)
{
}

	$empl_name_all .= $fname1." ".$mname1." ".$lname1."<br><br>";




	
	
	
	}
	
	
	$status = 'Followup.';

	$td .="<tr><td align='center'>".$m."</td><td align='center'>".$lead_no[$p]."</td><td align='center'>".$cust_reply_all."</td><td align='center'>".$call_back_date_all."</td><td align='center'>".$call_back_time_all."</td><td align='center'>".$entered_date_all."</td><td align='center'>".$empl_name_all."</td><td align='center'><b>".$status."</b></td></tr>";
	
	$cust_reply_all = "";
	$call_back_date_all = "";
	$call_back_time_all = "";
	$entered_date_all = "";
	$empl_name_all = "";

	
	
	}


}



}



#*************************** For Closed ****************************#

elsif($empl_cat == 2)
{




$q1="select lead_no,1 from crm_sales_followup where entered_by_transfered_to='$sel_empl_no' and pending_flag='0' and closed_flag = '1' and  droped_flag='0' and confirmed_flag='0'  and entered_date >='$cmprdatefrom' and entered_date <='$cmprdateto' group by lead_no";
$ph1 = $db->prepare($q1);
$ph1->execute();
$rows1=$ph1->rows;
$ph1->bind_columns(\$lead_no,\$dummy);
while($res1ph=$ph1->fetchrow_array){

push @lead_no,$lead_no;

}




$len=@lead_no;



for($q=0;$q<$len;$q++)
{
	


	$te1 = $db->prepare("select entered_by_transfered_to,pending_flag,closed_flag,droped_flag,confirmed_flag,1 from crm_sales_followup where lead_no='$lead_no[$q]' order by id desc limit 1");
	$te1->execute();
	$rowsa1=$te1->rows;
	$te1->bind_columns(\$last_empl_no,\$pending_flag,\$closed_flag,\$droped_flag,\$confirmed_flag,\$dummy);
	while($resgatepass1=$te1->fetchrow_array){}

	


	if(($sel_empl_no == $last_empl_no) && ($pending_flag == 0) && ($closed_flag == 1) && ($droped_flag == 0) && ($confirmed_flag == 0) )
	{

	$m++;
	
	$te1 = $db->prepare("select cust_reply,call_back_date,call_back_time,entered_by_transfered_to,entered_date,1 from crm_sales_followup where lead_no='$lead_no[$q]'");
	$te1->execute();
	$rowsa1=$te1->rows;
	$te1->bind_columns(\$cust_reply,\$call_back_date,\$call_back_time,\$entered_by_transfered_to,\$entered_date,\$dummy);
	while($resgatepass1=$te1->fetchrow_array){
	

	

	$cust_reply_all .=$cust_reply."<br><br>";

	$call_back_date_all .=$call_back_date."<br><br>";

	$call_back_time_all .=$call_back_time."<br><br>";

	$entered_date_all .=$entered_date."<br><br>";

$edtgatepass= $db->prepare("select  fname,mname,lname,1 from employee_details where empl_no='$entered_by_transfered_to'" );
$edtgatepass->execute();
$edtgatepass->bind_columns(\$fname1,\$mname1,\$lname1,\$dummy);
while($resgatepass=$edtgatepass->fetchrow_array)
{
}

	$empl_name_all .= $fname1." ".$mname1." ".$lname1."<br><br>";




	
	
	
	}
	
	
	$status = 'Closed.';

	$td .="<tr><td align='center'>".$m."</td><td align='center'>".$lead_no[$q]."</td><td align='center'>".$cust_reply_all."</td><td align='center'>".$call_back_date_all."</td><td align='center'>".$call_back_time_all."</td><td align='center'>".$entered_date_all."</td><td align='center'>".$empl_name_all."</td><td align='center'><b>".$status."</b></td></tr>";
	
	$cust_reply_all = "";
	$call_back_date_all = "";
	$call_back_time_all = "";
	$entered_date_all = "";
	$empl_name_all = "";

	
	
	}


}






}





#*************************** For Dropped ****************************#

elsif($empl_cat == 3)
{




$q1="select lead_no,1 from crm_sales_followup where entered_by_transfered_to='$sel_empl_no' and pending_flag='0' and closed_flag = '0' and droped_flag='1' and confirmed_flag='0'  and entered_date >='$cmprdatefrom' and entered_date <='$cmprdateto' group by lead_no";
$ph1 = $db->prepare($q1);
$ph1->execute();
$rows1=$ph1->rows;
$ph1->bind_columns(\$lead_no,\$dummy);
while($res1ph=$ph1->fetchrow_array){

push @lead_no,$lead_no;

}




$len=@lead_no;



for($q=0;$q<$len;$q++)
{
	


	$te1 = $db->prepare("select entered_by_transfered_to,pending_flag,closed_flag,droped_flag,confirmed_flag,1 from crm_sales_followup where lead_no='$lead_no[$q]' order by id desc limit 1");
	$te1->execute();
	$rowsa1=$te1->rows;
	$te1->bind_columns(\$last_empl_no,\$pending_flag,\$closed_flag,\$droped_flag,\$confirmed_flag,\$dummy);
	while($resgatepass1=$te1->fetchrow_array){}

	


	if(($sel_empl_no == $last_empl_no) && ($pending_flag == 0) && ($closed_flag == 0) && ($droped_flag == 1) && ($confirmed_flag == 0) )
	{

	$m++;
	
	$te1 = $db->prepare("select cust_reply,call_back_date,call_back_time,entered_by_transfered_to,entered_date,droped_reason,1 from crm_sales_followup where lead_no='$lead_no[$q]'");
	$te1->execute();
	$rowsa1=$te1->rows;
	$te1->bind_columns(\$cust_reply,\$call_back_date,\$call_back_time,\$entered_by_transfered_to,\$entered_date,\$droped_reason,\$dummy);
	while($resgatepass1=$te1->fetchrow_array){
	

	

	$cust_reply_all .=$cust_reply."<br><br>";

	$call_back_date_all .=$call_back_date."<br><br>";

	$call_back_time_all .=$call_back_time."<br><br>";

	$entered_date_all .=$entered_date."<br><br>";

$edtgatepass= $db->prepare("select  fname,mname,lname,1 from employee_details where empl_no='$entered_by_transfered_to'" );
$edtgatepass->execute();
$edtgatepass->bind_columns(\$fname1,\$mname1,\$lname1,\$dummy);
while($resgatepass=$edtgatepass->fetchrow_array)
{
}

	$empl_name_all .= $fname1." ".$mname1." ".$lname1."<br><br>";




	
	
	
	}
	
	
	$status = 'Dropped.';

	$td .="<tr><td align='center'>".$m."</td><td align='center'><p><a href=\"#\" onMouseover=\"ddrivetip(\'$droped_reason\',\'#F3F3F3\', 170)\"; onMouseout=\"hideddrivetip()\">".$lead_no[$q]."</a></p></td><td align='center'>".$cust_reply_all."</td><td align='center'>".$call_back_date_all."</td><td align='center'>".$call_back_time_all."</td><td align='center'>".$entered_date_all."</td><td align='center'>".$empl_name_all."</td><td align='center'><b>".$status."</b></td></tr>";
	
	$cust_reply_all = "";
	$call_back_date_all = "";
	$call_back_time_all = "";
	$entered_date_all = "";
	$empl_name_all = "";

	
	
	}


}






}







#*************************** For Confirmed ****************************#

elsif($empl_cat == 4)
{




$q1="select lead_no,1 from crm_sales_followup where entered_by_transfered_to='$sel_empl_no' and pending_flag='0' and closed_flag = '0' and droped_flag='0' and confirmed_flag='1'  and entered_date >='$cmprdatefrom' and entered_date <='$cmprdateto' group by lead_no";
$ph1 = $db->prepare($q1);
$ph1->execute();
$rows1=$ph1->rows;
$ph1->bind_columns(\$lead_no,\$dummy);
while($res1ph=$ph1->fetchrow_array){

push @lead_no,$lead_no;

}




$len=@lead_no;



for($q=0;$q<$len;$q++)
{
	


	$te1 = $db->prepare("select entered_by_transfered_to,pending_flag,closed_flag,droped_flag,confirmed_flag,1 from crm_sales_followup where lead_no='$lead_no[$q]' order by id desc limit 1");
	$te1->execute();
	$rowsa1=$te1->rows;
	$te1->bind_columns(\$last_empl_no,\$pending_flag,\$closed_flag,\$droped_flag,\$confirmed_flag,\$dummy);
	while($resgatepass1=$te1->fetchrow_array){}

	


	if(($sel_empl_no == $last_empl_no) && ($pending_flag == 0) && ($closed_flag == 0) && ($droped_flag == 0) && ($confirmed_flag == 1) )
	{

	$m++;
	
	$te1 = $db->prepare("select cust_reply,call_back_date,call_back_time,entered_by_transfered_to,entered_date,1 from crm_sales_followup where lead_no='$lead_no[$q]'");
	$te1->execute();
	$rowsa1=$te1->rows;
	$te1->bind_columns(\$cust_reply,\$call_back_date,\$call_back_time,\$entered_by_transfered_to,\$entered_date,\$dummy);
	while($resgatepass1=$te1->fetchrow_array){
	

	

	$cust_reply_all .=$cust_reply."<br><br>";

	$call_back_date_all .=$call_back_date."<br><br>";

	$call_back_time_all .=$call_back_time."<br><br>";

	$entered_date_all .=$entered_date."<br><br>";

$edtgatepass= $db->prepare("select  fname,mname,lname,1 from employee_details where empl_no='$entered_by_transfered_to'" );
$edtgatepass->execute();
$edtgatepass->bind_columns(\$fname1,\$mname1,\$lname1,\$dummy);
while($resgatepass=$edtgatepass->fetchrow_array)
{
}

	$empl_name_all .= $fname1." ".$mname1." ".$lname1."<br><br>";




	
	
	
	}
	
	
	$status = 'Confirmed.';

	$td .="<tr><td align='center'>".$m."</td><td align='center'>".$lead_no[$q]."</td><td align='center'>".$cust_reply_all."</td><td align='center'>".$call_back_date_all."</td><td align='center'>".$call_back_time_all."</td><td align='center'>".$entered_date_all."</td><td align='center'>".$empl_name_all."</td><td align='center'><b>".$status."</b></td></tr>";
	
	$cust_reply_all = "";
	$call_back_date_all = "";
	$call_back_time_all = "";
	$entered_date_all = "";
	$empl_name_all = "";

	
	
	}


}






}













#************************************** For All ***********************************#



else
{

$q1="select lead_no,1 from crm_sales_followup where entered_by_transfered_to='$sel_empl_no' and entered_date >='$cmprdatefrom' and entered_date <='$cmprdateto' group by lead_no";
$ph1 = $db->prepare($q1);
$ph1->execute();
$rows1=$ph1->rows;
$ph1->bind_columns(\$lead_no,\$dummy);
while($res1ph=$ph1->fetchrow_array){

push @lead_no,$lead_no;

}



$len=@lead_no;


for($r=0;$r<$len;$r++)
{


	#$te1 = $db->prepare("select entered_by_transfered_to,pending_flag,closed_flag,closed_flag,droped_flag,confirmed_flag,1 from crm_sales_followup where lead_no='$lead_no[$r]' order by id desc limit 1");
	$te1 = $db->prepare("select entered_by_transfered_to,1 from crm_sales_followup where lead_no='$lead_no[$r]' order by id desc limit 1");
	$te1->execute();
	$rowsa1=$te1->rows;
	#$te1->bind_columns(\$last_empl_no,\$pending_flag,\$closed_flag,\$droped_flag,\$confirmed_flag,\$dummy);
	$te1->bind_columns(\$last_empl_no,\$dummy);
	while($resgatepass1=$te1->fetchrow_array){}





if($sel_empl_no == $last_empl_no)  
{


$m++;




	$te1 = $db->prepare("select cust_reply,call_back_date,call_back_time,entered_by_transfered_to,entered_date,droped_reason,pending_flag,closed_flag,droped_flag,confirmed_flag,1 from crm_sales_followup where lead_no='$lead_no[$r]'");
	$te1->execute();
	$rowsa1=$te1->rows;
	$te1->bind_columns(\$cust_reply,\$call_back_date,\$call_back_time,\$entered_by_transfered_to,\$entered_date,\$droped_reason,\$pending_flag,\$closed_flag,\$droped_flag,\$confirmed_flag,\$dummy);
	while($resgatepass1=$te1->fetchrow_array){
	

	

	$cust_reply_all .=$cust_reply."<br><br>";

	$call_back_date_all .=$call_back_date."<br><br>";

	$call_back_time_all .=$call_back_time."<br><br>";

	$entered_date_all .=$entered_date."<br><br>";

$edtgatepass= $db->prepare("select  fname,mname,lname,1 from employee_details where empl_no='$entered_by_transfered_to'" );
$edtgatepass->execute();
$edtgatepass->bind_columns(\$fname1,\$mname1,\$lname1,\$dummy);
while($resgatepass=$edtgatepass->fetchrow_array)
{
}

	$empl_name_all .= $fname1." ".$mname1." ".$lname1."<br><br>";




	
	
	
}
	


if(($pending_flag == 1) && ($closed_flag == 0) && ($droped_flag == 0) && ($confirmed_flag == 0))
{

$status1 = 'Followup.';

}


elsif(($pending_flag == 0) && ($closed_flag == 1) && ($droped_flag == 0) && ($confirmed_flag == 0))
{

$status1 = 'Closed.';

}


elsif(($pending_flag == 0) && ($closed_flag == 0) && ($droped_flag == 1) && ($confirmed_flag == 0))
{

$status1 = 'Dropped.';

}


elsif(($pending_flag == 0) && ($closed_flag == 0) && ($droped_flag == 0) && ($confirmed_flag == 1))
{

$status1 = 'Confirmed.';

}


else
{

$status1 = '';

}


if(($pending_flag == 0) && ($closed_flag == 0) && ($droped_flag == 1) && ($confirmed_flag == 0))
{

$td .="<tr><td align='center'>".$m."</td><td align='center'><p><a href=\"#\" onMouseover=\"ddrivetip(\'$droped_reason\',\'#F3F3F3\', 170)\"; onMouseout=\"hideddrivetip()\">".$lead_no[$r]."</a></p></td><td align='center'>".$cust_reply_all."</td><td align='center'>".$call_back_date_all."</td><td align='center'>".$call_back_time_all."</td><td align='center'>".$entered_date_all."</td><td align='center'>".$empl_name_all."</td><td align='center'><b>".$status."</b></td></tr>";
}

else
{
$td .="<tr><td align='center'>".$m."</td><td align='center'>".$lead_no[$r]."</td><td align='center'>".$cust_reply_all."</td><td align='center'>".$call_back_date_all."</td><td align='center'>".$call_back_time_all."</td><td align='center'>".$entered_date_all."</td><td align='center'>".$empl_name_all."</td><td align='center'><b>".$status1."</b></td></tr>";

}



$cust_reply_all = "";
$call_back_date_all = "";
$call_back_time_all = "";
$entered_date_all = "";
$empl_name_all = "";

}


}





}



#**********************************************************************************#



















}




print <<HTMLEND;

<HTML><HEAD><TITLE>CRM Follow-up Details</TITLE>
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
	font-family: courier new;
	font-size: 14px;
	font-weight: bold;
	color: #000000;
}
.style8 {
	font-family: courier new;  
	font-size: 14px;
	color: #000000;
}
.style9 {font-family: Verdana, Arial, Helvetica, sans-serif}


.style19 {
	color: #FFFFFF;
	font-weight: bold;
}

.style20 {
	font-family: courier new;  
	font-size: 14px;
	color: #000000;
}

</STYLE>
</head>


<script language="JavaScript">



function redirback()
{
	var cmprdayfrom=document.getElementById('cmbDayFrom').value;
	var cmprmonthfrom=document.getElementById('cmbMonthFrom').value;
	var cmpryearfrom=document.getElementById('cmbYearFrom').value;

	var cmprdayto=document.getElementById('cmbDayTo').value;
	var cmprmonthto=document.getElementById('cmbMonthTo').value;
	var cmpryearto=document.getElementById('cmbYearTo').value;

	
	var empl_no=document.getElementById('cmbName').value;
	var empl_cat=document.getElementById('cat_no').value;
	

document.location ='crm_sales_followup_all_rpt.pl?file=$file&random=$qpairs{random}&user=$user&access=$access&cmprdayfrom='+cmprdayfrom+'&cmprmonthfrom='+cmprmonthfrom+'&cmpryearfrom='+cmpryearfrom+'&cmprdayto='+cmprdayto+'&cmprmonthto='+cmprmonthto+'&cmpryearto='+cmpryearto+'&empl_no='+empl_no+'&empl_cat='+empl_cat+'';
}


</script>






<style type="text/css">
#mousetext{
position: absolute;
width: 200px;
border: 2px solid black;
padding: 4px;
visibility: hidden;
z-index: 100;
font-family:verdana;
font-size:12px;
text-decoration:none;
}
</style>
</head>

<body>
<div id="mousetext"></div>
<p>
  <script type="text/javascript">
var offsetxpoint=-60
var offsetypoint=20
var ie=document.all
var ns6=document.getElementById && !document.all
var enabletip=false
if (ie||ns6)
var tipobj=document.all? document.all["mousetext"] : document.getElementById? document.getElementById("mousetext") : ""

function ietruebody(){
return (document.compatMode && document.compatMode!="BackCompat")? document.documentElement : document.body
}

function ddrivetip(thetext, thecolor, thewidth){
if (ns6||ie){
if (typeof thewidth!="undefined") tipobj.style.width=thewidth+"px"
if (typeof thecolor!="undefined" && thecolor!="") tipobj.style.backgroundColor=thecolor
tipobj.innerHTML=thetext
enabletip=true
return false
}
}

function positiontip(e){
if (enabletip){
var curX=(ns6)?e.pageX : event.clientX+ietruebody().scrollLeft;
var curY=(ns6)?e.pageY : event.clientY+ietruebody().scrollTop;
//Find out how close the mouse is to the corner of the window
var rightedge=ie&&!window.opera? ietruebody().clientWidth-event.clientX-offsetxpoint : window.innerWidth-e.clientX-offsetxpoint-20
var bottomedge=ie&&!window.opera? ietruebody().clientHeight-event.clientY-offsetypoint : window.innerHeight-e.clientY-offsetypoint-20

var leftedge=(offsetxpoint<0)? offsetxpoint*(-1) : -1000

//if the horizontal distance isn't enough to accomodate the width of the context menu
if (rightedge<tipobj.offsetWidth)
//move the horizontal position of the menu to the left by it's width
tipobj.style.left=ie? ietruebody().scrollLeft+event.clientX-tipobj.offsetWidth+"px" : window.pageXOffset+e.clientX-tipobj.offsetWidth+"px"
else if (curX<leftedge)
tipobj.style.left="5px"
else
//position the horizontal position of the menu where the mouse is positioned
tipobj.style.left=curX+offsetxpoint+"px"

//same concept with the vertical position
if (bottomedge<tipobj.offsetHeight)
tipobj.style.top=ie? ietruebody().scrollTop+event.clientY-tipobj.offsetHeight-offsetypoint+"px" : window.pageYOffset+e.clientY-tipobj.offsetHeight-offsetypoint+"px"
else
tipobj.style.top=curY+offsetypoint+"px"
tipobj.style.visibility="visible"
}
}

function hideddrivetip(){
if (ns6||ie){
enabletip=false
tipobj.style.visibility="hidden"
tipobj.style.left="-1000px"
tipobj.style.backgroundColor=''
tipobj.style.width=''
}
}

document.onmousemove=positiontip

</script>









<META content="MSHTML 6.00.2900.2180" name=GENERATOR></HEAD>
<BODY><br><br>

HTMLEND
require "/var/www/cgi-bin/greettech/menu_body_greettech.pl";
print <<HTMLEND;

<CENTER><table width="64%"  border=1 cellpadding="0" cellspacing="0" bordercolor="#990000"><tr>
<td height="20" bgcolor="#990000"><div align="center" class="style19">CRM Follow-up Details</div></td>
</tr></table><BR>




<form id='fedt' name='fedt' action='' method='POST'>


<br>	
$dept

<br><br><br>
<center>Total Count = $m</center>

<br>
<TABLE width=800 border=1 align=center cellPadding=0 cellSpacing=0 bordercolor="#990000">
<TBODY>
<tr bgcolor="A3AE7E">
<TD height=25 align="center" bgcolor="A3AE7E" width=50><div align="center"><span class="style20"><b>&nbsp;Sl&nbsp;No&nbsp;<b></div></TD>
<TD height=25 align=middle bgcolor="A3AE7E" width=100><span class="style20"><b>&nbsp;&nbsp;&nbsp;&nbsp;Lead&nbsp;No&nbsp;&nbsp;&nbsp;&nbsp;<b></div></TD>
<TD height=25 align=middle bgcolor="A3AE7E" width=100><span class="style20"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Customer&nbsp;Reply&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b></TD>
<TD height=25 align=middle bgcolor="A3AE7E" width=100><span class="style20"><b>&nbsp;Follow&nbsp;up&nbsp;Date&nbsp;<b></TD>
<TD height=25 align=middle bgcolor="A3AE7E" width=100><span class="style20"><b>&nbsp;Follow&nbsp;up&nbsp;Time&nbsp;<b></TD>
<TD height=25 align=middle bgcolor="A3AE7E" width=100><span class="style20"><b>&nbsp;Entered&nbsp;Date&nbsp;Time&nbsp;<b></TD>
<TD height=25 align=middle bgcolor="A3AE7E" width=100><span class="style20"><b>&nbsp;&nbsp;Handled&nbsp;By&nbsp;&nbsp;<b></TD>
<TD height=25 align=middle bgcolor="A3AE7E" width=100><span class="style20"><b>&nbsp;&nbsp;Status&nbsp;&nbsp;<b></TD>
</tr>


$td
</tr></table>

</center>


</form></body>
</html>
HTMLEND
;






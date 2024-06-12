#!/usr/bin/perl

require "/var/www/cgi-bin/greettech/variable_index.pl";
require "/var/www/cgi-bin/greettech/database.pl";
&database;
require "/var/www/cgi-bin/greettech/request.pl";
&request;
  # print "Content-type: text/html;\n\n";
use DBI;

	my $database="hrs";
	my $hostname="localhost";
	my $username="root";
	my $password="rsvp1260";

	my $db = DBI->connect("DBI:mysql:$database:$hostname",$username,$password)
	or die ("can't connect to the database");

  
  
$nowtime = time;
my($todaysecond, $todayminute, $todayhour, $todaydayofmonth, $todaymonth, $todayyear, $todayweekday, $todaydayofyear, $todayisdst)=localtime($nowtime);

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
$idelement=$qpairs{idelement};

$category=$qpairs{category};
#***************************************
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
$date =  "$currYear"."-"."$currMonth"."-"."$currDay";
$time =  "$todayhour:$todayminute:$todaysecond";
$date_time ="$date $time";

#***************************************   

   

$te = $db->prepare("select empl_no,1 from login where user_name='$user'");
$te->execute();
$rowsa=$te->rows;
$te->bind_columns(\$eval_by_emplno,\$dummy);
while($resgatepass=$te->fetchrow_array){
}


$pairs{customer_phno} =~ s/\'/\'\'/g;
$pairs{call_type} =~ s/\'/\'\'/g;

$pairs{source} =~ s/\'/\'\'/g;

$pairs{lead_stage} =~ s/\'/\'\'/g;
$pairs{Region} =~ s/\'/\'\'/g;
$pairs{Channel} =~ s/\'/\'\'/g;



$month = $pairs{cmbMonth};
$day = $pairs{cmbDay};

if($month < 10)
{
	$curmonth .= '0'.$month;
}
else
{
	$curmonth=$month;
}
if($day < 10)
{
	$curDay .= '0'.$day;
}
else
{
	$curDay=$day;
}

$call_date = $pairs{cmbYear}."-".$curmonth."-".$curDay;
$leadstage = $pairs{leadstage};
$feedbackdate = $pairs{cmbYear}."-".$curmonth."-".$curDay;
$channel = $pairs{channel};
$customer_name = $pairs{customer_name};
$source = $pairs{source};
$cust_ph_no = $pairs{cust_ph_no};
$calltype = $pairs{calltype};
$leadid = $pairs{leadid};
$callduration = $pairs{callduration};
$evalutiontype = $pairs{evalutiontype};
$callduration = $pairs{callduration};

# $sect1_hidden = $pairs{sect1_hidden};
# $sect2_hidden = $pairs{sect2_hidden};
# $sect3_hidden = $pairs{sect3_hidden};
# $sect4_hidden = $pairs{sect4_hidden};
# $sect5_hidden = $pairs{sect5_hidden};
# $sect6_hidden = $pairs{sect6_hidden};
# $sect7_hidden = $pairs{sect7_hidden};
# $sect8_hidden = $pairs{sect8_hidden};
# $sect9_hidden = $pairs{sect9_hidden};
# $sect10_hidden = $pairs{sect10_hidden};
# $sect11_hidden = $pairs{sect11_hidden};
# $sect12_hidden = $pairs{sect12_hidden};
# $sect13_hidden = $pairs{sect13_hidden};
# $sect14_hidden = $pairs{sect14_hidden};
# $sect15_hidden = $pairs{sect15_hidden};
# $sect16_hidden = $pairs{sect16_hidden};
# $sect17_hidden = $pairs{sect17_hidden};
# $sect18_hidden = $pairs{sect18_hidden};
# $sect19_hidden = $pairs{sect19_hidden};
# $sect20_hidden = $pairs{sect20_hidden};
# $sect21_hidden = $pairs{sect21_hidden};
# $sect22_hidden = $pairs{sect22_hidden};
# $sect23_hidden = $pairs{sect23_hidden};
# $sect24_hidden = $pairs{sect24_hidden};
# $sect25_hidden = $pairs{sect25_hidden};

$overall_hidden = $pairs{overall_hidden};
$overall_totScore = $pairs{overall_totScore};
$overall_percentage = $pairs{overall_percentage};
$fatal = $pairs{fatal};

$queryy = $pairs{queryy};
$callobservation = $pairs{callobservation};
$areaOfimprovement = $pairs{areaOfimprovement};
$tni = $pairs{tni};


if($pairs{sect1_hidden} eq '')
{
	$pairs{sect1_hidden} = 0;
}

if($pairs{sect2_hidden} eq '')
{
	$pairs{sect2_hidden} = 0;
}
if($pairs{sect3_hidden} eq '')
{
	$pairs{sect3_hidden} = 0;
}
if($pairs{sect4_hidden} eq '')
{
	$pairs{sect4_hidden} = 0;
}
if($pairs{sect5_hidden} eq '')
{
	$pairs{sect5_hidden} = 0;
}
if($pairs{sect6_hidden} eq '')
{
	$pairs{sect6_hidden} = 0;
}
if($pairs{sect7_hidden} eq '')
{
	$pairs{sect7_hidden} = 0;
}
if($pairs{sect8_hidden} eq '')
{
	$pairs{sect8_hidden} = 0;
}
if($pairs{sect9_hidden} eq '')
{
	$pairs{sect9_hidden} = 0;
}
if($pairs{sect10_hidden} eq '')
{
	$pairs{sect10_hidden} = 0;
}
if($pairs{sect11_hidden} eq '')
{
	$pairs{sect11_hidden} = 0;
}

if($pairs{sect12_hidden} eq '')
{
	$pairs{sect12_hidden} = 0;
}
if($pairs{sect13_hidden} eq '')
{
	$pairs{sect13_hidden} = 0;
}
if($pairs{sect14_hidden} eq '')
{
	$pairs{sect14_hidden} = 0;
}
if($pairs{sect15_hidden} eq '')
{
	$pairs{sect15_hidden} = 0;
}
if($pairs{sect16_hidden} eq '')
{
	$pairs{sect16_hidden} = 0;
}
if($pairs{sect17_hidden} eq '')
{
	$pairs{sect17_hidden} = 0;
}

if($pairs{sect18_hidden} eq '')
{
	$pairs{sect18_hidden} = 0;
}

if($pairs{sect19_hidden} eq '')
{
	$pairs{sect19_hidden} = 0;
}

if($pairs{sect20_hidden} eq '')
{
	$pairs{sect20_hidden} = 0;
}

if($pairs{sect21_hidden} eq '')
{
	$pairs{sect21_hidden} = 0;
}

if($pairs{sect22_hidden} eq '')
{
	$pairs{sect22_hidden} = 0;
}

if($pairs{sect23_hidden} eq '')
{
	$pairs{sect23_hidden} = 0;
}

if($pairs{sect24_hidden} eq '')
{
	$pairs{sect24_hidden} = 0;
}

if($pairs{sect25_hidden} eq '')
{
	$pairs{sect25_hidden} = 0;
}


if($fatal == 1)
{

	$outOff=0;
	$Total_score=0;
	$total_percentage=0;

}

# $pairs{TrainingReq} =~ s/\'/\'\'/g;
# $pairs{TrainingReq} =~ s/\\/\&#92;/g; 

# $hours = $pairs{hours};
# $min = $pairs{min};

# $AHT = $hours.":".$min;



		#To insert values into the fields
		$q = "insert into Atria_Review (Empl_no,Feedbackdatetime,customer_name,customer_phno,lead_id,evaluation_type,call_date,lead_stage,channel,source,call_type,call_duration,evaluator_name,agent_introduction,ageny_introduction_reason,establish_reason_for_call,establish_reason_for_reason,asked_ebill,asked_ebill_reason,sanction_load,sanction_load_reason,atria_brand_pitch,atria_brand_pitch_reason,size_and_pricing,pitch_for_financing,pitch_for_financing_reason,recap,recap_reason,roof_type,roof_type_reason,booking_amount,booking_amount_reason,ups,ups_reason,conveyed_technical_details,conveyed_technical_details_reason,sending_praposal,sending_praposal_reason,active_listening,active_listening_reason,closing_calls,closing_calls_reason,tone_and_manner,tone_and_manner_reason,language_and_speech,lanhuage_and_speech_reason,handling_objection,handling_objection_reason,offering_solutions,offering_solutions_reason,hold_time,hold_time_reason,overall_experence,overall_experence_reason,understanding_of_solar_pow,understanding_of_solar_reason,answering_queries,answeriing_queries_reason,adherence_to_script,adherence_to_script_reason,lead_management,lead_management_reason,correctness_of_query,call_observation,area_of_improve,TNI,Fatal,total_score,outof,tot_percentage,entered_by,entere_on)";
		    # print $q."<br>";
		$ins=$db->prepare($q);
		$ins->execute;
		$rowins=$ins->rows;
		$ins->finish;


if($rowins==1){
	
	
	$dest = "Upload_new_dc.pl?file=$qpairs{file}&id=$roweval_id&random=$random&user=$qpairs{user}&access=$access";
	print "Status: 302 Found\n" . "Location: $dest\n\n";
	
}

$err="An error occured while insertion.";
&showError($err);		
			

	


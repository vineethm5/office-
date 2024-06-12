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

$fbmonth = $pairs{fbMonth};
$fbday = $pairs{fbDay};
$Feed_Back = $pairs{Feed_Back};

if($month < 10)
{
	$feedmonth .= '0'.$fbmonth;
}
else
{
	$feedmonth=$fbmonth;
}
if($fbday < 10)
{
	$feedDay .= '0'.$fbday;
}
else
{
	$feedDay=$fbday;
}
 
# $Feed_Back = $pairs{fbYear}."-".$feedmonth."-".$feedDay;
 


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

$call_openingNaReason = $pairs{remarks1};
$agent_confirmedNaReason = $pairs{remarks2};
$call_purposeNaReason = $pairs{remarks2};
$BrandpitchingNaReason = $pairs{remarks4};
$Capturing_CustomerNaReason = $pairs{remarks5};
$callBcak_dateNaReason = $pairs{remarks6};
$Framing_proper_SentenceNaReason = $pairs{remarks7};
$Hold_ProcedureNaReason = $pairs{remarks9};
$listening_SkillNaReason = $pairs{remarks10};
$Effective_convincingNaReason = $pairs{remarks11};
$proper_AcknowledgementNaReason = $pairs{remarks12};
$Closing_ScriptNaReason = $pairs{remarks13};
$additional_infoNaReason = $pairs{remarks14};
$Capturing_MeetingNaReason = $pairs{remarks15};
$customer_requirementNaReason = $pairs{remarks16};
$floor_planNaReason = $pairs{remarks17};
$accurate_dispositionNaReason = $pairs{remarks18};


# $out_of = $pairs{overall_hidden};
$outOff = $pairs{overall_hidden};
$Tone_and_EnergyNaReason = $pairs{remarks8};
$fatal = $pairs{sect25_hidden};
$Total_score = $pairs{overall_totScore};
$total_percentage = $pairs{overall_percentage};

if($fatal == 1)
{

	$outOff=0;
	$Total_score=0;
	$total_percentage=0;

}

$pairs{evaluator_comment} =~ s/\'/\'\'/g;
$pairs{evaluator_comment} =~ s/\\/\&#92;/g;

$pairs{area_of_improvement} =~ s/\'/\'\'/g;
$pairs{area_of_improvement} =~ s/\\/\&#92;/g;



$Briefing_required = $pairs{Briefing_required};
$updated_disposition = $pairs{updated_disposition};
$fatal_reason = $pairs{fatal_reason};


# $pairs{TrainingReq} =~ s/\'/\'\'/g;
# $pairs{TrainingReq} =~ s/\\/\&#92;/g; 

$hours = $pairs{hours};
$min = $pairs{min};

$AHT = $hours.":".$min;



		#To insert values into the fields
		$q = "insert into New_Dc_Review(EmpNo,customer_phno,call_type,Feed_Back,call_date,source,lead_stage,Region,Channel,call_opening,agent_confirmed,call_purpose,product_pitching,Capturing_Customer,callBcak_date,Framing_proper_Sentence,Tone_and_Energy,Hold_Procedure,listening_Skill,Effective_convincing,proper_Acknowledgement,Closing_Script,additional_info,Capturing_Meeting,customer_requirement,floor_plan,accurate_disposition,Total_score,outOff,total_percentage,evaluator_comment,Briefing_required,AHT,fatal_reason,enteredBy,enteredOn,fatal,area_of_improvement,BrandpitchingNaReason,call_openingNaReason,agent_confirmedNaReason,call_purposeNaReason,Capturing_CustomerNaReason,callBcak_dateNaReason,Framing_proper_SentenceNaReason,Tone_and_EnergyNaReason,Hold_ProcedureNaReason,listening_SkillNaReason,Effective_convincingNaReason,proper_AcknowledgementNaReason,Closing_ScriptNaReason,additional_infoNaReason,Capturing_MeetingNaReason,customer_requirementNaReason,floor_planNaReason,accurate_dispositionNaReason,updated_disposition) 
		values ('$idelement','$pairs{customer_phno}','$pairs{call_type}',now(),'$call_date','$pairs{source}','$pairs{lead_stage}','$pairs{Region}','$pairs{Channel}','$pairs{sect1_hidden}','$pairs{sect2_hidden}','$pairs{sect3_hidden}','$pairs{sect4_hidden}','$pairs{sect5_hidden}','$pairs{sect6_hidden}','$pairs{sect7_hidden}','$pairs{sect8_hidden}','$pairs{sect9_hidden}','$pairs{sect10_hidden}','$pairs{sect11_hidden}','$pairs{sect12_hidden}','$pairs{sect13_hidden}','$pairs{sect14_hidden}','$pairs{sect15_hidden}','$pairs{sect16_hidden}','$pairs{sect17_hidden}','$pairs{sect18_hidden}','$Total_score','$outOff','$total_percentage','$pairs{evaluator_comment}','$Briefing_required','$AHT','$fatal_reason','$eval_by_emplno',now(),'$fatal','$pairs{area_of_improvement}','$BrandpitchingNaReason','$call_openingNaReason','$agent_confirmedNaReason','$call_purposeNaReason','$Capturing_CustomerNaReason','$callBcak_dateNaReason','$Framing_proper_SentenceNaReason','$Tone_and_EnergyNaReason','$Hold_ProcedureNaReason','$listening_SkillNaReason','$Effective_convincingNaReason','$proper_AcknowledgementNaReason','$Closing_ScriptNaReason','$additional_infoNaReason','$Capturing_MeetingNaReason','$customer_requirementNaReason','$floor_planNaReason','$accurate_dispositionNaReason','$updated_disposition')";
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
			

	


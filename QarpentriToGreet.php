<?php
$json=file_get_contents('php://input');
$data = json_decode($json,TRUE);


date_default_timezone_set("Asia/Calcutta");
$current_date = date("Y-m-d");
$date_elements = array();
$date_elements = (explode("-",$current_date));

#--------------------------------- GREET HR DATABASE CONNECTION -----------------------------------#
$mssqldriver = "/opt/microsoft/msodbcsql17/lib64/libmsodbcsql-17.10.so.2.1";
$hostname='192.168.30.29';
$dbname='OCSDB01';
$username1='sa';
$password1='Smart@123';
$conn1 = new PDO("odbc:Driver=$mssqldriver;Server=$hostname;Database=$dbname", $username1, $password1);

if($conn1)
{
	 // echo "Connected Successfully";
}else
{
	echo "Failed\n";
}

#--------------------------------- BSS DATABASE CONNECTION -----------------------------------#
$servername = "localhost";
$username = "root";
$password = "rsvp1260";
$dbname ="hrs";
$conn2 = new mysqli($servername, $username, $password, $dbname);
if (!$conn2) 
{
    die("Connection failed");
}
	//----------------------------------Newly added by Vineeth-----------------------------
	$PROSPECTID=$data['ProspectID'];
	if($PROSPECTID==NULL || $PROSPECTID==null || $PROSPECTID=="")
	{
		$PROSPECTID='null';
	}

	$PROSPECTAUTOID=$data['ProspectAutoId'];
	if($PROSPECTAUTOID==NULL || $PROSPECTAUTOID==null || $PROSPECTAUTOID=="")
	{
		$PROSPECTAUTOID='null';
	}
	$FIRSTNAME=$data['FirstName'];
	if($FIRSTNAME==NULL || $FIRSTNAME==null || $FIRSTNAME=="")
	{
		$FIRSTNAME='null';
	}
	$LASTNAME=$data['LastName'];
	if($LASTNAME==NULL || $LASTNAME==null || $LASTNAME=="")
	{
		$LASTNAME='null';
	}
	$EMAILADDRESS=$data['EmailAddress'];
	if($EMAILADDRESS==NULL || $EMAILADDRESS==null || $EMAILADDRESS=="")
	{
		$EMAILADDRESS='null';
	}
	$ORIGIN=$data['Origin'];
	if($ORIGIN==NULL || $ORIGIN==null || $ORIGIN=="")
	{
		$ORIGIN='null';
	}
	$ORIGINALPHONE = $data['Phone'];
	$mobile_no = str_replace(' ', '', $ORIGINALPHONE);

	$FOLLOWUPDATE=$data['mx_Follow_Up_for_Phone_Call'];
	if($FOLLOWUPDATE==NULL || $FOLLOWUPDATE==null || $FOLLOWUPDATE=="")
	{
		$FOLLOWUPDATE='null';
	}
	// if(strlen($mobile_no) == 12 ){
		// $mobile_no = substr($mobile_no,2);
	// }
	// else if(strlen($mobile_no) == 11){		
		// $mobile_no = substr($mobile_no,1);
	// }
	// else{			
		// $mobile_no = $mobile_no;		
	// }
	$MOBILE=$data['Mobile'];
	$mobile_no1 = str_replace(' ', '', $MOBILE);
	if(strlen($mobile_no1) == 12 ){
		$mobile_no1 = substr($mobile_no1,2);
	}
	else if(strlen($mobile_no1) == 11){		
		$mobile_no1 = substr($mobile_no1,1);
	}
	else{			
		$mobile_no1 = $mobile_no1;		
	}
	$SOURCE=$data['Source'];
	if($SOURCE==NULL || $SOURCE==null || $SOURCE=="")
	{
		$SOURCE='null';
	}
	$SOURCEMEDIUM=$data['SourceMedium'];
	if($SOURCEMEDIUM==NULL || $SOURCEMEDIUM==null || $SOURCEMEDIUM=="")
	{
		$SOURCEMEDIUM='null';
	}
	$SOURCECAMPAIGN=$data['SourceCampaign'];
	if($SOURCECAMPAIGN==NULL || $SOURCECAMPAIGN==null || $SOURCECAMPAIGN=="")
	{
		$SOURCECAMPAIGN='null';
	}
	$DONOTEMAIL=$data['DoNotEmail'];
	if($DONOTEMAIL==NULL || $DONOTEMAIL==null || $DONOTEMAIL=="")
	{
		$DONOTEMAIL='null';
	}
	$DONOTCALL=$data['DoNotCall'];
	if($DONOTCALL==NULL || $DONOTCALL==null || $DONOTCALL=="")
	{
		$DONOTCALL='null';
	}
	$PROSPECTSTAGE=$data['ProspectStage'];
	if($PROSPECTSTAGE==NULL || $PROSPECTSTAGE==null || $PROSPECTSTAGE=="")
	{
		$PROSPECTSTAGE='null';
	}	
	$SCORE=$data['Score'];
	if($SCORE==NULL || $SCORE==null || $SCORE=="")
	{
		$SCORE='null';
	}
	$ENGAGEMENTSCORE=$data['EngagementScore'];
	if($ENGAGEMENTSCORE==NULL || $ENGAGEMENTSCORE==null || $ENGAGEMENTSCORE=="")
	{
		$ENGAGEMENTSCORE='null';
	}
	$PROSPECTACTIVITYNAME_MAX=$data['ProspectActivityName_Max'];
	if($PROSPECTACTIVITYNAME_MAX==NULL || $PROSPECTACTIVITYNAME_MAX==null || $PROSPECTACTIVITYNAME_MAX=="")
	{
		$PROSPECTACTIVITYNAME_MAX='null';
	}
	$PROSPECTACTIVITYDATE_MAX=$data['ProspectActivityDate_Max'];
	if($PROSPECTACTIVITYDATE_MAX==NULL || $PROSPECTACTIVITYDATE_MAX==null || $PROSPECTACTIVITYDATE_MAX=="")
	{
		$PROSPECTACTIVITYDATE_MAX='null';
	}
	$FIRSTLANDINGPAGESUBMISSIONDATE=$data['FirstLandingPageSubmissionDate'];
	if($FIRSTLANDINGPAGESUBMISSIONDATE==NULL || $FIRSTLANDINGPAGESUBMISSIONDATE==null || $FIRSTLANDINGPAGESUBMISSIONDATE=="")
	{
		$FIRSTLANDINGPAGESUBMISSIONDATE='null';
	}
	$OWNERID=$data['OwnerId'];
	if($OWNERID==NULL || $OWNERID==null || $OWNERID=="")
	{
		$OWNERID='null';
	}
	$CREATEDBY=$data['CreatedBy'];
	if($CREATEDBY==NULL || $CREATEDBY==null || $CREATEDBY=="")
	{
		$CREATEDBY='null';
	}


	$LEADSTATUS=$data['mx_Lead_Status'];
	if($LEADSTATUS==NULL || $LEADSTATUS==null || $LEADSTATUS=="")
	{
		$LEADSTATUS='null';
	}

	
	$SUBSTATUS=$data['mx_Lead_Sub_Status'];
	if($SUBSTATUS==NULL || $SUBSTATUS==null || $SUBSTATUS=="")
	{
		$SUBSTATUS='null';
	}


	$MXCITY=$data['mx_City1'];
	if($MXCITY==NULL || $MXCITY==null || $MXCITY=="")
	{
		$MXCITY='null';
	}


	foreach($data as $update)
			{
				$PROSPECTID=$update['ProspectID'];
				$PROSPECTAUTOID=$update['ProspectAutoId'];
				$FIRSTNAME=$update['FirstName'];
				$LASTNAME=$update['LastName'];
				$EMAILADDRESS=$update['EmailAddress'];
				$ORIGIN=$update['Origin'];
				$mobile_no=$update['Phone'];
				$MOBILE=$update['Mobile'];
				$SOURCE=$update['Source'];
				$SOURCEMEDIUM=$update['SourceMedium'];
				$SOURCECAMPAIGN=$update['SourceCampaign'];
				$DONOTEMAIL=$update['DoNotEmail'];
				$DONOTCALL=$update['DoNotCall'];
				$PROSPECTSTAGE=$update['ProspectStage'];
				$SCORE=$update['Score'];
				$ENGAGEMENTSCORE=$update['EngagementScore'];
				$PROSPECTACTIVITYNAME_MAX=$update['ProspectActivityName_Max'];
				$FIRSTLANDINGPAGESUBMISSIONDATE=$update['FirstLandingPageSubmissionDate'];
				$OWNERID=$update['OwnerId'];
				$CREATEDBY=$update['CreatedBy'];
				$FOLLOWUPDATE=$update['mx_Follow_Up_for_Phone_Call'];
				$LEADSTATUS=$update['mx_Lead_Status'];
				$SUBSTATUS=$update['mx_Lead_Sub_Status'];
				$MXCITY=$update['mx_City1'];

			}
	
		$LenMob = strlen($mobile_no);
		if($LenMob == 14){
			$mobile_no = substr($mobile_no,4);
		}else if($LenMob == 13){
			$mobile_no = substr($mobile_no,3);
		}else if($LenMob == 12){
			$mobile_no = substr($mobile_no,2);
		}else if($LenMob == 11){
			$mobile_no = substr($mobile_no,1);
		}else{
			$mobile_no = $mobile_no;
		}
		// $leadstage="New";
		// $leadstatus="Undialed";

		
		if($mobile_no == 'null' || $mobile_no == ''){

			#do nothing
			// $jsonobj = '{"message":"An error occured while insertion","status":405,"details":"phone number missing please check"}';
			
			$jsonobj = '{"message":"An error occured while insertion","status":405,"details":"phone number missing please check","ProspectID":'.$PROSPECTID.',"ProspectAutoId":'.$PROSPECTAUTOID.',"FirstName":'.$FIRSTNAME.',"LastName":'.$LASTNAME.',"EmailAddress":'.$EMAILADDRESS.',"Origin":'.$ORIGIN.',"Phone":'.$ORIGINALPHONE.',"Mobile":'.$MOBILE.',"Source":'.$SOURCE.',"SourceMedium":'.$SOURCEMEDIUM.',"SourceCampaign":'.$SOURCECAMPAIGN.',"DoNotEmail":'.$DONOTEMAIL.',"DoNotCall":'.$DONOTCALL.',"ProspectStage":'.$PROSPECTSTAGE.',"Score":'.$SCORE.',"EngagementScore":'.$ENGAGEMENTSCORE.',"ProspectActivityName_Max":'.$PROSPECTACTIVITYNAME_MAX.',"FirstLandingPageSubmissionDate":'.$FIRSTLANDINGPAGESUBMISSIONDATE.',"OwnerId":'.$OWNERID.',"CreatedBy":'.$CREATEDBY.'}';
			echo $jsonobj;
		}
		else
		{
			$qry="select count(*)as IsExists from Qarpentri_new where Phone='$mobile_no'";
			$run11=$conn2->query($qry);
			while($row14=$run11->fetch_assoc())
			{
				$IsExists=$row14['IsExists'];
			}
			if($IsExists<=0)
			{
		
						
						$intoBSS="insert into Qarpentri_new(Prospectid,ProspectautoId,Firstname,Lastname,Emailaddress,Origin,Phone,Mobile,Source,Sourcemedium,Sourcecampaign,Donotemail,Donotcall,Prospectstage,Score,Engagementscore,Prospectactivityname_max,Prospectactivitydate_max,FirstlandingpagesubmissionDate,OwnerId,CreatedBy,entered_date,Lead_status,followup_date,Substatus,city) VALUES ('$PROSPECTID','$PROSPECTAUTOID','$FIRSTNAME','$LASTNAME','$EMAILADDRESS','$ORIGIN','$mobile_no','$mobile_no1','$SOURCE','$SOURCEMEDIUM','$SOURCECAMPAIGN','$DONOTEMAIL','$DONOTCALL','$PROSPECTSTAGE','$SCORE','$ENGAGEMENTSCORE','$PROSPECTACTIVITYNAME_MAX','$PROSPECTACTIVITYDATE_MAX','$FIRSTLANDINGPAGESUBMISSIONDATE','$OWNERID','$CREATEDBY',now(),'$LEADSTATUS','$FOLLOWUPDATE','$SUBSTATUS','$MXCITY')";
						// echo $q_insert."<br>";
						
						$resultBss = $conn2->query($intoBSS);

						// $jsonobj = '{"message":"success","status":200,"details":"Lead inserted successfully"}';
						$jsonobj = '{"ProspectID":'.$PROSPECTID.',"ProspectAutoId":'.$PROSPECTAUTOID.',"FirstName":'.$FIRSTNAME.',"LastName":'.$LASTNAME.',"EmailAddress":'.$EMAILADDRESS.',"Origin":'.$ORIGIN.',"Phone":'.$ORIGINALPHONE.',"Mobile":'.$MOBILE.',"Source":'.$SOURCE.',"SourceMedium":'.$SOURCEMEDIUM.',"SourceCampaign":'.$SOURCECAMPAIGN.',"DoNotEmail":'.$DONOTEMAIL.',"DoNotCall":'.$DONOTCALL.',"ProspectStage":'.$PROSPECTSTAGE.',"Score":'.$SCORE.',"EngagementScore":'.$ENGAGEMENTSCORE.',"ProspectActivityName_Max":'.$PROSPECTACTIVITYNAME_MAX.',"FirstLandingPageSubmissionDate":'.$FIRSTLANDINGPAGESUBMISSIONDATE.',"OwnerId":'.$OWNERID.'}';
						echo $jsonobj;
						
				// To Make to Dialer Remove Comments from Whole If block

						
						if($PROSPECTSTAGE == 'New' || $PROSPECTSTAGE == 'Recontacted')
						{

							$CUSTNAME = $FIRSTNAME." ".$LASTNAME;
							$gqry1="SELECT max(record_id) as RECORD_ID FROM Qarpentri";
							//echo $gqry1."<br>";
							$run1=$conn1->query($gqry1);
							// echo $run1;
							while ($row12 = $run1->fetch()) 
							{
								$RECORD_ID=$row12['RECORD_ID'];
							}
							$RECORD_ID++;
							$SP = "SELECT MAX(chain_id) as CHAIN_ID FROM Qarpentri";
							//echo $SP."<br>";
							$stid3 = $conn1->query($SP);
							
							while ($row13 = $stid3->fetch()) 
							{
								$CHAIN_ID=$row13['CHAIN_ID'];
							}
							$PHONE_TYPE=1;
							$RECORD_TYPE=2;	
							$RECORD_STATUS=1;	
							$CALL_RESULT=28;	
							$ATTEMPT=0;	
							$DIAL_SCHED_TIME='';
							$CALL_TIME=0;	
							$DAILY_FROM=32400;	
							$DAILY_TILL=79200;	
							$TZ_DBID=109;	
							$CAMPAIGN_ID=0;	
							$AGENT_ID='';	
							$CHAIN_N=$RECORD_ID;	
							$GROUP_ID=0;	
							$APP_ID=0;	
							$TREATMENTS='';	
							$MEDIA_REF=0;
							$CONTACT_INFO_TYPE=1;	
							$EMAIL_TEMPLATE_ID='';	
							$SWITCH_ID='';
							$CUST_NAME='';		
							$MAIL_ID='';		
							$SOURCE='';		
							$REGION='';		
							$CHANNEL='';		
							$LEAD_SOURCE='';		
							$CREATE_DATE='';		
							$AGENT_NUMBER_val = '';
							$CRM_DATE1='';
							$email_id1='';
							$option21='';
							$signin_date1='';
							if(strlen($mobile_no) == 14){
								$mobile_no = substr($mobile_no,4);
							}else if(strlen($mobile_no) == 13){
								$mobile_no = substr($mobile_no,3);
							}else if(strlen($mobile_no) == 12 ){
									// $CONTACT_INFO = substr($Mobile_No,2);
									$mobile_no = substr($mobile_no,2);
							}
							else if(strlen($mobile_no) == 11){		
								// $CONTACT_INFO = substr($Mobile_No,1);
								$mobile_no = substr($mobile_no,1);
							}
							else{	
								// $CONTACT_INFO = $Mobile_No;		
								$mobile_no = $mobile_no;		
							}
							// echo $Mobile_No."<br>";
							$next_chain_id = $CHAIN_ID+1;
							// $PARTNER_NAME = $partner_name;
							
							$PROSPECTID = $PROSPECTID;
							
							if($CUSTNAME == ''){
								$CUSTNAME ='NIL';
							}
							if($MAILID == ''){
								$MAILID ='NIL';
							}
							
							$LEAD_STAGE=$PROSPECTSTAGE;
							$LEAD_STATUS='DirectFlow';
							$REASON='NIL';
							
							$SP = "insert into Qarpentri(RECORD_ID,CONTACT_INFO,CONTACT_INFO_TYPE,RECORD_TYPE,RECORD_STATUS,CALL_RESULT,
							ATTEMPT,DIAL_SCHED_TIME,CALL_TIME,DAILY_FROM,DAILY_TILL,TZ_DBID,CAMPAIGN_ID,AGENT_ID,CHAIN_ID,CHAIN_N,GROUP_ID,APP_ID,TREATMENTS,SWITCH_ID,NAME,
							CUST_NAME,LEAD_STAGE,LEAD_STATUS,CALL_STAGE)VALUES
							('$RECORD_ID','$mobile_no','$CONTACT_INFO_TYPE','$RECORD_TYPE','$RECORD_STATUS', '$CALL_RESULT','$ATTEMPT','$DIAL_SCHED_TIME','$CALL_TIME','$DAILY_FROM','$DAILY_TILL', 
							'$TZ_DBID','$CAMPAIGN_ID','$AGENT_ID','$next_chain_id','$CHAIN_N','$GROUP_ID','$APP_ID','$TREATMENTS','$SWITCH_ID', '$CUSTNAME','$CUSTNAME','$LEAD_STAGE','$LEAD_STATUS','$LEAD_STAGE')";
							  // echo $SP."<br>";
							  $r = $conn1->exec($SP);
							// echo $r;
	
						}

		
		 }
			
			
	// }
	else{
		$jsonobj = '{"message":"An error occured while insertion","status":405,"details":"This Lead is already Exist"}';
				echo $jsonobj;
	}
		
}	
			
	// fclose($myfile1);			
	// fclose($myfile2);			
			
	################################Get Current Dialer Data------------------------------------------------------------------------------------------


?>


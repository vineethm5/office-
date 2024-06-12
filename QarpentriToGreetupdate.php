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
$username='sa';
$password='Smart@123';
$conn2 = new PDO("odbc:Driver=$mssqldriver;Server=$hostname;Database=$dbname", $username, $password);

if($conn2){
	echo "Connected Successfully";
}else{
	echo "Failed";
}



#--------------------------------- BSS DATABASE CONNECTION -----------------------------------#
$servername = "192.168.30.26";
$username = "root";
$password = "genesys";
$dbname ="hrs";
$conn3 = mysqli_connect($servername, $username, $password, $dbname);
if (!$conn3) {
	$jsonobj = '{"message":"connection failed","status":404,"details":"unable to connect to greet database"}';
	// die($jsonobj);
	die("Connection failed: " . mysqli_connect_error());
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

	$FOLLOWUPDATE=$data['mx_Follow_Up_for_Phone_Call'];
	if($FOLLOWUPDATE==NULL || $FOLLOWUPDATE==null || $FOLLOWUPDATE=="")
	{
		$FOLLOWUPDATE='null';
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
	//------------------------------original---------------------------------------------
	/*$ORIGINALPHONE = $data['PHONE'];
	$mobile_no = str_replace(' ', '', $ORIGINALPHONE);
	if(strlen($mobile_no) == 12 ){
		$mobile_no = substr($mobile_no,2);
	}
	else if(strlen($mobile_no) == 11){		
		$mobile_no = substr($mobile_no,1);
	}
	else{			
		$mobile_no = $mobile_no;		
	}
	// echo $mobile_no."<br>";

	$NAME = $data['NAME'];
	if($NAME == NULL || $NAME == null || $NAME == '' ){$NAME='null';}

	
	$LEAD_SOURCE = $data['LEAD_SOURCE'];
	if($LEAD_SOURCE == NULL || $LEAD_SOURCE == null || $LEAD_SOURCE == '' ){$LEAD_SOURCE='null';}

	$REGION = $data['REGION'];
	if($REGION == NULL || $REGION == null || $REGION == '' ){
		$REGION='null';
	}
	else{
		$REGION =$REGION;
	}
	
	$CREATE_DATE = $data['CREATE_DATE'];
	$createDate = substr("$CREATE_DATE",0,10);
	$createTime = substr("$CREATE_DATE",11,19);

	$CREATE_DATE = $createDate." ".$createTime;

	$CREATE_DATE  =  date('Y-m-d H:i:s',strtotime('+0 hour +0 minutes',strtotime($CREATE_DATE)));

	
	$LEAD_ID = $data['LEAD_ID'];
// $changedDate = substr("$LEAD_ID",0,10);
// $changedTime = substr("$LEAD_ID",10,18);

// $LEAD_ID=$changedDate." ".$changedTime;
// $LEAD_ID  =  date('Y-m-d H:i:s',strtotime('+0 hour +0 minutes',strtotime($LEAD_ID)));


	

	$LEAD_STAGE = $data['LEAD_STAGE'];

	$LEAD_STATUS = $data['LEAD_STATUS'];
	if($LEAD_STATUS == NULL || $LEAD_STATUS == null || $LEAD_STATUS == '' ){$LEAD_STATUS='null';}


	$REASON = $data['REASON'];
	if($REASON == NULL || $REASON == null || $REASON == '' ){$REASON='null';}


	// $fName='autoLeadsSuccess'.date('m-d-Y').'.txt';
	// $fName2='autoLeadsFailed'.date('m-d-Y').'.txt';
	// $fName='wfh.txt';

	###########Deleted previous data of abandon_mob_put_genesys---s
	// $myfile1 = fopen("/var/www/html/Logs/$fName", "a") or die("Unable to open file!");
	// $myfile2 = fopen("/var/www/html/Logs/$fName2", "a") or die("Unable to open file!");

	$add_index=0;
	$failed_count=0;
	$insert_count=0;

	// fwrite($myfile1,"----------------------------------------------------------------------------------------------\n\n");
	// fwrite($myfile2,"----------------------------------------------------------------------------------------------\n\n");

	// fwrite($myfile1,"\n\n");
	// fwrite($myfile2,"\n\n");

			
*/		
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
				$FOLLOWUPDATE=$update['mx_Follow_Up_Date_Tme'];
				$LEADSTATUS=$update['mx_Lead_Status'];
				$SUBSTATUS=$update['mx_Lead_Sub_Status'];
				$MXCITY=$update['mx_City1'];
				$Prospect_mx_Possession_Date=$update['Prospect_mx_Possession_Date'];
				$mx_Possession_Date=$update['mx_Possession_Date'];
				$mx_Customer_Budget=$update['mx_Customer_Budget'];
				$mx_Project_Type_in_BHK=$update['mx_Project_Type_in_BHK'];
				$mx_Cabinet_Requirements=$update['mx_Cabinet_Requirements'];
				$mx_Zip=$update['mx_Zip'];
				$mx_Property_Address=$update['mx_Property_Address'];
				$mx_Cx_Meeting_Type=$update['mx_Cx_Meeting_Type'];
				$mx_Meeting_Slot=$update['mx_Meeting_Slot'];
				$mx_CC_Notes=$update['mx_CC_Notes'];

				$full_address=$mx_Property_Address." ".$mx_Zip;

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

		if($PROSPECTSTAGE == 'null' || $PROSPECTSTAGE == '' || $PROSPECTSTAGE=='New'){

			#do nothing
			// $jsonobj = '{"message":"An error occured while insertion","status":405,"details":"phone number missing please check"}';
			
			$jsonobj = '{"message":"An error occured while insertion","status":405,"details":"phone number missing please check","ProspectID":'.$PROSPECTID.',"ProspectAutoId":'.$PROSPECTAUTOID.',"FirstName":'.$FIRSTNAME.',"LastName":'.$LASTNAME.',"EmailAddress":'.$EMAILADDRESS.',"Origin":'.$ORIGIN.',"Phone":'.$ORIGINALPHONE.',"Mobile":'.$MOBILE.',"Source":'.$SOURCE.',"SourceMedium":'.$SOURCEMEDIUM.',"SourceCampaign":'.$SOURCECAMPAIGN.',"DoNotEmail":'.$DONOTEMAIL.',"DoNotCall":'.$DONOTCALL.',"ProspectStage":'.$PROSPECTSTAGE.',"Score":'.$SCORE.',"EngagementScore":'.$ENGAGEMENTSCORE.',"ProspectActivityName_Max":'.$PROSPECTACTIVITYNAME_MAX.',"FirstLandingPageSubmissionDate":'.$FIRSTLANDINGPAGESUBMISSIONDATE.',"OwnerId":'.$OWNERID.',"CreatedBy":'.$CREATEDBY.'}';
			echo $jsonobj;
		}
		else{
						
						$intoBSS="insert into Qarpentri_new(Prospectid,ProspectautoId,Firstname,Lastname,Emailaddress,Origin,Phone,Mobile,Source,Sourcemedium,Sourcecampaign,Donotemail,Donotcall,Prospectstage,Score,Engagementscore,Prospectactivityname_max,Prospectactivitydate_max,FirstlandingpagesubmissionDate,OwnerId,CreatedBy,update_on,Lead_status,Substatus,followup_date,city,PP_Date,HouseType,Requirement,Address,meeting_type,meeting_date,budget,comment) VALUES ('$PROSPECTID','$PROSPECTAUTOID','$FIRSTNAME','$LASTNAME','$EMAILADDRESS','$ORIGIN','$mobile_no','$mobile_no1','$SOURCE','$SOURCEMEDIUM','$SOURCECAMPAIGN','$DONOTEMAIL','$DONOTCALL','$PROSPECTSTAGE','$SCORE','$ENGAGEMENTSCORE','$PROSPECTACTIVITYNAME_MAX','$PROSPECTACTIVITYDATE_MAX','$FIRSTLANDINGPAGESUBMISSIONDATE','$OWNERID','$CREATEDBY',now(),'$LEADSTATUS','$SUBSTATUS','$FOLLOWUPDATE','$MXCITY','$mx_Possession_Date','$mx_Project_Type_in_BHK','$mx_Cabinet_Requirements','$full_address','$mx_Cx_Meeting_Type','$mx_Meeting_Slot','$mx_Customer_Budget','$mx_CC_Notes')";
						// echo $intoBSS."<br>";
						
						$resultBss = $conn3->query($intoBSS);
						$jsonobj = '{"message":"success","status":200,"details":"Lead inserted successfully"}';
						// $jsonobj = '{"ProspectID":'.$PROSPECTID.',"ProspectAutoId":'.$PROSPECTAUTOID.',"FirstName":'.$FIRSTNAME.',"LastName":'.$LASTNAME.',"EmailAddress":'.$EMAILADDRESS.',"Origin":'.$ORIGIN.',"Phone":'.$ORIGINALPHONE.',"Mobile":'.$MOBILE.',"Source":'.$SOURCE.',"SourceMedium":'.$SOURCEMEDIUM.',"SourceCampaign":'.$SOURCECAMPAIGN.',"DoNotEmail":'.$DONOTEMAIL.',"DoNotCall":'.$DONOTCALL.',"ProspectStage":'.$PROSPECTSTAGE.',"Score":'.$SCORE.',"EngagementScore":'.$ENGAGEMENTSCORE.',"ProspectActivityName_Max":'.$PROSPECTACTIVITYNAME_MAX.',"FirstLandingPageSubmissionDate":'.$FIRSTLANDINGPAGESUBMISSIONDATE.',"OwnerId":'.$OWNERID.'}';
						echo $jsonobj;
						
			
						if($PROSPECTSTAGE == 'New'){/*
							
							
							$CUSTNAME = $FIRSTNAME." ".$LASTNAME;
							$stid112 = oci_parse($conn2, "SELECT max(RECORD_ID) as RECORD_ID FROM Qarpentri");
							$r112 = oci_execute($stid112);
							while ($row11 = oci_fetch_array($stid112, OCI_ASSOC+OCI_RETURN_NULLS))
							{
								$RECORD_ID=$row11['RECORD_ID'];		
							}
								$RECORD_ID++;
								// $CHAIN_ID++;
								// $CHAIN_N++;
							// $RECORD_ID+=1;
							$stid3 = oci_parse($conn2, 'SELECT MAX(CHAIN_ID) as CHAIN_ID FROM Qarpentri');
							$r = oci_execute($stid3);
							while ($row = oci_fetch_array($stid3, OCI_ASSOC+OCI_RETURN_NULLS))
							{
								$max_chain_id =  $row['CHAIN_ID'];
							}
							$SP = "insert into Qarpentri(RECORD_ID,CONTACT_INFO,CONTACT_INFO_TYPE,RECORD_TYPE,RECORD_STATUS,CALL_RESULT,
							ATTEMPT,DIAL_SCHED_TIME,CALL_TIME,DAILY_FROM,DAILY_TILL,TZ_DBID,CAMPAIGN_ID,AGENT_ID,CHAIN_ID,CHAIN_N,GROUP_ID,APP_ID,TREATMENTS,SWITCH_ID,NAME,
							CUST_NAME,LEAD_STAGE,LEAD_STATUS,CALL_STAGE)VALUES
							(:RECORD_ID, :CONTACT_INFO, :CONTACT_INFO_TYPE, :RECORD_TYPE, :RECORD_STATUS, :CALL_RESULT, :ATTEMPT,:DIAL_SCHED_TIME,:CALL_TIME, :DAILY_FROM, :DAILY_TILL, 
							:TZ_DBID, :CAMPAIGN_ID, :AGENT_ID, :CHAIN_ID, :CHAIN_N, :GROUP_ID, :APP_ID, :TREATMENTS,  :SWITCH_ID, :NAME, :CUST_NAME, :LEAD_STAGE, :LEAD_STATUS, :CALL_STAGE)";
							 // echo $SP."<br>";
							$stid = oci_parse($conn2,$SP);
							
							
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
							$CHAIN_N=0;	
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
							$next_chain_id = $max_chain_id+1;
							// $PARTNER_NAME = $partner_name;
							
							$PROSPECTID = $PROSPECTID;
							
							if($CUSTNAME == ''){
								$CUSTNAME ='NIL';
							}
							if($MAILID == ''){
								$MAILID ='NIL';
							}
							
							$LEAD_STAGE='NIL';
							$LEAD_STATUS='NIL';
							$REASON='NIL';
							
							
						
							oci_bind_by_name($stid, ':RECORD_ID', $next_chain_id);
							oci_bind_by_name($stid, ':CONTACT_INFO', $mobile_no);
							oci_bind_by_name($stid, ':CONTACT_INFO_TYPE', $CONTACT_INFO_TYPE);
							oci_bind_by_name($stid, ':RECORD_TYPE', $RECORD_TYPE);
							oci_bind_by_name($stid, ':RECORD_STATUS', $RECORD_STATUS);
							oci_bind_by_name($stid, ':CALL_RESULT', $CALL_RESULT);
							oci_bind_by_name($stid, ':ATTEMPT', $ATTEMPT);
							oci_bind_by_name($stid, ':DIAL_SCHED_TIME',$DIAL_SCHED_TIME);
							oci_bind_by_name($stid, ':CALL_TIME', $CALL_TIME);
							oci_bind_by_name($stid, ':DAILY_FROM', $DAILY_FROM);
							oci_bind_by_name($stid, ':DAILY_TILL', $DAILY_TILL);
							oci_bind_by_name($stid, ':TZ_DBID', $TZ_DBID);
							oci_bind_by_name($stid, ':CAMPAIGN_ID', $CAMPAIGN_ID);
							oci_bind_by_name($stid, ':AGENT_ID', $AGENT_ID);
							oci_bind_by_name($stid, ':CHAIN_ID', $next_chain_id);
							oci_bind_by_name($stid, ':CHAIN_N', $CHAIN_N);
							oci_bind_by_name($stid, ':GROUP_ID', $GROUP_ID);
							oci_bind_by_name($stid, ':APP_ID', $APP_ID);
							oci_bind_by_name($stid, ':TREATMENTS', $TREATMENTS);
							oci_bind_by_name($stid, ':SWITCH_ID', $SWITCH_ID);
							oci_bind_by_name($stid, ':NAME', $PROSPECTID);
							oci_bind_by_name($stid, ':CUST_NAME', $CUSTNAME);
							oci_bind_by_name($stid, ':LEAD_STAGE', $LEAD_STAGE);
							oci_bind_by_name($stid, ':LEAD_STATUS', $LEAD_STATUS);
							oci_bind_by_name($stid, ':CALL_STAGE', $REASON);
					
							$r = oci_execute($stid);	
											
							
							
							
							
						*/}

		
		 }
			
			
	// }
	// else{
		// $jsonobj = '{"message":"An error occured while insertion","status":405,"details":"This Lead is already Exist"}';
				// echo $jsonobj;
	// }
			
			
	// fclose($myfile1);			
	// fclose($myfile2);			
			
	################################Get Current Dialer Data------------------------------------------------------------------------------------------


?>
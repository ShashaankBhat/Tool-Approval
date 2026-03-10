/**
 * ******************************************************************************************
 * Copyright © 2021-2022 ANAND Automotive Private Limited. All rights reserved.				*
 * No part of this product may be reproduced in any form by any means without prior			*
 * written authorization of ANAND Automotive Private Limited and its licensors, if any.		*
 * ******************************************************************************************
 * Author - ANAND Automotive Private Limited - Corporate IT - R S Iyer						*
 * ******************************************************************************************
 */
package com.anand.common;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class Common_Constants {

	public static String flagshipCompanyAcronm = "AAPL";

	public static String toMailIdTesting = "sheshadhri.iyer@anandgroupindia.com";

	public static String ccMailIdTesting = "sheshadhri.iyer@anandgroupindia.com";

	public static String applicationUrl = "https://ijp.anandgroupindia.com/IJP/login.htm";

	public static String toolNotificationMailID = "hr@anandgroupindia.net.in";

	public static final String emailHeadNew = "<!DOCTYPE html>" + 
			"<html xmlns='http://www.w3.org/1999/xhtml' lang='en-US'>" + 
			"	<head>" + 
			"		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />" + 
			"		<title>IAMS Mail Notification</title>" + 
			"		<meta name='viewport' content='width=device-width, initial-scale=1.0'/>" + 
			"		<style text='css'>" + 
			"			.footlast {" + 
			"				font-family: Helvetica;" + 
			"				color: #444444;" + 
			"				font-size: 9pt;" + 
			"				background-color: #ffffff;" + 
			"			}" + 
			"			.namenow {" + 
			"				font-family: Helvetica;" + 
			"			}" + 
			"			table {" + 
			"				font-family: Helvetica;" + 
			"				border-width: thin;" + 
			"				border-spacing: 1px;" + 
			"				border-style: ridge;" + 
			"				border-color: #d9d9d9;" + 
			"			}" + 
			"			.center {" + 
			"				display: block;" + 
			"				margin-left: auto;" + 
			"				margin-right: auto;" + 
			"				width: 47%;" + 
			"			}" + 
			"			.stable {" + 
			"				font-family: Helvetica;" + 
			"				border-collapse: collapse;" + 
			"			}" + 
			"			.stable td {" + 
			"				border: 1px solid #ddd;" + 
			"				padding: 8px;" + 
			"			}" + 
			"			.stable tr{background-color: #deeaf6;}" + 
			"			.stable th {" + 
			"				padding-top: 12px;" + 
			"				padding-bottom: 12px;" + 
			"				text-align: left;" + 
			"				background-color: #deeaf6;" + 
			"				color: white;" + 
			"			}" + 
			"			.stable1 {" + 
			"				border: 1px solid #000;" + 
			"				border-collapse: collapse;" + 
			"			}" + 
			"			.firstletter{" + 
			"				border: 0px dotted;" + 
			"				font-size: 26.5px;" + 
			"				text-transform: capitalize;" + 
			"			}" + 
			"		</style>" + 
			"	</head>" + 
			"	<body style='margin: 0; padding: 0;'>" + 
			"		<table align='center' width='600px' class='stable1'>" + 
			"			<tr>" + 
			"				<td>" + 
			"					<br><img class='' width='600' height='35' style='padding-right:30px;padding-top:10px;float:right' src='cid:logoImage' alt='Anand Group IJP.' /><br><br>" +
			"				</td>" + 
			"			</tr>";

	public static final String emailFooterNew = "<tr>" + 
			"				<td style='padding: 10px 10px 10px 10px;'>" + 
			"					<p class='namenow' style='margin: 0;'>" + 
			"						Warm Regards,<br>" + 
			"						Corporate Administration Team.<br>" + 
			"					</p>" + 
			"				</td>" + 
			"			</tr>" + 
			"			<tr>" + 
			"				<td style='padding-top:20px'>" + 
			"					<a title='Anand Group India' href='https://www.anandgroupindia.com/'><img class='' style='' width='620'  height='' src='cid:footerImage' alt='Anand Group IJP.' /></a>" + 
			"				</td>" + 
			"			</tr>" + 
			"		</table>" + 
			"	</body>" + 
			"</html>";
	
	public static Set<String> domainSet1 = new HashSet<>(Arrays.asList(
		"anandgroupindia.com",
		"gabriel.co.in",
        "minditsystems.com",
		"anevolve.com",
		"inalfagabriel.com",
		"jawaileopardcamp.com",
		"sherbagh.com",
		"sujanjawai.com",
		"sujanluxury.com",
		"the-serai.com",
		"thesujanlife.com"
	));
	public static Set<String> domainSet2 = new HashSet<>(Arrays.asList("gabriel.co.in"));

	public static Set<String> domainSet3 = new HashSet<>(Arrays.asList("anandipower.com"));

	public static Set<String> urlAllowedForCheckSheetAdmin = new HashSet<>(Arrays.asList(
		"signup",
		"dashboard-check-sheet",
		"check-sheet",
		"drop-down-master",
		"check-sheet-entries",
		"view-check-sheet",
		"check-sheet-transaction",
		"addEdit-check-sheet",
		"approve-reject-check-sheet",
		"edit-check-point"
	));

	public static Set<String> urlAllowedForCheckSheetTransactor = new HashSet<>(Arrays.asList(
		"dashboard-check-sheet",
		"view-check-sheet",
		"check-sheet-transaction",
        "check-sheet-entries"
	));

	public static Set<String> urlAllowedForVimsUser = new HashSet<>(Arrays.asList(
		"book-appointment",
		"list-appointment"
	));

	public static Set<String> urlAllowedForVimsReception = new HashSet<>(Arrays.asList(
		"book-appointment",
		"visitor-time-out",
		"visitor-information",
		"list-appointment"
	));

	public static Set<String> urlAllowedForVimsAdmin = new HashSet<>(Arrays.asList(
		"book-appointment",
		"list-appointment",
		"visitor-type",
		"visitor-govt-type",
		"visitor-purpose",
		"vims-user",
		"vims-registration"
	));

	public static Set<String> urlAllowedForActAdmin = new HashSet<>(Arrays.asList(
			"dashboard-act","coaching-batch","coaching-batch-details","coachee-list","coaching-goals","coaching-report","coaching-report-coach","coaching-mis-report","getBatchDetails", "act-report","getCoacheeGoalDetails"
		));
		public static Set<String> urlAllowedForActCoach = new HashSet<>(Arrays.asList(
			"dashboard-act" ,"coaching-batch-details","coachee-list","coaching-goals","coaching-report","coaching-report-coach","getCoacheeReportDetails","getCoacheeGoalDetails"
		));
		public static Set<String> urlAllowedForActCoachee = new HashSet<>(Arrays.asList(
			"dashboard-act","coaching-batch-details","coaching-goals","coaching-report","coaching-report-coach","getCoacheeGoalDetails"
		));
		public static Set<String> urlAllowedForActProcessOwner = new HashSet<>(Arrays.asList(
			"dashboard-act","coaching-batch","coaching-batch-details","coachee-list","coaching-goals","coaching-report","coaching-report-coach","getBatchDetails", "act-report","getCoacheeGoalDetails"
		));
		public static Set<String> urlAllowedForEmcAdmin = new HashSet<>(Arrays.asList(
			"dashboard-emc","emc-coaching-batch","emc-coaching-mis-report","emc-coaching-report-coach","emc-coaching-report","emc-coaching-goals","upload","upload-document-form","submitFeedback",
			"emc-feedback-list","emc-coachee-list","emc-coaching-batch-details"
		));
		public static Set<String> urlAllowedForEmcCoach = new HashSet<>(Arrays.asList(
			"dashboard-emc","emc-coaching-report-coach","emc-coaching-report","emc-coaching-goals","emc-coachee-list","emc-coaching-batch-details",	"emc-feedback-list","submitFeedback"

		));
		public static Set<String> urlAllowedForEmcCoachee = new HashSet<>(Arrays.asList(
			"dashboard-emc","emc-coaching-report-coach","emc-coaching-report","emc-coaching-goals",	"emc-feedback-list","submitFeedback"
		
		));
		public static Set<String> urlAllowedForEmcProcessOwner = new HashSet<>(Arrays.asList(
			"dashboard-emc","emc-coaching-report-coach","emc-coaching-goals"
		));
}
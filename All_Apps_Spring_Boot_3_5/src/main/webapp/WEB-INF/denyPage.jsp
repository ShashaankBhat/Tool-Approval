<!-- ****************************************************************************************
# *******************************************************************************************
# Copyright © 2021 Anand Group India. All rights reserved.									*
# No part of this product may be reproduced in any form by any means without prior			*
# written authorization of Anand Automotive Private Limited and its licensors, if any.				*
# *******************************************************************************************
# Author - Sheshadhri Iyer																	*
# *************************************************************************************** -->
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>EXCEPTION<%@include file="includeJSP/company_name_title.jsp"%></title>
    <%@include file="includeJSP/cssFiles.jsp"%>
	</head>
	<body class="hold-transition lockscreen">
		<div class="lockscreen-wrapper">
			<div class="lockscreen-logo">
			  <img src="usedStaticFiles/essentials/images/logo.png" style="height:50px;" alt="Company Logo" class="brand-image">
			</div>
			<div class="lockscreen-logo font-2" style="font-size: 25px;">
			  Driving with you since 1961
			</div>
			<div class="lockscreen-logo font-3" style="font-size: 20px;">
				Oops, something went wrong.<br>
				Kindly login again to continue your operation.<br>
				<a class="font-2" href="logout" title="Go to Login Page" ><strong>Click Here</strong></a> to go Login.
			</div>
			<div class="lockscreen-footer text-center font-3">
				Copyright &copy; 2024 &nbsp;
				<a href="https://www.anandgroupindia.com/" target="_blank">Anand Group India</a>
				<br>All rights reserved.
			</div>
		</div>
		<%@include file="includeJSP/jsFiles.jsp"%>
	</body>
</html>
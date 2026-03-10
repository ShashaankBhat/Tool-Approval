<!-- -------------------------------------------------------------------------------------- -
 - Copyright © 2021-2022 ANAND Automotive Private Limited. All rights reserved.				-
 - No part of this product may be reproduced in any form by any means without prior			-
 - written authorization of ANAND Automotive Private Limited and its licensors, if any.		-
 - ---------------------------------------------------------------------------------------- -
 - Author - ANAND Automotive Private Limited - Corporate IT - R S Iyer						-
 - ---------------------------------------------------------------------------------------- -
 - -------------------------------------------------------------------------------------- -->
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>PAGE NOT FOUND<%@include file="includeJSP/company_name_title.jsp"%></title>
    <%@include file="includeJSP/cssFiles.jsp"%>
	</head>
	<body class="hold-transition lockscreen">
		<div class="lockscreen-wrapper" style="max-width: 530px;">
			<div class="lockscreen-logo">
			  <img src="usedStaticFiles/essentials/images/logo.png" style="height:50px;" alt="Company Logo" class="brand-image">
			</div>
			<div class="lockscreen-logo font-2" style="font-size: 25px;">
			  Driving with you since 1961
			</div>
			<div class="lockscreen-logo" style="font-size: 25px;">
				<b>Page Not Found</b>
			</div>
			<div class="lockscreen-logo font-3" style="font-size: 20px;">
				Oops, something is not right.<br>
				Seems you requested for something which is not available.<br>
				<a href="logout" title="Go to Login Page" style="color: darkblue"><strong>Click Here</strong></a> to go Login.
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
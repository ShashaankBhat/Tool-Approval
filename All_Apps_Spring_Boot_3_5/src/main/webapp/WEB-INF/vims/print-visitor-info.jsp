<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page buffer="1024kb" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns='http://www.w3.org/1999/xhtml' lang='en-US'>
	<head>
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />
		<title>Print Page</title>
		<meta name='viewport' content='width=device-width, initial-scale=1.0'/>
		<style text='css'>
			body {
				/* font-size:8.5px; */
			}
			@page {
      /* size: 105mm 148mm; */ /* A4 size in mm */
      size: A5;
    }
			.stable1 {
                	font-family: Calibri;
            	}
            	.image-logo {
            		padding-right:15px;
            		padding-top:5px;
            	}
            	.initial-td {
            		padding: 5px 5px 5px 5px;
            		text-align:center;
            	}
            	.padding-one {
            		padding: 5px 5px 5px 5px;
            	}
            	.padding-two {
            		margin: 0;
            	}
            	.padding-three {
            		margin: 0;
            		padding: 2.5px 0 2.5px 2.5px;
            	}
			@media print {
            	.stable1 {
                	font-family: Calibri;
            	}
            	.image-logo {
            		padding-right:15px;
            		padding-top:5px;
            	}
            	.initial-td {
            		padding: 5px 5px 5px 5px;
            		text-align:center;
            	}
            	.padding-one {
            		padding: 5px 5px 5px 5px;
            	}
            	.padding-two {
            		margin: 0;
            	}
            	.padding-three {
            		margin: 0;
            		padding: 2.5px 0 2.5px 2.5px;
            	}
            }
		</style>
	</head>
	<body style='margin: 0; padding: 0;'>
		<c:forEach items="${visitor.visitorInformationDetail }" var="visitorInformation" varStatus="visitorInformationLoop">
		<table align='center' width='100%' class='stable1'>
			<tr>
				<td class='initial-td' style=''>
					<img class='image-logo' width='180' height='40' src='usedStaticFiles/essentials/images/logo.png' alt='Anand Group IJP.' />
				</td>
			</tr>
			<tr>
				<td class='initial-td' style=''>
					<b>${visitor.hostName.mEntityId.entitySource.entityName }</b>
				</td>
			</tr>
			<tr>
				<td class='initial-td' style=''>
					<b>${visitor.MVisitorType.visitorTypeName }</b>
				</td>
			</tr>
			<tr>
				<td class='initial-td' style=''>
					<img width='74mm' height='30mm' src='${visitorInformation.visitorImage }'>
								<br><b>${visitorInformation.visitorInformationId }</b>
				</td>
			</tr>
			<%-- <tr>
				<td class='padding-one'>
					<table class='stable' width='100%' style='font-size:15px'>
						<tr>
							<td>
								<b>${visitor.MVisitorType.visitorTypeName }</b>
							</td>
							<td style='text-align:center'>
								<img src='${visitorInformation.visitorImage }'>
								<br><b>${visitorInformation.visitorInformationId }</b>
							</td>
					</table>
				</td>
			</tr> --%>
			<tr>
				<td class='padding-one'>
					<table class='stable' width='100%' style='font-size:10px'>
						<tr>
							<td class='left'>
								<p class='padding-one padding-two'>
								Visitor Name</h4>
							</td>
							<td class='right'>
								<b><p class='padding-three' style='font-size:10px'>:&ensp;${visitorInformation.visitorName }</p></b>
							</td>
						</tr>
						<tr>
							<td class='left'>
								<p class='padding-one padding-two'>
								Visitor Company</p>
							</td>
							<td class='right'>
								<b><p class='padding-three' style='font-size:10px'>:&ensp;${visitor.visitorCompanyName }</p></b>
							</td>
						</tr>
						<tr>
							<td class='left'>
								<p class='padding-one padding-two'>
								Visitor Host</p>
							</td>
							<td class='right'>
								<p class='padding-three'>:&ensp;${visitor.visitorCreatedBy.userFirstName } ${visitor.visitorCreatedBy.userLastName }</p>
							</td>
						</tr>
						<%-- <tr>
							<td class='left'>
								<p class='padding-one padding-two'>
								Visitor Email</p>
							</td>
							<td class='right'>
								<p class='padding-three'>${visitorInformation.visitorEmail }</p>
							</td>
						</tr> --%>
						<tr>
							<td class='left'>
								<p class='padding-one padding-two'>
								Department</p>
							</td>
							<td class='right'>
								<p class='padding-three'>:&ensp;${visitor.hostName.mDepartmentId.departmentName}</p>
							</td>
						</tr>
						<tr>
							<td class='left'>
								<p class='padding-one padding-two'>
								Time In</p>
							</td>
							<td class='right'>
								<p class='padding-three'>:&ensp;<fmt:formatDate pattern = "dd-MMM-yyyy HH:MM a" value = "${visitorInformation.createdOn }" /></p>
							</td>
						</tr>
						<tr>
							<td class='left'>
								<p class='padding-one padding-two'>
								Valid Upto</p>
							</td>
							<td class='right'>
								<p class='padding-three'>:&ensp;<fmt:formatDate pattern = "dd-MMM-yyyy HH:MM a" value = "${visitor.visitorAllowedUntil }" /></p>
							</td>
						</tr>
						<tr>
							<td class='left'>
								<p class='padding-one padding-two'>
								Purpose</p>
							</td>
							<td class='right'>
								<p class='padding-three'>:&ensp;${visitor.MVisitorPurpose.visitorPurposeName }</p>
							</td>
						</tr>
						<tr>
							<td class='left'>
								<p class='padding-one padding-two'>
								Badge Number</p>
							</td>
							<td class='right'>
								<p class='padding-three'>:&ensp;${visitorInformation.visitorBatch }</p>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<div style="break-after:page"></div>
		</c:forEach>
		</body>
		<!-- <script>
		/* Trigger print on load */
		window.onload = () => {
			window.print();
		};
</script> -->
</html>
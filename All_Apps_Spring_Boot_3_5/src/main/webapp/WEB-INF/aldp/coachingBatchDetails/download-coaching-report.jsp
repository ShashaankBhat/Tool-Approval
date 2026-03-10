<!-- ****************************************************************************************
# *******************************************************************************************
# Copyright © 2021 Anand Group India. All rights reserved.									*
# No part of this product may be reproduced in any form by any means without prior			*
# written authorization of Anand Automotive Private Limited and its licensors, if any.		*
# *******************************************************************************************
																*
# *************************************************************************************** -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <title>COACHING BATCH DETAILS | ACT<%@include file="../../includeJSP/company_name_title.jsp"%></title>
    <%@include file="../../includeJSP/cssFiles.jsp"%>
    <%@include file="../../includeJSP/datePickerCss.jsp"%>
  </head>
  <body class="sidebar-mini layout-navbar-fixed sidebar-collapse pace-primary">
    <div class="wrapper">
      <%@include file="../includeJSP/header.jsp"%>
      <%@include file="../includeJSP/leftSideBar.jsp"%>
      <div class="content-wrapper">
        

    <div class="no-print">
        <button onclick="window.print()">Download Page as PDF</button>
    </div>


    <table border="1" cellpadding="8" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th>Program</th>
                <th>Employee Name</th>
                <th>Company</th>
                <th>Session Date</th>
				<th>Session Planned</th>
				<th>Session Completed </th>
				<th>Completion Percentage</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="coachee" items="${coachCoacheeListForCurrentBatch}">
                <tr>
                    <td>${coachee.actCoacheeProgram}</td>
                   
				 <td>${coachee.coacheeUserId.userFirstName} ${coachee.coacheeUserId.userLastName}</td>

                    <td>${coachee.mEntityId.entityName}</td>
                   
					<td>${coachee.plannedTillDate}</td>
                            <td>${coachee.actualTillDate}</td>

							 <td>
                              <c:set var="percentage" value="${fn:substringBefore((coachee.actualTillDate/coachee.plannedTillDate * 100), '.')}" />

                              <c:choose>
                                <c:when test="${percentage le 50}">
                                  <input type="text" class="knob" value="${percentage}" data-width="40" data-height="40" data-fgColor="#C00000" disabled>
                                </c:when>
                                <c:when test="${percentage gt 50 && percentage le 75}">
                                  <input type="text" class="knob" value="${percentage}" data-width="40" data-height="40" data-fgColor="#FFC000" disabled>
                                </c:when>
                                <c:otherwise>
                                  <input type="text" class="knob" value="${percentage}" data-width="40" data-height="40" data-fgColor="#009845" disabled>
                                </c:otherwise>
                              </c:choose>
                            </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <script>
      
        window.onload = function() {
            window.print();
        };
    </script>

</body>
</html>

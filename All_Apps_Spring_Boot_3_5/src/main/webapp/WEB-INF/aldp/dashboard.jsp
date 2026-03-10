<!-- ****************************************************************************************
# *******************************************************************************************
# Copyright © 2021 Anand Group India. All rights reserved.									*
# No part of this product may be reproduced in any form by any means without prior			*
# written authorization of Anand Automotive Private Limited and its licensors, if any.		*
# *******************************************************************************************
# Author - Sheshadhri Iyer																	*
# *************************************************************************************** -->
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> --%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>DASHBOARD | ACT<%@include file="../includeJSP/company_name_title.jsp"%></title>
    <%@include file="../includeJSP/cssFiles.jsp"%>
    			<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
  </head>
  <body class="sidebar-mini layout-navbar-fixed sidebar-collapse pace-primary">
    <div class="wrapper">
      <%@include file="includeJSP/header.jsp"%>
      <%@include file="includeJSP/leftSideBar.jsp"%>
      <div class="content-wrapper">
        <section class="content-header">
          <div class="container-fluid">
            <div class="row mb-2">
              <div class="col-sm-6">
                <h5 class="font-1 font-weight-bold">ACT DASHBOARD</h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item"><a href="dashboard" title="Dashboard"><strong>Dashboard</strong></a></li>
                  <li class="breadcrumb-item active"><strong>ACT Dashboard</strong></li>
                </ol>
              </div>
            </div>
          </div>
        </section>
        <c:if test="${ctAdmin eq 1 || itAdmin eq 1 || ctCoach eq 1 || ctCoachee eq 1 || ctProcessOwner eq 1 }">
        <section class="content content-margin">
          <div class="container-fluid">
            <div class="row">
              <div class="col-md-12">
                <div class="card card-primary collapsed-card mb-3">
                  <div class="card-header bg-1" data-card-widget="collapse">
                    <h5 class="card-title font-weight-bold"><i class="fas fa-filter font-color-anand-one"></i>&emsp;Filters</h5>
                    <div class="card-tools">
                      <button type="button" class="btn btn-tool" data-card-widget="collapse">
                        <i class="fas fa-plus font-color-anand-one"></i>
                      </button>
                    </div>
                  </div>
                  <div class="card-body p-3">
                    <form action="dashboard-act" id="actDashboardFilter" method="POST">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                      <div class="form-row align-items-end mb-3">
                        <div class="col-12 col-md-3 mb-2">
                          <label class="mb-1 font-weight-bold">Batch</label>
                          <select name="batchId" id="batchId" class="form-control select2">
                            <c:forEach items="${batchList}" var="batch">
                              <option value="${batch.actCoachingBatchId}" ${param.batchId == batch.actCoachingBatchId ? 'selected' : ''}>${batch.batchName}</option>
                            </c:forEach>
                          </select>
                        </div>
                        <c:if test="${ctAdmin eq 1 || itAdmin eq 1 }">
                        <div class="col-12 col-md-3 mb-2">
                          <label class="mb-1 font-weight-bold">Company</label>
                          <select name="companyId" class="form-control select2">
                            <option value="-1">Select Entity</option>
                            <c:forEach items="${entityList}" var="entity">
                              <option value="${entity.mEntityId}" ${param.companyId == entity.mEntityId ? 'selected' : ''}>${entity.entityName}</option>
                            </c:forEach>
                          </select>
                        </div>
                        <div class="col-12 col-md-3 mb-2">
                          <label class="mb-1 font-weight-bold">Coach</label>
                          <select name="coachId" id="coachId" class="form-control select2">
                            <option value="-1">Select Coach</option>
                            <c:forEach var="coach" items="${coachCoacheeForFilter}">
                              <c:if test="${coach.key eq 'coach' }">
                                <c:forEach items="${coach.value}" var="coachList">
                                  <option value="${coachList.mUserId}" ${param.coachId == coachList.mUserId ? 'selected' : ''}>${coachList.userFirstName } ${coachList.userLastName }</option>
                                </c:forEach>
                              </c:if>
                            </c:forEach>
                          </select>
                        </div>
                        <div class="col-12 col-md-3 mb-2">
                          <label class="mb-1 font-weight-bold">Coachee</label>
                          <select name="coacheeId" id="coacheeId" class="form-control select2">
                            <option value="-1">Select Coach</option>
                            <c:forEach var="coach" items="${coachCoacheeForFilter}">
                              <c:if test="${coach.key eq 'coachee' }">
                                <c:forEach items="${coach.value}" var="coachList">
                                  <option value="${coachList.mUserId}" ${param.coacheeId == coachList.mUserId ? 'selected' : ''}>${coachList.userFirstName } ${coachList.userLastName }</option>
                                </c:forEach>
                              </c:if>
                            </c:forEach>
                          </select>
                        </div>
                        <div class="col-12 col-md-3 mb-2">
                          <label class="mb-1 font-weight-bold">Program Category</label>
                          <select name="programCategoryFilter" class="form-control select2">
                            <option value="-1">Select Program Category</option>
                            <option value="1" ${param.programCategoryFilter == '1' ? 'selected' : ''}>AM - ANAND Mentee</option>
                            <option value="2" ${param.programCategoryFilter == '2' ? 'selected' : ''}>AT - ANAND Talent</option>
                            <option value="3" ${param.programCategoryFilter == '3' ? 'selected' : ''}>AL - ANAND Leader</option>
                          </select>
                        </div>
                        
                        <div class="col-12 col-md-3 mb-2">
                          <label class="mb-1 font-weight-bold">Completion Percentage</label>
                          <select name="percentageFilter" class="form-control select2">
                            <option value="-1">Select Percentage</option>
                            <option value="0-30" ${param.percentageFilter == '0-30' ? 'selected' : ''}>0% - 30%</option>
                            <option value="30-50" ${param.percentageFilter == '30-50' ? 'selected' : ''}>30% - 50%</option>
                            <option value="50-75" ${param.percentageFilter == '50-75' ? 'selected' : ''}>50% - 75%</option>
                            <option value="75-100" ${param.percentageFilter == '75-100' ? 'selected' : ''}>75% - 100%</option>
                          </select>
                        </div>
                        </c:if>
                        <div class="col-md-3 mb-2 d-flex">
                          <button type="submit" class="btn bg-1">Search</button>&ensp;
                          <button type="button" onclick='location.href="dashboard-act"' class="btn bg-3">Clear</button>
                        </div>
                      </div>
                    </form>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
        </c:if>
        <section class="content content-margin mt-1">
          <div class="container-fluid">
            <div class="row">
              <div class="col-md-12">
                <div class="card" id="resultsTable">
                  <div class="card-header bg-3">
                    <h3 class="card-title font-weight-bold">
                      <c:forEach items="${coachCoacheeListForCurrentBatch}" var="coachingMap" varStatus="coachingMapLoop">
                        <c:if test="${coachingMapLoop.index eq 0}">
                          ${coachingMap.coachCoacheeMappingSet.batchName}
                        </c:if>
                      </c:forEach>
                    </h3>
                  </div>
                  <div class="card-body">
                    <table class="table table-bordered">
                      <thead>
                        <tr>
                          <th>#</th>
                          <th>Coach</th>
                          <th>Coachee</th>
                          <th>Yearly Plan</th>
                          <th>Sessions Planned Till Date</th>
                          <th>Actual Session Completed</th>
                          <th style="width: 40px">Completion Percentage</th>
                        </tr>
                      </thead>
                      <tbody style="vertical-align: middle;">
                        <c:forEach items="${coachCoacheeListForCurrentBatch}" var="coachingMap" varStatus="coachingMapLoop">
                          <tr>
                            <td>${coachingMapLoop.index + 1}</td>
                            <td>${coachingMap.coachUserId.userFirstName} ${coachingMap.coachUserId.userLastName}</td>
                            <td>${coachingMap.coacheeUserId.userFirstName} ${coachingMap.coacheeUserId.userLastName}</td>
                            <td>${coachingMap.overallPlan}</td>
                            <td>${coachingMap.plannedTillDate}</td>
                            <td>${coachingMap.actualTillDate}</td>
                            <td>
                              <c:set var="percentage" value="${fn:substringBefore((coachingMap.actualTillDate/coachingMap.plannedTillDate * 100), '.')}" />
                              <c:choose>
                                <c:when test="${percentage le 30}">
                                  <input type="text" class="knob" value="${percentage}" data-width="40" data-height="40" data-fgColor="#C00000" disabled>
                                </c:when>
                                <c:when test="${percentage gt 30 && percentage le 50}">
                                  <input type="text" class="knob" value="${percentage}" data-width="40" data-height="40" data-fgColor="#E06000" disabled>
                                </c:when>
                                <c:when test="${percentage gt 50 && percentage le 75}">
                                  <input type="text" class="knob" value="${percentage}" data-width="40" data-height="40" data-fgColor="#80AC23" disabled>
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
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
      </div>
      <%@include file="includeJSP/footer.jsp"%>
    </div>
    <%@include file="../includeJSP/jsFiles.jsp"%>
    <script src="usedStaticFiles/essentials/js/charts/Chart.min.js"></script>
    <script src="usedStaticFiles/essentials/js/jquery-knob/jquery.knob.min.js"></script>
    <script>
    $(function () {
    	$('.select2').select2({
    		theme: 'bootstrap4'
    	});
    	$('.knob').knob({
    	      draw: function () {
    	        if (this.$.data('skin') == 'tron') {

    	          var a   = this.angle(this.cv)  // Angle
    	            ,
    	              sa  = this.startAngle          // Previous start angle
    	            ,
    	              sat = this.startAngle         // Start angle
    	            ,
    	              ea                            // Previous end angle
    	            ,
    	              eat = sat + a                 // End angle
    	            ,
    	              r   = true

    	          this.g.lineWidth = this.lineWidth

    	          this.o.cursor
    	          && (sat = eat - 0.3)
    	          && (eat = eat + 0.3)

    	          if (this.o.displayPrevious) {
    	            ea = this.startAngle + this.angle(this.value)
    	            this.o.cursor
    	            && (sa = ea - 0.3)
    	            && (ea = ea + 0.3)
    	            this.g.beginPath()
    	            this.g.strokeStyle = this.previousColor
    	            this.g.arc(this.xy, this.xy, this.radius - this.lineWidth, sa, ea, false)
    	            this.g.stroke()
    	          }

    	          this.g.beginPath()
    	          this.g.strokeStyle = r ? this.o.fgColor : this.fgColor
    	          this.g.arc(this.xy, this.xy, this.radius - this.lineWidth, sat, eat, false)
    	          this.g.stroke()

    	          this.g.lineWidth = 2
    	          this.g.beginPath()
    	          this.g.strokeStyle = this.o.fgColor
    	          this.g.arc(this.xy, this.xy, this.radius - this.lineWidth + 1 + this.lineWidth * 2 / 3, 0, 2 * Math.PI, false)
    	          this.g.stroke()

    	          return false
    	        }
    	      }
    	 });
    })
    </script>
  </body>
</html>
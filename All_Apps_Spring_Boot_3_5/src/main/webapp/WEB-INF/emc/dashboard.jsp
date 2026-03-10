<!-- ****************************************************************************************
# *******************************************************************************************
# Copyright © 2021 Anand Group India. All rights reserved.									*
# No part of this product may be reproduced in any form by any means without prior			*
# written authorization of Anand Automotive Private Limited and its licensors, if any.		*
# *******************************************************************************************
# Author - Sheshadhri Iyer																	*
# *************************************************************************************** -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
                <h5 class="font-1 font-weight-bold">EMC DASHBOARD</h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item"><a href="dashboard" title="Dashboard"><strong>Dashboard</strong></a></li>
                  <li class="breadcrumb-item active"><strong>EMC Dashboard</strong></li>
                </ol>
              </div>
            </div>
          </div>
        </section>
        <c:if test="${emcAdmin eq 1 || itAdmin eq 1 || emcMentee eq 1 || emcMentor eq 1 || emcProcessOwner eq 1 }">
        <section class="content content-margin">
          <div class="container-fluid">
            <div class="row">
              <div class="col-md-12">
                <div class="card card-primary collapsed-card mb-3">
                  <div class="card-header bg-1" data-card-widget="collapse">
                    <h5 class="card-title font-weight-bold"><i class="fas fa-filter"></i>&emsp;Filters</h5>
                    <div class="card-tools">
                      <button type="button" class="btn btn-tool" data-card-widget="collapse">
                        <i class="fas fa-plus text-white font-weight-bold"></i>
                      </button>
                    </div>
                  </div>
                  <div class="card-body p-3">
                    <form action="dashboard-emc" id="actDashboardFilter" method="POST">
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
                        <c:if test="${emcAdmin eq 1 || itAdmin eq 1 || emcProcessOwner eq 1 }">
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
                          <label class="mb-1 font-weight-bold">Mentor/Coach</label>
                          <select name="coachId" id="coachId" class="form-control select2">
                            <option value="-1">Select Mentor/Coach</option>
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
                          <label class="mb-1 font-weight-bold">Mentee/Coachee</label>
                          <select name="coacheeId" id="coacheeId" class="form-control select2">
                            <option value="-1">Select Mentee/Coachee</option>
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
                            <option value="1" ${param.programCategoryFilter == '1' ? 'selected' : ''}>Senior Executive Coaching</option>
                            <option value="2" ${param.programCategoryFilter == '2' ? 'selected' : ''}>Top Executive Mentoring</option>
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
                          <button type="button" onclick='location.href="dashboard-emc"' class="btn bg-3">Clear</button>
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
                <div class="card">
                  <div class="card-header bg-3">
                    <h3 class="card-title font-weight-bold">
                      <c:forEach items="${coachCoacheeListForCurrentBatch }" var="coachingMap" varStatus="coachingMapLoop">
                        <c:if test="${coachingMapLoop.index eq 0 }">
                          ${coachingMap.coachCoacheeMappingSet.batchName }
                        </c:if>
                      </c:forEach>
                    </h3>
                  </div>
                  <div class="card-body">
                    <div class="col-md-12">
                      <c:choose>
                        <c:when test="${itAdmin eq 1 || emcAdmin eq 1 || emcProcessOwner eq 1}">
                          <table class="table table-bordered" id="adminEmcTable">
                            <thead>
                              <tr>
                                <th>Mentee/Coachee</th>
                                <th>Mentor/Coach</th>
                                <th>Program Type</th>
                                <th>Targeted Session Count</th>
                                <th>Sessions Planned Till Date</th>
                                <th>Actual Session Completed</th>
                                <th style="width: 40px">Completion Percentage</th>
                              </tr>
                            </thead>
                            <tbody style="vertical-align: middle;">
                              <c:forEach items="${coachCoacheeListForCurrentBatch1 }" var="coachingMap" varStatus="coachingMapLoop">
                                <tr>
                                  <td>${coachingMap.coacheeUserId.userFirstName } ${coachingMap.coacheeUserId.userLastName }</td>
                                  <td>${coachingMap.coachUserId.userFirstName } ${coachingMap.coachUserId.userLastName }</td>
                                  <td>
                                    <c:choose>
                                      <c:when test = "${coachingMap.actCoacheeProgram == 2 }">
                                        <span class="badge sequence-bg-5" style='font-size:14px'>Top Executive Mentoring</span>
                                      </c:when>
                                      <c:when test = "${coachingMap.actCoacheeProgram == 1 }">
                                        <span class="badge sequence-bg-4" style='font-size:14px'>Senior Executive Coaching</span>
                                      </c:when>
                                    </c:choose>
                                  </td>
                                  <td>${coachingMap.overallPlan }</td>
                                  <td>${coachingMap.plannedTillDate }</td>
                                  <td>${coachingMap.actualTillDate }</td>
                                  <td>
                                    <c:set var="percentage" value="${fn:substringBefore((coachingMap.actualTillDate/coachingMap.overallPlan * 100), '.')}" />
                                    <c:choose>
                                      <c:when test="${percentage le 30}">
                                        <span class="badge sequence-bg-1" style='font-size:18px'>${percentage }%</span>
                                      </c:when>
                                      <c:when test="${percentage gt 30 && percentage le 50}">
                                        <span class="badge sequence-bg-2" style='font-size:18px'>${percentage }%</span>
                                      </c:when>
                                      <c:when test="${percentage gt 50 && percentage le 75}">
                                        <span class="badge sequence-bg-4" style='font-size:18px'>${percentage }%</span>
                                      </c:when>
                                      <c:otherwise>
                                        <span class="badge sequence-bg-5" style='font-size:18px'>${percentage }%</span>
                                      </c:otherwise>
                                    </c:choose>
                                  </td>
                                </tr>
                              </c:forEach>
                            </tbody>
                          </table>
                        </c:when>
                        <c:when test="${itAdmin eq 1 || (emcMentor eq 1 && emcMentee eq 1) }">
                          <h5 class="font-2 font-weight-bold">Your Analytics</h5>
                          <table class="table table-bordered" id="adminEmcTable">
                            <thead>
                              <tr>
                                <th>Mentee/Coachee</th>
                                <th>Mentor/Coach</th>
                                <th>Program Type</th>
                                <th>Targeted Session Count</th>
                                <th>Sessions Planned Till Date</th>
                                <th>Actual Session Completed</th>
                                <th style="width: 40px">Completion Percentage</th>
                              </tr>
                            </thead>
                            <tbody style="vertical-align: middle;">
                              <c:forEach items="${coachCoacheeListForCurrentBatch1 }" var="coachingMap" varStatus="coachingMapLoop">
                                <c:if test="${coachingMap.coacheeUserId.mUserId eq sessionUserInfo.mUserId }">
                                <tr>
                                  <td>${coachingMap.coacheeUserId.userFirstName } ${coachingMap.coacheeUserId.userLastName }</td>
                                  <td>${coachingMap.coachUserId.userFirstName } ${coachingMap.coachUserId.userLastName }</td>
                                  <td>
                                    <c:choose>
                                      <c:when test = "${coachingMap.actCoacheeProgram == 2 }">
                                        <span class="badge sequence-bg-5" style='font-size:14px'>Top Executive Mentoring</span>
                                      </c:when>
                                      <c:when test = "${coachingMap.actCoacheeProgram == 1 }">
                                        <span class="badge sequence-bg-4" style='font-size:14px'>Senior Executive Coaching</span>
                                      </c:when>
                                    </c:choose>
                                  </td>
                                  <td>${coachingMap.overallPlan }</td>
                                  <td>${coachingMap.plannedTillDate }</td>
                                  <td>${coachingMap.actualTillDate }</td>
                                  <td>
                                    <c:set var="percentage" value="${fn:substringBefore((coachingMap.actualTillDate/coachingMap.overallPlan * 100), '.')}" />
                                    <c:choose>
                                      <c:when test="${percentage le 30}">
                                        <span class="badge sequence-bg-1" style='font-size:18px'>${percentage }%</span>
                                      </c:when>
                                      <c:when test="${percentage gt 30 && percentage le 50}">
                                        <span class="badge sequence-bg-2" style='font-size:18px'>${percentage }%</span>
                                      </c:when>
                                      <c:when test="${percentage gt 50 && percentage le 75}">
                                        <span class="badge sequence-bg-4" style='font-size:18px'>${percentage }%</span>
                                      </c:when>
                                      <c:otherwise>
                                        <span class="badge sequence-bg-5" style='font-size:18px'>${percentage }%</span>
                                      </c:otherwise>
                                    </c:choose>
                                  </td>
                                </tr>
                                </c:if>
                              </c:forEach>
                            </tbody>
                          </table>
                          <h5 class="font-3 font-weight-bold">Your Coachee/Mentee Analytics</h5>
                          <table class="table table-bordered" id="adminEmcTable">
                            <thead>
                              <tr>
                                <th>Mentee/Coachee</th>
                                <th>Mentor/Coach</th>
                                <th>Program Type</th>
                                <th>Targeted Session Count</th>
                                <th>Sessions Planned Till Date</th>
                                <th>Actual Session Completed</th>
                                <th style="width: 40px">Completion Percentage</th>
                              </tr>
                            </thead>
                            <tbody style="vertical-align: middle;">
                              <c:forEach items="${coachCoacheeListForCurrentBatch1 }" var="coachingMap" varStatus="coachingMapLoop">
                                ${coachingMap.coachUserId.mUserId} -- ${sessionUserInfo.mUserId }
                                <c:if test="${coachingMap.coachUserId.mUserId eq sessionUserInfo.mUserId }">
                                <tr>
                                  <td>${coachingMap.coacheeUserId.userFirstName } ${coachingMap.coacheeUserId.userLastName }</td>
                                  <td>${coachingMap.coachUserId.userFirstName } ${coachingMap.coachUserId.userLastName }</td>
                                  <td>
                                    <c:choose>
                                      <c:when test = "${coachingMap.actCoacheeProgram == 2 }">
                                        <span class="badge sequence-bg-5" style='font-size:14px'>Top Executive Mentoring</span>
                                      </c:when>
                                      <c:when test = "${coachingMap.actCoacheeProgram == 1 }">
                                        <span class="badge sequence-bg-4" style='font-size:14px'>Senior Executive Coaching</span>
                                      </c:when>
                                    </c:choose>
                                  </td>
                                  <td>${coachingMap.overallPlan }</td>
                                  <td>${coachingMap.plannedTillDate }</td>
                                  <td>${coachingMap.actualTillDate }</td>
                                  <td>
                                    <c:set var="percentage" value="${fn:substringBefore((coachingMap.actualTillDate/coachingMap.overallPlan * 100), '.')}" />
                                    <c:choose>
                                      <c:when test="${percentage le 30}">
                                        <span class="badge sequence-bg-1" style='font-size:18px'>${percentage }%</span>
                                      </c:when>
                                      <c:when test="${percentage gt 30 && percentage le 50}">
                                        <span class="badge sequence-bg-2" style='font-size:18px'>${percentage }%</span>
                                      </c:when>
                                      <c:when test="${percentage gt 50 && percentage le 75}">
                                        <span class="badge sequence-bg-4" style='font-size:18px'>${percentage }%</span>
                                      </c:when>
                                      <c:otherwise>
                                        <span class="badge sequence-bg-5" style='font-size:18px'>${percentage }%</span>
                                      </c:otherwise>
                                    </c:choose>
                                  </td>
                                </tr>
                                </c:if>
                              </c:forEach>
                            </tbody>
                          </table>
                        </c:when>
                        <c:when test="${emcMentor eq 1 }">
                          <table class="table table-bordered" id="adminEmcTable">
                            <thead>
                              <tr>
                                <th>Mentee/Coachee</th>
                                <th>Mentor/Coach</th>
                                <th>Program Type</th>
                                <th>Targeted Session Count</th>
                                <th>Sessions Planned Till Date</th>
                                <th>Actual Session Completed</th>
                                <th style="width: 40px">Completion Percentage</th>
                              </tr>
                            </thead>
                            <tbody style="vertical-align: middle;">
                              <c:forEach items="${coachCoacheeListForCurrentBatch1 }" var="coachingMap" varStatus="coachingMapLoop">
                                <c:if test="${coachingMap.coachUserId.mUserId ne sessionUserInfo.mUserId }">
                                <tr>
                                  <td>${coachingMap.coacheeUserId.userFirstName } ${coachingMap.coacheeUserId.userLastName }</td>
                                  <td>${coachingMap.coachUserId.userFirstName } ${coachingMap.coachUserId.userLastName }</td>
                                  <td>
                                    <c:choose>
                                      <c:when test = "${coachingMap.actCoacheeProgram == 2 }">
                                        <span class="badge sequence-bg-5" style='font-size:14px'>Top Executive Mentoring</span>
                                      </c:when>
                                      <c:when test = "${coachingMap.actCoacheeProgram == 1 }">
                                        <span class="badge sequence-bg-4" style='font-size:14px'>Senior Executive Coaching</span>
                                      </c:when>
                                    </c:choose>
                                  </td>
                                  <td>${coachingMap.overallPlan }</td>
                                  <td>${coachingMap.plannedTillDate }</td>
                                  <td>${coachingMap.actualTillDate }</td>
                                  <td>
                                    <c:set var="percentage" value="${fn:substringBefore((coachingMap.actualTillDate/coachingMap.overallPlan * 100), '.')}" />
                                    <c:choose>
                                      <c:when test="${percentage le 30}">
                                        <span class="badge sequence-bg-1" style='font-size:18px'>${percentage }%</span>
                                      </c:when>
                                      <c:when test="${percentage gt 30 && percentage le 50}">
                                        <span class="badge sequence-bg-2" style='font-size:18px'>${percentage }%</span>
                                      </c:when>
                                      <c:when test="${percentage gt 50 && percentage le 75}">
                                        <span class="badge sequence-bg-4" style='font-size:18px'>${percentage }%</span>
                                      </c:when>
                                      <c:otherwise>
                                        <span class="badge sequence-bg-5" style='font-size:18px'>${percentage }%</span>
                                      </c:otherwise>
                                    </c:choose>
                                  </td>
                                </tr>
                                </c:if>
                              </c:forEach>
                            </tbody>
                          </table>
                        </c:when>
                        <c:when test="${emcMentee eq 1 }">
                          <table class="table table-bordered" id="adminEmcTable">
                            <thead>
                              <tr>
                                <th>Mentee/Coachee</th>
                                <th>Mentor/Coach</th>
                                <th>Program Type</th>
                                <th>Targeted Session Count</th>
                                <th>Sessions Planned Till Date</th>
                                <th>Actual Session Completed</th>
                                <th style="width: 40px">Completion Percentage</th>
                              </tr>
                            </thead>
                            <tbody style="vertical-align: middle;">
                              <c:forEach items="${coachCoacheeListForCurrentBatch1 }" var="coachingMap" varStatus="coachingMapLoop">
                                <c:if test="${coachingMap.coacheeUserId.mUserId eq sessionUserInfo.mUserId }">
                                <tr>
                                  <td>${coachingMap.coacheeUserId.userFirstName } ${coachingMap.coacheeUserId.userLastName }</td>
                                  <td>${coachingMap.coachUserId.userFirstName } ${coachingMap.coachUserId.userLastName }</td>
                                  <td>
                                    <c:choose>
                                      <c:when test = "${coachingMap.actCoacheeProgram == 2 }">
                                        <span class="badge sequence-bg-5" style='font-size:14px'>Top Executive Mentoring</span>
                                      </c:when>
                                      <c:when test = "${coachingMap.actCoacheeProgram == 1 }">
                                        <span class="badge sequence-bg-4" style='font-size:14px'>Senior Executive Coaching</span>
                                      </c:when>
                                    </c:choose>
                                  </td>
                                  <td>${coachingMap.overallPlan }</td>
                                  <td>${coachingMap.plannedTillDate }</td>
                                  <td>${coachingMap.actualTillDate }</td>
                                  <td>
                                    <c:set var="percentage" value="${fn:substringBefore((coachingMap.actualTillDate/coachingMap.overallPlan * 100), '.')}" />
                                    <c:choose>
                                      <c:when test="${percentage le 30}">
                                        <span class="badge sequence-bg-1" style='font-size:18px'>${percentage }%</span>
                                      </c:when>
                                      <c:when test="${percentage gt 30 && percentage le 50}">
                                        <span class="badge sequence-bg-2" style='font-size:18px'>${percentage }%</span>
                                      </c:when>
                                      <c:when test="${percentage gt 50 && percentage le 75}">
                                        <span class="badge sequence-bg-4" style='font-size:18px'>${percentage }%</span>
                                      </c:when>
                                      <c:otherwise>
                                        <span class="badge sequence-bg-5" style='font-size:18px'>${percentage }%</span>
                                      </c:otherwise>
                                    </c:choose>
                                  </td>
                                </tr>
                                </c:if>
                              </c:forEach>
                            </tbody>
                          </table>
                        </c:when>
                      </c:choose>
                      
                    </div>
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
    	  var observation_tracker = $('#observation_tracker').get(0).getContext('2d');
    	  var observation_tracker_data = {
    			  labels: ['Covered > 70%','Covered > 50%','Covered < 50%'],
    			  datasets: [{
    				  data: [30,30,40],
    				  backgroundColor: ['#009845', '#FFC000', '#C00000']
    			  }]
    	  }
    	  var observation_tracker_options = {
    			  maintainAspectRatio : false,
    			  responsive : true
    	  }
    	  var observation_tracker_chart = new Chart(observation_tracker, {
    		  type: 'doughnut',
    		  data: observation_tracker_data,
    		  options: observation_tracker_options
    		  });
    	  });
      /* jQueryKnob */
		    $('.knob').knob({
		      /*change : function (value) {
		       //console.log("change : " + value);
		       },
		       release : function (value) {
		       console.log("release : " + value);
		       },
		       cancel : function () {
		       console.log("cancel : " + this.value);
		       },*/
		      draw: function () {

		        // "tron" case
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
		    })
		    /* END JQUERY KNOB */
		</script>
  </body>
</html>
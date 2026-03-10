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
    <title>EMC MIS REPORT | EMC<%@include file="../includeJSP/company_name_title.jsp"%></title>
    <%@include file="../includeJSP/cssFiles.jsp"%>
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
                <h5 class="font-1 font-weight-bold">EMC MIS REPORT</h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item"><a href="dashboard" title="Dashboard"><strong>Dashboard</strong></a></li>
                  <li class="breadcrumb-item active"><strong>EMC MIS Report</strong></li>
                </ol>
              </div>
            </div>
          </div>
        </section>
        <c:if test="${ctAdmin eq 1 || itAdmin eq 1 }">
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
                    <form action="emc-coaching-mis-report" id="actDashboardFilter" method="POST">
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
		            <div class="row">
		              
		              <div class="col-md-12 table-responsive" style="overflow-x: auto; max-width: 100%;">
		                <c:set value="0" var="maxSessionCountTempSet" />
		                <table class="table table-bordered table-striped dataTable" id="appTable">
		                  <thead>
		                    <tr class="bg-table-head">
		                      <th>Program</th>
		                      <th>Coachee/Mentee</th>
		                      <th>Coach/Mentor</th>
		                      <th>Company</th>
		                      <c:forEach var="sessionCount" items="${coachCoacheeForFilter}">
                                <c:if test="${sessionCount.key eq 'maxSessionCount' }">
                                  <c:forEach items="${sessionCount.value}" var="reportCount">
                                    <c:set value="${reportCount.mUserId }" var="maxSessionCountTempSet" />
                                    <c:forEach var="i" begin="1" end="${reportCount.mUserId }">
                                      <th>Coaching Session - ${i}</th>
                                    </c:forEach>
                                  </c:forEach>
                                </c:if>
                              </c:forEach>
		                      <th>YTM</th>
                          <!-- <th>actualTillDateTopExe</th> -->
		                      <th>% Completion</th>
		                    </tr>
		                  </thead>
		                  <tbody style="vertical-align: middle;">
		                    <c:forEach items="${coachCoacheeListForCurrentBatch}" var="coachingMap" varStatus="coachingMapLoop">
		                      <tr>
		                        <td>
		                          <c:choose>
		                            <c:when test="${coachingMap.actCoacheeProgram eq 1}">
		                              <span class="badge bg-1" style='font-size:15px'>Senior Executive Coaching</span>
		                            </c:when>
		                            <c:when test="${coachingMap.actCoacheeProgram eq 2}">
		                              <span class="badge bg-2" style='font-size:15px'>Top Executive Mentoring</span>
		                            </c:when>
		                          </c:choose>
		                        </td>
		                        <td>${coachingMap.coacheeUserId.userFirstName} ${coachingMap.coacheeUserId.userLastName}</td>
		                        <td>${coachingMap.coachUserId.userFirstName} ${coachingMap.coachUserId.userLastName}</td>
		                        <td>${coachingMap.coacheeUserId.mEntityId.entitySource.entityName} - ${coachingMap.coacheeUserId.mEntityId.locationId.locationName}</td>
		                        <c:forEach items="${coachingMap.coacheeReportTempList }" var="report">
		                          <td><fmt:formatDate value="${report.sessionDate}" pattern="dd-MMM-yyyy" /></td>
		                        </c:forEach>
		                        <%-- <c:set value="${maxSessionCountTempSet - fn:length(coachingMap.coacheeReportTempList) }" var="maxSessionCountTempSet" /> --%>
		                        <c:if test="${maxSessionCountTempSet ne fn:length(coachingMap.coacheeReportTempList)}">
		                          <c:set value="${maxSessionCountTempSet - fn:length(coachingMap.coacheeReportTempList) }" var="maxSessionCountTempSetTemp" />
		                          <c:forEach var="i" begin="1" end="${maxSessionCountTempSetTemp }">
		                            <td>-</td>
		                          </c:forEach>
		                        </c:if>
		                        <td>${coachingMap.actualTillDate}</td>
                              <!-- <td>${coachingMap.plannedTillDateTopExe}</td> -->
                           <c:choose>
  <c:when test="${coachingMap.actCoacheeProgram == 1}">
    <td>
      <c:set var="percentage" value="${fn:substringBefore((coachingMap.actualTillDate/coachingMap.plannedTillDate * 100), '.')}" />
      <c:choose>
        <c:when test="${percentage le 30}">
          <span class="badge sequence-bg-1" style='font-size:18px'>${percentage}%</span>
        </c:when>
        <c:when test="${percentage gt 30 && percentage le 50}">
          <span class="badge sequence-bg-2" style='font-size:18px'>${percentage}%</span>
        </c:when>
        <c:when test="${percentage gt 50 && percentage le 75}">
          <span class="badge sequence-bg-4" style='font-size:18px'>${percentage}%</span>
        </c:when>
        <c:otherwise>
          <span class="badge sequence-bg-5" style='font-size:18px'>${percentage}%</span>
        </c:otherwise>
      </c:choose>
    </td>
  </c:when>


  <c:when test="${coachingMap.actCoacheeProgram == 2}">
    <td>
      <c:set var="percentage2" value="${fn:substringBefore((coachingMap.actualTillDate/coachingMap.plannedTillDateTopExe * 100), '.')}" />
      <c:choose>
        <c:when test="${percentage2 le 30}">
          <span class="badge sequence-bg-1" style='font-size:18px'>${percentage2}%</span>
        </c:when>
        <c:when test="${percentage2 gt 30 && percentage2 le 50}">
          <span class="badge sequence-bg-2" style='font-size:18px'>${percentage2}%</span>
        </c:when>
        <c:when test="${percentage2 gt 50 && percentage2 le 75}">
          <span class="badge sequence-bg-4" style='font-size:18px'>${percentage2}%</span>
        </c:when>
        <c:otherwise>
          <span class="badge sequence-bg-5" style='font-size:18px'>${percentage2}%</span>
        </c:otherwise>
      </c:choose>
    </td>
  </c:when>


</c:choose>

                            
		                      </tr>
		                    </c:forEach>
		                  </tbody>
		                  <tfoot>
		                    <tr class="bg-table-head">
		                      <th>Program</th>
		                      <th>Coachee/Mentee</th>
		                      <th>Coach/Mentor</th>
		                      <th>Company</th>
		                      <c:forEach var="sessionCount" items="${coachCoacheeForFilter}">
                                <c:if test="${sessionCount.key eq 'maxSessionCount' }">
                                  <c:forEach items="${sessionCount.value}" var="reportCount">
                                    <c:forEach var="i" begin="1" end="${reportCount.mUserId }">
                                      <th>Coaching Session - ${i}</th>
                                    </c:forEach>
                                  </c:forEach>
                                </c:if>
                              </c:forEach>
		                      <th>YTM</th>
		                      <th>% Completion</th>
		                    </tr>
		                  </tfoot>
		                </table>
		              </div>
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
    <%@ include file="../includeJSP/dataTablesImport.jsp" %>
    <script src="usedStaticFiles/essentials/js/jsp_js_files/emc/mis-report2.js"></script>
  </body>
</html>
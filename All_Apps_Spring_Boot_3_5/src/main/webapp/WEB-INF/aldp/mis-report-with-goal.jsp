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
    <title>ACT MIS REPORT | ACT<%@include file="../includeJSP/company_name_title.jsp"%></title>
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
                <h5 class="font-1 font-weight-bold">ACT MIS REPORT</h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item"><a href="dashboard" title="Dashboard"><strong>Dashboard</strong></a></li>
                  <li class="breadcrumb-item active"><strong>ACT MIS Report</strong></li>
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
                    <form action="coaching-mis-report-with-goal" id="actDashboardFilter" method="POST">
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
                            <option value="-1">Select Coachee</option>
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
		            <div class="row">
		              
		              <div class="col-md-12 table-responsive" style="overflow-x: auto; max-width: 100%;">
		                <c:set value="0" var="maxSessionCountTempSet" />
		                <table class="table table-bordered table-striped dataTable" id="appTable">
		                  <thead>
		                    <tr class="bg-table-head">
		                      <th>Program</th>
		                      <th>Participant</th>
		                      <th>Company</th>
		                      <th>Coaching Goal</th>
		                    </tr>
		                  </thead>
		                  <tbody style="vertical-align: middle;">
		                    <c:forEach items="${coachCoacheeListForCurrentBatch}" var="coachingMap" varStatus="coachingMapLoop">
		                      <tr>
		                        <td>
		                          <c:choose>
		                            <c:when test="${coachingMap.actCoacheeProgram eq 1}">
		                              <span class="badge bg-1" style='font-size:15px'>ANAND Mentee - AM</span>
		                            </c:when>
		                            <c:when test="${coachingMap.actCoacheeProgram eq 2}">
		                              <span class="badge bg-2" style='font-size:15px'>ANAND Talent - AT</span>
		                            </c:when>
		                            <c:otherwise>
		                              <span class="badge bg-3" style='font-size:15px'>ANAND Leader - AL</span>
		                            </c:otherwise>
		                          </c:choose>
		                        </td>
		                        <td>${coachingMap.coacheeUserId.userFirstName} ${coachingMap.coacheeUserId.userLastName}</td>
		                        <td>${coachingMap.coacheeUserId.mEntityId.entitySource.entityName} - ${coachingMap.coacheeUserId.mEntityId.locationId.locationName}</td>
		                        <td>
		                          <ul>
		                          <c:forEach items="${coachingMap.coacheeGoalsSet }" var="goal" varStatus="goalLoop">
		                            <c:if test="${goal.coachingGoalActive eq 1 }">
		                              <li>${goal.coachingGoal } - ${goal.mCompetencyId.competencyName }</li>
		                            </c:if>
		                          </c:forEach>
		                          </ul>
		                        </td>
		                      </tr>
		                    </c:forEach>
		                  </tbody>
		                  <tfoot>
		                    <tr class="bg-table-head">
		                      <th>Program</th>
		                      <th>Participant</th>
		                      <th>Company</th>
		                      <th>Coaching Goal</th>
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
    <script src="usedStaticFiles/essentials/js/jsp_js_files/aldp/mis-report2.js"></script>
  </body>
</html>
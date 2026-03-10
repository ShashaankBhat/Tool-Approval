<!-- ****************************************************************************************
# *******************************************************************************************
# Copyright © 2021 Anand Group India. All rights reserved.									*
# No part of this product may be reproduced in any form by any means without prior			*
# written authorization of Anand Automotive Private Limited and its licensors, if any.		*
# *******************************************************************************************
# Author - Sheshadhri Iyer																	*
# *************************************************************************************** -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>COACHING GOALS | ACT<%@include file="../../includeJSP/company_name_title.jsp"%></title>
    <%@include file="../../includeJSP/cssFiles.jsp"%>
    <%@include file="../../includeJSP/datePickerCss.jsp"%>
  </head>
  <body class="sidebar-mini layout-navbar-fixed sidebar-collapse pace-primary">
    <div class="wrapper">
      <%@include file="../includeJSP/header.jsp"%>
      <%@include file="../includeJSP/leftSideBar.jsp"%>
      <div class="content-wrapper">
        <input type="hidden" id="jsBatchName" value="${coachCoacheeMapInfo.coachCoacheeMappingSet.batchName }" />
        <input type="hidden" id="jsCoacheeName" value="${coachCoacheeMapInfo.coacheeUserId.userFirstName } ${coachCoacheeMapInfo.coacheeUserId.userLastName }" />
        <input type="hidden" id="jsCoachName" value="${coachCoacheeMapInfo.coachUserId.userFirstName } ${coachCoacheeMapInfo.coachUserId.userLastName }" />
        <input type="hidden" id="jsSupervisorName" value="${coachCoacheeMapInfo.supervisorUserId.userFirstName } ${coachCoacheeMapInfo.supervisorUserId.userLastName }" />
        <section class="content-header">
          <div class="container-fluid">
            <div class="row mb-2">
              <div class="col-sm-6">
                <h5 class="font-3 font-weight-bold">Coaching Goals - ${coachCoacheeMapInfo.coacheeUserId.userFirstName } ${coachCoacheeMapInfo.coacheeUserId.userLastName } - ${coachCoacheeMapInfo.coachCoacheeMappingSet.batchName } </h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right font-weight-bold">
                  <li class="breadcrumb-item"><a href="dashboard-act" title="Dashboard">Dashboard</a></li>
                  <li class="breadcrumb-item"><a href="coaching-batch-details" title="Coaching Batch Details">Coaching Batch</a></li>
                  <c:if test="${ctCoach eq 1 || ctAdmin eq 1 || itAdmin eq 1 }">
                    <li class="breadcrumb-item"><a href="coachee-list?batch-id=${coachCoacheeMapInfo.coachCoacheeMappingSet.actCoachingBatchId }" title="Coachee List">Coachee List</a></li>
                  </c:if>
                  <li class="breadcrumb-item active">Coachee List</li>
                </ol>
              </div>
            </div>
          </div>
        </section>
        
        <c:if test="${not empty regMsg }">
          <section class="content content-margin">
            <div class="container-fluid">
              <div class="alert ${css } alert-dismissible">
                <button type="button" title="CLose Alert Box" class="close" data-dismiss="alert" aria-hidden="true"><i class="fas fa-times"></i></button>
                <c:if test="${css eq 'sequence-bg-1'}">
                  <h5><i class="icon fas fa-ban"></i>${regMsg }</h5>
                </c:if>
                <c:if test="${css ne 'sequence-bg-1'}">
                  <h5><i class="icon fas fa-check"></i>${regMsg }</h5>
                </c:if>
              </div>
            </div>
          </section>
        </c:if>

		<section class="content content-margin">
		  <div class="container-fluid">
		    <div class="row">
		      <div class="col-md-12">
		        <div class="card">
		          <div class="card-header bg-3">
		            <div class="row mb-2 font-weight-bold">
		              <div class="col-sm-4">
		                <h5 class="card-title font-weight-bold">Batch: ${coachCoacheeMapDetails.coachCoacheeMappingSet.batchName }</h5>
		              </div>
		              <div class="col-sm-6">
		                <h5 class="card-title font-weight-bold">Description: ${coachCoacheeMapDetails.coachCoacheeMappingSet.batchDescription }</h5>
		              </div>
		              <div class="col-sm-2">
		                <h5 class="card-title font-weight-bold"><a title="Add/Edit Coaching Report" class="font-white breadcrumb-item font-weight-bold font-sequence-2" href="coaching-report?batch-id=${coachCoacheeMapDetails.coachCoacheeMappingSet.actCoachingBatchId }&coachee-id=${coachCoacheeMapDetails.coacheeUserId.mUserId }">Add/Edit Report</a></h5>
		              </div>
		              <div class="col-sm-4">
		                <h5 class="card-title font-weight-bold">Coachee: ${coachCoacheeMapDetails.coacheeUserId.userFirstName } ${coachCoacheeMapDetails.coacheeUserId.userLastName }</h5>
		              </div>
		              <div class="col-sm-4">
		                <h5 class="card-title font-weight-bold">Coach: ${coachCoacheeMapDetails.coachUserId.userFirstName } ${coachCoacheeMapDetails.coachUserId.userLastName }</h5>
		              </div>
		              <div class="col-sm-4">
		                <h5 class="card-title font-weight-bold">Supervisor: ${coachCoacheeMapDetails.supervisorUserId.userFirstName } ${coachCoacheeMapDetails.supervisorUserId.userLastName }</h5>
		              </div>
		              <%-- <div class="col-sm-4">
		                <ol class="breadcrumb">
		                  <li class="breadcrumb-item">Batch: ${coachCoacheeMapDetails.coachCoacheeMappingSet.batchName }</li>
		                </ol>
		              </div>
		              <div class="col-sm-6">
		                <ol class="breadcrumb">
		                  <li class="breadcrumb-item">Description: ${coachCoacheeMapDetails.coachCoacheeMappingSet.batchDescription }</li>
		                </ol>
		              </div>
		              <div class="col-sm-2">
		                <ol class="breadcrumb">
		                  <li class="breadcrumb-item"><a title="Add/Edit Coaching Report" class="breadcrumb-item font-weight-bold font-color-anand-warning" href="coaching-report?batch-id=${coachCoacheeMapDetails.coachCoacheeMappingSet.actCoachingBatchId }&coachee-id=${coachCoacheeMapDetails.coacheeUserId.mUserId }">Add/Edit Report</a></li>
		                </ol>
		              </div>
		              <div class="col-sm-4">
		                <ol class="breadcrumb">
		                  <li class="breadcrumb-item">Coachee: ${coachCoacheeMapDetails.coacheeUserId.userFirstName } ${coachCoacheeMapDetails.coacheeUserId.userLastName }</li>
		                </ol>
		              </div>
		              <div class="col-sm-4">
		                <ol class="breadcrumb">
		                  <li class="breadcrumb-item">Coach: ${coachCoacheeMapDetails.coachUserId.userFirstName } ${coachCoacheeMapDetails.coachUserId.userLastName } </li>
		                </ol>
		              </div>
		              <div class="col-sm-4">
		                <ol class="breadcrumb">
		                  <li class="breadcrumb-item">Supervisor: ${coachCoacheeMapDetails.supervisorUserId.userFirstName } ${coachCoacheeMapDetails.supervisorUserId.userLastName } </li>
		                </ol>
		              </div> --%>
		            </div>
		          </div>
		          <div class="card-body">
		            <div class="row">
		              <div class="col-md-12">
		                <h5 class="font-1 font-weight-bold">Active Goals</h5>
		              </div>
		              <div class="col-md-12">
		                <table class="table table-bordered dataTable anand-table-font-size" id="coachingGoalTableActive">
		                  <thead>
		                    <tr class="bg-table-head">
		                      <th>Action</th>
		                      <th>Coaching Theme</th>
		                      <th>Coaching Goal</th>
		                      <th>Active/In-Active</th>
		                      <th>Coaching Description</th>
		                    </tr>
		                  </thead>
		                  <tbody>
		                    <c:forEach items="${coacheeGoalsList }" var="coachingGoal" varStatus="coachingGoalLoop">
		                      <c:if test="${coachingGoal.coachingGoalActive eq 1 }">
		                        <tr class="bg-table-row-${coachingGoalsLoop.index %2 }">
		                          <td>${coachingGoal.actionForCoachingGoal }</td>
		                          <td>
		                            <span class="badge bg-${coachingGoal.mCompetencyId.MCompetencyId}">${coachingGoal.mCompetencyId.competencyName }</span>
		                          </td>
		                          <td>${coachingGoal.coachingGoal }</td>
		                          <td>
		                            <c:choose>
		                              <c:when test="${coachingGoal.coachingGoalActive eq 1 }">
		                                <span class="badge sequence-bg-5">Active</span>
		                              </c:when>
		                              <c:otherwise>
		                                <span class="badge sequence-bg-1">In-Active</span>
		                              </c:otherwise>
		                            </c:choose>
		                          </td>
		                          <td style="white-space: pre-line">${coachingGoal.coachingGoalDescription }</td>
		                        </tr>
		                      </c:if>
		                    </c:forEach>
		                  </tbody>
		                  <tfoot>
		                    <tr class="bg-table-foot">
		                      <th>Action</th>
		                      <th>Coaching Theme</th>
		                      <th>Coaching Goal</th>
		                      <th>Active/In-Active</th>
		                      <th>Coaching Description</th>
		                    </tr>
		                  </tfoot>
		                </table>
		              </div>
		              <div class="col-md-12">
		                <br><h5 class="sequence-font-1 font-weight-bold">In-Active Goals</h5>
		              </div>
		              <div class="col-md-12">
		                <table class="table table-bordered dataTable anand-table-font-size" id="coachingGoalTableInActive">
		                  <thead>
		                    <tr class="bg-table-head">
		                      <th>Action</th>
		                      <th>Coaching Theme</th>
		                      <th>Coaching Goal</th>
		                      <th>Active/In-Active</th>
		                      <th>Coaching Description</th>
		                    </tr>
		                  </thead>
		                  <tbody>
		                    <c:forEach items="${coacheeGoalsList }" var="coachingGoal" varStatus="coachingGoalLoop">
		                      <c:if test="${coachingGoal.coachingGoalActive eq 0 }">
		                        <tr class="bg-table-row-${coachingGoalsLoop.index %2 }">
		                          <td>${coachingGoal.actionForCoachingGoal }</td>
		                          <td>
		                            <span class="badge bg-${coachingGoal.mCompetencyId.MCompetencyId}">${coachingGoal.mCompetencyId.competencyName }</span>
		                          </td>
		                          <td>${coachingGoal.coachingGoal }</td>
		                          <td>
		                            <c:choose>
		                              <c:when test="${coachingGoal.coachingGoalActive eq 1 }">
		                                <span class="badge sequence-bg-5">Active</span>
		                              </c:when>
		                              <c:otherwise>
		                                <span class="badge sequence-bg-1">In-Active</span>
		                              </c:otherwise>
		                            </c:choose>
		                          </td>
		                          <td style="white-space: pre-line">${coachingGoal.coachingGoalDescription }</td>
		                        </tr>
		                      </c:if>
		                    </c:forEach>
		                  </tbody>
		                  <tfoot>
		                    <tr class="bg-table-foot">
		                      <th>Action</th>
		                      <th>Coaching Theme</th>
		                      <th>Coaching Goal</th>
		                      <th>Active/In-Active</th>
		                      <th>Coaching Description</th>
		                    </tr>
		                  </tfoot>
		                </table>
		              </div>
		            </div>
		          </div>
				  <c:choose>
					<c:when test="${reportSubmittedCount > 0}">
					  <div class="card-footer">
						<form:form method="post" action="coaching-goals" modelAttribute="actCoacheeGoals" id="coachingGoals">
						  <form:hidden path="actCoacheeGoalsId" id="actCoacheeGoalsId" />
						  <form:hidden path="actCoachCoacheeMapId" id="actCoachCoacheeMapId" value="${coachCoacheeMapInfo.actCoachCoacheeMapId}" />
						  <input type="hidden" name="batch-id" id="batch-id" value="${coachCoacheeMapInfo.coachCoacheeMappingSet.actCoachingBatchId}" />
						  <input type="hidden" name="coacheeIdForPage" id="coacheeIdForPage" value="${coacheeIdForPage}" />
				  
						  <div class="row">
						    <div class="col-md-2">
							  <div class="form-group">
								<label for="tempCompetencyId"><span class="mandatory">*</span>Coaching Theme</label>
								<form:select class="form-control select2" type="text" id="tempCompetencyId" path="tempCompetencyId" >
								  <form:option value="-1">Select Competency</form:option>
								  <c:forEach items="${competencyList }" var="competency" varStatus="competencyLoop">
								    <form:option value="${competency.MCompetencyId }">${competency.competencyName }</form:option>
								  </c:forEach>
								</form:select>
								<span class="error invalid-feedback" id="tempCompetencyIdError"></span>
							  </div>
							</div>
							<div class="col-md-3">
							  <div class="form-group">
								<label for="batchName"><span class="mandatory">*</span>Coaching Goal</label>
								<form:input class="form-control" type="text" id="coachingGoal" path="coachingGoal" placeholder="Enter Coaching Goal" />
								<span class="error invalid-feedback" id="coachingGoalError"></span>
							  </div>
							</div>
							<div class="col-md-3">
							  <div class="form-group">
								<label for="coachingGoalDescription"><span class="mandatory">*</span>Goal Description</label>
								<form:textarea class="form-control" id="coachingGoalDescription" path="coachingGoalDescription" placeholder="Enter Coaching Goal Description" />
								<span class="error invalid-feedback" id="coachingGoalDescriptionError"></span>
							  </div>
							</div>
							<div class="col-md-2">
							  <div class="form-check" id="isActiveDiv">
								<label><span class="mandatory">*</span>Goal Active/InActive</label>
								<div class="custom-control custom-radio">
								  <form:radiobutton path="coachingGoalActive" class="custom-control-input" value="1" id="coachingGoalActive1" name="coachingGoalActive" />
								  <label for="coachingGoalActive1" class="custom-control-label text-green">Active</label>
								</div>
								<div class="custom-control custom-radio">
								  <form:radiobutton path="coachingGoalActive" class="custom-control-input" value="0" id="coachingGoalActive2" name="coachingGoalActive" />
								  <label for="coachingGoalActive2" class="custom-control-label text-red">Inactive</label>
								</div>
								<span class="error invalid-feedback" id="isActiveError" style="display:block"></span>
							  </div>
							</div>
							<!-- <div class="col-md-10"></div> -->
							<div class="col-md-2">
							  <br>
							  <button title="Add Goal" type="submit" id="submitCoachingGoalButton" class="btn bg-2 float-right">Submit</button>
							</div>
						  </div>
						</form:form>
					  </div>
					</c:when>
					<c:otherwise>
					  <div class="card-footer">
						<div class="sequence-bg-1  text-center">
						  You must submit at least one report before adding goals.
						</div>
					  </div>
					</c:otherwise>
				  </c:choose>
				  
		        </div>
		      </div>
		    </div>
		  </div>
		</section>
      </div>
      <%@include file="../includeJSP/footer.jsp"%>
    </div>
    <%@include file="../../includeJSP/jsFiles.jsp"%>
    <%@include file="../../includeJSP/dataTablesImport.jsp"%>
    <%@include file="../../includeJSP/datePickerJs.jsp"%>
    <script src="usedStaticFiles/essentials/js/jsp_js_files/aldp/coachingBatchDetails/coaching-goals.js"></script>
  </body>
</html>
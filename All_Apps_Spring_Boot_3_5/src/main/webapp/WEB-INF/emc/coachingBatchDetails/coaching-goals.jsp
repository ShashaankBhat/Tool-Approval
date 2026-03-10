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
    <title>MENTORING GOALS | EMC<%@include file="../../includeJSP/company_name_title.jsp"%></title>
    <%@include file="../../includeJSP/cssFiles.jsp"%>
    <%@include file="../../includeJSP/datePickerCss.jsp"%>
  </head>
  <body class="sidebar-mini layout-navbar-fixed sidebar-collapse pace-primary">
    <div class="wrapper">
      <%@include file="../../includeJSP/header.jsp"%>
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
                <h5 class="font-1 font-weight-bold">Mentoring Goals - ${coachCoacheeMapInfo.coacheeUserId.userFirstName } ${coachCoacheeMapInfo.coacheeUserId.userLastName } - ${coachCoacheeMapInfo.coachCoacheeMappingSet.batchName } </h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right font-weight-bold">
                  <li class="breadcrumb-item"><a href="dashboard-emc" title="Dashboard">Dashboard</a></li>
                  <li class="breadcrumb-item"><a href="emc-coaching-batch-details?batch-id=${coachCoacheeMapInfo.coachCoacheeMappingSet.actCoachingBatchId }" title="Coaching Batch Details">Mentoring Batch</a></li>
                  <c:if test="${emcMentor eq 1 || emcAdmin eq 1 || itAdmin eq 1 }">
                    <li class="breadcrumb-item"><a href="emc-coachee-list?batch-id=${coachCoacheeMapInfo.coachCoacheeMappingSet.actCoachingBatchId }" title="Coachee List">Mentee List</a></li>
                  </c:if>
                  <li class="breadcrumb-item active">Mentee List</li>
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
		          <div class="card-header">
		            <div class="row mb-2 font-color-anand-two font-weight-bold">
		              <div class="col-sm-4">
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
		                  <li class="breadcrumb-item"><a title="Add/Edit Mentoring Report" class="breadcrumb-item font-weight-bold font-color-anand-warning" href="emc-coaching-report?batch-id=${coachCoacheeMapDetails.coachCoacheeMappingSet.actCoachingBatchId }&coachee-id=${coachCoacheeMapDetails.coacheeUserId.mUserId }">Add/Edit Report</a></li>
		                </ol>
		              </div>
		              <div class="col-sm-4">
		                <ol class="breadcrumb">
		                  <li class="breadcrumb-item">Mentee: ${coachCoacheeMapDetails.coacheeUserId.userFirstName } ${coachCoacheeMapDetails.coacheeUserId.userLastName }</li>
		                </ol>
		              </div>
		              <div class="col-sm-4">
		                <ol class="breadcrumb">
		                  <li class="breadcrumb-item">Mentor: ${coachCoacheeMapDetails.coachUserId.userFirstName } ${coachCoacheeMapDetails.coachUserId.userLastName } </li>
		                </ol>
		              </div>
		              <div class="col-sm-4">
		                <ol class="breadcrumb">
		                  <li class="breadcrumb-item">Supervisor: ${coachCoacheeMapDetails.supervisorUserId.userFirstName } ${coachCoacheeMapDetails.supervisorUserId.userLastName } </li>
		                </ol>
		              </div>
		            </div>
		          </div>
		          <div class="card-body">
		            <div class="row">
		              <div class="col-md-12">
		                <h5 class="font-color-anand-three font-weight-bold">Active Goals</h5>
		              </div>
		              <div class="col-md-12">
		                <table class="table table-bordered dataTable anand-table-font-size" id="coachingGoalTableActive">
		                  <thead>
		                    <tr class="bg-table-head">
		                      <th>Action</th>
		                      <th>Mentoring Goal</th>
		                      <th>Active/In-Active</th>
		                      <th>Mentoring Description</th>
		                      <th>Mentee</th>
		                      <th>Mentor</th>
		                      <th>Supervisor</th>
		                    </tr>
		                  </thead>
		                  <tbody>
		                    <c:forEach items="${coacheeGoalsList }" var="coachingGoal" varStatus="coachingGoalLoop">
		                      <c:if test="${coachingGoal.coachingGoalActive eq 1 }">
		                        <tr class="bg-table-row-${coachingGoalsLoop.index %2 }">
		                          <td>${coachingGoal.actionForCoachingGoal }
									

									<c:if test="${not empty documents}">
                                     <a title="View Documents" href="javascript:void(0);"
                              onclick="openDownloadModal('${coachingGoal.coacheeGoalsSet.coachCoacheeMappingSet.actCoachingBatchId}', '${coachingGoal.coacheeGoalsSet.coacheeUserId.mUserId}')">
                             <i class="fas fa-file-archive"></i>
                                  </a>
                                 </c:if>


								  </td>
		                          <td>${coachingGoal.coachingGoal }</td>
		                          <td>
		                            <c:choose>
		                              <c:when test="${coachingGoal.coachingGoalActive eq 1 }">
		                                <span class="badge bg-info-anand-success">Active</span>
		                              </c:when>
		                              <c:otherwise>
		                                <span class="badge bg-info-anand-danger">In-Active</span>
		                              </c:otherwise>
		                            </c:choose>
		                          </td>
		                          <td style="white-space: pre-line">${coachingGoal.coachingGoalDescription }</td>
		                          <td>${coachingGoal.coacheeGoalsSet.coacheeUserId.userFirstName } ${coachingGoal.coacheeGoalsSet.coacheeUserId.userLastName }</td>
		                          <td>${coachingGoal.coacheeGoalsSet.coachUserId.userFirstName } ${coachingGoal.coacheeGoalsSet.coachUserId.userLastName }</td>
		                          <td>${coachingGoal.coacheeGoalsSet.supervisorUserId.userFirstName } ${coachingGoal.coacheeGoalsSet.supervisorUserId.userLastName }</td>
		                        </tr>
		                      </c:if>
		                    </c:forEach>
		                  </tbody>
		                  <tfoot>
		                    <tr class="bg-table-foot">
		                      <th>Action</th>
		                      <th>Mentoring Goal</th>
		                      <th>Active/In-Active</th>
		                      <th>Mentoring Description</th>
		                      <th>Mentee</th>
		                      <th>Mentor</th>
		                      <th>Supervisor</th>
		                    </tr>
		                  </tfoot>
		                </table>
		              </div>

					

					  <!-- <div id="question-section" class="mt-4">
						<h5 class="font-color-anand-three font-weight-bold">Questions</h5>
						<div id="question-container"></div>
					</div> -->
					
					<!-- Submit button will be added dynamically after all questions are loaded -->
					<button id="submit-btn" class="btn btn-primary mt-3" style="display: none;">Submit</button>

		              <div class="col-md-12">
		                <br><h5 class="font-color-anand-fourteen font-weight-bold">In-Active Goals</h5>
		              </div>
		              <div class="col-md-12">
		                <table class="table table-bordered dataTable anand-table-font-size" id="coachingGoalTableInActive">
		                  <thead>
		                    <tr class="bg-table-head">
		                      <th>Action</th>
		                      <th>Mentoring Goal</th>
		                      <th>Active/In-Active</th>
		                      <th>Mentoring Description</th>
		                      <th>Mentee</th>
		                      <th>Mentor</th>
		                      <th>Supervisor</th>
		                    </tr>
		                  </thead>
		                  <tbody>
		                    <c:forEach items="${coacheeGoalsList }" var="coachingGoal" varStatus="coachingGoalLoop">
		                      <c:if test="${coachingGoal.coachingGoalActive eq 0 }">
		                        <tr class="bg-table-row-${coachingGoalsLoop.index %2 }">
		                          <td>${coachingGoal.actionForCoachingGoal }</td>
		                          <td>${coachingGoal.coachingGoal }</td>
		                          <td>
		                            <c:choose>
		                              <c:when test="${coachingGoal.coachingGoalActive eq 1 }">
		                                <span class="badge bg-info-anand-success">Active</span>
		                              </c:when>
		                              <c:otherwise>
		                                <span class="badge bg-info-anand-danger">In-Active</span>
		                              </c:otherwise>
		                            </c:choose>
		                          </td>
		                          <td style="white-space: pre-line">${coachingGoal.coachingGoalDescription }</td>
		                          <td>${coachingGoal.coacheeGoalsSet.coacheeUserId.userFirstName } ${coachingGoal.coacheeGoalsSet.coacheeUserId.userLastName }</td>
		                          <td>${coachingGoal.coacheeGoalsSet.coachUserId.userFirstName } ${coachingGoal.coacheeGoalsSet.coachUserId.userLastName }</td>
		                          <td>${coachingGoal.coacheeGoalsSet.supervisorUserId.userFirstName } ${coachingGoal.coacheeGoalsSet.supervisorUserId.userLastName }</td>
		                        </tr>
		                      </c:if>
		                    </c:forEach>
		                  </tbody>
		                  <tfoot>
		                    <tr class="bg-table-foot">
		                      <th>Action</th>
		                      <th>Mentoring Goal</th>
		                      <th>Active/In-Active</th>
		                      <th>Mentoring Description</th>
		                      <th>Mentee</th>
		                      <th>Mentor</th>
		                      <th>Supervisor</th>
		                    </tr>
		                  </tfoot>
		                </table>
		              </div>
		            </div>
		          </div>
		          <div class="card-footer">
		            <form:form method="post" action="emc-coaching-goals" modelAttribute="actCoacheeGoals" id="coachingGoals">
		            <form:hidden path="actCoacheeGoalsId" id="actCoacheeGoalsId" />
		            <form:hidden path="actCoachCoacheeMapId" id="actCoachCoacheeMapId" value="${coachCoacheeMapInfo.actCoachCoacheeMapId }" />
		            <input type="hidden" name="batch-id" id="batch-id" value="${coachCoacheeMapInfo.coachCoacheeMappingSet.actCoachingBatchId }" />
		            <input type="hidden" name="coacheeIdForPage" id="coacheeIdForPage" value="${coacheeIdForPage }" />
		            <div class="row">
		              <div class="col-md-4">
		                <div class="form-group">
		                  <label for="batchName"><span class="mandatory">*</span>Mentoring Goal</label>
		                  <form:input class="form-control" type="text" id="coachingGoal" path="coachingGoal" placeholder="Enter Coaching Goal" />
		                  <span class="error invalid-feedback" id="coachingGoalError"></span>
		                </div>
		              </div>
		              <div class="col-md-6">
		                <div class="form-group">
		                  <label for="coachingGoalDescription"><span class="mandatory">*</span>Goal Description</label>
		                  <form:textarea class="form-control" type="text" id="coachingGoalDescription" path="coachingGoalDescription" placeholder="Enter Coaching Goal Description" />
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
		                  <span class="error invalid-feedback" id="isActiveError" style="display:block" ></span> 
		                </div>
		              </div>
		              <div class="col-md-10"></div>
		              <div class="col-md-2">
		                <button title="Add Goal" type="submit" id="submitCoachingGoalButton" class="btn bg-1">Submit</button>
		              </div>
		            </div>
		            </form:form>
		          </div>
		        </div>
		      </div>
		    </div>
		  </div>

		  <div class="modal fade" id="downloadModal" tabindex="-1" aria-labelledby="downloadModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content shadow">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title" id="downloadModalLabel">Available Documents</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body bg-light">
        <ul class="list-group" id="fileList">
          <!-- File links will be dynamically added here -->
        </ul>
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
	
    <script src="usedStaticFiles/essentials/js/jsp_js_files/emc/coachingBatchDetails/coaching-goals.js"></script>

	





  </body>
</html>
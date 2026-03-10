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
    <title>COACHING REPORT | ACT<%@include file="../../includeJSP/company_name_title.jsp"%></title>
    <%@include file="../../includeJSP/cssFiles.jsp"%>
    <%@include file="../../includeJSP/datePickerCss.jsp"%>
  </head>
  <body class="sidebar-mini layout-navbar-fixed sidebar-collapse pace-primary">
    <div class="wrapper">
      <%@include file="../includeJSP/header.jsp"%>
      <%@include file="../includeJSP/leftSideBar.jsp"%>
      <div class="content-wrapper">
        <c:set var="goalIndex" value="0" />
        <c:forEach items="${coacheeGoalsList }" var="coachingGoal" varStatus="coachingGoalLoop">
          <c:if test="${coachingGoal.coachingGoalActive eq 1 }">
            <input type="hidden" id="goalName${goalIndex }" value="${coachingGoal.coachingGoal }" />
            <input type="hidden" id="goalId${goalIndex }" value="${coachingGoal.actCoacheeGoalsId }" />
            <c:set var="goalIndex" value="${goalIndex + 1 }" />
          </c:if>
        </c:forEach>
        <!-- <br> -->
        <input type="hidden" id="jsGoalIndex" value="${goalIndex }" />
        <input type="hidden" id="jsBatchName" value="${coachCoacheeMapDetails.coachCoacheeMappingSet.batchName }" />
        <input type="hidden" id="jsCoacheeName" value="${coachCoacheeMapDetails.coacheeUserId.userFirstName } ${coachCoacheeMapDetails.coacheeUserId.userLastName }" />
        <input type="hidden" id="jsCoachName" value="${coachCoacheeMapDetails.coachUserId.userFirstName } ${coachCoacheeMapDetails.coachUserId.userLastName }" />
        <input type="hidden" id="jsSupervisorName" value="${coachCoacheeMapDetails.supervisorUserId.userFirstName } ${coachCoacheeMapDetails.supervisorUserId.userLastName }" />
        <section class="content-header">
          <div class="container-fluid">
            <div class="row mb-2">
              <div class="col-sm-6">
                <h5 class="font-1 font-weight-bold">Coaching Report - ${coachCoacheeMapDetails.coacheeUserId.userFirstName } ${coachCoacheeMapDetails.coacheeUserId.userLastName } - ${coachCoacheeMapDetails.coachCoacheeMappingSet.batchName } </h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right font-weight-bold">
                  <li class="breadcrumb-item"><a href="dashboard-act" title="Dashboard">Dashboard</a></li>
                  <c:if test="${ctCoach eq 1 || ctAdmin eq 1 || itAdmin eq 1 }">
                    <li class="breadcrumb-item"><a href="coaching-batch-details" title="Coaching Batch Details">Coaching Batch</a></li>
                    <li class="breadcrumb-item"><a href="coachee-list?batch-id=${coachCoacheeMapDetails.coachCoacheeMappingSet.actCoachingBatchId }" title="Coachee List">Coachee List</a></li>
                  </c:if>
                  <li class="breadcrumb-item active">Coaching Report</li>
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
		        <div class="card card-primary">
		          <div class="card-header bg-3">
		            <div class="row font-weight-bold">
		              <div class="col-md-4">
		                <h5 class="font-weight-bold">Batch: ${coachCoacheeMapDetails.coachCoacheeMappingSet.batchName } </h5>
		              </div>
		              <div class="col-md-6">
		                <h5 class="font-weight-bold">Description: ${coachCoacheeMapDetails.coachCoacheeMappingSet.batchDescription } </h5>
		              </div>
		              <div class="col-md-2">
		                <a title="Add/Edit Coaching Goals" class="breadcrumb-item font-weight-bold sequence-bg-2" href="coaching-goals?batch-id=${coachCoacheeMapDetails.coachCoacheeMappingSet.actCoachingBatchId }&coachee-id=${coachCoacheeMapDetails.coacheeUserId.mUserId }">Add/Edit Goals</a>
		              </div>
		              <div class="col-md-4">
		                <h5 class="font-weight-bold">Coachee: ${coachCoacheeMapDetails.coacheeUserId.userFirstName } ${coachCoacheeMapDetails.coacheeUserId.userLastName } </h5>
		              </div>
		              <div class="col-md-4">
		                <h5 class="font-weight-bold">Coach: ${coachCoacheeMapDetails.coachUserId.userFirstName } ${coachCoacheeMapDetails.coachUserId.userLastName } </h5>
		              </div>
		              <div class="col-md-4">
		                <h5 class="font-weight-bold">Supervisor: ${coachCoacheeMapDetails.supervisorUserId.userFirstName } ${coachCoacheeMapDetails.supervisorUserId.userLastName } </h5>
		              </div>
		            </div>
		          </div>
		          <c:set var="coachCoacheeAdminFlag" value="0" />
		          <!-- 1 -> Coach
		          2 -> Coachee
		          3 -> Admin -->
		          <c:if test="${ctAdmin eq 1 || itAdmin eq 1 }">
		            <c:set var="coachCoacheeAdminFlag" value="3" />
		          </c:if>
		          <c:if test="${coachCoacheeMapDetails.coacheeUserId.mUserId eq sessionUserInfo.mUserId }">
		            <c:set var="coachCoacheeAdminFlag" value="2" />
		          </c:if>
		          <c:if test="${coachCoacheeMapDetails.coachUserId.mUserId eq sessionUserInfo.mUserId }">
		            <c:set var="coachCoacheeAdminFlag" value="1" />
		          </c:if>
		          <input id="coachCoacheeAdminFlag" type="hidden" value="${coachCoacheeAdminFlag }" />
		          <div class="card-body">
		            <div class="row">
		              <div class="col-md-12">
		                <table class="table table-bordered dataTable anand-table-font-size" id="coachingGoalTableActive">
		                  <thead>
		                    <tr class="bg-table-head">
		                      <th>Action</th>
		                      <th>Session Date</th>
		                      <th>Report Status</th>
		                      <th>Meeting Conducted</th>
		                      <th>Coachee Reason for Not Conducting</th>
		                      <th>Topics Discussed &amp; Input Given</th>
		                    </tr>
		                  </thead>
		                  <tbody>
		                    <c:set var="coachingSessionTillNowWithAllDraftAndSubmitted" value="0" />
		                    <c:forEach items="${coacheeReportList }" var="coachingReport" varStatus="coachingReportLoop">
		                      <c:set var="showReportInfoFlag" value="1" />
		                      <c:if test="${ctCoach eq 1 && coachingReport.reportStatus eq 2 && coachingReport.coacheeReportSet.coacheeUserId.mUserId ne sessionUserInfo.mUserId }">
		                        <c:set var="showReportInfoFlag" value="0" />
		                      </c:if>
		                      <c:if test="${coachingReport.reportActive eq 1 && showReportInfoFlag eq 1}">
		                        <tr class="bg-table-row-${coachingReportLoop.index %2 }">
									
		                          <td>${coachingReport.actionForCoachingReport }</td>
		                          <td>
		                            <fmt:formatDate pattern = "dd-MMM-yyyy" value = "${coachingReport.sessionDate }" />
		                            <fmt:formatDate var="currentObject" pattern="dd/MM/yyyy" value="${coachingReport.sessionDate }" />
		                            <input type="hidden" value="${currentObject }" id="coachingDates${coachingSessionTillNowWithAllDraftAndSubmitted }" />
		                            <c:set var="coachingSessionTillNowWithAllDraftAndSubmitted" value="${coachingSessionTillNowWithAllDraftAndSubmitted + 1 }" />
		                          </td>
		                          <td>
		                            <c:choose>
		                              <c:when test="${coachingReport.reportStatus eq 2 }">
		                                <span class="badge sequence-bg-1">Draft</span>
		                              </c:when>
									  <c:when test="${coachingReport.reportStatus eq 1 }">
		                                <span class="badge sequence-bg-4">Submitted</span>
		                              </c:when>
		                              <c:when test="${coachingReport.reportStatus eq 3 }">
		                                <span class="badge sequence-bg-2">Draft at Coach</span>
		                              </c:when>
									  <c:when test="${coachingReport.reportStatus eq -1 }">
		                                <span class="badge sequence-bg-3">Sent Back To Coachee</span>
		                              </c:when>
		                              <c:when test="${coachingReport.reportStatus eq 4 }">
		                                <span class="badge sequence-bg-5">Complete</span>
		                              </c:when>
		                            </c:choose>
		                          </td>
		                          <td>
		                            <c:choose>
		                              <c:when test="${coachingReport.meetingConductedStatus eq 1 }">
		                                <span class="badge sequence-bg-5">Conducted</span>
		                              </c:when>
		                              <c:when test="${coachingReport.meetingConductedStatus eq 2 }">
		                                <span class="badge sequence-bg-1">Not-Conducted</span>
		                              </c:when>
		                            </c:choose>
		                          </td>
		                          <td style="white-space: pre-line">${coachingReport.reasonForNotConducting }</td>
		                          <td style="white-space: pre-line">${coachingReport.discussionAndInputsFromCoach }</td>
		                        </tr>
		                      </c:if>
		                    </c:forEach>
		                    <input type="hidden" value="${coachingSessionTillNowWithAllDraftAndSubmitted }" id="coachingSessionTillNowWithAllDraftAndSubmitted" />
		                  </tbody>
		                  <tfoot>
		                    <tr class="bg-table-foot">
		                      <th>Action</th>
		                      <th>Session Date</th>
		                      <th>Report Status</th>
		                      <th>Meeting Conducted</th>
		                      <th>Coachee Reason for Not Conducting</th>
		                      <th>Topics Discussed &amp; Input Given</th>
		                    </tr>
		                  </tfoot>
		                </table>
		              </div>
		            </div>
		          </div>

		          <c:set var="coacheeActionIndex" value="0" />
		          <div class="card-footer coacheeReportFooter">
		            <form:form method="post" action="coaching-report" modelAttribute="actCoachCoacheeMap" id="actCoacheeReport">
		            <form:hidden path="coacheeReportTemp.actCoacheeReportId" id="actCoacheeReportId" />
		            <form:hidden path="coacheeReportTemp.actCoachCoacheeMapId" id="actCoachCoacheeMapId" value="${coachCoacheeMapDetails.actCoachCoacheeMapId }" />
		            <input type="hidden" name="batch-id" id="batch-id" value="${coachCoacheeMapDetails.coachCoacheeMappingSet.actCoachingBatchId }" />
		            <input type="hidden" name="coacheeIdForPage" id="coacheeIdForPage" value="${coacheeIdForPage }" />
		            <div class="row">
		              <div class="col-md-12">
		                <c:if test="${coachCoacheeAdminFlag eq 3 }">
		                  <h5 class="font-1 font-weight-bold">Coachee Report - Coachee Submission</h5>
		                </c:if>
		                <c:if test="${coachCoacheeAdminFlag eq 1 }">
		                  <h5 class="font-1 font-weight-bold">Coaching Report</h5>
		                </c:if>
		              </div>
		              <div class="col-md-2 sessionDateString">
		                <div class="form-group">
		                  <label><span class="mandatory">*</span>Session Date</label>
		                  <div class="input-group">
		                    <div class="input-group-prepend">
		                      <span class="input-group-text">
		                        <i class="far fa-calendar-alt"></i>
		                      </span>
		                    </div>
		                    <form:input id="sessionDateString" path="coacheeReportTemp.sessionDateString" type="text" class="form-control float-right" placeholder="Session Date" />
		                    <span class="error invalid-feedback" id="sessionDateStringError"></span>
		                  </div>
		                </div>
		              </div>
		              <div class="col-md-2 meetingConductedStatus">
		                <div class="form-group">
		                  <label for="meetingConductedStatus"><span class="mandatory">*</span>Meeting Conducted</label>
		                  <form:select class="form-control" id="meetingConductedStatus" path="coacheeReportTemp.meetingConductedStatus"> 
		                    <form:option value="-1">Select Status</form:option>
		                    <form:option value="1">Conducted</form:option>
		                    <form:option value="2">Not Conducted</form:option>
		                  </form:select>
		                  <span class="error invalid-feedback" id="meetingConductedStatusError"></span>
		                </div>
		              </div>
		              <div class="col-md-8 not-conducted reasonForNotConducting">
		                <div class="form-group">
		                  <label for="batchName"><span class="mandatory">*</span>Reason for Not Conducting</label>
		                  <form:textarea class="form-control" type="text" id="reasonForNotConducting" path="coacheeReportTemp.reasonForNotConducting" placeholder="Enter the reason for not conductiong the session" />
		                  <span class="error invalid-feedback" id="reasonForNotConductingError"></span>
		                </div>
		              </div>
		              <div class="col-md-12 conducted">
		                <div class="row">
		                  <div class="col-md-12">
		                    <div class="card card-primary">
		                      <div class="card-header bg-3">
		                        <div class="col-md-4">
		                          <h5 class="font-weight-bold">Coachee Goals </h5>
		                        </div>
		                      </div>
		                      <div class="card-body">
		                        <table class="table table-bordered dataTable anand-table-font-size" id="">
		                          <thead class="bg-table-head">
		                            <tr>
		                              <th>Coaching Competency</th>
		                              <th>Goal</th>
		                              <th>Goal Description</th>
		                            </tr>
		                          </thead>
		                          <tbody>
		                            <c:forEach items="${coacheeGoalsList }" var="coachingGoal" varStatus="coachingGoalLoop">
		                              <c:if test="${coachingGoal.coachingGoalActive eq 1 }">
		                                <tr>
		                                  <td><span class="badge bg-${coachingGoal.mCompetencyId.MCompetencyId }">${coachingGoal.mCompetencyId.competencyName }</span></td>
		                                  <td>${coachingGoal.coachingGoal }</td>
		                                  <td>${coachingGoal.coachingGoalDescription }</td>
		                                </tr>
		                              </c:if>
		                            </c:forEach>
		                          </tbody>
		                        </table>
		                      </div>
		                    </div>
		                  </div>
		                </div>
		              </div>
		              <div class="col-md-12 conducted goalActionDiv">
		                <div class="row ">
		                  <div class="col-md-12">
		                    <div class="card card-primary">
		                      <div class="card-header bg-2">
		                        <h5 class="text-white font-weight-bold">What did coachee agree to do before the next meeting (Action Items)</h5>
		                      </div>
		                      <div class="card-body goalActionBody">
		                      <c:if test="${empty coacheeGoalActionList }">
		                        <div class="row goalAction${coacheeActionIndex }">
		                          <div class="col-md-1">
		                            <div class="form-group">
		                              <a href="#" onclick="removeGoalAction(${coacheeActionIndex });"><i class="fas fa-times"></i></a><h1>
		                              <form:hidden id="actCoacheeReportActionId${coacheeActionIndex }" class="form-control" value="" path="coacheeReportTemp.coacheeReportActionTempList[${coacheeActionIndex }].actCoacheeReportActionId" />
		                              <form:hidden id="actionGoalActive${coacheeActionIndex }" class="form-control" value="1" path="coacheeReportTemp.coacheeReportActionTempList[${coacheeActionIndex }].reportActionActive" />
		                            </div>
		                          </div>
		                          <div class="col-md-4">
		                            <div class="form-group">
		                              <label for="actionGoal${coacheeActionIndex }"><span class="mandatory">*</span>Select Goal</label>
		                              <form:select id="actionGoal${coacheeActionIndex }" class="form-control" path="coacheeReportTemp.coacheeReportActionTempList[${coacheeActionIndex }].actCoacheeGoalId.actCoacheeGoalsId"> 
		                                <form:option value="-1">Select Goal</form:option>
		                                <c:forEach items="${coacheeGoalsList }" var="coachingGoal" varStatus="coachingGoalLoop">
		                                  <c:if test="${coachingGoal.coachingGoalActive eq 1 }">
		                                    <form:option value="${coachingGoal.actCoacheeGoalsId }">${coachingGoal.coachingGoal }</form:option>
		                                  </c:if>
		                                </c:forEach>
		                              </form:select>
		                              <span class="error invalid-feedback" id="actionGoal${coacheeActionIndex }Error"></span>
		                            </div>
		                          </div>
		                          <div class="col-md-7">
		                            <div class="form-group">
		                              <label for="goalAction${coacheeActionIndex }"><span class="mandatory">*</span>Goal Action</label>
		                              <form:textarea rows="3" class="form-control" type="text" id="goalAction${coacheeActionIndex }" path="coacheeReportTemp.coacheeReportActionTempList[${coacheeActionIndex }].goalAction" placeholder="Enter Goal Action" />
		                              <span class="error invalid-feedback" id="goalAction${coacheeActionIndex }Error"></span>
		                            </div>
		                          </div>
		                        </div>
		                        <c:set var="coacheeActionIndex" value="${coacheeActionIndex + 1 }" />
		                      </c:if>
		                      <c:if test="${not empty coacheeGoalActionList }">
		                        <c:set var="bg_color" value="1" />
		                        <c:forEach items="${coacheeGoalActionList }" var="reportActionNow" varStatus="reportActionNowStatus">
		                          <div class="row goalAction${coacheeActionIndex }">
		                            <%-- <c:if test="${reportActionNow.reportActionStatus eq 0 || reportActionNow.reportActionStatus eq 1 }"> --%>
		                              <div class="col-md-12">
		                                <div class="card card-primary">
		                                  <div class="card-header bg-${bg_color }">
		                                    <div class="row">
		                                      <div class="col-md-6">
		                                        <h5 class="font-weight-bold">
		                                          Related Report Date: <fmt:formatDate pattern = "dd-MMM-yyyy" value = "${reportActionNow.coacheeReportActionList.sessionDate }" />
		                                        </h5>
		                                      </div>
		                                      <div class="col-md-6">
		                                        <h5 class="font-weight-bold">
		                                          <c:forEach items="${coacheeGoalsList }" var="coachingGoal" varStatus="coachingGoalLoop">
		                                            <c:if test="${coachingGoal.coachingGoalActive eq 1 && reportActionNow.actCoacheeGoalId.actCoacheeGoalsId eq coachingGoal.actCoacheeGoalsId }">
		                                              Related Goal: ${coachingGoal.coachingGoal }
		                                            </c:if>
		                                          </c:forEach>
		                                        </h5>
		                                      </div>
		                                    </div>
		                                  </div>
		                                  <c:if test="${bg_color eq 3 }">
		                                    <c:set var="bg_color" value="1" />
		                                  </c:if>
		                                  <c:if test="${bg_color ne 3 }">
		                                    <c:set var="bg_color" value="${bg_color + 1 }" />
		                                  </c:if>
		                                  <div class="card-body">
		                                    <div class="row">
		                                      <form:hidden id="actCoacheeReportActionId${coacheeActionIndex }" class="form-control" value="${reportActionNow.actCoacheeReportActionId }" path="coacheeReportTemp.coacheeReportActionTempList[${coacheeActionIndex }].actCoacheeReportActionId" />
		                                      <form:hidden id="actionGoalActive${coacheeActionIndex }" class="form-control" value="${reportActionNow.reportActionActive }" path="coacheeReportTemp.coacheeReportActionTempList[${coacheeActionIndex }].reportActionActive" />
		                                      <div class="col-md-3">
		                                        <div class="form-group">
		                                          <label for="actionGoal${coacheeActionIndex }">Goal</label>
		                                          <c:forEach items="${coacheeGoalsList }" var="coachingGoal" varStatus="coachingGoalLoop">
		                                            <c:if test="${coachingGoal.coachingGoalActive eq 1 && reportActionNow.actCoacheeGoalId.actCoacheeGoalsId eq coachingGoal.actCoacheeGoalsId }">
		                                              <br>${coachingGoal.coachingGoal }
		                                            </c:if>
		                                          </c:forEach>
		                                        </div>
		                                      </div>
		                                      <div class="col-md-3">
		                                        <div class="form-group">
		                                          <label for="goalAction${coacheeActionIndex }">Goal Action</label>
		                                          <p style="white-space: pre-line">${reportActionNow.goalAction }</p>
		                                        </div>
		                                      </div>
		                                      <div class="col-md-3">
		                                        <div class="form-group">
		                                          <input type="hidden" value="${reportActionNow.coacheeComment }" id="tempCoacheeComment${coacheeActionIndex }" />
		                                          <label for="coacheeComment${coacheeActionIndex }">Coachee Comments</label>
 		                                          <form:textarea rows="3" class="form-control" type="text" id="coacheeComment${coacheeActionIndex }" path="coacheeReportTemp.coacheeReportActionTempList[${coacheeActionIndex }].coacheeComment" placeholder="Enter Coachee Comments" />
		                                          <span class="error invalid-feedback" id="coacheeComment${coacheeActionIndex }Error"></span>
		                                        </div>
		                                      </div>
		                                      <div class="col-md-2">
		                                        <div class="form-check" id="isActiveDiv">
		                                          <input type="hidden" id="reportActionStatusTemp${coacheeActionIndex }" value="${reportActionNow.reportActionStatus }" />
		                                          <label><span class="mandatory">*</span>Action Status</label>
		                                          <div class="custom-control custom-radio">
		                                            <form:radiobutton path="coacheeReportTemp.coacheeReportActionTempList[${coacheeActionIndex }].reportActionStatus" class="custom-control-input" value="0" id="reportActionStatus1${coacheeActionIndex }" name="coacheeReportTemp.coacheeReportActionTempList[${coacheeActionIndex }].reportActionStatus" />
		                                            <label for="reportActionStatus1${coacheeActionIndex }" class="custom-control-label text-red">Yet to start</label>
		                                          </div>
		                                          <div class="custom-control custom-radio">
		                                            <form:radiobutton path="coacheeReportTemp.coacheeReportActionTempList[${coacheeActionIndex }].reportActionStatus" class="custom-control-input" value="1" id="reportActionStatus2${coacheeActionIndex }" name="coacheeReportTemp.coacheeReportActionTempList[${coacheeActionIndex }].reportActionStatus" />
		                                            <label for="reportActionStatus2${coacheeActionIndex }" class="custom-control-label text-warning">In Progress</label>
		                                          </div>
		                                          <div class="custom-control custom-radio">
		                                            <form:radiobutton path="coacheeReportTemp.coacheeReportActionTempList[${coacheeActionIndex }].reportActionStatus" class="custom-control-input" value="2" id="reportActionStatus3${coacheeActionIndex }" name="coacheeReportTemp.coacheeReportActionTempList[${coacheeActionIndex }].reportActionStatus" />
		                                            <label for="reportActionStatus3${coacheeActionIndex }" class="custom-control-label text-green">Completed</label>
		                                          </div>
		                                          <span class="error invalid-feedback" id="isActiveError${coacheeActionIndex }" style="display:block" ></span> 
		                                        </div>
		                                      </div>
		                                    </div>
		                                  </div>
		                                </div>
		                              </div>
		                              <c:set var="coacheeActionIndex" value="${coacheeActionIndex + 1 }" />
		                            <%-- </c:if> --%>
		                          </div>
		                        </c:forEach>
		                      </c:if>
		                      </div>
		                      <div class="card-footer">
		                        <button title="Add More Goal Action Item" style="float: right;" type="button" id="addMoreGoalActionItem" class="btn bg-3">
		                          <i class="fas fa-plus"></i>&emsp;Add Action Item
		                        </button>
		                      </div>
		                    </div>
		                  </div>
		                </div>
		              </div>
		              <div class="col-md-6 conducted coacheeAdditionalComments">
		                <div class="form-group">
		                  <label for="batchName"><span class="mandatory">*</span>Additional Comments by Coachee</label>
		                  <form:textarea rows="3" class="form-control" type="text" id="coacheeAdditionalComments" path="coacheeReportTemp.coacheeAdditionalComments" placeholder="Enter breif of topics discussed and inputs given by coach in the session" />
		                  <span class="error invalid-feedback" id="coacheeAdditionalCommentsError"></span>
		                </div>
		              </div>
		              <div class="col-md-6 conducted discussionAndInputsFromCoach">
		                <div class="form-group">
		                  <label for="discussionAndInputsFromCoach"><span class="mandatory">*</span>Topics discussed and inputs from coach in the current session</label>
		                  <form:textarea rows="3" class="form-control" type="text" id="discussionAndInputsFromCoach" path="coacheeReportTemp.discussionAndInputsFromCoach" placeholder="Enter topics discussed with coach and inputs given by coach" />
		                  <span class="error invalid-feedback" id="discussionAndInputsFromCoachError"></span>
		                </div>
		              </div>
		              <div class="col-md-3 conducted sessionMode">
		                <div class="form-group">
		                  <label for="sessionMode"><span class="mandatory">*</span>Session Mode</label>
		                  <form:select class="form-control" id="sessionMode" path="coacheeReportTemp.sessionMode"> 
		                    <form:option value="-1">Select Mode</form:option>
		                    <form:option value="1">Online</form:option>
		                    <form:option value="2">In-Person</form:option>
		                  </form:select>
		                  <span class="error invalid-feedback" id="sessionModeError"></span>
		                </div>
		              </div>
		              <div class="col-md-4 conducted sessionModeReasonOnline">
		                <div class="form-group">
		                  <label for="sessionModeReasonOnline">Reason for online session?</label>
		                  <form:textarea rows="3" class="form-control" type="text" id="sessionModeReasonOnline" path="coacheeReportTemp.sessionModeReasonOnline" placeholder="Elaborate on why online session was taken." />
		                  <span class="error invalid-feedback" id="sessionModeReasonOnlineError"></span>
		                </div>
		              </div>
		              <div class="col-md-4 reportStatus">
		                <div class="form-check" id="reportStatusDiv">
		                  <label><span class="mandatory">*</span>Report Status</label>
		                  <div class="custom-control custom-radio">
		                    <form:radiobutton path="coacheeReportTemp.reportStatus" class="custom-control-input" value="1" id="reportStatus2" name="coacheeReportTemp.reportStatus" />
		                    <label for="reportStatus2" class="custom-control-label text-blue">Submit Report to Coach</label>
		                  </div>
		                  <div class="custom-control custom-radio">
		                    <form:radiobutton path="coacheeReportTemp.reportStatus" class="custom-control-input" value="2" id="reportStatus1" name="coacheeReportTemp.reportStatus" />
		                    <label for="reportStatus1" class="custom-control-label text-green">Keep in Draft</label>
		                  </div>
						 
		                  <span class="error invalid-feedback" id="reportStatusError" style="display:block" ></span> 
		                </div>
		              </div>
		              <div class="col-md-10"><input type="hidden" value="${coacheeActionIndex }" id="coacheeActionIndex" /></div>
		              <div class="col-md-2">
		                <button title="Save Report" type="submit" id="submitCoachingReportButton" class="btn bg-2 float-right">Submit</button>
		              </div>
		            </div>
		            </form:form>
		          </div>

		          <c:set var="coachActionIndex" value="0" />
		          <c:if test="${coachCoacheeAdminFlag eq 1 || coachCoacheeAdminFlag eq 3 }">
		          <div class="card-footer coachReportFooter">
		            <form:form method="post" action="coaching-report-coach" modelAttribute="actCoachCoacheeMap" id="actCoachReport">
		            <form:hidden path="coacheeReportTemp.actCoacheeReportId" id="actCoacheeReportIdCoach" />
		            <form:hidden path="coacheeReportTemp.actCoachCoacheeMapId" id="actCoachCoacheeMapId" value="${coachCoacheeMapDetails.actCoachCoacheeMapId }" />
		            <input type="hidden" name="batch-id" id="batch-id" value="${coachCoacheeMapDetails.coachCoacheeMappingSet.actCoachingBatchId }" />
		            <input type="hidden" name="coacheeIdForPage" id="coacheeIdForPage" value="${coacheeIdForPage }" />
		            <div class="row">
		              <div class="col-md-12">
		                <c:if test="${ctAdmin eq 1 || itAdmin eq 1 }">
		                  <h5 class="font-1 font-weight-bold">Coachee Report - Coach Submission</h5>
		                </c:if>
		                <c:if test="${ctCoach eq 1 }">
		                  <h5 class="font-1 font-weight-bold">Coaching Report</h5>
		                </c:if>
		              </div>
		              <div class="col-md-2 sessionDateStringShow">
		                <div class="form-group">
		                  <label>Session Date</label>
		                  <p id="sessionDateStringShow"></p>
		                </div>
		              </div>
		              <div class="col-md-2 meetingConductedStatusShow">
		                <div class="form-group">
		                  <label>Meeting Conducted</label>
		                  <p id="meetingConductedStatusShow"></p>
		                  <input type="hidden" id="meetingConductedStatusCoach" value="" />
		                </div>
		              </div>
		              <div class="col-md-4 reasonForNotConductingShow">
		                <div class="form-group">
		                  <label>Coachee Reason</label>
		                  <p style="white-space: pre-line" id="reasonForNotConductingShow"></p>
		                </div>
		              </div>
		              <div class="col-md-4 not-conducted coachReasonForNotConducting">
		                <div class="form-group">
		                  <label for="coachReasonForNotConducting"><span class="mandatory">*</span>Coach Reason</label>
		                  <form:textarea class="form-control" type="text" id="coachReasonForNotConducting" path="coacheeReportTemp.coachReasonForNotConducting" placeholder="Enter the coach reason for not conductiong the session" />
		                  <span class="error invalid-feedback" id="coachReasonForNotConductingError"></span>
		                </div>
		              </div>
		              <div class="col-md-12 conducted">
		                <div class="row">
		                  <div class="col-md-12">
		                    <div class="card card-primary">
		                      <div class="card-header bg-3">
		                        <div class="col-md-4">
		                          <h5 class="font-weight-bold">Coachee Goals </h5>
		                        </div>
		                      </div>
		                      <div class="card-body">
		                        <table class="table table-bordered dataTable anand-table-font-size" id="">
		                          <thead class="bg-table-head">
		                            <tr>
		                              <th>Coaching Competency</th>
		                              <th>Goal</th>
		                              <th>Goal Description</th>
		                            </tr>
		                          </thead>
		                          <tbody>
		                            <c:forEach items="${coacheeGoalsList }" var="coachingGoal" varStatus="coachingGoalLoop">
		                              <c:if test="${coachingGoal.coachingGoalActive eq 1 }">
		                                <tr>
		                                  <td><span class="badge bg-${coachingGoal.mCompetencyId.MCompetencyId }">${coachingGoal.mCompetencyId.competencyName }</span></td>
		                                  <td>${coachingGoal.coachingGoal }</td>
		                                  <td>${coachingGoal.coachingGoalDescription }</td>
		                                </tr>
		                              </c:if>
		                            </c:forEach>
		                          </tbody>
		                        </table>
		                      </div>
		                    </div>
		                  </div>
		                </div>
		              </div>
		              <div class="col-md-12 conducted goalActionDivCoach">
		                <div class="row ">
		                  <div class="col-md-12">
		                    <div class="card card-primary">
		                      <div class="card-header bg-2">
		                        <h5 class="font-3 font-weight-bold">Coach View What did coachee agree to do before the next meeting (Action Items)</h5>
		                      </div>
		                      <div class="card-body goalActionBody">
		                      
		                      <c:if test="${empty coacheeGoalActionList }">
		                        <div class="row goalAction${coachActionIndex }">
		                          <div class="col-md-1">
		                            <div class="form-group">
		                              <a href="#" onclick="removeGoalAction(${coachActionIndex });"><i class="fas fa-times"></i></a>
									  <form:hidden id="actCoacheeReportActionId${coachActionIndex}" 
									  path="coacheeReportTemp.coacheeReportActionTempList[${coachActionIndex}].actCoacheeReportActionId" />
						 
						 <form:hidden id="actionGoalActive${coachActionIndex}" 
									  path="coacheeReportTemp.coacheeReportActionTempList[${coachActionIndex}].reportActionActive" 
									  value="1" />
						   </div>
		                          </div>
		                          <div class="col-md-4">
		                            <div class="form-group">
		                              <label for="actionGoal${coachActionIndex }"><span class="mandatory">*</span>Select Goal</label>
		                              <form:select id="actionGoal${coachActionIndex }" class="form-control" path="coacheeReportTemp.coacheeReportActionTempList[${coachActionIndex }].actCoacheeGoalId.actCoacheeGoalsId"> 
		                                <form:option value="-1">Select Goal</form:option>
		                                <c:forEach items="${coacheeGoalsList }" var="coachingGoal" varStatus="coachingGoalLoop">
		                                  <c:if test="${coachingGoal.coachingGoalActive eq 1 }">
		                                    <form:option value="${coachingGoal.actCoacheeGoalsId }">${coachingGoal.coachingGoal }</form:option>
		                                  </c:if>
		                                </c:forEach>
		                              </form:select>
		                              <span class="error invalid-feedback" id="actionGoal${coachActionIndex }Error"></span>
		                            </div>
		                          </div>
		                          <div class="col-md-7">
		                            <div class="form-group">
		                              <label for="goalAction${coachActionIndex }"><span class="mandatory">*</span>Goal Action</label>
		                              <form:textarea rows="3" class="form-control" type="text" id="goalAction${coachActionIndex }" path="coacheeReportTemp.coacheeReportActionTempList[${coachActionIndex }].goalAction" placeholder="Enter Goal Action" />
		                              <span class="error invalid-feedback" id="goalAction${coachActionIndex }Error"></span>
		                            </div>
		                          </div>
		                        </div>
		                        <c:set var="coachActionIndex" value="${coachActionIndex + 1 }" />
		                      </c:if>
		                      
		                      <c:if test="${not empty coacheeGoalActionList }">
		                        <c:set var="bg_color" value="1" />
		                        <c:forEach items="${coacheeGoalActionList }" var="reportActionNow" varStatus="reportActionNowStatus">
		                        <%-- <c:if test="${reportActionNow.reportActionStatus eq 1 || reportActionNow.reportActionStatus eq 0 }"> --%>
		                          <div class="row goalAction${coachActionIndex }">
		                            <div class="col-md-12">
		                              <div class="card card-primary">
		                                <div class="card-header bg-${bg_color }">
		                                  <div class="row">
		                                    <div class="col-md-6">
		                                      <h5 class="font-weight-bold">
		                                        Related Report Date: <fmt:formatDate pattern = "dd-MMM-yyyy" value = "${reportActionNow.coacheeReportActionList.sessionDate }" />
		                                      </h5>
		                                    </div>
		                                    <div class="col-md-6">
		                                      <h5 class="font-weight-bold">
		                                        <c:forEach items="${coacheeGoalsList }" var="coachingGoal" varStatus="coachingGoalLoop">
		                                          <c:if test="${coachingGoal.coachingGoalActive eq 1 && reportActionNow.actCoacheeGoalId.actCoacheeGoalsId eq coachingGoal.actCoacheeGoalsId }">
		                                            Related Goal: ${coachingGoal.coachingGoal }
		                                          </c:if>
		                                        </c:forEach>
		                                      </h5>
		                                    </div>
		                                  </div>
		                                </div>
		                                <c:if test="${bg_color eq 3 }">
		                                  <c:set var="bg_color" value="1" />
		                                </c:if>
		                                <c:if test="${bg_color ne 3 }">
		                                  <c:set var="bg_color" value="${bg_color + 1 }" />
		                                </c:if>
		                                <div class="card-body">
		                                  <div class="row">
		                                    <form:hidden id="actCoacheeReportActionId${coachActionIndex }" class="form-control" value="${reportActionNow.actCoacheeReportActionId }" path="coacheeReportTemp.coacheeReportActionTempList[${coachActionIndex }].actCoacheeReportActionId" />
		                                    <form:hidden id="actionGoalActive${coachActionIndex }" class="form-control" value="${reportActionNow.reportActionActive }" path="coacheeReportTemp.coacheeReportActionTempList[${coachActionIndex }].reportActionActive" />
		                                    <%-- <div class="col-md-3">
		                                      <div class="form-group">
		                                        <label for="actionGoal${coachActionIndex }">Action</label>
		                                        <p style="white-space: pre-line">${reportActionNow.goalAction }</p>
		                                      </div>
		                                    </div> --%>
		                                    <div class="col-md-3">
		                                      <div class="form-group">
		                                        <input type="hidden" value="${reportActionNow.goalAction }" id="tempGoalAction${coachActionIndex }" />
		                                        <label for="goalAction${coachActionIndex }">Goal Action</label>
		                                        <form:textarea rows="3" class="form-control" type="text" id="goalAction${coachActionIndex }" path="coacheeReportTemp.coacheeReportActionTempList[${coachActionIndex }].goalAction" placeholder="Enter Goal Action" />
		                                        <span class="error invalid-feedback" id="goalAction${coachActionIndex }Error"></span>
		                                      </div>
		                                    </div>
		                                    <div class="col-md-3">
		                                      <div class="form-group">
		                                        <label for="goalAction${coachActionIndex }">Coachee Comments</label>
		                                        <p style="white-space: pre-line">${reportActionNow.coacheeComment }</p>
		                                      </div>
		                                    </div>
		                                    <div class="col-md-3">
		                                      <div class="form-group">
		                                        <input type="hidden" value="${reportActionNow.coachComment }" id="tempCoachComment${coachActionIndex }" />
		                                        <label for="coachComment${coachActionIndex }">Coach Comments</label>
		                                        <form:textarea rows="3" class="form-control" type="text" id="coachComment${coachActionIndex }" path="coacheeReportTemp.coacheeReportActionTempList[${coachActionIndex }].coachComment" placeholder="Enter Coach Comments" />
		                                        <span class="error invalid-feedback" id="coachComment${coachActionIndex }Error"></span>
		                                      </div>
		                                    </div>
		                                    <div class="col-md-2">
		                                      <div class="form-check" id="isActiveDiv">
		                                        <input type="hidden" id="reportActionStatusTempCoach${coachActionIndex }" value="${reportActionNow.reportActionStatus }" />
		                                        <label><span class="mandatory">*</span>Action Status</label>
		                                        <div class="custom-control custom-radio">
		                                          <form:radiobutton path="coacheeReportTemp.coacheeReportActionTempList[${coachActionIndex }].reportActionStatus" class="custom-control-input" value="0" id="reportActionStatus1${coachActionIndex }" name="coacheeReportTemp.coacheeReportActionTempList[${coachActionIndex }].reportActionStatus" />
		                                          <label for="reportActionStatus1${coachActionIndex }" class="custom-control-label text-red">Yet to start</label>
		                                        </div>
		                                        <div class="custom-control custom-radio">
		                                          <form:radiobutton path="coacheeReportTemp.coacheeReportActionTempList[${coachActionIndex }].reportActionStatus" class="custom-control-input" value="1" id="reportActionStatus2${coachActionIndex }" name="coacheeReportTemp.coacheeReportActionTempList[${coachActionIndex }].reportActionStatus" />
		                                          <label for="reportActionStatus2${coachActionIndex }" class="custom-control-label text-warning">In Progress</label>
		                                        </div>
		                                        <div class="custom-control custom-radio">
		                                          <form:radiobutton path="coacheeReportTemp.coacheeReportActionTempList[${coachActionIndex }].reportActionStatus" class="custom-control-input" value="2" id="reportActionStatus3${coachActionIndex }" name="coacheeReportTemp.coacheeReportActionTempList[${coachActionIndex }].reportActionStatus" />
		                                          <label for="reportActionStatus3${coachActionIndex }" class="custom-control-label text-green">Completed</label>
		                                        </div>
		                                        <span class="error invalid-feedback" id="isActiveError${coachActionIndex }" style="display:block" ></span> 
		                                      </div>
		                                    </div>
		                                  </div>
		                                </div>
		                              </div>
		                            </div>
		                          </div>
		                          <c:set var="coachActionIndex" value="${coachActionIndex + 1 }" />
		                        <%-- </c:if> --%>
		                        </c:forEach>
		                      </c:if>
		                      </div>
		                    </div>
		                  </div>
		                </div>
		              </div>
		              <div class="col-md-4 discussionAndInputsFromCoachShow">
		                <div class="form-group">
		                  <label>Topics discussed and inputs from coach in the current session</label>
		                  <p style="white-space: pre-line" id="discussionAndInputsFromCoachShow"></p>
		                </div>
		              </div>
					  <div class="col-md-4 coacheeAdditionalComments">
		                <div class="form-group">
		                  <label>Additional Comments by Coachee</label>
		                  <p style="white-space: pre-line" id="coacheeAdditionalComments"></p>
		                </div>
		              </div>
		              <div class="col-md-6 coachAdditionalComments">
		                <div class="form-group">
		                  <label for="coachAdditionalComments"><span class="mandatory">*</span>Additional Comments by Coach</label>
		                  <form:textarea rows="3" class="form-control" type="text" id="coachAdditionalComments" path="coacheeReportTemp.coachAdditionalComments" placeholder="Additional Comments by coach." />
		                  <span class="error invalid-feedback" id="coachAdditionalCommentsError"></span>
		                </div>
		              </div>
		              <div class="col-md-6 anyConcernOrObservation">
		                <div class="form-group">
		                  <label for="anyConcernOrObservation"><span class="mandatory">*</span>Any Concern/Observation</label>
		                  <form:textarea rows="3" class="form-control" type="text" id="anyConcernOrObservation" path="coacheeReportTemp.anyConcernOrObservation" placeholder="Any concern or observation?" />
		                  <span class="error invalid-feedback" id="anyConcernOrObservationError"></span>
		                </div>
		              </div>
		              <div class="col-md-4 sessionMode">
		                <div class="form-group">
		                  <label>Session Mode</label>
		                  <p style="white-space: pre-line" id="sessionModeShow"></p>
		                </div>
		              </div>
		              <div class="col-md-4 sessionModeReasonOnline">
		                <div class="form-group">
		                  <label>Reason For Online Session</label>
		                  <p style="white-space: pre-line" id="sessionModeReasonOnlineShow"></p>
		                </div>
		              </div>
					 
		              <div class="col-md-4 reportStatus">
		                <div class="form-check" id="reportStatusDiv">
		                  <label><span class="mandatory">*</span>Report Status</label>
		                  <div class="custom-control custom-radio">
		                    <form:radiobutton path="coacheeReportTemp.reportStatus" class="custom-control-input" value="4" id="reportStatusCoach2" name="coacheeReportTemp.reportStatus" />
		                    <label for="reportStatusCoach2" class="custom-control-label text-blue">Submit Report</label>
		                  </div>
		                  <div class="custom-control custom-radio">
		                    <form:radiobutton path="coacheeReportTemp.reportStatus" class="custom-control-input" value="3" id="reportStatusCoach1" name="coacheeReportTemp.reportStatus" />
		                    <label for="reportStatusCoach1" class="custom-control-label text-green">Keep in Draft</label>
		                  </div>
						 
						
						 <div class="custom-control custom-radio">
							<form:radiobutton 
								path="coacheeReportTemp.reportStatus"
								class="custom-control-input" 
								value="-1"
								id="reportStatus4" 
								name="coacheeReportTemp.reportStatus" />
							<label for="reportStatus4" class="custom-control-label text-blue">Sent Back To Coachee</label>
						</div>
						
						
						
		                  <span class="error invalid-feedback" id="reportStatusError" style="display:block" ></span> 
		                </div>
		              </div>
		              
		              <div class="col-md-10"><input type="hidden" value="${coachActionIndex }" id="coachActionIndex" /></div>
		              <div class="col-md-2">
		                <button title="Save Report" type="submit" id="submitCoachingReportButton" class="btn bg-2 float-right">Submit</button>
		              </div>
		            </div>
		            </form:form>
		          </div>
		          </c:if>
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
    <!-- <script src="usedStaticFiles/essentials/js/jsp_js_files/aldp/coachingBatchDetails/coaching-report.js"></script> -->
     <script src="usedStaticFiles/essentials/js/jsp_js_files/aldp/coachingBatchDetails/coaching-report.js"></script>

</body>
</html>
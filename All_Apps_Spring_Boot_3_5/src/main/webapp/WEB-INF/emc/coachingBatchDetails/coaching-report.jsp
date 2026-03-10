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
					<title>MENTORING REPORT | EMC<%@include file="../../includeJSP/company_name_title.jsp" %>
					</title>
					<%@include file="../../includeJSP/cssFiles.jsp" %>
						<%@include file="../../includeJSP/datePickerCss.jsp" %>
							<meta name="_csrf" content="${_csrf.token}" />
							<meta name="_csrf_header" content="${_csrf.headerName}" />

				</head>

				<body class="sidebar-mini layout-navbar-fixed sidebar-collapse pace-primary">
					<div class="wrapper">
						<%@include file="../../includeJSP/header.jsp" %>
							<%@include file="../includeJSP/leftSideBar.jsp" %>

								<div class="content-wrapper">
									<c:set var="goalIndex" value="0" />
									
									<c:set var="emcMentorReportPage" value="0" />
									<c:if test="${sessionUserInfo.mUserId eq coachCoacheeMapDetails.coachUserId.mUserId}">
									  <c:set var="emcMentorReportPage" value="1" />
									</c:if>
									<c:set var="emcMenteeReportPage" value="0" />
									<c:if test="${sessionUserInfo.mUserId eq coachCoacheeMapDetails.coacheeUserId.mUserId}">
									  <c:set var="emcMenteeReportPage" value="1" />
									</c:if>
									<c:set var="pg" value="${fn:replace(fn:replace(programCategory,'[',''),']','')}" />
									<input type="hidden" id="jsBatchName"
										value="${coachCoacheeMapDetails.coachCoacheeMappingSet.batchName }" />
									<input type="hidden" id="jsCoacheeName"
										value="${coachCoacheeMapDetails.coacheeUserId.userFirstName } ${coachCoacheeMapDetails.coacheeUserId.userLastName }" />
									<input type="hidden" id="jsCoachName"
										value="${coachCoacheeMapDetails.coachUserId.userFirstName } ${coachCoacheeMapDetails.coachUserId.userLastName }" />
									<input type="hidden" id="jsSupervisorName"
										value="${coachCoacheeMapDetails.supervisorUserId.userFirstName } ${coachCoacheeMapDetails.supervisorUserId.userLastName }" />
									<section class="content-header">
										<div class="container-fluid">
											<div class="row mb-2">
												<div class="col-sm-6">
													<h5 class="font-1 font-weight-bold">Mentoring Report -
														${coachCoacheeMapDetails.coacheeUserId.userFirstName }
														${coachCoacheeMapDetails.coacheeUserId.userLastName } -
														${coachCoacheeMapDetails.coachCoacheeMappingSet.batchName }
													</h5>
												</div>
												<div class="col-sm-6">
													<ol class="breadcrumb float-sm-right font-weight-bold">
														<li class="breadcrumb-item"><a href="dashboard-emc"
																title="Dashboard">Dashboard</a></li>
														<c:if
															test="${emcMentor eq 1 || emcAdmin eq 1 || itAdmin eq 1 }">
															<li class="breadcrumb-item"><a
																	href="emc-coaching-batch-details?batch-id=${coachCoacheeMapDetails.coachCoacheeMappingSet.actCoachingBatchId }"
																	title="Mentoring Batch Details">Mentoring Batch</a>
															</li>
															<li class="breadcrumb-item"><a
																	href="emc-coachee-list?batch-id=${coachCoacheeMapDetails.coachCoacheeMappingSet.actCoachingBatchId }"
																	title="Mentee List">Mentee List</a></li>
														</c:if>
														<li class="breadcrumb-item active">Mentoring Report</li>
													</ol>
												</div>
											</div>
										</div>
									</section>

									<c:if test="${not empty regMsg }">
										<section class="content content-margin">
											<div class="container-fluid">
												<div class="alert ${css } alert-dismissible">
													<button type="button" title="CLose Alert Box" class="close"
														data-dismiss="alert" aria-hidden="true"><i
															class="fas fa-times"></i></button>
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
															<div class="row">
																<div class="col-md-4">
																	<h5 class="font-color-anand-two font-weight-bold">
																		Batch:
																		${coachCoacheeMapDetails.coachCoacheeMappingSet.batchName
																		} </h5>
																</div>
																<div class="col-md-6">
																	<h5 class="font-color-anand-two font-weight-bold">
																		Description:
																		${coachCoacheeMapDetails.coachCoacheeMappingSet.batchDescription
																		} </h5>
																</div>
																<div class="col-md-2">
																	<a title="Add/Edit Coaching Goals"
																		class="breadcrumb-item font-weight-bold font-color-anand-warning"
																		href="emc-coaching-goals?batch-id=${coachCoacheeMapDetails.coachCoacheeMappingSet.actCoachingBatchId }&coachee-id=${coachCoacheeMapDetails.coacheeUserId.mUserId }">Add/Edit
																		Goals</a>

																</div>

																<div class="col-md-4">
																	<h5 class="font-color-anand-three font-weight-bold">
																		Mentee:
																		${coachCoacheeMapDetails.coacheeUserId.userFirstName
																		}
																		${coachCoacheeMapDetails.coacheeUserId.userLastName
																		} </h5>
																</div>
																<div class="col-md-4">
																	<h5 class="font-color-anand-three font-weight-bold">
																		Mentor:
																		${coachCoacheeMapDetails.coachUserId.userFirstName
																		}
																		${coachCoacheeMapDetails.coachUserId.userLastName
																		} </h5>
																</div>
																<div class="col-md-4">
																	<h5 class="font-color-anand-three font-weight-bold">
																		Supervisor:
																		${coachCoacheeMapDetails.supervisorUserId.userFirstName
																		}
																		${coachCoacheeMapDetails.supervisorUserId.userLastName
																		} </h5>
																</div>

															</div>
														</div>
														<c:set var="coachCoacheeAdminFlag" value="0" />
														<c:if test="${emcAdmin eq 1 || itAdmin eq 1 }">
															<c:set var="coachCoacheeAdminFlag" value="3" />
														</c:if>
														<!-- --${coachCoacheeMapDetails.coacheeUserId.mUserId}--${sessionUserInfo.mUserId }-- -->
														<c:if
															test="${coachCoacheeMapDetails.coacheeUserId.mUserId eq sessionUserInfo.mUserId }">
															<c:set var="coachCoacheeAdminFlag" value="2" />
														</c:if>
														<c:if
															test="${coachCoacheeMapDetails.coachUserId.mUserId eq sessionUserInfo.mUserId }">
															<c:set var="coachCoacheeAdminFlag" value="1" />
														</c:if>
														<input id="coachCoacheeAdminFlag" type="hidden"
															value="${coachCoacheeAdminFlag }" />

														<c:set var="programCategoryAsString"
															value="${programCategory}" />

														<div class="card-body">
															<div class="row">
																<div class="col-md-12">


																	<c:set var="programCategoryAsString"
																		value="${programCategory}" />

																	<table
																		class="table table-bordered dataTable anand-table-font-size"
																		id="coachingGoalTableActive">
																		<thead>
																			<tr class="bg-table-head">
																				<th>Action</th>
																				<th>Session Date</th>
																				<c:if test="(${emcMentor eq '1' and emcMentorReportPage eq 1 and fn:split(pg, ',')[0] eq '1'}) 
                     or (${emcMentee eq '1' and emcMenteeReportPage eq 1 and fn:split(pg, ',')[0] eq '1'})">
																					<th>Session Mode</th>
																				</c:if>

																				<th>Report Status</th>
																			</tr>
																		</thead>

																		<tbody>
																			<c:forEach items="${coacheeReportList}"
																				var="coachingReport"
																				varStatus="coachingReportLoop">
																				<c:set var="showReportInfoFlag"
																					value="1" />
																			<c:set var="showReportInfoFlag" value="1" />

																				<c:if
																					test="${showReportInfoFlag eq 1}">
																					<tr
																						class="bg-table-row-${coachingReportLoop.index % 2}">
																						<td>${coachingReport.actionForCoachingReport}
																						</td>

																						<td>
																							<fmt:formatDate
																								pattern="dd-MMM-yyyy"
																								value="${coachingReport.sessionDate}" />
																						</td>

																						
																						<c:if test="(${emcMentor eq 1 and emcMentorReportPage eq 1 and fn:split(pg, ',')[0] eq '1'}) 
                             or (${emcMentee eq 1 and emcMenteeReportPage eq 1 and fn:split(pg, ',')[0] eq '1'})">
																							<td>
																								<c:choose>
																									<c:when
																										test="${coachingReport.sessionMode eq 1}">
																										<span
																											class="badge bg-primary">Online</span>
																									</c:when>
																									<c:when
																										test="${coachingReport.sessionMode eq 2}">
																										<span
																											class="badge bg-secondary">In-Person</span>
																									</c:when>
																								</c:choose>
																							</td>
																						</c:if>

																						<td>
																							<c:choose>
																								<c:when
																									test="${coachingReport.reportStatus eq 1}">
																									<span
																										class="badge bg-primary">Submitted</span>
																								</c:when>
																								<c:when
																									test="${coachingReport.reportStatus eq 2}">
																									<span
																										class="badge bg-secondary">Draft</span>
																								</c:when>
																								<c:when
																									test="${coachingReport.reportStatus eq 3}">
																									<span
																										class="badge bg-success">Complete</span>
																								</c:when>
																							</c:choose>
																						</td>
																					</tr>
																				</c:if>
																			</c:forEach>
																		</tbody>

																		<tfoot>
																			<tr class="bg-table-foot">
																				<th>Action</th>
																				<th>Session Date</th>

																				<c:if test="(${emcMentor eq '1' and emcMentorReportPage eq 1 and fn:split(pg, ',')[0] eq '1'}) 
                     or (${emcMentee eq '1' and emcMenteeReportPage eq 1 and fn:split(pg, ',')[0] eq '1' })">
																					<th>Session Mode</th>
																				</c:if>

																				<th>Report Status</th>
																			</tr>
																		</tfoot>
																	</table>
																</div>
															</div>
														</div>
														<!-- Goals and Questins -->




														<div class="card-body">

															<div class="row">
																<div class="col-md-12">
																	<h5 class="font-color-anand-three font-weight-bold">
																		Active Goals</h5>
																</div>
																<div class="col-md-12">
																	<table
																		class="table table-bordered dataTable anand-table-font-size"
																		id="coachingGoalTableActive">
																		<thead>
																			<tr class="bg-table-head">
																				<!-- <th>Action</th> -->
																				<th>Mentoring Goal</th>
																				<th>Active/In-Active</th>
																				<th>Mentoring Description</th>
																				<th>Mentee</th>
																				<th>Mentor</th>
																				<th>Supervisor</th>
																			</tr>
																		</thead>
																		<tbody>
																			<c:forEach items="${coacheeGoalsList }"
																				var="coachingGoal"
																				varStatus="coachingGoalLoop">
																				<c:if
																					test="${coachingGoal.coachingGoalActive eq 1 }">
																					<tr
																						class="bg-table-row-${coachingGoalsLoop.index %2 }">
																						<!-- <td>${coachingGoal.actionForCoachingGoal }</td> -->
																						<td>${coachingGoal.coachingGoal
																							}</td>
																						<td>
																							<c:choose>
																								<c:when
																									test="${coachingGoal.coachingGoalActive eq 1 }">
																									<span
																										class="badge bg-info-anand-success">Active</span>
																								</c:when>
																								<c:otherwise>
																									<span
																										class="badge bg-info-anand-danger">In-Active</span>
																								</c:otherwise>
																							</c:choose>
																						</td>
																						<td
																							style="white-space: pre-line">
																							${coachingGoal.coachingGoalDescription
																							}</td>
																						<td>${coachingGoal.coacheeGoalsSet.coacheeUserId.userFirstName
																							}
																							${coachingGoal.coacheeGoalsSet.coacheeUserId.userLastName
																							}</td>
																						<td>${coachingGoal.coacheeGoalsSet.coachUserId.userFirstName
																							}
																							${coachingGoal.coacheeGoalsSet.coachUserId.userLastName
																							}</td>
																						<td>${coachingGoal.coacheeGoalsSet.supervisorUserId.userFirstName
																							}
																							${coachingGoal.coacheeGoalsSet.supervisorUserId.userLastName
																							}</td>
																					</tr>
																				</c:if>
																			</c:forEach>
																		</tbody>
																		<tfoot>
																			<tr class="bg-table-foot">
																				<!-- <th>Action</th> -->
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







																<c:set var="coachActionIndex" value="0" />

																<form:form method="post" action="emc-coaching-report"
																	modelAttribute="actCoachCoacheeMap"
																	id="actCoachReport">
																	<form:hidden
																		path="coacheeReportTemp.actCoacheeReportId"
																		id="actCoacheeReportIdCoach" />
																	<form:hidden
																		path="coacheeReportTemp.actCoachCoacheeMapId"
																		id="actCoachCoacheeMapId"
																		value="${coachCoacheeMapDetails.actCoachCoacheeMapId }" />
																	<input type="hidden" name="batch-id" id="batch-id"
																		value="${coachCoacheeMapDetails.coachCoacheeMappingSet.actCoachingBatchId }" />
																	<input type="hidden" name="coacheeIdForPage"
																		id="coacheeIdForPage"
																		value="${coacheeIdForPage }" />
																	<input type="hidden"
																		name="coacheeReportTemp.sessionDateString"
																		id="sessionDateHidden" />
																		<input type="hidden" id="savedReportId" value="${savedReportId}" />

																		

                              
                                                                  <c:if test="${emcMentor eq '1' and emcMentorReportPage eq 1 and fn:contains(pg, '2')}">

																	
																		<div id="editReportSection"
																			style="display: none;">

																		<h4 class="fw-bold mb-3">Questions</h4>

																		<div class="table-responsive">
																			<table
																				class="table table-bordered dataTable anand-table-font-size"
																				id="questionTable">

																				<thead class="table-light">
																					<tr class="bg-table-head">
																						<th style="width: 55%">
																							Question</th>
																						<th style="width: 65%">
																							Answer</th>
																					</tr>
																				</thead>
																				<tbody id="question-container">
																				</tbody>
																				<tfoot>
																					<tr class="bg-table-foot">
																						<th>Question</th>
																						<th>Answer</th>

																					</tr>
																				</tfoot>
																			</table>
																		</div>

																		
																			<div class="row">
																	
																				<div
																					class="col-md-6 sessionDateStringShow">
																					<div class="form-group">
																						<label>
																							<span
																								class="mandatory">*</span>Session
																							Date
																						</label>
																						<div class="form-control"
																							style="background-color: #e9ecef;">
																							<p
																								id="sessionDateStringShow">
																							</p>

																						</div>
																					</div>
																				</div>
																				<div class="col-md-6 reportStatus">
																					<div class="form-check"
																						id="reportStatusDiv">
																						<label><span
																								class="mandatory">*</span>Report
																							Status</label>
																						<div
																							class="custom-control custom-radio">
																							<form:radiobutton
																								path="coacheeReportTemp.reportStatus"
																								class="custom-control-input"
																								value="1"
																								id="reportStatusCoach2"
																								name="coacheeReportTemp.reportStatus" />
																							<label
																								for="reportStatusCoach2"
																								class="custom-control-label text-blue">Submit
																								Report</label>
																						</div>
																						<div
																							class="custom-control custom-radio">
																							<form:radiobutton
																								path="coacheeReportTemp.reportStatus"
																								class="custom-control-input"
																								value="3"
																								id="reportStatusCoach1"
																								name="coacheeReportTemp.reportStatus" />
																							<label
																								for="reportStatusCoach1"
																								class="custom-control-label text-green">Keep
																								in
																								Draft</label>
																						</div>
																						<span
																							class="error invalid-feedback"
																							id="reportStatusError"
																							style="display:block"></span>
																					</div>
																				</div>


																				<div class="text-end mt-3">
																					<button id="submit-btn"
																						class="btn bg-1">Submit</button>
																				</div>
																			</div>
																		</div>
																	</c:if>                  

                                                                    <c:if test="${emcMentor eq '1' and emcMentorReportPage eq 1 and fn:contains(pg, '1')}">

																		<div id="editReportSection"
																					style="display: none;">
																					
																		<div class="row">
																			<div class="col-md-12">
																				<h4 class="fw-bold mb-3">Questions</h4>

																				<div class="table-responsive">
																					<table
																						class="table table-bordered dataTable anand-table-font-size"
																						id="questionTable">

																						<thead class="table-light">
																							<tr class="bg-table-head">
																								<th style="width: 55%">
																									Question</th>
																								<th style="width: 65%">
																									Answer</th>
																							</tr>
																						</thead>
																						<tbody id="question-container">
																						</tbody>
																						<tfoot>
																							<tr class="bg-table-foot">
																								<th>Question</th>
																								<th>Answer</th>

																							</tr>
																						</tfoot>
																					</table>
																				</div>


																				
																					<div class="row">

																						<div
																							class="col-md-3 sessionDateStringShow">
																							<div class="form-group">
																								<label>
																									<span
																										class="mandatory">*</span>Session
																									Date
																								</label>
																								<div class="form-control"
																									style="background-color: #e9ecef;">
																									<!-- <fmt:formatDate pattern="dd-MMM-yyyy" value="${coachingReport.sessionDate}" />  -->
																									<p
																										id="sessionDateStringShow">
																									</p>

																								</div>
																							</div>
																						</div>

																						<div
																							class="col-md-3  sessionMode">
																							<div class="form-group">
																								<label
																									for="sessionMode"><span
																										class="mandatory">*</span>Session
																									Mode</label>
																								
																									<div class="form-control"
																									style="background-color: #e9ecef;">

																									<p
																										id="sessionModeShow">
																									</p>
																								</div>






																								<span
																									class="error invalid-feedback"
																									id="sessionModeError"></span>
																							</div>
																						</div>

																						<div
																							class="col-md-6  coacheeAdditionalComments1">
																							<div class="form-group">
																								<label
																									for="coacheeAdditionalComments1"><span
																										class="mandatory">*</span>Coachee
																									Session
																									Reflection</label>
																								<div class="form-control"
																									style="background-color: #e9ecef;">
																									<p
																										id="coacheeAdditionalComments1">
																									</p>
																								</div>

																								<span
																									class="error invalid-feedback"
																									id="coacheeAdditionalCommentsError"></span>
																							</div>
																						</div>
																						<div
																							class="col-md-6  discussionAndInputsFromCoachShow1">
																							<div class="form-group">
																								<label
																									for="discussionAndInputsFromCoachShow1"><span
																										class="mandatory">*</span>Coachee
																									Actions
																									Points</label>

																								<div class="form-control"
																									style="background-color: #e9ecef;">
																									<p
																										id="discussionAndInputsFromCoachShow1">
																									</p>
																								</div>
																								<span
																									class="error invalid-feedback"
																									id="discussionAndInputsFromCoachError"></span>
																							</div>
																						</div>
																						<div
																							class="col-md-6  coachAdditionalComments">
																							<div class="form-group">
																								<label
																									for="batchName"><span
																										class="mandatory">*</span>Session
																									Reflection</label>
																								<form:textarea rows="3"
																									class="form-control"
																									type="text"
																									id="coachAdditionalComments"
																									path="coacheeReportTemp.coachAdditionalComments"
																									placeholder="Enter the session Reflection" />
																								<span
																									class="error invalid-feedback"
																									id="coacheeAdditionalCommentsError"></span>
																							</div>
																						</div>
																						<div
																							class="col-md-6  anyConcernOrObservation">
																							<div class="form-group">
																								<label
																									for="anyConcernOrObservation"><span
																										class="mandatory">*</span>Actions
																									Points</label>
																								<form:textarea rows="3"
																									class="form-control"
																									type="text"
																									id="anyConcernOrObservation"
																									path="coacheeReportTemp.anyConcernOrObservation"
																									placeholder="Enter session action points" />
																								<span
																									class="error invalid-feedback"
																									id="discussionAndInputsFromCoachError"></span>
																							</div>
																						</div>
																						<div
																							class="col-md-6 reportStatus">
																							<div class="form-check"
																								id="reportStatusDiv">
																								<label><span
																										class="mandatory">*</span>Report
																									Status</label>
																								<div
																									class="custom-control custom-radio">
																									<form:radiobutton
																										path="coacheeReportTemp.reportStatus"
																										class="custom-control-input"
																										value="1"
																										id="reportStatus2"
																										name="coacheeReportTemp.reportStatus" />
																									<label
																										for="reportStatus2"
																										class="custom-control-label text-blue">Submit
																									</label>
																								</div>
																								<div
																									class="custom-control custom-radio">
																									<form:radiobutton
																										path="coacheeReportTemp.reportStatus"
																										class="custom-control-input"
																										value="2"
																										id="reportStatus1"
																										name="coacheeReportTemp.reportStatus" />
																									<label
																										for="reportStatus1"
																										class="custom-control-label text-green">Keep
																										in Draft</label>
																								</div>
																								<span
																									class="error invalid-feedback"
																									id="reportStatusError"
																									style="display:block"></span>
																							</div>


																						</div>

																						<div class="col-md-2 align-content-end float-right">
																							<!-- <button id="submit-btn"
																							class="btn bg-1"
																							style="display: none; ">Submit
																							Answers</button> -->

																							<button id="submit-btn"
																								class="btn bg-1">Submit
																								Answers</button>

																						</div>

																					</div>

																				</div>
																			</div>
																			</div>
																	</c:if>






																</form:form>









																<c:set var="coacheeActionIndex" value="0" />
																<div class="card-footer coacheeReportFooter w-100 mx-2">
																	<form:form method="post"
																		action="emc-coaching-report"
																		modelAttribute="actCoachCoacheeMap"
																		id="actCoacheeReport">
																		<form:hidden
																			path="coacheeReportTemp.actCoacheeReportId"
																			id="actCoacheeReportId" />
																		<form:hidden
																			path="coacheeReportTemp.actCoachCoacheeMapId"
																			id="actCoachCoacheeMapId"
																			value="${coachCoacheeMapDetails.actCoachCoacheeMapId }" />
																		<input type="hidden" name="batch-id"
																			id="batch-id"
																			value="${coachCoacheeMapDetails.coachCoacheeMappingSet.actCoachingBatchId }" />
																		<input type="hidden" name="coacheeIdForPage"
																			id="coacheeIdForPage"
																			value="${coacheeIdForPage }" />
																		<div class="row">

																			<!-- <h1>hhhh</h1> -->
																			<c:if test="${coachCoacheeAdminFlag eq 3 }">

																				<div class="col-md-12">
																					<h4 class="fw-bold mb-3">Questions
																					</h4>

																					<div class="table-responsive">
																						<table
																							class="table table-bordered dataTable anand-table-font-size"
																							id="questionTable">

																							<thead class="table-light">
																								<tr
																									class="bg-table-head">
																									<th class="py-9"
																										style="width: 250%">
																										Question</th>
																									<th class="py-3"
																										style="width: 55%">
																										Answer</th>
																								</tr>
																							</thead>
																							<tbody
																								id="question-container">
																							</tbody>
																							<tfoot>
																								<tr
																									class="bg-table-foot">
																									<th class="py-3">
																										Question</th>
																									<th class="py-3">
																										Answer</th>

																								</tr>
																							</tfoot>
																						</table>
																					</div>
																				</div>

																			</c:if>
																			<c:if test="${coachCoacheeAdminFlag eq 1 }">
																				<h5
																					class="font-color-anand-one font-weight-bold">
																					Mentoring Report</h5>
																			</c:if>
																		</div>


																		<div class="row">
																			

<c:if test="${emcMentee == 1 and emcMenteeReportPage eq 1 and fn:split(pg, ',')[0] eq '1'}">



																				<div class="col-md-6 sessionDateString">
																					<div class="form-group">
																						<label><span
																								class="mandatory">*</span>Session
																							Date</label>
																						<div class="input-group">
																							<div
																								class="input-group-prepend">
																								<span
																									class="input-group-text">
																									<i
																										class="far fa-calendar-alt"></i>
																								</span>
																							</div>
																							<form:input
																								id="sessionDateString"
																								path="coacheeReportTemp.sessionDateString"
																								type="text"
																								class="form-control float-right"
																								placeholder="Session Date" />
																							<span
																								class="error invalid-feedback"
																								id="sessionDateStringError"></span>
																						</div>
																					</div>
																				</div>
																				<div class="col-md-6  sessionMode">
																					<div class="form-group">
																						<label for="sessionMode"><span
																								class="mandatory">*</span>Session
																							Mode</label>
																						<form:select
																							class="form-control"
																							id="sessionMode"
																							path="coacheeReportTemp.sessionMode">
																							<form:option value="-1">
																								Select Mode
																							</form:option>
																							<form:option value="1">
																								Online
																							</form:option>
																							<form:option value="2">
																								In-Person
																							</form:option>
																						</form:select>
																						<span
																							class="error invalid-feedback"
																							id="sessionModeError"></span>
																					</div>
																				</div>
																				<div
																					class="col-md-6  coacheeAdditionalComments">
																					<div class="form-group">
																						<label for="batchName"><span
																								class="mandatory">*</span>Session
																							Reflection</label>
																						<form:textarea rows="3"
																							class="form-control"
																							type="text"
																							id="coacheeAdditionalComments"
																							path="coacheeReportTemp.coacheeAdditionalComments"
																							placeholder="Enter the session Reflection" />
																						<span
																							class="error invalid-feedback"
																							id="coacheeAdditionalCommentsError"></span>
																					</div>
																				</div>
																				<div
																					class="col-md-6  discussionAndInputsFromCoach">
																					<div class="form-group">
																						<label
																							for="discussionAndInputsFromCoach"><span
																								class="mandatory">*</span>Actions
																							Points</label>
																						<form:textarea rows="3"
																							class="form-control"
																							type="text"
																							id="discussionAndInputsFromCoach"
																							path="coacheeReportTemp.discussionAndInputsFromCoach"
																							placeholder="Enter session action points" />
																						<span
																							class="error invalid-feedback"
																							id="discussionAndInputsFromCoachError"></span>
																					</div>
																				</div>

																				<div class="col-md-3 reportStatus">
																					<div class="form-check"
																						id="reportStatusDiv">
																						<label><span
																								class="mandatory">*</span>Report
																							Status</label>
																						<div
																							class="custom-control custom-radio">
																							<form:radiobutton
																								path="coacheeReportTemp.reportStatus"
																								class="custom-control-input"
																								value="1"
																								id="reportStatus2"
																								name="coacheeReportTemp.reportStatus" />
																							<label for="reportStatus2"
																								class="custom-control-label text-blue">Submit
																								Report to Coach</label>
																						</div>
																						<div
																							class="custom-control custom-radio">
																							<form:radiobutton
																								path="coacheeReportTemp.reportStatus"
																								class="custom-control-input"
																								value="2"
																								id="reportStatus1"
																								name="coacheeReportTemp.reportStatus" />
																							<label for="reportStatus1"
																								class="custom-control-label text-green">Keep
																								in Draft</label>
																						</div>
																						<span
																							class="error invalid-feedback"
																							id="reportStatusError"
																							style="display:block"></span>
																					</div>
																				</div>

																				<div class="col-md-2 align-content-end float-right">
																					<button title="Save Report"
																						type="submit"
																						id="submitCoachingReportButton"
																						class="btn bg-1">Submit</button>
																				</div>
																			</c:if>
																		</div>

																		
																			<c:if test="${emcMentee == 1 and emcMenteeReportPage eq 1 and fn:split(pg, ',')[0] eq '2'}">

																			<div class="row">
																				<div class="col-md-6 sessionDateString">
																					<div class="form-group">
																						<label><span
																								class="mandatory">*</span>Session
																							Date</label>
																						<div class="input-group">
																							<div
																								class="input-group-prepend">
																								<span
																									class="input-group-text">
																									<i
																										class="far fa-calendar-alt"></i>
																								</span>
																							</div>
																							<form:input
																								id="sessionDateString"
																								path="coacheeReportTemp.sessionDateString"
																								type="text"
																								class="form-control float-right"
																								placeholder="Session Date" />
																							<span
																								class="error invalid-feedback"
																								id="sessionDateStringError"></span>
																						</div>
																					</div>
																				</div>

																				<div class="col-md-6 reportStatus">
																					<div class="form-check"
																						id="reportStatusDiv">
																						<label><span
																								class="mandatory">*</span>Report
																							Status</label>
																						<div
																							class="custom-control custom-radio">
																							<form:radiobutton
																								path="coacheeReportTemp.reportStatus"
																								class="custom-control-input"
																								value="1"
																								id="reportStatus2"
																								name="coacheeReportTemp.reportStatus" />
																							<label for="reportStatus2"
																								class="custom-control-label text-blue">Submit
																								Report to Coach</label>
																						</div>
																						<div
																							class="custom-control custom-radio">
																							<form:radiobutton
																								path="coacheeReportTemp.reportStatus"
																								class="custom-control-input"
																								value="2"
																								id="reportStatus1"
																								name="coacheeReportTemp.reportStatus" />
																							<label for="reportStatus1"
																								class="custom-control-label text-green">Keep
																								in Draft</label>
																						</div>
																						<span
																							class="error invalid-feedback"
																							id="reportStatusError"
																							style="display:block"></span>
																					</div>
																				</div>
																			</div>
																			<div class="col-md-2 align-content-end float-right">
																				<button title="Save Report"
																					type="submit"
																					id="submitCoachingReportButton"
																					class="btn bg-1">Submit</button>
																			</div>
																		</c:if>
																	</form:form>

																</div>


															</div>


															<div class="col-md-10"><input type="hidden"
																	value="${coacheeActionIndex }"
																	id="coacheeActionIndex" /></div>
															<!-- <div class="col-md-2">
																	<button title="Save Report" type="submit"
																		id="submitCoachingReportButton"
																		class="btn bg-1">Submit</button>
																</div> -->
														</div>

													</div>

													<c:set var="coachActionIndex" value="0" />

													<!-- ----${coachCoacheeAdminFlag }---- -->
													<div class="card-footer coachReportFooter">
														<form:form method="post" action="emc-coaching-report-coach"
															modelAttribute="actCoachCoacheeMap" id="actCoachReport">
															<form:hidden path="coacheeReportTemp.actCoacheeReportId"
																id="actCoacheeReportIdCoach" />
															<form:hidden path="coacheeReportTemp.actCoachCoacheeMapId"
																id="actCoachCoacheeMapId"
																value="${coachCoacheeMapDetails.actCoachCoacheeMapId }" />
															<input type="hidden" name="batch-id" id="batch-id"
																value="${coachCoacheeMapDetails.coachCoacheeMappingSet.actCoachingBatchId }" />
															<input type="hidden" name="coacheeIdForPage"
																id="coacheeIdForPage" value="${coacheeIdForPage }" />
															<div class="row">
																<div class="col-md-12">
																	<c:if test="${emcAdmin eq 1 || itAdmin eq 1 }">
																		<h5
																			class="font-color-anand-one font-weight-bold">
																			Mentoring Report - Mentor Submission
																		</h5>
																	</c:if>
															
																</div>


																<div class="row">
																	<c:if
																		test="${emcMentee == 1  and emcMenteeReportPage eq 1 and  fn:split(pg, ',')[0] eq '1'}">


																		<div class="col-md-6 sessionDateString">
																			<div class="form-group">
																				<label><span
																						class="mandatory">*</span>Session
																					Date</label>
																				<div class="input-group">
																					<div class="input-group-prepend">
																						<span class="input-group-text">
																							<i
																								class="far fa-calendar-alt"></i>
																						</span>
																					</div>
																					<form:input id="sessionDateString"
																						path="coacheeReportTemp.sessionDateString"
																						type="text"
																						class="form-control float-right"
																						placeholder="Session Date" />
																					<span class="error invalid-feedback"
																						id="sessionDateStringError"></span>
																				</div>
																			</div>
																		</div>

																		<div class="col-md-3  sessionMode">
																			<div class="form-group">
																				<label for="sessionMode"><span
																						class="mandatory">*</span>Session
																					Mode</label>
																				<form:select class="form-control"
																					id="sessionMode"
																					path="coacheeReportTemp.sessionMode">
																					<form:option value="-1">
																						Select Mode
																					</form:option>
																					<form:option value="1">
																						Online
																					</form:option>
																					<form:option value="2">
																						In-Person
																					</form:option>
																				</form:select>
																				<span class="error invalid-feedback"
																					id="sessionModeError"></span>
																			</div>
																		</div>
																		<div
																			class="col-md-6  coacheeAdditionalComments">
																			<div class="form-group">
																				<label for="batchName"><span
																						class="mandatory">*</span>Session
																					Reflection</label>
																				<form:textarea rows="3"
																					class="form-control" type="text"
																					id="coacheeAdditionalComments"
																					path="coacheeReportTemp.coacheeAdditionalComments"
																					placeholder="Enter the session Reflection" />
																				<span class="error invalid-feedback"
																					id="coacheeAdditionalCommentsError"></span>
																			</div>
																		</div>
																		<div
																			class="col-md-6  discussionAndInputsFromCoach">
																			<div class="form-group">
																				<label
																					for="discussionAndInputsFromCoach"><span
																						class="mandatory">*</span>Actions
																					Points</label>
																				<form:textarea rows="3"
																					class="form-control" type="text"
																					id="discussionAndInputsFromCoach"
																					path="coacheeReportTemp.discussionAndInputsFromCoach"
																					placeholder="Enter session action points" />
																				<span class="error invalid-feedback"
																					id="discussionAndInputsFromCoachError"></span>
																			</div>
																		</div>

																		<div class="col-md-3 reportStatus">
																			<div class="form-check"
																				id="reportStatusDiv">
																				<label><span
																						class="mandatory">*</span>Report
																					Status</label>
																				<div
																					class="custom-control custom-radio">
																					<form:radiobutton
																						path="coacheeReportTemp.reportStatus"
																						class="custom-control-input"
																						value="1" id="reportStatus2"
																						name="coacheeReportTemp.reportStatus" />
																					<label for="reportStatus2"
																						class="custom-control-label text-blue">Submit
																						Report to Coach</label>
																				</div>
																				<div
																					class="custom-control custom-radio">
																					<form:radiobutton
																						path="coacheeReportTemp.reportStatus"
																						class="custom-control-input"
																						value="2" id="reportStatus1"
																						name="coacheeReportTemp.reportStatus" />
																					<label for="reportStatus1"
																						class="custom-control-label text-green">Keep
																						in Draft</label>
																				</div>
																				<span class="error invalid-feedback"
																					id="reportStatusError"
																					style="display:block"></span>
																			</div>
																		</div>

																		<div class="col-md-2 align-content-end float-right">
																			<button title="Save Report" type="submit"
																				id="submitCoachingReportButton"
																				class="btn bg-1">Submit</button>
																		</div>
																	</c:if>




																</div>
															</div>
														</form:form>
													</div>
												</div>
									</section>
								</div>
								<%@include file="../includeJSP/footer.jsp" %>
					</div>
					<%@include file="../../includeJSP/jsFiles.jsp" %>
						<%@include file="../../includeJSP/dataTablesImport.jsp" %>
							<%@include file="../../includeJSP/datePickerJs.jsp" %>
								<script
									src="usedStaticFiles/essentials/js/jsp_js_files/emc/coachingBatchDetails/coaching-report.js"></script>


								<script>document.addEventListener("DOMContentLoaded", function () {
										const questionTable = document.getElementById("questionTable");

										if (questionTable) {
											// ✅ Make table occupy full width of the page
											questionTable.classList.add("w-100");

											// ✅ Stretch parent .col-md-12 to full width
											const parentDiv = questionTable.closest(".col-md-12");
											if (parentDiv) {
												parentDiv.classList.remove("col-md-12");
												parentDiv.classList.add("container-fluid", "px-0");
											}

											// ✅ Make .table-responsive wrapper use full width
											const tableResponsive = questionTable.closest(".table-responsive");
											if (tableResponsive) {
												tableResponsive.style.width = "100%";
											}

											// ✅ Fix column widths — evenly distributed
											const headers = questionTable.querySelectorAll("th");
											headers.forEach((th) => {
												th.style.width = "50%"; // even split between Question and Answer
											});

											// ✅ Ensure table fills full horizontal area
											questionTable.style.margin = "0";
											questionTable.style.tableLayout = "fixed";
										}
									});
								</script>
				</body>

				</html>
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
					<title>MENTORING BATCH | EMC<%@include file="../../includeJSP/company_name_title.jsp" %>
					</title>
					<%@include file="../../includeJSP/cssFiles.jsp" %>
						<%@include file="../../includeJSP/datePickerCss.jsp" %>
				</head>

				<body class="sidebar-mini layout-navbar-fixed sidebar-collapse pace-primary">
					<div class="wrapper">
						<%@include file="../includeJSP/header.jsp" %>
							<%@include file="../includeJSP/leftSideBar.jsp" %>
								<div class="content-wrapper">

									<section class="content-header">
										<div class="container-fluid">
											<div class="row mb-2">
												<div class="col-sm-6">
													<h5 class="font-3 font-weight-bold">EMC BATCH</h5>
												</div>
												<div class="col-sm-6">
													<ol class="breadcrumb float-sm-right">
														<li class="breadcrumb-item"><a href="dashboard-act"
																title="Dashboard"><strong>Dashboard</strong></a></li>
														<li class="breadcrumb-item active"><strong>Mentoring
																Batch</strong></li>
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

											<c:if test="${itAdmin eq 1 || emcAdmin eq 1 }">
												<div class="row">


													<div class="col-12" style="display: none;">
														<c:set var="coachListString" value="" />
														<c:forEach items="${coachList }" var="coach"
															varStatus="coachIndex">
															<c:choose>
																<c:when test="${not empty coachListString }">
																	<c:set var="coachListString"
																		value="${coachListString }||${coach.mUserId }!!${coach.userFirstName } ${coach.userLastName }" />
																</c:when>
																<c:when test="${empty coachListString }">
																	<c:set var="coachListString"
																		value="${coach.mUserId }!!${coach.userFirstName } ${coach.userLastName }" />
																</c:when>
															</c:choose>
														</c:forEach>
														<input type="hidden" id="coachStringForJs"
															value="${coachListString }" />

														<c:set var="coacheeListString" value="" />
														<c:forEach items="${coacheeList }" var="coachee"
															varStatus="coacheeIndex">
															<c:choose>
																<c:when test="${not empty coacheeListString }">
																	<c:set var="coacheeListString"
																		value="${coacheeListString }||${coachee.mUserId }!!${coachee.userFirstName } ${coachee.userLastName }" />
																</c:when>
																<c:when test="${empty coacheeListString }">
																	<c:set var="coacheeListString"
																		value="${coachee.mUserId }!!${coachee.userFirstName } ${coachee.userLastName }" />
																</c:when>
															</c:choose>
														</c:forEach>
														<input type="hidden" id="coacheeStringForJs"
															value="${coacheeListString }" />

														<c:set var="supervisorListString" value="" />
														<c:forEach items="${supervisorList }" var="supervisor"
															varStatus="supervisorIndex">
															<c:choose>
																<c:when test="${not empty supervisorListString }">
																	<c:set var="supervisorListString"
																		value="${supervisorListString }||${supervisor.mUserId }!!${supervisor.userFirstName } ${supervisor.userLastName }" />
																</c:when>
																<c:when test="${empty supervisorListString }">
																	<c:set var="supervisorListString"
																		value="${supervisor.mUserId }!!${supervisor.userFirstName } ${supervisor.userLastName }" />
																</c:when>
															</c:choose>
														</c:forEach>
														<input type="hidden" id="supervisorStringForJs"
															value="${supervisorListString }" />
													</div>

													<!-- <c:set var="programCategoryListString" value="" />
		        <c:forEach items="${programCategoryList }" var="programCategory" varStatus="programCategoryIndex">
					jkmkm<c:out value="${programCategory}"/>
		          <c:choose>
		            <c:when test="${not empty programCategoryListString }">
		              <c:set var="programCategoryListString" value="${programCategoryListString }" />
		            </c:when>
		         
		          </c:choose>
		        </c:forEach>
		        <input type="hidden" id="programCategoryStringForJs" value="${programCategoryListString }" />
				
                           -->

													<%-- Initialize program category string --%>
														<c:set var="programCategoryListString" value="" />

														<%-- Build the program category options --%>
															<c:forEach items="${programCategoryList}" var="pc">
																<c:choose>
																	<c:when test="${pc.actCoacheeProgram == 1}">
																		<c:if
																			test="${not fn:contains(programCategoryListString, '1!!')}">
																			<c:set var="programCategoryListString"
																				value="${programCategoryListString}||1!!Senior Executive Coaching" />
																		</c:if>
																	</c:when>
																	<c:when test="${pc.actCoacheeProgram == 2}">
																		<c:if
																			test="${not fn:contains(programCategoryListString, '2!!')}">
																			<c:set var="programCategoryListString"
																				value="${programCategoryListString}||2!!Top Executive Mentoring" />
																		</c:if>
																	</c:when>
																</c:choose>
															</c:forEach>

															<%-- Remove leading || if present --%>
																<c:choose>
																	<c:when
																		test="${fn:startsWith(programCategoryListString, '||')}">
																		<c:set var="programCategoryListString"
																			value="${fn:substring(programCategoryListString, 2, fn:length(programCategoryListString))}" />
																	</c:when>
																</c:choose>

																<%-- Store in hidden field for JavaScript --%>
																	<input type="hidden" id="programCategoryStringForJs"
																		value="${programCategoryListString}" />





												</div>


												<div class="col-md-12">
													<form:form modelAttribute="actCoachingBatch"
														action="emc-coaching-batch" id="actCoachingBatch" method="post"
														onsubmit="return prepareFeedbackQuestionsForSubmit()">

														<form:input path="questionTexts" type="hidden"
															id="questionsField" name="questionTexts" />


														<form:input path="feedbackText" type="hidden"
															id="feedbackTextField" name="feedbackText" />
														<form:input path="feedbackcoacheeText" type="hidden"
															id="feedbackCoacheeTextField" name="feedbackcoacheeText" />
														<form:input path="feedbackMentorText" type="hidden"
															id="feedbackMentorTextField" name="feedbackMentorText" />
														<form:input path="feedbackMenteeText" type="hidden"
															id="feedbackMenteeTextField" name="feedbackMenteeText" />






														<div class="card card-outline collapsed-card">
															<div class="card-header bg-1" data-card-widget="collapse">
																<h5 class="card-title font-weight-bold">Add EMC
																	 Batch</h5>
																<div class="card-tools">
																	<button type="button"
																		class="btn btn-tool text-white "
																		data-card-widget="collapse">
																		<i class="fas fa-plus"></i>
																	</button>
																	<input type="hidden" value="${openAddModal }"
																		id="openAddModel" />
																	<input type="hidden" value="${openEditModel }"
																		id="openEditModel" />
																</div>
															</div>
															<div class="card-body" style="display: none;">
																<div class="row">
																	<div class="col-md-4">
																		<div class="form-group">
																			<label for="batchName"><span
																					class="mandatory">*</span>Batch
																				Name</label>
																			<form:input type="text" class="form-control"
																				id="batchName"
																				placeholder="Enter Batch Name"
																				path="batchName" />
																			<span class="error invalid-feedback"
																				id="batchNameError"></span>
																		</div>
																	</div>
																	<div class="col-md-8">
																		<div class="form-group">
																			<label for="batchDescription"><span
																					class="mandatory">*</span>Batch
																				Description</label>
																			<form:input type="text" class="form-control"
																				id="batchDescription"
																				placeholder="Enter Batch Description"
																				path="batchDescription" />
																			<span class="error invalid-feedback"
																				id="batchDescriptionError"></span>
																		</div>
																	</div>
																	<div class="col-md-3">
																		<div class="form-group">
																			<label><span class="mandatory">*</span>Batch
																				Start Date</label>
																			<div class="input-group">
																				<div class="input-group-prepend">
																					<span class="input-group-text">
																						<i
																							class="far fa-calendar-alt"></i>
																					</span>
																				</div>
																				<form:input path="startDateTemp"
																					id="startDateTemp" type="text"
																					class="form-control float-right"
																					title="Estimated Start Date" />
																				<span class="error invalid-feedback"
																					id="startDateTempError"></span>
																			</div>
																		</div>
																	</div>
																	<div class="col-md-3">
																		<div class="form-group">
																			<label><span class="mandatory">*</span>Batch
																				End Date</label>
																			<div class="input-group">
																				<div class="input-group-prepend">
																					<span class="input-group-text">
																						<i
																							class="far fa-calendar-alt"></i>
																					</span>
																				</div>
																				<form:input path="endDateTemp"
																					id="endDateTemp" type="text"
																					class="form-control float-right"
																					title="Estimated Start Date" />
																				<span class="error invalid-feedback"
																					id="endDateTempError"></span>
																			</div>
																		</div>
																	</div>
																	<div class="col-md-3">
																		<div class="form-check" id="isActiveDiv">
																			<label><span class="mandatory">*</span>Batch
																				Active/InActive</label>
																			<div class="custom-control custom-radio">
																				<form:radiobutton path="batchActive"
																					class="custom-control-input"
																					value="1" id="batchActive1"
																					name="batchActive" />
																				<label for="batchActive1"
																					class="custom-control-label text-green">Active</label>
																			</div>
																			<div class="custom-control custom-radio">
																				<form:radiobutton path="batchActive"
																					class="custom-control-input"
																					value="0" id="batchActive2"
																					name="batchActive" />
																				<label for="batchActive2"
																					class="custom-control-label text-red">Inactive</label>
																			</div>
																			<span class="error invalid-feedback"
																				id="isActiveError"
																				style="display:block"></span>
																		</div>
																	</div>
																	<div class="col-md-3">
																		<div class="form-group">
																			<label for="daysBetweenTwoSession"><span
																					class="mandatory">*</span>Avg days
																				between two sessions(Senior Executive)</label>
																			<form:input type="text" class="form-control"
																				id="daysBetweenTwoSession"
																				placeholder="Enter Avg Days"
																				path="daysBetweenTwoSession" />
																			<span class="error invalid-feedback"
																				id="daysBetweenTwoSessionError"></span>
																		</div>
																	</div>

                                                                  <div class="col-md-3">
																		<div class="form-group">
																			<label for="daysBetweenTwoSessionTopExe"><span
																					class="mandatory">*</span>Avg days
																				between two sessions(Top Executive)</label>
																			<form:input type="text" class="form-control"
																				id="daysBetweenTwoSessionTopExe"
																				placeholder="Enter Avg Days"
																				path="daysBetweenTwoSessionTopExe" />
																			<span class="error invalid-feedback"
																				id="daysBetweenTwoSessionError"></span>
																		</div>
																	</div>


																	<div class="col-md-2">
																		<div class="form-group">
																			<label for="batchDuration"><span
																					class="mandatory">*</span>Batch
																				Duration</label>
																			<form:input type="text" disabled="true"
																				class="form-control" id="batchDuration"
																				placeholder="Batch Duration"
																				path="batchDuration" />
																			<span class="error invalid-feedback"
																				id="batchDurationError"></span>
																		</div>
																	</div>

																	<div class="col-md-3"></div>
																	<div class="col-12 table-responsive tableDiv">
																		<table
																			class="table table-striped anand-table-font-size"
																			id="coachCoacheeTable">
																			<thead class="bg-table-head">
																				<tr>
																					<th>Action</th>
																					<th>Mentor/Coach</th>
																					<th>Mentee/Coachee</th>
																					<th>Program Category</th>
																					<th>Supervisor</th>
																				</tr>
																			</thead>
																			<tbody>
																				<tr class="coacheCoacheeMapTr0">
																					<td>
																						<form:hidden
																							path="coachCoacheeMappingList[0].actCoachCoacheeMapActive"
																							id="actCoachCoacheeMapActive0"
																							value="1" />
																						<a href="#"
																							title="Remove Coach-Coachee"
																							onclick="removeCoachCoacheeMapping(0);"><i
																								class="fas fa-times"></i></a>
																					</td>
																					<td>
																						<form:select
																							onchange="coachIdTempValidation('-',0)"
																							class="form-control"
																							path="coachCoacheeMappingList[0].coachIdTemp"
																							id="coachIdTemp0">
																							<form:option value="-1">
																								Select Mentor/Coach
																							</form:option>
																							<c:forEach
																								items="${coachList }"
																								var="coach"
																								varStatus="coachIndex">
																								<form:option
																									value="${coach.mUserId }">
																									${coach.userFirstName
																									}
																									${coach.userLastName
																									}</form:option>
																							</c:forEach>
																						</form:select>
																						<span
																							class="error invalid-feedback"
																							id="coachIdTempError0"></span>
																					</td>
																					<td>
																						<form:select
																							onchange="coacheeIdTempValidation('-',0)"
																							class="form-control"
																							path="coachCoacheeMappingList[0].coacheeIdTemp"
																							id="coacheeIdTemp0">
																							<form:option value="-1">
																								Select Mentee/Coachee
																							</form:option>
																							<c:forEach
																								items="${coacheeList }"
																								var="coachee"
																								varStatus="coacheeIndex">
																								<form:option
																									value="${coachee.mUserId }">
																									${coachee.userFirstName
																									}
																									${coachee.userLastName
																									}</form:option>
																							</c:forEach>
																						</form:select>
																						<span
																							class="error invalid-feedback"
																							id="coacheeIdTempError0"></span>
																					</td>
																					<td>
																						<form:select
																							onchange="actCoacheeProgramValidation('-',0)"
																							class="form-control"
																							path="coachCoacheeMappingList[0].actCoacheeProgram"
																							id="actCoacheeProgram0">
																							<form:option value="-1">
																								Select EMC Program
																							</form:option>
																							<form:option value="1">
																								Senior Executive
																								Coaching</form:option>
																							<form:option value="2">Top
																								Executive Mentoring
																							</form:option>
																							<!-- <form:option value="3">AL - ANAND Leader</form:option> -->
																						</form:select>
																						<span
																							class="error invalid-feedback"
																							id="actCoacheeProgramError0"></span>
																					</td>
																					<td>
																						<form:select
																							onchange="supervisorIdTempValidation('-',0)"
																							class="form-control"
																							path="coachCoacheeMappingList[0].supervisorIdTemp"
																							id="supervisorIdTemp0">
																							<form:option value="-1">
																								Select Supervisor
																							</form:option>
																							<c:forEach
																								items="${supervisorList }"
																								var="supervisor"
																								varStatus="supervisorIndex">
																								<form:option
																									value="${supervisor.mUserId }">
																									${supervisor.userFirstName
																									}
																									${supervisor.userLastName
																									}</form:option>
																							</c:forEach>
																						</form:select>
																						<span
																							class="error invalid-feedback"
																							id="supervisorIdTempError0"></span>
																					</td>
																				</tr>
																			</tbody>
																		</table>
																	</div>
																	<div>
																		<button title="Add Stakeholder"
																			style="float: left;" type="button"
																			id="addMoreCoachCoachee"
																			class="btn bg-color-anand-three text-blue pull-right"><i
																				class="fas fa-plus"></i>&nbsp;Add Stakeholder
																			</button>
																	</div>

																	<div class="col-md-3"></div>
																	<div class="col-12 table-responsive tableDiv">

																		<table
																			class="table table-striped anand-table-font-size"
																			id="questionTable">
																			<thead class="bg-table-head">
																				<tr>
																					<th>Action</th>
																					<th>Question</th>
																				</tr>
																			</thead>
																			<tbody id="questionTableBody">


																			</tbody>
																		</table>

																		<input type="hidden" id="questionsField"
																			name="questionsField">
																		<button title="Add Question"
																			style="float: left;" type="button"
																			onclick="addQuestionRow()"
																			class="btn bg-color-anand-three text-blue pull-right"><i
																				class="fas fa-plus"></i>&nbsp;Add
																			Question</button>

																		<!-- <button class="btn btn-primary mb-2" onclick="addQuestionRow()">Add Question Row</button> -->
																	</div>

																	<div class="col-md-3"></div>
																	<div class="col-12 table-responsive tableDiv">

																		<table
																			class="table table-striped anand-table-font-size"
																			id="questionTable">
																			<thead class="bg-table-head">
																				<tr>
																					<th>Action</th>
																					<th>Coach Question</th>
																				</tr>
																			</thead>
																			<tbody id="feedbackQuestionTableBody">
																				<!-- Dynamic rows go here -->
																			</tbody>
																		</table>

																		<button title="Add Question"
																			style="float: left;" type="button"
																			onclick="addfeedbackQuestionRow()"
																			class="btn bg-color-anand-three text-blue pull-right">
																			<i class="fas fa-plus"></i>&nbsp;Add Coach
																			Feedback
																			Question
																		</button>

																	</div>

																	<div class="col-md-3"></div>
																	<div class="col-12 table-responsive tableDiv">

																		<table
																			class="table table-striped anand-table-font-size"
																			id="questionTable">
																			<thead class="bg-table-head">
																				<tr>
																					<th>Action</th>
																					<th>Coachee Question</th>
																				</tr>
																			</thead>
																			<tbody
																				id="feedbackCoacheeQuestionTableBody">
																				<!-- Dynamic rows go here -->
																			</tbody>
																		</table>

																		<button title="Add Question"
																			style="float: left;" type="button"
																			onclick="addfeedbackCoacheeQuestionRow()"
																			class="btn bg-color-anand-three text-blue pull-right">
																			<i class="fas fa-plus"></i>&nbsp;Add Coachee
																			Feedback
																			Question
																		</button>

																	</div>
																	<div class="col-md-3"></div>
																	<div class="col-12 table-responsive tableDiv">

																		<table
																			class="table table-striped anand-table-font-size"
																			id="questionTable">
																			<thead class="bg-table-head">
																				<tr>
																					<th>Action</th>
																					<th>Mentor Question</th>
																				</tr>
																			</thead>
																			<tbody id="feedbackMentorQuestionTableBody">
																				<!-- Dynamic rows go here -->
																			</tbody>
																		</table>

																		<button title="Add Question"
																			style="float: left;" type="button"
																			onclick="addfeedbackMentorQuestionRow()"
																			class="btn bg-color-anand-three text-blue pull-right">
																			<i class="fas fa-plus"></i>&nbsp;Add Mentor
																			Feedback
																			Question
																		</button>

																	</div>


																	<div class="col-md-3"></div>
																	<div class="col-12 table-responsive tableDiv">

																		<table
																			class="table table-striped anand-table-font-size"
																			id="questionTable">
																			<thead class="bg-table-head">
																				<tr>
																					<th>Action</th>
																					<th>Mentee Question</th>
																				</tr>
																			</thead>
																			<tbody id="feedbackMenteeQuestionTableBody">
																				<!-- Dynamic rows go here -->
																			</tbody>
																		</table>

																		<button title="Add Question"
																			style="float: left;" type="button"
																			onclick="addfeedbackMenteeQuestionRow()"
																			class="btn bg-color-anand-three text-blue pull-right">
																			<i class="fas fa-plus"></i>&nbsp;Add Mentee
																			Feedback
																			Question
																		</button>

																	</div>



																</div>
																<div class="card-footer">
																	<!-- <button title="Add Coach-Coachee-Supervisor" style="float: left;" type="button" id="addMoreCoachCoachee" class="btn bg-color-anand-three text-white pull-right"><i class="fas fa-plus"></i>&nbsp;Add Coach-Coachee-Supervisor</button> -->
																	<button title="Submit Coaching Batch"
																		style="float: right;" title="Add Batch"
																		type="submit" id="submitBatchButton"
																		class="btn bg-1">Submit</button>
																</div>
															</div>

														</div>
													</form:form>
												</div>
												<!-- </div> -->
											</c:if>

											<div class="row">
												<div class="col-md-12">
													<div class="card card-secondary card-outline bg-card-primary-anand">
														<div class="card-header bg-3">
															<h5 class="card-title font-weight-bold">List of all
																Mentoring
																Batches</h5>
														</div>
														<div class="card-body">
															<div class="row">
																<div class="col-md-12 tableOverFlowDiv">
																	<table
																		class="table table-bordered dataTable anand-table-font-size"
																		id="batchTable">
																		<thead>
																			<tr class="bg-table-head">
																				<th>Action</th>
																				<th>Batch Name</th>
																				<th>Batch Description</th>
																				<th>Status</th>
																				<th>Start Date</th>
																				<th>End Date</th>
																				<th>Total Participants</th>
																				<th>Senior Executive Coaching</th>
																				<th>Top Executive Mentoring</th>
																				<!-- <th>ANAND Mentee</th>  -->
																				<th>Created By &amp; On</th>
																				<th>Updated By &amp; On</th>
																			</tr>
																		</thead>
																		<tbody>
																			<c:forEach items="${batchList }" var="batch"
																				varStatus="batchLoop">
																				<tr
																					class="bg-table-row-${batchLoop.index %2 }">
																					<td>${batch.actionForList }</td>
																					<td>${batch.batchName }</td>
																					<td>${batch.batchDescription }</td>
																					<td>
																						<c:choose>
																							<c:when
																								test="${batch.batchActive == 1}">
																								Active
																							</c:when>
																							<c:otherwise>
																								Inactive
																							</c:otherwise>
																						</c:choose>
																					</td>

																					<td>
																						<fmt:formatDate
																							pattern="dd-MMM-yyyy"
																							value="${batch.batchStartDate }" />
																					</td>
																					<td>
																						<fmt:formatDate
																							pattern="dd-MMM-yyyy"
																							value="${batch.batchEndDate }" />
																					</td>
																					<td><span
																							class="badge sequence-bg-5">${batch.totalParticipants
																							}</span></td>
																					<td><span
																							class="badge bg-1">${batch.anandLeaderCount
																							}</span></td>
																					<td><span
																							class="badge bg-2">${batch.anandTalentCount
																							}</span></td>

																					<td>
																						${batch.mUserId.userFirstName }
																						${batch.mUserId.userLastName
																						}<br>
																						<fmt:formatDate
																							pattern="dd-MMM-yyyy"
																							value="${batch.createdOn }" />
																					</td>
																					<td>
																						${batch.mUserIdUpdated.userFirstName
																						}
																						${batch.mUserIdUpdated.userLastName
																						}<br>
																						<fmt:formatDate
																							pattern="dd-MMM-yyyy"
																							value="${batch.updatedOn }" />
																					</td>
																				</tr>
																			</c:forEach>
																		</tbody>
																		<tfoot>
																			<tr class="bg-table-foot">
																				<th>Action</th>
																				<th>Batch Name</th>
																				<th>Batch Description</th>
																				<th>Status</th>
																				<th>Start Date</th>
																				<th>End Date</th>
																				<th>Total Participants</th>
																				<th>Senior Executive Coaching</th>
																				<th>Top Executive Mentoring</th>
																				<!-- <th>ANAND Leader</th>
		                      <th>ANAND Talent</th>
		                      <th>ANAND Mentee</th> -->
																				<th>Created By</th>
																				<th>Updated By</th>
																			</tr>
																		</tfoot>
																	</table>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>

											<div class="row editCoachingBatch">
												<div class="col-md-12">


													<form:form modelAttribute="actCoachingBatch"
														action="emc-coaching-batch" id="actCoachingBatchEdit"
														method="post">





														<form:hidden path="actCoachingBatchId"
															id="actCoachingBatchId" />

														<form:input path="questionTexts" type="hidden"
															id="questionsField" name="questionTexts" />





														<!-- <input type="hidden" id="batchId" value="" /> -->
														<input type="hidden" id="coachId" value="" />
														<input type="hidden" id="coacheeId" value="" />
														<input type="hidden" id="actCoacheeProgram" value="" />



														<div
															class="card card-primary card-outline bg-card-primary-anand">
															<div class="card-header" data-card-widget="collapse">
																<h5 class="card-title">Edit EMC Batch</h5>
																<div class="card-tools">
																	<button type="button" class="btn btn-tool"
																		data-card-widget="collapse">
																		<i class="fas fa-minus"></i>
																	</button>
																</div>
															</div>
															<div class="card-body" style="display: block;">
																<div class="row">

																	<c:if test="${not empty regMsgEdit }">
																		<div class="col-md-12">
																			<div
																				class="alert bg-info-anand-${cssEdit } alert-dismissible">
																				<button type="button"
																					title="CLose Alert Box"
																					class="close" data-dismiss="alert"
																					aria-hidden="true"><i
																						class="fas fa-times"></i></button>
																				<c:if test="${css eq 'danger'}">
																					<h5><i
																							class="icon fas fa-ban"></i>${regMsgEdit
																						}</h5>
																				</c:if>
																				<c:if test="${css ne 'danger'}">
																					<h5><i
																							class="icon fas fa-check"></i>${regMsgEdit
																						}</h5>
																				</c:if>
																			</div>
																		</div>
																	</c:if>

																	<div class="col-md-4">
																		<div class="form-group">
																			<label for="batchNameEdit"><span
																					class="mandatory">*</span>Batch
																				Name</label>
																			<form:input type="text" class="form-control"
																				id="batchNameEdit"
																				placeholder="Enter Batch Name"
																				path="batchName" />
																			<span class="error invalid-feedback"
																				id="batchNameErrorEdit"></span>
																		</div>
																	</div>
																	<div class="col-md-8">
																		<div class="form-group">
																			<label for="batchDescriptionEdit"><span
																					class="mandatory">*</span>Batch
																				Description</label>
																			<form:input type="text" class="form-control"
																				id="batchDescriptionEdit"
																				placeholder="Enter Batch Description"
																				path="batchDescription" />
																			<span class="error invalid-feedback"
																				id="batchDescriptionErrorEdit"></span>
																		</div>
																	</div>
																	<div class="col-md-3">
																		<div class="form-group">
																			<label><span class="mandatory">*</span>Batch
																				Start Date</label>
																			<div class="input-group">
																				<div class="input-group-prepend">
																					<span class="input-group-text">
																						<i
																							class="far fa-calendar-alt"></i>
																					</span>
																				</div>
																				<form:input path="startDateTemp"
																					id="startDateTempEdit" type="text"
																					class="form-control float-right"
																					title="Estimated Start Date" />
																				<span class="error invalid-feedback"
																					id="startDateTempErrorEdit"></span>
																			</div>
																		</div>
																	</div>
																	<div class="col-md-3">
																		<div class="form-group">
																			<label><span class="mandatory">*</span>Batch
																				End
																				Date</label>
																			<div class="input-group">
																				<div class="input-group-prepend">
																					<span class="input-group-text">
																						<i
																							class="far fa-calendar-alt"></i>
																					</span>
																				</div>
																				<form:input path="endDateTemp"
																					id="endDateTempEdit" type="text"
																					class="form-control float-right"
																					title="Estimated End Date" />
																				<span class="error invalid-feedback"
																					id="endDateTempErrorEdit"></span>
																			</div>
																		</div>
																	</div>
																	<div class="col-md-3">
																		<div class="form-check" id="isActiveEditDiv">
																			<label><span class="mandatory">*</span>Batch
																				Active/InActive</label>
																			<div class="custom-control custom-radio">
																				<form:radiobutton path="batchActive"
																					class="custom-control-input"
																					value="1" id="batchActiveEdit1"
																					name="batchActive" />
																				<label for="batchActiveEdit1"
																					class="custom-control-label text-green">Active</label>
																			</div>
																			<div class="custom-control custom-radio">
																				<form:radiobutton path="batchActive"
																					class="custom-control-input"
																					value="0" id="batchActiveEdit2"
																					name="batchActive" />
																				<label for="batchActiveEdit2"
																					class="custom-control-label text-red">Inactive</label>
																			</div>
																			<span class="error invalid-feedback"
																				id="isActiveEditError"
																				style="display:block"></span>
																		</div>
																	</div>
																	<div class="col-md-3">

																		<div class="form-group">
																			<label for="daysBetweenTwoSession"><span
																					class="mandatory">*</span>Avg days
																				between two sessions(Senior Executive)</label>
																			<form:input type="text" class="form-control"
																				id="daysBetweenTwoSessionEdit"
																				placeholder="Enter Avg Days"
																				path="daysBetweenTwoSession" />
																			<span class="error invalid-feedback"
																				id="daysBetweenTwoSessionError"></span>
																		</div>
																	</div>

																	<div class="col-md-3">

																		<div class="form-group">
																			<label for="daysBetweenTwoSessionTopExe"><span
																					class="mandatory">*</span>Avg days
																				between two sessions(Top Executive)</label>
																			<form:input type="text" class="form-control"
																				id="daysBetweenTwoSessionTopExeEdit"
																				placeholder="Enter Avg Days"
																				path="daysBetweenTwoSessionTopExe" />
																			<span class="error invalid-feedback"
																				id="daysBetweenTwoSessionError"></span>
																		</div>
																	</div>
																	<div class="col-md-2">
																		<div class="form-group">
																			<label for="batchDuration"><span
																					class="mandatory">*</span>Batch
																				Duration</label>
																			<form:input type="text" disabled="true"
																				class="form-control"
																				id="batchDurationEdit"
																				placeholder="Batch Duration"
																				path="batchDuration" />
																			<span class="error invalid-feedback"
																				id="batchDurationError"></span>
																		</div>
																	</div>
																	<div class="col-md-12">
																		<table
																			class="table table-striped anand-table-font-size"
																			id="coachCoacheeTableEdit">
																			<thead class="bg-table-head">
																				<tr>
																					<th>Action</th>
																					<th>Mentor/Coach</th>
																					<th>Mentee/Coachee</th>
																					<th>Program Category</th>
																					<th>Supervisor</th>
																				</tr>
																			</thead>
																			<tbody>
																				<tr></tr>

																			</tbody>
																		</table>
																	</div>
																	<div>
																		<!-- <button title="Add Coach-Coachee-Supervisor" style="float: left;" type="button" id="addMoreCoachCoachee" class="btn bg-color-anand-three text-blue pull-right"><i class="fas fa-plus"></i>&nbsp;Add Coach-Coachee-Supervisor</button> -->
																		<button title="Add Mentor-Mentee-Supervisor"
																			style="float: left;" type="button"
																			id="editMoreCoachCoachee"
																			class="btn bg-color-anand-three text-blue pull-right"><i
																				class="fas fa-plus"></i>&nbsp;Add
																			Stakeholder</button>
																	</div>
																	<div class="col-md-12 mt-3">

																		<table
																			class="table table-bordered anand-table-font-size"
																			id="questionTableEdit">
																			<thead class="bg-table-head">
																				<tr>
																					<th>Action</th>
																					<th>Question</th>
																				</tr>
																			</thead>
																			<tbody>

																				<c:forEach var="question"
																					items="${actCoachingBatch.questionTexts}"
																					varStatus="status">
																					<tr
																						id="questionRow-${status.index}">
																						<td>
																							<button type="button"
																								class="btn btn-danger btn-sm"
																								onclick="removeQuestionRows('${status.index}', '${fn:escapeXml(question)}')">
																								<i
																									class="fas fa-trash"></i>
																							</button>

																						</td>
																						<td>
																							<input type="text"
																								name="questionTexts[${status.index}]"
																								value="${question}"
																								class="form-control mb-2" />
																						</td>
																					</tr>
																				</c:forEach>

																			</tbody>
																		</table>
																		<button title="Add Question"
																			style="float: left;" type="button"
																			onclick="addQuestionRows()"
																			class="btn bg-color-anand-three text-blue pull-right"><i
																				class="fas fa-plus"></i>&nbsp;Add
																			Question</button>

																		<!-- <button type="button" onclick="addQuestionRows()">Add Question</button> -->
																		<div>
																			<!-- <button title="Add Coach-Coachee-Supervisor" style="float: left;" type="button" id="addMoreCoachCoachee" class="btn bg-color-anand-three text-blue pull-right"><i class="fas fa-plus"></i>&nbsp;Add Coach-Coachee-Supervisor</button> -->
																			<!-- <button title="Add Feedback Questions" style="float: left;" type="button" id="editMoreCoachCoachee" class="btn bg-color-anand-three text-blue pull-right"><i class="fas fa-plus"></i>&nbsp;Add Feedback Question</button> -->
																		</div>

																	</div>

																	<!-- Feedback Questions Table -->


																	<div class="col-md-3"></div>
																	<div class="col-12 table-responsive tableDiv">

																		<table
																			class="table table-striped anand-table-font-size"
																			id="questionTable">
																			<thead class="bg-table-head">
																				<tr>
																					<th>Action</th>
																					<th>Coach Question</th>
																				</tr>
																			</thead>
																			<tbody id="editfeedbackQuestionTableBody">
																				<!-- Dynamic rows go here -->
																			</tbody>
																		</table>

																		<button title="Add Question"
																			style="float: left;" type="button"
																			onclick="addEditfeedbackQuestionRow()"
																			class="btn bg-color-anand-three text-blue pull-right">
																			<i class="fas fa-plus"></i>&nbsp;Add Coach
																			Feedback
																			Question
																		</button>

																	</div>

																	<div class="col-md-3"></div>
																	<div class="col-12 table-responsive tableDiv">

																		<table
																			class="table table-striped anand-table-font-size"
																			id="questionTable">
																			<thead class="bg-table-head">
																				<tr>
																					<th>Action</th>
																					<th>Coachee Question</th>
																				</tr>
																				
																			</thead>
																			<tbody
																				id="editfeedbackCoacheeQuestionTableBody">
																				<!-- Dynamic rows go here -->
																			</tbody>
																		</table>

																		<button title="Add Question"
																			style="float: left;" type="button"
																			onclick="addEditfeedbackCoacheeQuestionRow()"
																			class="btn bg-color-anand-three text-blue pull-right">
																			<i class="fas fa-plus"></i>&nbsp;Add Coachee
																			Feedback
																			Question
																		</button>

																	</div>
																	<div class="col-md-3"></div>
																	<div class="col-12 table-responsive tableDiv">

																		<table
																			class="table table-striped anand-table-font-size"
																			id="questionTable">
																			<thead class="bg-table-head">
																				<tr>
																					<th>Action</th>
																					<th>Mentor Question</th>
																				</tr>
																			</thead>
																			<tbody
																				id="editfeedbackMentorQuestionTableBody">
																				<!-- Dynamic rows go here -->
																			</tbody>
																		</table>

																		<button title="Add Question"
																			style="float: left;" type="button"
																			onclick="addEditfeedbackMentorQuestionRow()"
																			class="btn bg-color-anand-three text-blue pull-right">
																			<i class="fas fa-plus"></i>&nbsp;Add Mentor
																			Feedback
																			Question
																		</button>

																	</div>


																	<div class="col-md-3"></div>
																	<div class="col-12 table-responsive tableDiv">

																		<table
																			class="table table-striped anand-table-font-size"
																			id="questionTable">
																			<thead class="bg-table-head">
																				<tr>
																					<th>Action</th>
																					<th>Mentee Question</th>
																				</tr>
																			</thead>
																			<tbody
																				id="editfeedbackMenteeQuestionTableBody">
																				<!-- Dynamic rows go here -->
																			</tbody>
																		</table>

																		<button title="Add Question"
																			style="float: left;" type="button"
																			onclick="addEditfeedbackMenteeQuestionRow()"
																			class="btn bg-color-anand-three text-blue pull-right">
																			<i class="fas fa-plus"></i>&nbsp;Add Mentee
																			Feedback
																			Question
																		</button>

																	</div>

																</div>
															</div>

														</div>
												</div>
												<div class="card-footer" style="display: block;">

													<button type="submit" id="saveBatchChanges" style="float: right;"
														class="btn bg-1" title="Save Batch Changes">Save Batch
														Changes</button>
												</div>
											</div>
											</form:form>
										</div>
								</div>

					</div>
					</section>



					<div class="modal fade" id="batchInfoModal">
						<div class="modal-dialog modal-xl">
							<div class="modal-content">
								<div class="modal-header bg-secondary">
									<h4 class="modal-title">EMC Batch Information</h4>
								</div>
								<div class="modal-body">
									<div class="row">
										<div class="col-md-12">
											<div class="card-body">
												<div class="row">
													<div class="col-md-4">
														<div class="form-group">
															<label for="batchNameInfo">Batch Name</label>
															<p id="batchNameInfo"></p>
														</div>
													</div>
													<div class="col-md-8">
														<div class="form-group">
															<label for="batchDescriptionInfo">Batch Description</label>
															<p id="batchDescriptionInfo"></p>
														</div>
													</div>
													<div class="col-md-4">
														<div class="form-group">
															<label for="batchStartDateInfo">Batch Start Date</label>
															<p id="batchStartDateInfo"></p>
														</div>
													</div>
													<div class="col-md-4">
														<div class="form-group">
															<label for="batchEndDateInfo">Batch End Date</label>
															<p id="batchEndDateInfo"></p>
														</div>
													</div>
													<div class="col-md-4">
														<div class="form-group">
															<label for="batchActiveInfo">Batch Active/In-Active</label>
															<p id="batchActiveInfo"></p>
														</div>
													</div>
													<div class="col-md-12">
														<table class="table table-striped anand-table-font-size"
															id="coachCoacheeTableInfo">
															<thead class="bg-table-head">
																<tr>
																	<th>Mentor/Coach</th>
																	<th>Mentee/Coachee</th>
																	<th>Program Category</th>
																	<th>Supervisor</th>
																</tr>
															</thead>
															<tbody>
															</tbody>
														</table>
													</div>

													<div class="col-md-12 mt-3">

														<table class="table table-striped anand-table-font-size"
															id="questionTableEdit">
															<thead class="bg-table-head">
																<tr>

																	<th>Coaching Observations</th>
																</tr>
															</thead>
															<tbody>


															</tbody>
														</table>


													</div>
													<!-- <div class="col-md-3"></div>
																	<div class="col-12 table-responsive tableDiv">

																		<table
																			class="table table-striped anand-table-font-size"
																			id="coachQuestionTable">
																			<thead class="bg-table-head">
																				<tr>
																					
																					<th>Coach Question</th>
																				</tr>
																			</thead>
																			<tbody id="editfeedbackQuestionTableBody">
																			</tbody>
																		</table>

																	

																	</div>

																	<div class="col-md-3"></div>
																	<div class="col-12 table-responsive tableDiv">

																		<table
																			class="table table-striped anand-table-font-size"
																			id="coacheeQuestionTable">
																			<thead class="bg-table-head">
																				<tr>
																				
																					<th>Coachee Question</th>
																				</tr>
																			</thead>
																			<tbody
																				id="editfeedbackCoacheeQuestionTableBody">
																				
																			</tbody>
																		</table>


																	</div>
																	<div class="col-md-3"></div>
																	<div class="col-12 table-responsive tableDiv">

																		<table
																			class="table table-striped anand-table-font-size"
																			id="mentorQuestionTable">
																			<thead class="bg-table-head">
																				<tr>
																					
																					<th>Mentor Question</th>
																				</tr>
																			</thead>
																			<tbody
																				id="editfeedbackMentorQuestionTableBody">
																			</tbody>
																		</table>

																		

																	</div>


																	<div class="col-md-3"></div>
																	<div class="col-12 table-responsive tableDiv">

																		<table
																			class="table table-striped anand-table-font-size"
																			id="menteeQuestionTable">
																			<thead class="bg-table-head">
																				<tr>
																					
																					<th>Mentee Question</th>
																				</tr>
																			</thead>
																			<tbody
																				id="editfeedbackMenteeQuestionTableBody">
																				
																			</tbody>
																		</table>

																		


												</div> -->
											</div>
										</div>
									</div>
								</div>
								<div class="modal-footer justify-content-between">
									<button onclick="" id="closeEditRoleModal" type="button" class="btn bg-3"
										data-dismiss="modal">Close</button>
								</div>
							</div>
						</div>
					</div>



					</div>
					<%@include file="../includeJSP/footer.jsp" %>
						</div>
						<%@include file="../../includeJSP/jsFiles.jsp" %>
							<%@include file="../../includeJSP/dataTablesImport.jsp" %>
								<%@include file="../../includeJSP/datePickerJs.jsp" %>
									<script
										src="usedStaticFiles/essentials/js/jsp_js_files/emc/coachingBatch/coachingBatch.js"></script>


									<script>

										document.getElementById("saveBatchChanges").addEventListener("click", function () {
											prepareEditFeedbackQuestionsForSubmit();
										});

									</script>

									<script>

										document.addEventListener("DOMContentLoaded", function () {
											// Bind to the form submit event
											document.getElementById("actCoachingBatchEdit").addEventListener("submit", function (event) {
												prepareEditFeedbackQuestionsForSubmit(); // Fill hidden fields with dynamic table inputs
											});
										});
									</script>
				</body>

				</html>
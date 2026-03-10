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
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>MENTORING BATCH DETAILS | EMC<%@include file="../../includeJSP/company_name_title.jsp"%></title>
    <%@include file="../../includeJSP/cssFiles.jsp"%>
    <%@include file="../../includeJSP/datePickerCss.jsp"%>
  </head>
  <body class="sidebar-mini layout-navbar-fixed sidebar-collapse pace-primary">
    <div class="wrapper">
      <%@include file="../includeJSP/header.jsp"%>
      <%@include file="../includeJSP/leftSideBar.jsp"%>
      <div class="content-wrapper">
        
        <section class="content-header">
          <div class="container-fluid">
            <div class="row mb-2">
              <div class="col-sm-6">
                <h5 class="font-3 font-weight-bold">MENTORING BATCH DETAILS</h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item"><a href="dashboard-act" title="Dashboard"><strong>Dashboard</strong></a></li>
                  <li class="breadcrumb-item active"><strong>Mentoring Batch Details</strong></li>
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
		        <div class="card card-secondary card-outline bg-card-primary-anand">
		          <div class="card-header bg-3">
		            <h5 class="card-title font-weight-bold">List of all Mentoring Batches &amp; Details</h5>
		          </div>
		          <div class="card-body">
		            <div class="row">
		              <div class="col-md-12">
		                <table class="table table-bordered dataTable anand-table-font-size" id="batchTable">
		                  <thead>
		                    <tr class="bg-table-head">
		                      <th>Action</th>
		                      <th>Batch Name</th>
		                      <th>Batch Description</th>
		                      <th>Start Date</th>
		                      <th>End Date</th>
		                      <c:if test="${itAdmin eq 1 || emcAdmin eq 1 }">
		                        <th>Total Participants</th>
		                        <!-- <th>ANAND Leader</th>
		                        <th>ANAND Talent</th>
		                        <th>ANAND Mentee</th> -->
		                      </c:if>
		                    </tr>
		                  </thead>
		                  <tbody>
		                    <c:forEach items="${batchList }" var="batch" varStatus="batchLoop">
		                      <tr class="bg-table-row-${batchLoop.index %2 }">
		                        <td>${batch.actionForList }</td>
		                        <td>${batch.batchName }</td>
		                        <td>${batch.batchDescription }</td>
		                        <td><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${batch.batchStartDate }" /></td>
		                        <td><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${batch.batchEndDate }" /></td>
		                        <c:if test="${itAdmin eq 1 || emcAdmin eq 1 }">
		                          <td><span class="badge sequence-bg-5" style='font-size:18px'>${batch.totalParticipants }</span></td>
		                          <!-- <td><span class="badge bg-1" style='font-size:18px'>${batch.anandLeaderCount }</span></td>
		                          <td><span class="badge bg-2" style='font-size:18px'>${batch.anandTalentCount }</span></td>
		                          <td><span class="badge bg-3" style='font-size:18px'>${batch.anandMenteeCount }</span></td> -->
		                        </c:if>
		                      </tr>
		                    </c:forEach>
		                  </tbody>
		                  <tfoot>
		                    <tr class="bg-table-foot">
		                      <th>Action</th>
		                      <th>Batch Name</th>
		                      <th>Batch Description</th>
		                      <th>Start Date</th>
		                      <th>End Date</th>
		                      <c:if test="${itAdmin eq 1 }">
		                        <th>Total Participants</th>
		                        <!-- <th>ANAND Leader</th>
		                        <th>ANAND Talent</th>
		                        <th>ANAND Mentee</th> -->
		                      </c:if>
		                    </tr>
		                  </tfoot>
		                </table>
		              </div>
		            </div>
		          </div>
		        </div>
		      </div>
		    </div>
		 

			<div class="row editCoachingBatch" style="display: none;">

			<div class="col-md-12">
			  <form:form modelAttribute="actCoachingBatch" action="emc-coaching-batch" id="actCoachingBatchEdit" method="post">
			  <form:hidden path="actCoachingBatchId" id="actCoachingBatchId" />
			  <div class="card card-primary card-outline collapsed-card bg-card-primary-anand">
				<div class="card-header" data-card-widget="collapse">
				  <h5 class="card-title">Edit EMC Mentoring Batch</h5>
				  <div class="card-tools">
					<button type="button" class="btn btn-tool" data-card-widget="collapse">
					  <i class="fas fa-minus"></i>
					</button>
				  </div>
				</div>
				<div class="card-body" style="display: block;">
				  <div class="row">

					<c:if test="${not empty regMsgEdit }">
					  <div class="col-md-12">
						<div class="alert bg-info-anand-${cssEdit } alert-dismissible">
						  <button type="button" title="CLose Alert Box" class="close" data-dismiss="alert" aria-hidden="true"><i class="fas fa-times"></i></button>
						  <c:if test="${css eq 'danger'}">
							<h5><i class="icon fas fa-ban"></i>${regMsgEdit }</h5>
						  </c:if>
						  <c:if test="${css ne 'danger'}">
							<h5><i class="icon fas fa-check"></i>${regMsgEdit }</h5>
						  </c:if>
						</div>
					  </div>
					</c:if>

					<div class="col-md-4">
					  <div class="form-group">
						<label for="batchNameEdit"><span class="mandatory">*</span>Batch Name</label>
						<form:input type="text" class="form-control" id="batchNameEdit" placeholder="Enter Batch Name" path="batchName" />
						<span class="error invalid-feedback" id="batchNameErrorEdit"></span>
					  </div>
					</div>
					<div class="col-md-8">
					  <div class="form-group">
						<label for="batchDescriptionEdit"><span class="mandatory">*</span>Batch Description</label>
						<form:input type="text" class="form-control" id="batchDescriptionEdit" placeholder="Enter Batch Description" path="batchDescription" />
						<span class="error invalid-feedback" id="batchDescriptionErrorEdit"></span>
					  </div>
					</div>
					<div class="col-md-3">
					  <div class="form-group">
						<label><span class="mandatory">*</span>Batch Start Date</label>
						<div class="input-group">
						  <div class="input-group-prepend">
							<span class="input-group-text">
							  <i class="far fa-calendar-alt"></i>
							</span>
						  </div>
						  <form:input path="startDateTemp" id="startDateTempEdit" type="text" class="form-control float-right" title="Estimated Start Date" />
						  <span class="error invalid-feedback" id="startDateTempErrorEdit"></span>
						</div>
					  </div>
					</div>
					<div class="col-md-3">
					  <div class="form-group">
						<label><span class="mandatory">*</span>Batch End Date</label>
						<div class="input-group">
						  <div class="input-group-prepend">
							<span class="input-group-text">
							  <i class="far fa-calendar-alt"></i>
							</span>
						  </div>
						  <form:input path="endDateTemp" id="endDateTempEdit" type="text" class="form-control float-right" title="Estimated End Date" />
						  <span class="error invalid-feedback" id="endDateTempErrorEdit"></span>
						</div>
					  </div>
					</div>
					<!-- <div class="col-md-3">
					  <div class="form-check" id="isActiveEditDiv">
						<label><span class="mandatory">*</span>Batch Active/InActive</label>
						<div class="custom-control custom-radio">
						  <form:radiobutton path="batchActive" class="custom-control-input" value="1" id="batchActiveEdit1" name="batchActive" />
						  <label for="batchActiveEdit1" class="custom-control-label text-green">Active</label>
						</div>
						<div class="custom-control custom-radio">
						  <form:radiobutton path="batchActive" class="custom-control-input" value="0" id="batchActiveEdit2" name="batchActive" />
						  <label for="batchActiveEdit2" class="custom-control-label text-red">Inactive</label>
						</div>
						<span class="error invalid-feedback" id="isActiveEditError" style="display:block" ></span> 
					  </div>
					</div> -->
					<!-- <div class="col-md-3">
				  
					  <div class="form-group">
						<label for="daysBetweenTwoSession"><span class="mandatory">*</span>Avg days between two sessions</label>
						<form:input type="text" class="form-control" id="daysBetweenTwoSessionEdit" placeholder="Enter Avg Days" path="daysBetweenTwoSession" />
						<span class="error invalid-feedback" id="daysBetweenTwoSessionError"></span>
					  </div>
					</div> -->
					<!-- <div class="col-md-2">
					  <div class="form-group">
						<label for="batchDuration"><span class="mandatory">*</span>Batch Duration</label>
						<form:input type="text" disabled="true" class="form-control" id="batchDurationEdit" placeholder="Batch Duration" path="batchDuration" />
						<span class="error invalid-feedback" id="batchDurationError"></span>
					  </div>
					</div> -->
					<!-- <div class="col-md-12">
					  <table class="table table-striped anand-table-font-size" id="coachCoacheeTableEdit">
						<thead class="bg-table-head">
						  <tr>
							<th>Action</th>
							<th>Coach</th>
							<th>Coachee</th>
							
							<th>Supervisor</th>
						  </tr>
						</thead>
						<tbody>
						</tbody>
					  </table>
					</div> -->
				  </div>
				</div>
				<div class="card-footer" style="display: block;">
				  <button title="Add Mentor-Mentee-Supervisor" style="float: left;" type="button" id="editMoreCoachCoachee" class="btn bg-color-anand-three text-white pull-right"><i class="fas fa-plus"></i>&nbsp;Add Stakeholder</button>
				  <button type="submit" id="saveBatchChanges" style="float: right;" class="btn bg-color-anand-two text-white" title="Save Batch Changes">Save Batch Changes</button>
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
		                  <table class="table table-striped anand-table-font-size" id="coachCoacheeTableInfo">
		                    <thead class="bg-table-head">
		                      <tr>
		                        <th>Mentor/Coach</th>
		                        <th>Mentee/Coachee</th>
		                        <!-- <th>ALDP Program</th> -->
		                        <th>Supervisor</th>
		                      </tr>
		                    </thead>
		                    <tbody>
		                    </tbody>
		                  </table>
		                </div>
						<div class="col-md-12 mt-3">
						
							<table class="table table-striped anand-table-font-size" id="questionTableEdit">
								<thead class="bg-table-head">
								  <tr>
								
									<th>Coach Observations</th>
								  </tr>
								</thead>
								<tbody>
								
									
								</tbody>
							  </table>
	
							  
						  </div>
						                                          <div class="col-md-3"></div>
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
																				<!-- Dynamic rows go here -->
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
																				<!-- Dynamic rows go here -->
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
																				<!-- Dynamic rows go here -->
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
																				<!-- Dynamic rows go here -->
																			</tbody>
																		</table>

																		


												</div>
						
		              </div>
		            </div>
		          </div>
		        </div>
		      </div>
		      <div class="modal-footer justify-content-between">
		        <button onclick="" id="closeEditRoleModal" type="button" class="btn bg-3" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		  </div>
		</div>
		
		
		
      </div>
      <%@include file="../includeJSP/footer.jsp"%>
    </div>
    <%@include file="../../includeJSP/jsFiles.jsp"%>
    <%@include file="../../includeJSP/dataTablesImport.jsp"%>
    <%@include file="../../includeJSP/datePickerJs.jsp"%>
	
     <script src="usedStaticFiles/essentials/js/jsp_js_files/emc/coachingBatchDetails/coachingBatchDetails.js"></script> 
	<!-- <script src="usedStaticFiles/essentials/js/jsp_js_files/emc/coachingBatchDetails/coachingBatchDetails.js"></script> -->
  </body>
</html>
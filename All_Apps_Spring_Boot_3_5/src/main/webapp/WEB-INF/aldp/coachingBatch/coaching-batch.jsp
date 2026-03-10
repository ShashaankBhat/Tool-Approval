<!-- ****************************************************************************************
# *******************************************************************************************
# Copyright © 2021 Anand Group India. All rights reserved.									*
# No part of this product may be reproduced in any form by any means without prior			*
# written authorization of Anand Automotive Private Limited and its licensors, if any.		*
# *******************************************************************************************
# Author - Sheshadhri Iyer																	*
# *************************************************************************************** -->
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>COACHING BATCH | ACT<%@include file="../../includeJSP/company_name_title.jsp"%></title>
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
                <h5 class="font-3 font-weight-bold">COACHING BATCH</h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item"><a href="dashboard-act" title="Dashboard"><strong>Dashboard</strong></a></li>
                  <li class="breadcrumb-item active"><strong>Coaching Batch</strong></li>
                </ol>
              </div>
            </div>
          </div>
        </section>
        
        <c:if test="${not empty regMsg }">
          <section class="content content-margin">
            <div class="container-fluid">
              <div class="alert ${css } alert-dismissible">
                <button type="button" title="CLose Alert Box" class="close" data-dismiss="alert" aria-hidden="true">
                  <i class="fas fa-times"></i>
                </button>
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
		    
		    <c:if test="${itAdmin eq 1 || ctAdmin eq 1 }">
		    <div class="row">
		      
		      
		      <div class="col-12" style="display: none;">
		        <c:set var="coachListString" value="" />
		        <c:forEach items="${coachList }" var="coach" varStatus="coachIndex">
		          <c:choose>
		            <c:when test="${not empty coachListString }">
		              <c:set var="coachListString" value="${coachListString }||${coach.mUserId }!!${coach.userFirstName } ${coach.userLastName }" />
		            </c:when>
		            <c:when test="${empty coachListString }">
		              <c:set var="coachListString" value="${coach.mUserId }!!${coach.userFirstName } ${coach.userLastName }" />
		            </c:when>
		          </c:choose>
		        </c:forEach>
		        <input type="hidden" id="coachStringForJs" value="${coachListString }" />
		        
		        <c:set var="coacheeListString" value="" />
		        <c:forEach items="${coacheeList }" var="coachee" varStatus="coacheeIndex">
		          <c:choose>
		            <c:when test="${not empty coacheeListString }">
		              <c:set var="coacheeListString" value="${coacheeListString }||${coachee.mUserId }!!${coachee.userFirstName } ${coachee.userLastName }" />
		            </c:when>
		            <c:when test="${empty coacheeListString }">
		              <c:set var="coacheeListString" value="${coachee.mUserId }!!${coachee.userFirstName } ${coachee.userLastName }" />
		            </c:when>
		          </c:choose>
		        </c:forEach>
		        <input type="hidden" id="coacheeStringForJs" value="${coacheeListString }" />
		        
		        <c:set var="supervisorListString" value="" />
		        <c:forEach items="${supervisorList }" var="supervisor" varStatus="supervisorIndex">
		          <c:choose>
		            <c:when test="${not empty supervisorListString }">
		              <c:set var="supervisorListString" value="${supervisorListString }||${supervisor.mUserId }!!${supervisor.userFirstName } ${supervisor.userLastName }" />
		            </c:when>
		            <c:when test="${empty supervisorListString }">
		              <c:set var="supervisorListString" value="${supervisor.mUserId }!!${supervisor.userFirstName } ${supervisor.userLastName }" />
		            </c:when>
		          </c:choose>
		        </c:forEach>
		        <input type="hidden" id="supervisorStringForJs" value="${supervisorListString }" />
		      </div>
		      
		      
		      <div class="col-md-12">
		        <form modelAttribute="actCoachingBatch" action="coaching-batch" id="actCoachingBatch" method="post">
		        <div class="card card-outline collapsed-card">
		          <div class="card-header bg-1" data-card-widget="collapse">
		            <h5 class="card-title font-weight-bold">Add ACT Coaching Batch</h5>
		            <div class="card-tools">
		              <button type="button" class="btn btn-tool text-white " data-card-widget="collapse">
		                <i class="fas fa-plus"></i>
		              </button>
		              <input type="hidden" value="${openAddModal }" id="openAddModel" />
		              <input type="hidden" value="${openEditModel }" id="openEditModel" />
		            </div>
		          </div>
		          <div class="card-body" style="display: none;">
		            <div class="row">
		              <div class="col-md-4">
		                <div class="form-group">
		                  <label for="batchName"><span class="mandatory">*</span>Batch Name</label>
		                  <input type="text" class="form-control" id="batchName" placeholder="Enter Batch Name" name="batchName" />
		                  <span class="error invalid-feedback" id="batchNameError"></span>
		                </div>
		              </div>
		              <div class="col-md-8">
		                <div class="form-group">
		                  <label for="batchDescription"><span class="mandatory">*</span>Batch Description</label>
		                  <input type="text" class="form-control" id="batchDescription" placeholder="Enter Batch Description" name="batchDescription" />
		                  <span class="error invalid-feedback" id="batchDescriptionError"></span>
		                </div>
		              </div>
		              <div class="col-md-2">
		                <%-- <div class="form-group">
		                  <label><span class="mandatory">*</span>Batch Start Date</label>
		                  <div class="input-group">
		                    <div class="input-group-prepend">
		                      <span class="input-group-text">
		                        <i class="far fa-calendar-alt"></i>
		                      </span>
		                    </div>
		                    <input name="startDateTemp" id="startDateTemp" type="text" class="form-control float-right" title="Estimated Start Date" />
		                    <span class="error invalid-feedback" id="startDateTempError"></span>
		                  </div>
		                </div> --%>
		                <div class="form-group">
		                  <label>Batch Start Date</label>
		                  <div class="input-group date" id="startDateTemp" data-target-input="nearest">
		                    <input name="startDateTemp" id="startDateTempIn" type="text" class="form-control datetimepicker-input" data-target="#startDateTemp"/>
		                    <%-- <input name="startDateTemp" id="startDateTemp" type="text" class="form-control float-right" title="Estimated Start Date" /> --%>
		                    <div class="input-group-append" data-target="#startDateTemp" data-toggle="datetimepicker">
                              <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                            </div>
                          </div>
                          <span class="error invalid-feedback" id="startDateTempError"></span>
                        </div>
		              </div>
		              <div class="col-md-2">
		                <%-- <div class="form-group">
		                  <label><span class="mandatory">*</span>Batch End Date</label>
		                  <div class="input-group">
		                    <div class="input-group-prepend">
		                      <span class="input-group-text">
		                        <i class="far fa-calendar-alt"></i>
		                      </span>
		                    </div>
		                    <input name="endDateTemp" id="endDateTemp" type="text" class="form-control float-right" title="Estimated Start Date" />
		                    <span class="error invalid-feedback" id="endDateTempError"></span>
		                  </div>
		                </div> --%>
		                <div class="form-group">
		                  <label>Batch End Date</label>
		                  <div class="input-group date" id="endDateTemp" data-target-input="nearest">
		                    <input name="endDateTemp" id="endDateTempIn" type="text" class="form-control datetimepicker-input" data-target="#endDateTemp"/>
		                    <%-- <input name="endDateTemp" id="endDateTemp" type="text" class="form-control float-right" title="Estimated Start Date" /> --%>
		                    <div class="input-group-append" data-target="#endDateTemp" data-toggle="datetimepicker">
                              <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                            </div>
                          </div>
                          <span class="error invalid-feedback" id="endDateTempError"></span>
                        </div>
		              </div>
		              <div class="col-md-3">
		                <div class="form-check" id="isActiveDiv">
		                  <label><span class="mandatory">*</span>Batch Active/InActive</label>
		                  <div class="custom-control custom-radio">
		                    <input type="radio" name="batchActive" class="custom-control-input" value="1" id="batchActive1" name="batchActive" />
		                    <label for="batchActive1" class="custom-control-label text-green">Active</label>
		                  </div>
		                  <div class="custom-control custom-radio">
		                    <input type="radio" name="batchActive" class="custom-control-input" value="0" id="batchActive2" name="batchActive" />
		                    <label for="batchActive2" class="custom-control-label text-red">Inactive</label>
		                  </div>
						  <div class="custom-control custom-radio">
		                    <input type="radio" name="batchActive" class="custom-control-input" value="2" id="batchActive3" name="batchActive" />
		                    <label for="batchActive3" class="custom-control-label text-secondary">Closed</label>
		                  </div>
		                  <span class="error invalid-feedback" id="isActiveError" style="display:block" ></span> 
		                </div>
		              </div>
		              <div class="col-md-3">
		                <div class="form-group">
		                  <label for="daysBetweenTwoSession"><span class="mandatory">*</span>Avg days between two sessions</label>
		                  <input type="text" class="form-control" id="daysBetweenTwoSession" placeholder="Enter Avg Days" name="daysBetweenTwoSession" />
		                  <span class="error invalid-feedback" id="daysBetweenTwoSessionError"></span>
		                </div>
		              </div>
		              <div class="col-md-2">
		                <div class="form-group">
		                  <label for="batchDuration"><span class="mandatory">*</span>Batch Duration</label>
		                  <input type="text" disabled="true" class="form-control" id="batchDuration" placeholder="Batch Duration" name="batchDuration" />
		                  <span class="error invalid-feedback" id="batchDurationError"></span>
		                </div>
		              </div>
		              <div class="col-12 table-responsive tableDiv">
		                <table class="table table-striped anand-table-font-size" id="coachCoacheeTable">
		                  <thead class="bg-table-head">
		                    <tr>
		                      <th>Action</th>
		                      <th>Coach</th>
		                      <th>Coachee</th>
		                       <th>ALDP Program</th> 
		                      <th>Supervisor</th>
		                    </tr>
		                  </thead>
		                  <tbody>
		                    <tr class="coacheCoacheeMapTr0">
		                      <td>
		                        <input type="hidden" name="coachCoacheeMappingList[0].actCoachCoacheeMapActive" id="actCoachCoacheeMapActive0" value="1" />
		                        <a href="#" title="Remove Coach-Coachee" onclick="removeCoachCoacheeMapping(0);"><i class="fas fa-times"></i></a>
		                      </td>
		                      <td>
		                        <select onchange="coachIdTempValidation('-',0)" class="form-control" name="coachCoacheeMappingList[0].coachIdTemp" id="coachIdTemp0">
		                          <option value="-1">Select  Coach</option>
		                          <c:forEach items="${coachList }" var="coach" varStatus="coachIndex">
		                            <option value="${coach.mUserId }">${coach.userFirstName } ${coach.userLastName }</option>
		                          </c:forEach>
		                        </select>
		                        <span class="error invalid-feedback" id="coachIdTempError0"></span>
		                      </td>
		                      <td>
		                        <select onchange="coacheeIdTempValidation('-',0)" class="form-control" name="coachCoacheeMappingList[0].coacheeIdTemp" id="coacheeIdTemp0">
		                          <option value="-1">Select  Coachee</option>
		                          <c:forEach items="${coacheeList }" var="coachee" varStatus="coacheeIndex">
		                            <option value="${coachee.mUserId }">${coachee.userFirstName } ${coachee.userLastName }</option>
		                          </c:forEach>
		                        </select>
		                        <span class="error invalid-feedback" id="coacheeIdTempError0"></span>
		                      </td>
		                      <td>
		                        <select onchange="actCoacheeProgramValidation('-',0)" class="form-control" name="coachCoacheeMappingList[0].actCoacheeProgram" id="actCoacheeProgram0">
		                          <option value="-1">Select ALDP Program</option>
		                          <option value="1">AM - ANAND Mentee</option>
		                          <option value="2">AT - ANAND Talent</option>
		                          <option value="3">AL - ANAND Leader</option>
		                        </select>
		                        <span class="error invalid-feedback" id="actCoacheeProgramError0"></span>
		                      </td>
		                      <td>
		                        <select onchange="supervisorIdTempValidation('-',0)" class="form-control" name="coachCoacheeMappingList[0].supervisorIdTemp" id="supervisorIdTemp0">
		                          <option value="-1">Select Supervisor</option>
		                          <c:forEach items="${supervisorList }" var="supervisor" varStatus="supervisorIndex">
		                            <option value="${supervisor.mUserId }">${supervisor.userFirstName } ${supervisor.userLastName }</option>
		                          </c:forEach>
		                        </select>
		                        <span class="error invalid-feedback" id="supervisorIdTempError0"></span>
		                      </td>
		                    </tr>
		                  </tbody>
		                </table>
		              </div>
		            </div>
		          </div>
		          <div class="card-footer">
		            <button title="Add Coach-Coachee-Supervisor" style="float: left;" type="button" id="addMoreCoachCoachee" class="btn bg-3 pull-right"><i class="fas fa-plus"></i>&nbsp;Add Coach-Coachee-Supervisor</button>
		            <button title="Submit Coaching Batch" style="float: right;" title="Add Batch" type="submit" id="submitBatchButton" class="btn btn-primary bg-2">Submit</button>
		          </div>
		        </div>
		        </form>
		      </div>
		    </div>
		    </c:if>
		    
		    <div class="row">
		      <div class="col-md-12">
		        <div class="card card-secondary card-outline bg-card-primary-anand">
		          <div class="card-header bg-3">
		            <h5 class="card-title font-weight-bold">List of all Coaching Batches</h5>
		          </div>
		          <div class="card-body">
		            <div class="row">
		              <div class="col-md-12 tableOverFlowDiv">
		                <table class="table table-bordered dataTable anand-table-font-size" id="batchTable">
		                  <thead>
		                    <tr class="bg-table-head">
		                      <th>Action</th>
		                      <th>Batch Name</th>
		                      <th>Batch Description</th>
		                      <th>Start Date</th>
		                      <th>End Date</th>
		                      <th>Total Participants</th>
		                      <th>ANAND Leader</th>
		                      <th>ANAND Talent</th>
		                      <th>ANAND Mentee</th>
		                      <th>Created By &amp; On</th>
		                      <th>Updated By &amp; On</th>
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
		                        <td><span class="badge sequence-bg-5">${batch.totalParticipants }</span></td>
		                        <td><span class="badge bg-1">${batch.anandLeaderCount }</span></td>
		                        <td><span class="badge bg-2">${batch.anandTalentCount }</span></td>
		                        <td><span class="badge bg-3">${batch.anandMenteeCount }</span></td>
		                        <td>
		                          ${batch.mUserId.userFirstName } ${batch.mUserId.userLastName }<br>
		                          <fmt:formatDate pattern = "dd-MMM-yyyy" value = "${batch.createdOn }" />
		                        </td>
		                        <td>
		                          ${batch.mUserIdUpdated.userFirstName } ${batch.mUserIdUpdated.userLastName }<br>
		                          <fmt:formatDate pattern = "dd-MMM-yyyy" value = "${batch.updatedOn }" />
		                        </td>
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
		                      <th>Total Participants</th>
		                      <th>ANAND Leader</th>
		                      <th>ANAND Talent</th>
		                      <th>ANAND Mentee</th>
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
		        <form modelAttribute="actCoachingBatch" action="coaching-batch" id="actCoachingBatchEdit" method="post">
		        <input type="hidden" name="actCoachingBatchId" id="actCoachingBatchId" />
		        <div class="card card-primary card-outline collapsed-card bg-card-primary-anand">
		          <div class="card-header" data-card-widget="collapse">
		            <h5 class="card-title">Edit ACT Coaching Batch</h5>
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
		                  <input type="text" class="form-control" id="batchNameEdit" placeholder="Enter Batch Name" name="batchName" />
		                  <span class="error invalid-feedback" id="batchNameErrorEdit"></span>
		                </div>
		              </div>
		              <div class="col-md-8">
		                <div class="form-group">
		                  <label for="batchDescriptionEdit"><span class="mandatory">*</span>Batch Description</label>
		                  <input type="text" class="form-control" id="batchDescriptionEdit" placeholder="Enter Batch Description" name="batchDescription" />
		                  <span class="error invalid-feedback" id="batchDescriptionErrorEdit"></span>
		                </div>
		              </div>
		              <div class="col-md-2">
		                <%-- <div class="form-group">
		                  <label><span class="mandatory">*</span>Batch Start Date</label>
		                  <div class="input-group">
		                    <div class="input-group-prepend">
		                      <span class="input-group-text">
		                        <i class="far fa-calendar-alt"></i>
		                      </span>
		                    </div>
		                    <input name="startDateTemp" id="startDateTempEdit" type="text" class="form-control float-right" title="Estimated Start Date" />
		                    <span class="error invalid-feedback" id="startDateTempErrorEdit"></span>
		                  </div>
		                </div> --%>
		                <div class="form-group">
		                  <label>Batch Start Date</label>
		                  <div class="input-group date" id="startDateTempEdit" data-target-input="nearest">
		                    <input name="startDateTemp" id="startDateTempInEdit" type="text" class="form-control datetimepicker-input" data-target="#startDateTempEdit"/>
		                    <%-- <input name="startDateTempEdit" id="startDateTempEdit" type="text" class="form-control float-right" title="Estimated Start Date" /> --%>
		                    <div class="input-group-append" data-target="#startDateTempEdit" data-toggle="datetimepicker">
                              <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                            </div>
                          </div>
                          <span class="error invalid-feedback" id="startDateTempErrorEdit"></span>
                        </div>
		              </div>
		              <div class="col-md-2">
		                <%-- <div class="form-group">
		                  <label><span class="mandatory">*</span>Batch End Date</label>
		                  <div class="input-group">
		                    <div class="input-group-prepend">
		                      <span class="input-group-text">
		                        <i class="far fa-calendar-alt"></i>
		                      </span>
		                    </div>
		                    <input name="endDateTemp" id="endDateTempEdit" type="text" class="form-control float-right" title="Estimated End Date" />
		                    <span class="error invalid-feedback" id="endDateTempErrorEdit"></span>
		                  </div>
		                </div> --%>
		                <div class="form-group">
		                  <label>Batch Start Date</label>
		                  <div class="input-group date" id="endDateTempEdit" data-target-input="nearest">
		                    <input name="endDateTemp" id="endDateTempInEdit" type="text" class="form-control datetimepicker-input" data-target="#endDateTempEdit"/>
		                    <%-- <input name="endDateTempEdit" id="endDateTempEdit" type="text" class="form-control float-right" title="Estimated Start Date" /> --%>
		                    <div class="input-group-append" data-target="#endDateTempEdit" data-toggle="datetimepicker">
                              <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                            </div>
                          </div>
                          <span class="error invalid-feedback" id="endDateTempErrorEdit"></span>
                        </div>
		              </div>
		              <div class="col-md-3">
		                <div class="form-check" id="isActiveEditDiv">
		                  <label><span class="mandatory">*</span>Batch Active/InActive</label>
		                  <div class="custom-control custom-radio">
		                    <input type="radio" name="batchActive" class="custom-control-input" value="1" id="batchActiveEdit1" name="batchActive" />
		                    <label for="batchActiveEdit1" class="custom-control-label text-green">Active</label>
		                  </div>
		                  <div class="custom-control custom-radio">
		                    <input type="radio" name="batchActive" class="custom-control-input" value="0" id="batchActiveEdit2" name="batchActive" />
		                    <label for="batchActiveEdit2" class="custom-control-label text-red">Inactive</label>
		                  </div>
						  <div class="custom-control custom-radio">
		                    <input type="radio" name="batchActive" class="custom-control-input" value="2" id="batchActiveEdit3" name="batchActive" />
		                    <label for="batchActiveEdit3" class="custom-control-label text-secondary">Closed</label>
		                  </div>
		                  <span class="error invalid-feedback" id="isActiveEditError" style="display:block" ></span> 
		                </div>
		              </div>
		              <div class="col-md-3">
		                <div class="form-group">
		                  <label for="daysBetweenTwoSessionEdit"><span class="mandatory">*</span>Avg days between two sessions</label>
		                  <input type="text" class="form-control" id="daysBetweenTwoSessionEdit" placeholder="Enter Avg Days" name="daysBetweenTwoSession" />
		                  <span class="error invalid-feedback" id="daysBetweenTwoSessionErrorEdit"></span>
		                </div>
		              </div>
		              <div class="col-md-2">
		                <div class="form-group">
		                  <label for="batchDurationEdit"><span class="mandatory">*</span>Batch Duration</label>
		                  <input type="text" disabled="true" class="form-control" id="batchDurationEdit" placeholder="Batch Duration" name="batchDuration" />
		                  <span class="error invalid-feedback" id="batchDurationErrorEdit"></span>
		                </div>
		              </div>
					 
		              <div class="col-md-12">
		                <table class="table table-striped anand-table-font-size" id="coachCoacheeTableEdit">
		                  <thead class="bg-table-head">
		                    <tr>
		                      <th>Action</th>
		                      <th>Coach</th>
		                      <th>Coachee</th>
		                      <th>ALDP Program</th>
		                      <th>Supervisor</th>
		                    </tr>
		                  </thead>
		                  <tbody>
		                  </tbody>
		                </table>
		              </div>
		            </div>
		          </div>
		          <div class="card-footer" style="display: block;">
		            <button title="Add Coach-Coachee-Supervisor" style="float: left;" type="button" id="editMoreCoachCoachee" class="btn bg-3 text-white pull-right"><i class="fas fa-plus"></i>&nbsp;Add Coach-Coachee-Supervisor</button>
		            <button type="submit" id="saveBatchChanges" style="float: right;" class="btn bg-1 text-white" title="Save Batch Changes">Save Batch Changes</button>
		          </div>
		        </div>
		        </form>
		      </div>
		    </div>

		  </div>
		</section>
		
		
		
		<div class="modal fade" id="batchInfoModal">
		  <div class="modal-dialog modal-xl">
		    <div class="modal-content">
		      <div class="modal-header bg-secondary">
		        <h4 class="modal-title">ALDP Batch Information</h4>
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
		                        <th>Coach</th>
		                        <th>Coachee</th>
		                        <th>ALDP Program</th>
		                        <th>Supervisor</th>
		                      </tr>
		                    </thead>
		                    <tbody>
		                    </tbody>
		                  </table>
		                </div>
		              </div>
		            </div>
		          </div>
		        </div>
		      </div>
		      <div class="modal-footer justify-content-between">
		        <button onclick="" id="closeEditRoleModal" type="button" class="btn sequence-bg-1" data-dismiss="modal">Close</button>
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
    <script src="usedStaticFiles/essentials/js/jsp_js_files/aldp/coachingBatch/coachingBatch.js"></script>
  </body>
</html>
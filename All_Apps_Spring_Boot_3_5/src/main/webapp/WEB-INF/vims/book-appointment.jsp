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
    <title>BOOK APPOINTMENT<%@include file="../includeJSP/company_name_title.jsp"%></title>
    <%@include file="../includeJSP/cssFiles.jsp"%>
    <link rel="stylesheet" href="usedStaticFiles/essentials/daterangepicker/daterangepicker - Copy.css">
    <link rel="stylesheet" href="usedStaticFiles/essentials/daterangepicker/bootstrap-colorpicker.min.css">
    <link rel="stylesheet" href="usedStaticFiles/essentials/daterangepicker/tempusdominus-bootstrap-4.min.css">
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
                <h5 class="font-3 font-weight-bold">BOOK APPOINTMENT</h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item font-1"><a href="dashboard" title="Dashboard">Dashboard</a></li>
                  <li class="breadcrumb-item font-3 active">Book Appointment</li>
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
		  <form modelAttribute="visitor" action="book-appointment" id="visitor" method="post">
		  <input type="hidden" name="visitorId" id="visitorId" />
		  <input type="hidden" id="dateNow" value="${dateNow }" />
		  <input type="hidden" id="timeNow" value="${timeNow }" />
		  <div class="container-fluid">
		    <div class="row">
		      <div class="col-md-12">
		        <div class="card card-secondary">
		          <div class="card-header bg-1">
		            <h5 class="card-title font-weight-bold">Appointment Information</h5>
		          </div>
		          <div class="card-body">
		            <div class="row">
		              <div class="col-md-3">
		                <div class="form-group">
		                  <label class="font-1" for="visitorName"><span class="mandatory">*</span>Visitor Name</label>
		                  <input type="text" class="form-control" id="visitorName" placeholder="Enter Visitor Name" name="visitorName" />
		                  <span class="error invalid-feedback" id="visitorNameError"></span>
		                </div>
		              </div>
		              <div class="col-md-3">
		                <div class="form-group">
		                  <label class="font-3" for="visitorEmail"><span class="mandatory">*</span>Visitor Email ID</label>
		                  <input type="text" class="form-control" id="visitorEmail" placeholder="Enter Email" name="visitorEmail" />
		                  <span class="error invalid-feedback" id="visitorEmailError"></span>
		                </div>
		              </div>
		              <div class="col-md-3">
		                <div class="form-group">
		                  <label class="font-1" for="visitorTypeTemp"><span class="mandatory">*</span>Visitor Type</label>
		                  <select name="visitorTypeTemp" class="form-control select2">
		                    <option value="-1">- Select Visitor Type -</option>
		                  	<%-- <options items="${visitorTypeList}" itemValue="mVisitorTypeId" itemLabel="visitorTypeName"/> --%>
		                  	<c:forEach items="${visitorTypeList }" var="purpose" varStatus="entityLoop">
		                  	  <option value="${purpose.MVisitorTypeId }">${purpose.visitorTypeName }</option>
		                  	</c:forEach>
						  </select>
		                  <span class="error invalid-feedback" id="visitorTypeTempError"></span>
		                </div>
		              </div>
		              <div class="col-md-3">
		                <div class="form-group">
		                  <%-- <label class="font-2" for="visitorMobileNumber"><span class="mandatory">*</span>Visitor Mobile Number</label>
		                  <input type="text" class="form-control" id="visitorMobileNumber" placeholder="Enter Mobile Number" name="visitorMobileNumber" />
		                  <span class="error invalid-feedback" id="visitorMobileNumberError"></span> --%>
		                </div>
		              </div>
		              <div class="col-md-3">
		                <div class="form-group">
		                  <label class="font-2" for="visitorPurposeTemp"><span class="mandatory">*</span>Purpose of Visit</label>
		                  <select name="visitorPurposeTemp" id="visitorPurposeTemp" class="form-control select2">
		                  	<option value="-1">- Select Visitor Pupose -</option>
		                  	<%-- <options items="${visitorPurposeList}" itemValue="mVisitorPurposeId" itemLabel="visitorPurposeName"/> --%>
		                  	<c:forEach items="${visitorPurposeList }" var="purpose" varStatus="entityLoop">
		                  	  <option value="${purpose.MVisitorPurposeId }">${purpose.visitorPurposeName }</option>
		                  	</c:forEach>
						  </select>
		                  <span class="error invalid-feedback" id="visitorPurposeTempError"></span>
		                </div>
		              </div>
		              <div class="col-md-3">
		                <div class="form-group">
		                  <label class="font-1" for="visitingLocationTemp"><span class="mandatory">*</span>Location</label>
		                  <select name="visitingLocationTemp" id="visitingLocationTemp" class="form-control select2">
		                  	<option value="-1">- Select Location -</option>
		                  	<%-- <options items="${childEntityList}" itemValue="mEntityId" itemLabel="entityName"/> --%>
		                  	<c:forEach items="${childEntityList }" var="entity" varStatus="entityLoop">
		                  	  <c:choose>
		                  	    <c:when test="${vimsReception eq 1 || vimsAdmin eq 1 }">
		                  	      <option value="${entity.mEntityId }">${entity.locationId.locationName } - ${entity.entityName }</option>
		                  	    </c:when>
		                  	    <c:otherwise>
		                  	      <c:if test="${sessionUserInfo.mEntityId.entitySource.mEntityId eq entity.entitySource.mEntityId }">
		                  	        <option value="${entity.mEntityId }">${entity.locationId.locationName } - ${entity.entityName }</option>
		                  	      </c:if>
		                  	    </c:otherwise>
		                  	  </c:choose>
		                  	</c:forEach>
						  </select>
		                  <span class="error invalid-feedback" id="visitingLocationTempError"></span>
		                </div>
		              </div>
		              <div class="col-md-3">
		                <div class="form-group">
		                  <label class="font-1" for="visitorPlantEntry"><span class="mandatory">*</span>Is Plant entry allowed?</label>
		                  <select name = "visitorPlantEntry" class="form-control">
		                  	<option value="0">Prohibited</option>
		                  	<option value="1">Granted</option>
						  </select>
		                  <span class="error invalid-feedback" id="visitorPlantEntryError"></span>
		                </div>
		              </div>
		              <div class="col-md-3">
		                <div class="form-group">
		                  <label class="font-3" for="totalVisitor"><span class="mandatory">*</span>Total Visitors 1+</label>
		                  <c:set value="${visitor.totalVisitor }" var="totalVisitorTemp" />
		                  <c:if test="${not empty totalVisitorTemp }">
		                    <c:set value="${totalVisitorTemp - 1 }" var="totalVisitorTemp" />
		                  </c:if>
		                  <c:if test="${empty totalVisitorTemp }">
		                    <c:set value="" var="totalVisitorTemp" />
		                  </c:if>
		                  <input type="number" class="form-control" id="totalVisitor" placeholder="Enter Number of people going to accompany" name="totalVisitor" value="${totalVisitorTemp }" />
		                  <span class="error invalid-feedback" id="totalVisitorError"></span>
		                </div>
		              </div>
		              <div class="col-md-3">
		                <div class="form-group">
		                  <label class="font-1" for="visitorCompanyName"><span class="mandatory">*</span>Visitor Company Name</label>
		                  <input type="text" class="form-control" id="visitorCompanyName" placeholder="Visitor Company Name" name="visitorCompanyName" />
		                  <span class="error invalid-feedback" id="visitorCompanyNameError"></span>
		                </div>
		              </div>
		              <div class="col-md-3">
		                <div class="form-group">
		                  <label class="font-3" for="visitorCompanyAddress"><span class="mandatory">*</span>Visitor Company Address</label>
		                  <textarea placeholder="Visitor Company Address" id="visitorCompanyAddress" name="visitorCompanyAddress" class="form-control">
		                  </textarea>
		                  <span class="error invalid-feedback" id="visitorCompanyAddressError"></span>
		                </div>
		              </div>
		              <div class="col-md-3">
		                <div class="form-check" id="visitorPermissionChecboxDiv">
		                  <label class="font-2"><span class="mandatory">*</span>Visitor Permissions</label>
		                  <div class="custom-control custom-checkbox">
		                    <input type="checkbox" name="visitorCanteenAccess" class="custom-control-input" value="1" id="visitorCanteenAccess" />
		                    <label for="visitorCanteenAccess" class="custom-control-label sequence-font-5">Canteen Access</label>
		                  </div>
		                  <div class="custom-control custom-checkbox">
		                    <input type="checkbox" name="visitorLaptopAllowed" class="custom-control-input" value="1" id="visitorLaptopAllowed" />
		                    <label for="visitorLaptopAllowed" class="custom-control-label sequence-font-4">Laptop Allowed</label>
		                  </div>
		                  <div class="custom-control custom-checkbox">
		                    <input type="checkbox" name="visitorCellPhoneAllowed" class="custom-control-input" value="1" id="visitorCellPhoneAllowed" />
		                    <label for="visitorCellPhoneAllowed" class="custom-control-label sequence-font-2">Cell Phone Allowed</label>
		                  </div>
		                  <div class="custom-control custom-checkbox">
		                    <input type="checkbox" name="visitorEscortRequired" class="custom-control-input" value="1" id="visitorEscortRequired" />
		                    <label for="visitorEscortRequired" class="custom-control-label sequence-font-1">Escort Required</label>
		                  </div>
		                  <span class="error invalid-feedback" id="visitorPermissionChecboxDivError" style="display:block" ></span>
		                </div>
		              </div>
		              <div class="col-md-3">
		                <div class="form-group">
		                  <label class="font-3" for="visitorRemarks"><span class="mandatory">*</span>Remarks</label>
		                  <textarea name="visitorRemarks" class="form-control"></textarea>
		                  <span class="error invalid-feedback" id="visitorRemarksError"></span>
		                </div>
		              </div>
		            </div>
		          </div>
		          <div class="card-header bg-3">
		            <h5 class="card-title font-weight-bold">Host Information</h5>
		          </div>
		          <div class="card-body">
		            <div class="row">
		              <div class="col-md-4">
		                <div class="form-group">
		                  <label class="font-1" for="appName"><span class="mandatory">*</span>Host Name</label>
		                  <select name="hostNameTemp" id="hostNameTemp" class="form-control select2">
		                    <%-- <option value="-1">- Select Host Name -</option> --%>
		                    <c:forEach items="${userListForEditAppointment }" var="userInLocation" varStatus="userStatus">
		                      <option value="${userInLocation.mUserId }">${userInLocation.userFirstName } ${userInLocation.userLastName }</option>
		                    </c:forEach>
		                  </select>
		                  <span class="error invalid-feedback" id="hostNameTempError"></span>
		                </div>
		              </div>
		              <div class="col-md-2">
		                <div class="form-group">
		                  <label class="font-2" for="hostExtensionNumber">Extension Number</label>
		                  <input type="text" class="form-control" id="hostExtensionNumber" placeholder="Host Extension Number" name="hostExtensionNumber" />
		                  <span class="error invalid-feedback" id="hostExtensionNumberError"></span>
		                </div>
		              </div>
		              <div class="col-md-6">
		                <div class="form-group">
		                  <label class="font-2" for="meetingPlace">Meeting Place</label>
		                  <input type="text" class="form-control" id="meetingPlace" placeholder="Enter Meeting Place" name="meetingPlace" />
		                  <span class="error invalid-feedback" id="meetingPlaceError"></span>
		                </div>
		              </div>
		              <div class="col-md-2">
		                <div class="form-group">
		                  <label class="font-1" for="meetingStartDateTemp"><span class="mandatory">*</span>Meeting Date</label>
		                  <input type="hidden" id="meetingStartDateTempJS" value="${visitor.meetingStartDateTemp }" />
		                  <div class="input-group date" id="meetingStartDateTemp" data-target-input="nearest">
		                    <input placeholder="Meeting Date" id="meetingStartDateTempId" name="meetingStartDateTemp" type="text" class="form-control datetimepicker-input" data-target="#meetingStartDateTemp" />
		                    <div class="input-group-append" data-target="#meetingStartDateTemp" data-toggle="datetimepicker">
		                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
		                   </div>
		                 </div>
		                 <span class="error invalid-feedback" style="display: block;" id="meetingStartDateTempIdError"></span>
		               </div>
		              </div>
		              <div class="col-md-2">
		                <div class="form-group">
		                  <label class="font-3" for="meetingStartTimeTemp"><span class="mandatory">*</span>Meeting Start Time</label>
		                  <div class="input-group date" id="meetingStartTimeTemp" data-target-input="nearest">
		                    <input placeholder="Start Time" name="meetingStartTimeTemp" id="meetingStartTimeTempId" type="text" class="form-control datetimepicker-input" data-target="#meetingStartTimeTemp" />
		                    <div class="input-group-append" data-target="#meetingStartTimeTemp" data-toggle="datetimepicker">
		                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
		                   </div>
		                 </div>
		                 <span class="error invalid-feedback" style="display: block;" id="meetingStartTimeTempIdError"></span>
		               </div>
		              </div>
		              <div class="col-md-2">
		                <div class="form-group">
		                  <label class="font-3" for="meetingEndTimeTemp"><span class="mandatory">*</span>Meeting End Time</label>
		                  <div class="input-group date" id="meetingEndTimeTemp" data-target-input="nearest">
		                    <input placeholder="End Time" name="meetingEndTimeTemp" id="meetingEndTimeTempId" type="text" class="form-control datetimepicker-input" data-target="#meetingEndTimeTemp" />
		                    <div class="input-group-append" data-target="#meetingEndTimeTemp" data-toggle="datetimepicker">
		                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
		                   </div>
		                 </div>
		                 <span class="error invalid-feedback" style="display: block;" id="meetingEndTimeTempIdError"></span>
		               </div>
		              </div>
		              <div class="col-md-2">
		                <div class="form-group">
		                  <label class="font-2" for="meetingEndDateTemp"><span class="mandatory">*</span>Visit Planned Till</label>
		                  <div class="input-group date" id="meetingEndDateTemp" data-target-input="nearest">
		                    <input placeholder="Planned Till" id="meetingEndDateTempId" name="meetingEndDateTemp" type="text" class="form-control datetimepicker-input" data-target="#meetingEndDateTemp" />
		                    <div class="input-group-append" data-target="#meetingEndDateTemp" data-toggle="datetimepicker">
		                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
		                   </div>
		                 </div>
		                 <span class="error invalid-feedback" style="display: block;" id="meetingEndDateTempError"><code>This allow visitor to enter using same reqeust until the date you mention here.</code></span>
		                 <span class="error invalid-feedback" style="display: block;" id="meetingEndDateTempIdError"></span>
		               </div>
		              </div>
		              <div class="col-md-4">
		                <br>
		                <span class="error invalid-feedback" style="display: block;" id="startEndDateDiff"></span>
		              </div>
		            </div>
		          </div>
		          <div class="card-footer">
		            <button style="float: right;" title="Add Visitor Visitor" type="submit" id="submitVisitorPurposeButton" class="btn bg-3"><i class="fas fa-plus"></i>&ensp;Book Appointment</button>
		          </div>
		        </div>
		      </div>
		    </div>
		  </div>
		  </form>
		</section>
      </div>
      <%@include file="includeJSP/footer.jsp"%>
    </div>
    <%@include file="../includeJSP/jsFiles.jsp"%>
    <%@include file="../includeJSP/dataTablesImport.jsp"%>
    <%-- <%@include file="../includeJSP/datePickerJs.jsp"%> --%>
    <script src="usedStaticFiles/essentials/moment/moment.min.js"></script>
    <script src="usedStaticFiles/essentials/daterangepicker/jquery.inputmask.js"></script>
    <script src="usedStaticFiles/essentials/daterangepicker/daterangepicker - Copy.js"></script>
    <script src="usedStaticFiles/essentials/daterangepicker/bootstrap-colorpicker.min.js"></script>
    <script src="usedStaticFiles/essentials/daterangepicker/tempusdominus-bootstrap-4.min.js"></script>
    <script src="usedStaticFiles/essentials/js/jsp_js_files/vims/book-appointment.js"></script>
  </body>
</html>
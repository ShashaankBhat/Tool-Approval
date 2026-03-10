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
    <title>APP<%@include file="../includeJSP/company_name_title.jsp"%></title>
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
                <h5 class="font-3 font-weight-bold">VISITOR LIST</h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item font-1"><a href="dashboard" title="Dashboard">Dashboard</a></li>
                  <li class="breadcrumb-item font-3 active">Visitor List</li>
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
		        <form action="visitor_form" id="vform" method="post">
		        <div class="card collapsed-card">
		          <div class="card-header bg-1" data-card-widget="collapse">
		            <h5 class="card-title font-weight-bold">Add New Appointment</h5>
		            <div class="card-tools">
		              <button type="button" class="btn btn-tool text-white" data-card-widget="collapse">
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
		                  <label class="font-1" for="appName"><span class="mandatory">*</span>Visitor Name</label>
		                  <input type="text" class="form-control" id="appName" placeholder="Enter Visitor Name" path="visitorName" />
		                  <span class="error invalid-feedback" id="appNameError"></span>
		                </div>
		              </div>
		              <div class="col-md-4">
		                <div class="form-group">
		                  <label class="font-2" for="appName"><span class="mandatory">*</span>Mobile Number</label>
		                  <input type="text" class="form-control" id="appName" placeholder="Enter Mobile Number" path="mobileNumber" />
		                  <span class="error invalid-feedback" id="appNameError"></span>
		                </div>
		              </div>
		              <div class="col-md-4">
		                <div class="form-group">
		                  <label class="font-3" for="appName"><span class="mandatory">*</span>Email ID</label>
		                  <input type="text" class="form-control" id="appName" placeholder="Enter Email" path="visitorEmail" />
		                  <span class="error invalid-feedback" id="appNameError"></span>
		                </div>
		              </div>
		              <div class="col-md-4">
		                <div class="form-group">
		                  <label class="font-3" for="appName"><span class="mandatory">*</span>Visit Planned Until</label>
		                  <input type="date" class="form-control" id="appName" placeholder="Enter Date" path="visitorAllowedUntil" />
		                  <span class="error invalid-feedback" id="appNameError"></span>
		                </div>
		              </div>
		              <div class="col-md-4">
		                <div class="form-group">
		                  <label class="font-1" for="appName"><span class="mandatory">*</span>Company Name</label>
		                  <input type="text" class="form-control" id="appName" placeholder="Enter Company Name" path="companyName" />
		                  <span class="error invalid-feedback" id="appNameError"></span>
		                </div>
		              </div>
		              <div class="col-md-4">
		                <div class="form-group">
		                  <label class="font-3" for="appName"><span class="mandatory">*</span>Company Address</label>
		                  <textarea placeholder="Company Address" path="companyAddress" class="form-control" />
		                  <span class="error invalid-feedback" id="appNameError"></span>
		                </div>
		              </div>
		              <div class="col-md-4">
		                <div class="form-group">
		                  <label class="font-1" for="appName"><span class="mandatory">*</span>Visitor Type</label>
		                  <select path = "visitorType" class="form-control">
		                  	<option value="Candidate">Candidate</option>
		                  	<option value="Auditor">Auditor</option>
		                  	<option value="Construction Worker">Construction Worker</option>
						  </select>
		                  <span class="error invalid-feedback" id="appNameError"></span>
		                </div>
		              </div>
		              <div class="col-md-4">
		                <div class="form-group">
		                  <label class="font-2" for="appName"><span class="mandatory">*</span>Purpose of Visit</label>
		                  <select path="visitorPurpose" class="form-control">
		                  	<option value="Interview">Interview</option>
		                  	<option value="Meeting">Meeting</option>
						  </select>
		                  <span class="error invalid-feedback" id="appNameError"></span>
		                </div>
		              </div>
		              <div class="col-md-4">
		                <div class="form-group">
		                  <label path="visitorRemarks" placeholder = "Enter Remarks" class="font-3" for="appName"><span class="mandatory">*</span>Remarks</label>
		                  <textarea path="visitorRemarks" class="form-control"/>
		                  <span class="error invalid-feedback" id="appNameError"></span>
		                </div>
		              </div>

		              <div class="col-md-4">
		                <div class="form-group">
		                  <label class="font-1" for="hostName"><span class="mandatory">*</span>Host Name</label>
		                  <input type="text" class="form-control" id="hostName" placeholder="Enter Host Name" path="hostName" />
		                  <span class="error invalid-feedback" id="hostNameError"></span>
		                </div>
		              </div>
		              <div class="col-md-4">
		                <div class="form-group">
		                  <label class="font-2" for="appName"><span class="mandatory">*</span>Is Plant entry allowed?</label>
		                  <select path = "visitorPlantEntry" class="form-control">
		                  	<option value="1">Prohibited</option>
		                  	<option value="0">Granted</option>
						  </select>
		                  <span class="error invalid-feedback" id="appNameError"></span>
		                </div>
		              </div>
		              <div class="col-md-4">
		                <div class="form-check" id="isActiveDiv">
		                  <label class="font-3"><span class="mandatory">*</span>Visitor Permissions</label>
		                  <div class="custom-control custom-radio">
		                    <radiobutton path="visitorCanteenAccess" class="custom-control-input" value="1" id="VisitorCanteenAcess" name="Canteen Access" />
		                    <label for="VisitorCanteenAcess" class="custom-control-label sequence-font-5">Canteen Access</label>
		                  </div>
		                  <div class="custom-control custom-radio">
		                    <radiobutton path="visitorLaptopAllowed" class="custom-control-input" value="0" id="VisitorLaptopAllowed" name="Laptop Allowed" />
		                    <label for="VisitorLaptopAllowed" class="custom-control-label sequence-font-1">Laptop Allowed</label>
		                  </div>
		                  <span class="error invalid-feedback" id="isActiveError" style="display:block" ></span>
		                </div>
		              </div>
		            </div>
		          </div>
		          <div class="card-footer">
		            <button style="float: right;" title="Add App" type="submit" id="submitAppButton" class="btn bg-1">Submit</button>
				  </div>
		        </div>
		        </form>
		      </div>
		    </div>

		    <div class="row">
		      <div class="col-md-12">
		        <div class="card card-secondary">
		          <div class="card-header bg-3">
		            <h5 class="card-title font-weight-bold">List of Appointments</h5>
		          </div>
		          <div class="card-body">
		            <div class="row">
		              <div class="col-md-12 tableOverFlowDiv">
		                <table class="table table-bordered table-striped dataTable" id="appTable">
		                  <thead>
		                    <tr class="bg-table-head">
		                      <th>Name</th>
		                      <th>Company Name</th>
		                      <th>Mobile Number</th>
		                      <th>Email</th>
		                      <th>Visitor Type</th>
		                      <th>Hosted By</th>
		                      <th>Visiting On/Until</th>
		                      <th>Updated By</th>
		                      <th>Updated On</th>
		                    </tr>
		                  </thead>
		                  <tbody>
		                    <c:forEach items="${visitorList}" var="visitor" varStatus="appLoop">
		                      <tr class="bg-table-row-${appLoop.index %2 }">
		                        <td>${visitor.visitorName }</td>
		                        <td>${visitor.companyName }</td>
		                        <td>${visitor.mobileNumber }</td>
		                        <td>${visitor.visitorEmail }</td>
		                        <td>
		                          <c:choose>
		                            <c:when test="${visitor.visitorType eq 1 }"><span class="badge sequence-bg-5">Candidate</span></c:when>
		                            <c:otherwise><span class="badge sequence-bg-1">Auditor</span></c:otherwise>
		                          </c:choose>
		                        </td>
		                        <td>${visitor.hostName }</td>
		                        <td><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${visitor.visitorAllowedUntil }" /></td>
		                        <td>${visitor.hostName}</td>
		                        <td><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${visitor.visitorAllowedUntil }" /></td>
		                      </tr>
		                    </c:forEach>
		                  </tbody>
		                  <tfoot>
		                    <tr class="bg-table-foot">
		                      <th>Action</th>
		                      <th>Name</th>
		                      <th>Description</th>
		                      <th>Description 2</th>
		                      <th>Active/In-Active</th>
		                      <th>Created By</th>
		                      <th>Created On</th>
		                      <th>Updated By</th>
		                      <th>Updated On</th>
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
    <%@include file="../includeJSP/dataTablesImport.jsp"%>
    <script src="usedStaticFiles/essentials/js/jsp_js_files/vims/visitor-form.js"></script>
  </body>
</html>
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
    <title>DEPARTMENT<%@include file="../includeJSP/company_name_title.jsp"%></title>
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
                <h5 class="font-3 font-weight-bold font-1">DEPARTMENT LIST</h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item font-1"><a href="dashboard" title="Dashboard">Dashboard</a></li>
                  <li class="breadcrumb-item font-1"><a href="master" title="Masters Dashboard">Masters</a></li>
                  <li class="breadcrumb-item font-3 active">Department</li>
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
		        <form modelAttribute="department" action="department" id="department" method="post">
		        <div class="card card-primary collapsed-card">
		          <div class="card-header bg-1" data-card-widget="collapse">
		            <h5 class="card-title font-weight-bold">Add Department</h5>
		            <div class="card-tools">
		              <button type="button" class="btn btn-tool" data-card-widget="collapse">
		                <i class="fas fa-plus"></i>
		              </button>
		              <input type="hidden" value="${openAddModal }" id="openAddModel" />
		              <input type="hidden" value="${openEditModel }" id="openEditModel" />
		            </div>
		          </div>
		          <div class="card-body" style="display: none;">
		            <div class="row">
		              <div class="col-md-6">
		                <div class="form-group">
		                  <label for="departmentName" class="font-1"><span class="mandatory">*</span>Department Name</label>
		                  <input type="text" class="form-control" id="departmentName" placeholder="Enter Department Name" name="departmentName" />
		                  <span class="error invalid-feedback" id="departmentNameError"></span>
		                </div>
		              </div>
		              <div class="col-md-4">
		                <div class="form-check" id="isActiveDiv">
		                  <label for="departmentActive" class="font-2"><span class="mandatory">*</span>Department Active/InActive</label>
		                  <div class="custom-control custom-radio">
		                    <input type="radio" name="departmentActive" class="custom-control-input" value="1" id="departmentActive1" name="departmentActive" />
		                    <label for="departmentActive1" class="custom-control-label sequence-font-5">Active</label>
		                  </div>
		                  <div class="custom-control custom-radio">
		                    <input type="radio" name="departmentActive" class="custom-control-input" value="0" id="departmentActive2" name="departmentActive" />
		                    <label for="departmentActive2" class="custom-control-label sequence-font-1">Inactive</label>
		                  </div>
		                  <span class="error invalid-feedback" id="isActiveError" style="display:block" ></span> 
		                </div>
		              </div>
		              <div class="col-md-2">
		                <div class="form-check">
		                  <br>
		                  <button style="float: left;" title="Add Department" type="submit" id="submitDepartmentButton" class="btn bg-1">Submit</button>
		                </div>
		              </div>
		              <div class="col-md-8">
		                <div class="form-group">
		                  <label for="departmentDescription"  class="font-3"><span class="mandatory">*</span>Department Description</label>
		                  <input type="text" class="form-control" id="departmentDescription" placeholder="Enter Department Description" name="departmentDescription" />
		                  <span class="error invalid-feedback" id="departmentDescriptionError"></span>
		                </div>
		              </div>
		            </div>
		          </div>
		        </div>
		        </form>
		      </div>
		    </div>
		    <div class="row">
		      <div class="col-md-12">
		        <div class="card card-secondary">
		          <div class="card-header bg-3">
		            <h5 class="card-title font-weight-bold">List of Departments</h5>
		          </div>
		          <div class="card-body">
		            <div class="row">
		              <div class="col-md-12 tableOverFlowDiv">
		                <table class="table table-bordered table-striped dataTable" id="departmentTable">
		                  <thead>
		                    <tr class="bg-table-head">
		                      <th>Action</th>
		                      <th>Name</th>
		                      <th>Description</th>
		                      <th>Active/In-Active</th>
		                      <th>Created By</th>
		                      <th>Created On</th>
		                      <th>Updated By</th>
		                      <th>Updated On</th>
		                    </tr>
		                  </thead>
		                  <tbody>
		                    <c:forEach items="${departmentList }" var="department" varStatus="departmentLoop">
		                      <tr class="bg-table-row-${departmentLoop.index %2 }">
		                        <td>${department.actionForList }</td>
		                        <td>${department.departmentName }</td>
		                        <td>${department.departmentDescription }</td>
		                        <td>
		                          <c:choose>
		                            <c:when test="${department.departmentActive eq 1 }"><span class="badge sequence-bg-5">Active</span></c:when>
		                            <c:otherwise><span class="badge sequence-bg-1">In-Active</span></c:otherwise>
		                          </c:choose>
		                        </td>
		                        <td>${department.mUserId.userFirstName } ${department.mUserId.userLastName }</td>
		                        <td><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${department.createdOn }" /></td>
		                        <td>${department.mUserIdUpdate.userFirstName } ${department.mUserIdUpdate.userLastName }</td>
		                        <td><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${department.updatedOn }" /></td>
		                      </tr>
		                    </c:forEach>
		                  </tbody>
		                  <tfoot>
		                    <tr class="bg-table-foot">
		                      <th>Action</th>
		                      <th>Name</th>
		                      <th>Description</th>
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

		<div class="modal fade" id="editDepartmentModal">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <form modelAttribute="department" action="department" id="departmentEdit" method="post">
		      <input type="hidden" name="mDepartmentId" id="mDepartmentId" />
		      <div class="modal-header bg-3">
		        <h4 class="modal-title font-weight-bold">Edit Department</h4>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	              <span aria-hidden="true"><i class="text-white font-weight-bold fas fa-times"></i></span>
	            </button>
		      </div>
		      <div class="modal-body">
		        <div class="row">
		          <c:if test="${not empty regMsgEdit }">
		            <div class="col-md-12">
		              <div class="alert bg-${cssEdit } alert-dismissible">
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
		          <div class="col-md-12">
		            <div class="card-body">
		              <div class="row">
		                <div class="col-md-12">
		                  <div class="form-group">
		                    <label for="departmentNameEdit"><span class="mandatory">*</span>Department Name</label>
		                    <input type="text" class="form-control" id="departmentNameEdit" placeholder="Enter Department Name" name="departmentName" />
		                    <span class="error invalid-feedback" id="departmentNameErrorEdit"></span>
		                  </div>
		                </div>
		                <div class="col-md-12">
		                  <div class="form-group">
		                    <label for="departmentDescriptionEdit"><span class="mandatory">*</span>Department Description</label>
		                    <input type="text" class="form-control" id="departmentDescriptionEdit" placeholder="Enter Department Description" name="departmentDescription" />
		                    <span class="error invalid-feedback" id="departmentDescriptionErrorEdit"></span>
		                  </div>
		                </div>
		                <div class="col-md-12">
		                  <div class="form-check" id="isActiveEditDiv">
		                    <label><span class="mandatory">*</span>Department Active/InActive</label>
		                    <div class="custom-control custom-radio">
		                      <input type="radio" name="departmentActive" class="custom-control-input" value="1" id="departmentActiveEdit1" name="departmentActive" />
		                      <label for="departmentActiveEdit1" class="custom-control-label sequence-font-1">Active</label>
		                    </div>
		                    <div class="custom-control custom-radio">
		                      <input type="radio" name="departmentActive" class="custom-control-input" value="0" id="departmentActiveEdit2" name="departmentActive" />
		                      <label for="departmentActiveEdit2" class="custom-control-label sequence-font-1">Inactive</label>
		                    </div>
		                    <span class="error invalid-feedback" id="isActiveEditError" style="display:block" ></span> 
		                  </div>
		                </div>
		              </div>
		            </div>
		          </div>
		        </div>
		      </div>
		      <div class="modal-footer justify-content-between">
		        <button title="Close" id="closeEditDepartmentModal" type="button" class="btn sequence-bg-1" data-dismiss="modal">Close</button>
		        <button type="submit" id="saveDepartmentChanges" class="btn bg-1" title="Edit Department Details">Edit Department Details</button>
		      </div>
		      </form>
		    </div>
		  </div>
		</div>

      </div>
      <%@include file="../includeJSP/footer.jsp"%>
    </div>
    <%@include file="../includeJSP/jsFiles.jsp"%>
    <%@include file="../includeJSP/dataTablesImport.jsp"%>
    <script src="usedStaticFiles/essentials/js/jsp_js_files/masters/department.js"></script>
  </body>
</html>
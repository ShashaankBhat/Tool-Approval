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
    <title>APP DUMP<%@include file="../includeJSP/company_name_title.jsp"%></title>
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
                <h5 class="font-3 font-weight-bold">APP DUMP LIST</h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item font-1"><a href="dashboard" title="Dashboard">Dashboard</a></li>
                  <li class="breadcrumb-item font-1"><a href="master" title="Masters Dashboard">Masters</a></li>
                  <li class="breadcrumb-item font-3 active">App Dump</li>
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
		        <form:form modelAttribute="appDump" action="app-dump" id="app" method="post">
		        <div class="card collapsed-card">
		          <div class="card-header bg-1" data-card-widget="collapse">
		            <h5 class="card-title font-weight-bold">Add App Dump</h5>
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
		                  <label class="font-1" for="appDumpName"><span class="mandatory">*</span>App Name</label>
		                  <form:input type="text" class="form-control" id="appDumpName" placeholder="Enter App Name" path="appDumpName" />
		                  <span class="error invalid-feedback" id="appDumpNameError"></span>
		                </div>
		              </div>
		              <div class="col-md-8">
		                <div class="form-group">
		                  <label class="font-2" for="appDumpLink"><span class="mandatory">*</span>App Link</label>
		                  <form:input type="text" class="form-control" id="appDumpLink" placeholder="Enter App Link" path="appDumpLink" />
		                  <span class="error invalid-feedback" id="appDumpLinkError"></span>
		                </div>
		              </div>
		              <div class="col-md-6">
		                <div class="form-group">
		                  <label class="font-3" for="appDumpDescription"><span class="mandatory">*</span>App Description</label>
		                  <form:input type="text" class="form-control" id="appDumpDescription" placeholder="Enter App Description" path="appDumpDescription" />
		                  <span class="error invalid-feedback" id="appDumpDescriptionError"></span>
		                </div>
		              </div>
		              <div class="col-md-6">
		                <div class="form-group">
		                  <label class="font-2" for="appDumpDescription2"><span class="mandatory">*</span>App Description2</label>
		                  <form:input type="text" class="form-control" id="appDumpDescription2" placeholder="Enter App Description2" path="appDumpDescription2" />
		                  <span class="error invalid-feedback" id="appDumpDescription2Error"></span>
		                </div>
		              </div>
		              <div class="col-md-4">
		                <div class="form-group">
		                  <label for="tempEntityId" class="font-1">Entity</label>
		                  <form:select path="tempEntityId" id="tempEntityId" class="form-control select2">
		                    <form:option value="-1">-- Select Entity --</form:option>
		                    <c:forEach items="${activeParentEntityList }" var="entity" varStatus="entityStatus">
		                      <form:option value="${entity.mEntityId }">${entity.entityName } - ${entity.entityAcronym }</form:option>
		                    </c:forEach>
		                  </form:select>
		                  <span class="error invalid-feedback" id="tempEntityIdError"></span>
		                </div>
		              </div>
		              <div class="col-md-4">
		                <div class="form-group">
		                  <label for="tempDepartmentId" class="font-2">Department</label>
		                  <form:select id="tempDepartmentId" path="tempDepartmentId" class="form-control select2">
		                    <form:option value="-1">-- Select Department --</form:option>
		                    <c:forEach items="${activeDepartmentList }" var="department" varStatus="departmentStatus">
		                      <form:option value="${department.mDepartmentId }">${department.departmentName }</form:option>
		                    </c:forEach>
		                  </form:select>
		                  <span class="error invalid-feedback" id="tempDepartmentIdError"></span>
		                </div>
		              </div>
		              <div class="col-md-2">
		                <div class="form-check" id="isActiveDiv">
		                  <label class="font-3"><span class="mandatory">*</span>App Dump Active/InActive</label>
		                  <div class="custom-control custom-radio">
		                    <form:radiobutton path="appDumpActive" class="custom-control-input" value="1" id="appDumpActive1" name="appDumpActive" />
		                    <label for="appDumpActive1" class="custom-control-label sequence-font-5">Active</label>
		                  </div>
		                  <div class="custom-control custom-radio">
		                    <form:radiobutton path="appDumpActive" class="custom-control-input" value="0" id="appDumpActive2" name="appDumpActive" />
		                    <label for="appDumpActive2" class="custom-control-label sequence-font-1">Inactive</label>
		                  </div>
		                  <span class="error invalid-feedback" id="isActiveError" style="display:block" ></span> 
		                </div>
		              </div>
		              <div class="col-md-2">
		                <div class="form-check">
		                  <br>
		                  <button style="float: left;" title="Add App" type="submit" id="submitAppButton" class="btn bg-1">Submit</button>
		                </div>
		              </div>
		            </div>
		          </div>
		        </div>
		        </form:form>
		      </div>
		    </div>
		    
		    <div class="row">
		      <div class="col-md-12">
		        <div class="card card-secondary">
		          <div class="card-header bg-3">
		            <h5 class="card-title font-weight-bold">List of Apps</h5>
		          </div>
		          <div class="card-body">
		            <div class="row">
		              <div class="col-md-12 tableOverFlowDiv">
		                <table class="table table-bordered table-striped dataTable" id="appTable">
		                  <thead>
		                    <tr class="bg-table-head">
		                      <th>Action</th>
		                      <th>Name</th>
		                      <th>Description</th>
		                      <th>Description 2</th>
		                      <th>Department</th>
		                      <th>Entity</th>
		                      <th>Active/In-Active</th>
		                      <th>Created By</th>
		                      <th>Updated By</th>
		                    </tr>
		                  </thead>
		                  <tbody>
		                    <c:forEach items="${appDumpList }" var="app" varStatus="appLoop">
		                      <tr class="bg-table-row-${appLoop.index %2 }">
		                        <td>${app.actionForList }</td>
		                        <td>
		                          <a href="${app.appDumpLink }" target="_target">${app.appDumpName }</a>
		                        </td>
		                        <td>${app.appDumpDescription }</td>
		                        <td>${app.appDumpDescription2 }</td>
		                        <td>${app.appDumpDepartment.departmentName }</td>
		                        <td>${app.appDumpEntity.entityName }</td>
		                        <td>
		                          <c:choose>
		                            <c:when test="${app.appDumpActive eq 1 }"><span class="badge sequence-bg-5">Active</span></c:when>
		                            <c:otherwise><span class="badge sequence-bg-1">In-Active</span></c:otherwise>
		                          </c:choose>
		                        </td>
		                        <td>
		                          ${app.appDumpCreatedBy.userFirstName } ${app.appDumpCreatedBy.userLastName }<br>
		                          <fmt:formatDate pattern = "dd-MMM-yyyy" value = "${app.appDumpCreatedOn }" />
		                        </td>
		                        <td>
		                          ${app.appDumpUpdatedBy.userFirstName } ${app.appDumpUpdatedBy.userLastName }<br>
		                          <fmt:formatDate pattern = "dd-MMM-yyyy" value = "${app.appDumpUpdatedOn }" />
		                        </td>
		                      </tr>
		                    </c:forEach>
		                  </tbody>
		                  <tfoot>
		                    <tr class="bg-table-foot">
		                      <th>Action</th>
		                      <th>Name</th>
		                      <th>Description</th>
		                      <th>Description 2</th>
		                      <th>Department</th>
		                      <th>Entity</th>
		                      <th>Active/In-Active</th>
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

		  </div>
		</section>
		
		<div class="modal fade" id="editAppModal">
		  <div class="modal-dialog modal-lg">
		    <div class="modal-content">
		      <form:form modelAttribute="appDump" action="app-dump" id="appEdit" method="post">
		      <form:hidden path="mAppDumpId" id="mAppDumpId" />
		      <div class="modal-header bg-3">
		        <h4 class="modal-title font-weight-bold">Edit App Dump</h4>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	              <span aria-hidden="true"><i class="text-white font-weight-bold fas fa-times"></i></span>
	            </button>
		      </div>
		      <div class="modal-body">
		        <div class="row">
		          <c:if test="${not empty regMsgEdit }">
		            <div class="col-md-12">
		              <div class="alert ${cssEdit } alert-dismissible">
		                <button type="button" title="CLose Alert Box" class="close" data-dismiss="alert" aria-hidden="true"><i class="fas fa-times"></i></button>
		                <c:if test="${css eq 'sequence-bg-1'}">
		                  <h5><i class="icon fas fa-ban"></i>${regMsgEdit }</h5>
		                </c:if>
		                <c:if test="${css ne 'sequence-bg-1'}">
		                  <h5><i class="icon fas fa-check"></i>${regMsgEdit }</h5>
		                </c:if>
		              </div>
		            </div>
		          </c:if>
		          <div class="col-md-12">
		            <div class="card-body">
		              <div class="row">
		                <div class="col-md-6">
		                  <div class="form-group">
		                    <label class="font-1" for="appDumpNameEdit"><span class="mandatory">*</span>App Name</label>
		                    <form:input type="text" class="form-control" id="appDumpNameEdit" placeholder="Enter App Name" path="appDumpName" />
		                    <span class="error invalid-feedback" id="appNameErrorEdit"></span>
		                  </div>
		                </div>
		                <div class="col-md-6">
		                  <div class="form-group">
		                    <label class="font-2" for="appDumpLinkEdit"><span class="mandatory">*</span>App Link</label>
		                    <form:input type="text" class="form-control" id="appDumpLinkEdit" placeholder="Enter App Link" path="appDumpLink" />
		                    <span class="error invalid-feedback" id="appDumpLinkErrorEdit"></span>
		                  </div>
		                </div>
		                <div class="col-md-6">
		                  <div class="form-group">
		                    <label class="font-3" for="appDumpDescriptionEdit"><span class="mandatory">*</span>App Description</label>
		                    <form:input type="text" class="form-control" id="appDumpDescriptionEdit" placeholder="Enter App Description" path="appDumpDescription" />
		                    <span class="error invalid-feedback" id="appDumpDescriptionEditError"></span>
		                  </div>
		                </div>
		                <div class="col-md-6">
		                  <div class="form-group">
		                    <label class="font-2" for="appDumpDescription2Edit"><span class="mandatory">*</span>App Description2</label>
		                    <form:input type="text" class="form-control" id="appDumpDescription2Edit" placeholder="Enter App Description2" path="appDumpDescription2" />
		                    <span class="error invalid-feedback" id="appDumpDescription2EditError"></span>
		                  </div>
		                </div>
		                <div class="col-md-6">
		                  <div class="form-group">
		                    <label for="tempDepartmentIdEdit" class="font-1">Entity</label>
		                    <form:select path="tempEntityId" id="tempEntityIdEdit" class="form-control select2">
		                      <form:option value="-1">-- Select Entity --</form:option>
		                      <c:forEach items="${activeParentEntityList }" var="entity" varStatus="entityStatus">
		                        <form:option value="${entity.mEntityId }">${entity.entityName } - ${entity.entityAcronym }</form:option>
		                      </c:forEach>
		                    </form:select>
		                    <span class="error invalid-feedback" id="tempEntityIdEditError"></span>
		                  </div>
		                </div>
		                <div class="col-md-6">
		                  <div class="form-group">
		                    <label for="tempDepartmentIdEdit" class="font-2">Department</label>
		                    <form:select id="tempDepartmentIdEdit" path="tempDepartmentId" class="form-control select2">
		                      <form:option value="-1">-- Select Department --</form:option>
		                      <c:forEach items="${activeDepartmentList }" var="department" varStatus="departmentStatus">
		                        <form:option value="${department.mDepartmentId }">${department.departmentName }</form:option>
		                      </c:forEach>
		                    </form:select>
		                    <span class="error invalid-feedback" id="tempDepartmentIdEditError"></span>
		                  </div>
		                </div>
		                <div class="col-md-6">
		                  <div class="form-check" id="isActiveEditDiv">
		                    <label class="font-3"><span class="mandatory">*</span>App Active/InActive</label>
		                    <div class="custom-control custom-radio">
		                      <form:radiobutton path="appDumpActive" class="custom-control-input" value="1" id="appDumpActiveEdit1" name="appDumpActive" />
		                      <label for="appDumpActiveEdit1" class="custom-control-label sequence-font-5">Active</label>
		                    </div>
		                    <div class="custom-control custom-radio">
		                      <form:radiobutton path="appDumpActive" class="custom-control-input" value="0" id="appDumpActiveEdit2" name="appDumpActive" />
		                      <label for="appDumpActiveEdit2" class="custom-control-label sequence-font-1">Inactive</label>
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
		        <button title="Close" id="closeEditAppModal" type="button" class="btn sequence-bg-1" data-dismiss="modal">Close</button>
		        <button type="submit" id="saveAppChanges" class="btn bg-1" title="Edit App Details">Edit App Details</button>
		      </div>
		      </form:form>
		    </div>
		  </div>
		</div>

      </div>
      <%@include file="../includeJSP/footer.jsp"%>
    </div>
    <%@include file="../includeJSP/jsFiles.jsp"%>
    <%@include file="../includeJSP/dataTablesImport.jsp"%>
    <script src="usedStaticFiles/essentials/js/jsp_js_files/masters/app-dump.js"></script>
  </body>
</html>
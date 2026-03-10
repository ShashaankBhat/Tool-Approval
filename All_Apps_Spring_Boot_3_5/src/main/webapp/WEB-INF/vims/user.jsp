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
    <title>USER<%@include file="../includeJSP/company_name_title.jsp"%></title>
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
                <h5 class="font-3">USER LIST</h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item font-1"><a href="dashboard" title="Dashboard">Dashboard</a></li>
                  <li class="breadcrumb-item font-1"><a href="master" title="Visitor Management Dashboard">VIMS Dashboard</a></li>
                  <li class="breadcrumb-item font-3 active">User
                  <input type="hidden" value="${openAddModal }" id="openAddModel" />
		              <input type="hidden" value="${openEditModel }" id="openEditModel" />
                  </li>
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
		          <div class="card-header bg-1">
		            <h5 class="card-title font-weight-bold">List of Users</h5>
		          </div>
		          <div class="card-body">
		            <div class="row">
		              <div class="col-md-12 tableOverFlowDiv">
		                <table class="table table-bordered table-striped dataTable" id="userTable">
		                  <thead>
		                    <tr class="bg-table-head">
		                      <th>Action</th>
		                      <th>First Name</th>
		                      <th>Middle Name</th>
		                      <th>Last Name</th>
		                      <th>Email Id</th>
		                      <th>Entity</th>
		                      <th>Location</th>
		                      <th>Zone</th>
		                      <th>Roles</th>
		                      <th>Active/In-Active</th>
		                    </tr>
		                  </thead>
		                  <tbody>
		                    <c:forEach items="${userList }" var="user" varStatus="userLoop">
		                      <tr class="bg-table-row-${roleLoop.index %2 }">
		                        <td>${user.action }</td>
		                        <td>${user.userFirstName }</td>
		                        <td>${user.userMiddleName }</td>
		                        <td>${user.userLastName }</td>
		                        <td>${user.userLoginId }</td>
		                        <td>${user.mEntityId.entityName }</td>
		                        <td>${user.mEntityId.locationId.locationName }</td>
		                        <td>${user.mEntityId.locationId.mZoneId.zoneName }</td>
		                        <td>${user.rolesAvailable }</td>
		                        <td>
		                          <c:choose>
		                            <c:when test="${user.userActive eq 1 }"><span class="badge sequence-bg-5">Active</span></c:when>
		                            <c:otherwise><span class="badge sequence-bg-1">In-Active</span></c:otherwise>
		                          </c:choose>
		                        </td>
		                      </tr>
		                    </c:forEach>
		                  </tbody>
		                  <tfoot>
		                    <tr class="bg-table-foot">
		                      <th>Action</th>
		                      <th>First Name</th>
		                      <th>Middle Name</th>
		                      <th>Last Name</th>
		                      <th>Email Id</th>
		                      <th>Entity</th>
		                      <th>Location</th>
		                      <th>Zone</th>
		                      <th>Roles</th>
		                      <th>Active/In-Active</th>
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

		<div class="modal fade" id="userInfomationEditModal">
		  <div class="modal-dialog modal-xl">
		    <div class="modal-content">
		      <form:form modelAttribute="user" action="user" id="userEditForm" method="post">
		        <form:hidden path="mUserId" id="mUserId" />
		      <div class="modal-header bg-3">
		        <h4 class="modal-title font-weight-bold">Edit User</h4>
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
		                 <div class="col-md-4">
                                       <div class="form-group">
                                          <label class="font-1" for="userFirstName"><span class="mandatory">*</span>First Name</label>
                                          <form:input id="userFirstNameEdit" path="userFirstName" type="text" class="form-control" placeholder="First Name" />
                                          <span class="error invalid-feedback" id="userFirstNameErrorEdit"></span>
                                       </div>
                                    </div>
                                    <div class="col-md-4">
                                       <div class="form-group">
                                          <label class="font-2" for="userMiddleName"><span class="mandatory">*</span>Middle Name</label>
                                          <form:input id="userMiddleNameEdit" path="userMiddleName" type="text" class="form-control" placeholder="Middle Name" />
                                          <span class="error invalid-feedback" id="userMiddleNameErrorEdit"></span>
                                       </div>
                                    </div>
                                    <div class="col-md-4">
                                       <div class="form-group">
                                          <label class="font-3" for="userLastName"><span class="mandatory">*</span>Last Name</label>
                                          <form:input id="userLastNameEdit" path="userLastName" type="text" class="form-control" placeholder="Last Name" />
                                          <span class="error invalid-feedback" id="userLastNameErrorEdit"></span>
                                       </div>
                                    </div>
                                    <div class="col-md-8">
                                       <div class="form-group">
                                          <label class="font-1" for="userLoginId">Email ID</label>
                                          <form:input id="userLoginIdEdit" path="userLoginId" type="text" class="form-control" placeholder="Email ID" />
                                          <span class="error invalid-feedback" id="userLoginIdErrorEdit"></span>
                                          <span class="error invalid-feedback formError" id="emailCheckLoader" style="display:none;color:black;">
                                             Checking for email uniqueness&nbsp;<img src="usedStaticFiles/essentials/images/dotted_loader.gif" height="10px" />
                                          </span>
                                       </div>
                                    </div>
                                    <div class="col-md-4">
                                       <div class="form-group">
                                          <label class="font-2" for="userPhoneNumber"><span class="mandatory">*</span>Phone No</label>
                                          <form:input id="userPhoneNumberEdit" path="userPhoneNumber" type="text" class="form-control" placeholder="Phone No" />
                                          <span class="error invalid-feedback" id="userPhoneNumberErrorEdit"></span>
                                       </div>
                                    </div>
                                    <div class="col-md-6">
                                       <div class="form-group">
                                          <label class="font-1" for="tempEntityIdEdit"><span class="mandatory">*</span>Entity</label>
                                          <form:select id="tempEntityIdEdit" class="form-control select2" path="tempEntityId">
                                             <form:option value="-1">-- Select Entity --</form:option>
                                             <c:forEach items="${activeChildEntityList }" var="entity" varStatus="entityStatus">
                                                <form:option value="${entity.mEntityId }">${entity.entityName } - ${entity.entityAcronym } - ${entity.locationId.locationName }</form:option>
                                             </c:forEach>
                                          </form:select>
                                          <span class="error invalid-feedback" id="tempEntityIdErrorEdit"></span>
                                       </div>
                                    </div>
                                    <div class="col-md-3">
                                       <div class="form-group">
                                          <label class="font-2" for="tempDesignationId"><span class="mandatory">*</span>Designation</label>
                                          <form:select id="tempDesignationIdEdit" path="tempDesignationId" class="form-control select2">
                                             <form:option value="-1">-- Select Designation --</form:option>
                                             <c:forEach items="${activeDesignationList }" var="designation" varStatus="desginationStatus">
                                                <form:option value="${designation.mDesignationId }">${designation.designationName }</form:option>
                                             </c:forEach>
                                          </form:select>
                                          <span class="error invalid-feedback" id="tempDesignationIdErrorEdit"></span>
                                       </div>
                                    </div>
                                    <div class="col-md-3">
                                       <div class="form-group">
                                          <label class="font-3" for="tempDepartmentIdEdit"><span class="mandatory">*</span>Department</label>
                                          <form:select id="tempDepartmentIdEdit" path="tempDepartmentId" class="form-control select2">
                                             <form:option value="-1">-- Select Department --</form:option>
                                             <c:forEach items="${activeDepartmentList }" var="department" varStatus="departmentStatus">
                                                <form:option value="${department.mDepartmentId }">${department.departmentName }</form:option>
                                             </c:forEach>
                                          </form:select>
                                          <span class="error invalid-feedback" id="tempDepartmentIdErrorEdit"></span>
                                       </div>
                                    </div>
                                    <div class="col-md-6">
                                       <div class="form-group">
                                          <label class="font-1" for="userManagerId"><span class="mandatory">*</span>Reporting Manager</label>
                                          <form:select id="userReportingManagerEdit" path="userManagerId" class="form-control select2" style="height:100%">
                                             <form:option value="-1">-- Select Reporting Manager --</form:option>
                                             <c:forEach items="${activeUsers }" var="user" varStatus="userStatus">
                                                <form:option value="${user.mUserId }">${user.userFirstName } ${user.userLastName }, ${user.mDesignationId.designationName }, ${user.mDepartmentId.departmentName }</form:option>
                                             </c:forEach>
                                          </form:select>
                                          <span class="error invalid-feedback" id="userReportingManagerEditError"></span>
                                       </div>
                                    </div>
                                    <div class="col-md-3">
                                       <div class="form-group">
                                          <label class="font-2" for="userRolesTemp"><span class="mandatory">*</span>Roles</label>
                                          <form:select id="userRolesTempEdit" path="userRolesTemp" class="form-control select2" multiple="multiple">
                                             <form:option value="-1">-- Select Roles --</form:option>
                                             <c:forEach items="${roleList }" var="role" varStatus="roleStatus">
                                                <c:if test="${role.roleActive eq 1 }">
                                                   <form:option value="${role.mRoleId }">${role.roleName }</form:option>
                                                </c:if>
                                             </c:forEach>
                                          </form:select>
                                          <span class="error invalid-feedback" id="userRolesTempErrorEdit"></span>
                                       </div>
                                    </div>
                                    
                                    <div class="col-md-3">
                                       <div class="form-group">
                                          <label class="font-3" for="userRolesTemp"><span class="mandatory">*</span>Apps Access</label>
                                          <form:select id="userAppsTempEdit" path="userAppsTemp" class="form-control select2" multiple="multiple">
                                             <form:option value="-1">-- Select Apps --</form:option>
                                             <c:forEach items="${activeApps }" var="app" varStatus="appStatus">
                                                <c:if test="${app.appActive eq 1 }">
                                                   <form:option value="${app.mAppId }">${app.appName }</form:option>
                                                </c:if>
                                             </c:forEach>
                                          </form:select>
                                          <span class="error invalid-feedback" id="userAppsTempErrorEdit"></span>
                                       </div>
                                    </div>

                                    <div class="col-md-4">
                                       <div class="form-check" id="isActiveDiv">
                                          <label class="font-1"><span class="mandatory">*</span>User Active/InActive</label>
                                          <div class="custom-control custom-radio">
                                             <form:radiobutton path="userActive" class="custom-control-input" value="1" id="userActive1" name="userActive" />
                                             <label for="userActive1" class="custom-control-label sequence-font-5">Active</label>
                                          </div>
                                          <div class="custom-control custom-radio">
                                             <form:radiobutton path="userActive" class="custom-control-input" value="0" id="userActive2" name="userActive" />
                                             <label for="userActive2" class="custom-control-label sequence-font-1">Inactive</label>
                                          </div>
                                          <span class="error invalid-feedback" id="isActiveError" style="display:block" ></span> 
                                       </div>
                                    </div>
                                    <%-- <div class="col-md-4">
                                       <div class="form-group">
                                          <label for="userPassword"><span class="mandatory">*</span>Password</label>
                                          <form:input id="userPassword" path="userPassword" type="password" class="form-control" placeholder="Password" />
                                          <span class="error invalid-feedback" id="userPasswordError"></span>
                                       </div>
                                    </div>
                                    <div class="col-md-4">
                                       <div class="form-group">
                                          <label for="userPasswordTwo"><span class="mandatory">*</span>Re-Type Password</label>
                                          <form:input id="userPasswordTwo" path="userPasswordTwo" type="password" class="form-control" placeholder="Re-Type Password" />
                                          <span class="error invalid-feedback" id="userPasswordTwoError"></span>
                                       </div>
                                    </div> --%>
		              </div>
		            </div>
		          </div>
		        </div>
		      </div>
		      <div class="modal-footer justify-content-between">
		        <button title="Close" id="closeEditUserModal" type="button" class="btn sequence-bg-1" data-dismiss="modal">Close</button>
		        <button type="submit" id="saveUserChanges" class="btn bg-1" title="Edit User Details">Edit User Details</button>
		      </div>
		      </form:form>
		    </div>
		  </div>
		</div>
		
		
		<div class="modal fade" id="userInformationModal">
		  <div class="modal-dialog modal-lg">
		    <div class="modal-content">
		      <div class="modal-header bg-3">
		        <h4 class="modal-title font-weight-bold">User Information</h4>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	              <span aria-hidden="true"><i class="text-white font-weight-bold fas fa-times"></i></span>
	            </button>
		      </div>
		      <div class="modal-body">
		        <div class="row">
		          <div class="col-md-12">
		            <div class="card-body">
		              <div class="row">
		                <div class="col-md-4">
		                  <div class="form-group">
		                    <label class="font-1" for="userFirstName">First Name</label>
		                    <br><span class="userFirstName"></span>
		                  </div>
		                </div>
		                <div class="col-md-4">
		                  <div class="form-group">
		                    <label class="font-2" for="userMiddleName">Middle Name</label>
		                    <span class="userMiddleName"></span>
		                  </div>
		                </div>
                        <div class="col-md-4">
                          <div class="form-group">
                            <label class="font-3" for="userLastName">Last Name</label>
                            <br><span class="userLastName"></span>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group">
                            <label class="font-1" for="userLoginId">Email ID</label>
                            <br><span class="userLoginId"></span>
                          </div>
                        </div>
                        <div class="col-md-3">
                          <div class="form-group">
                            <label  class="font-2" for="tempDesignationId">Designation</label>
                            <br><span class="tempDesignationId"></span>
                          </div>
                        </div>
                        <div class="col-md-3">
                          <div class="form-group">
                            <label class="font-3" for="tempDepartmentId">Department</label>
                            <br><span class="tempDepartmentId"></span>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group">
                            <label class="font-1" for="tempEntityId">Entity</label>
                            <br><span class="tempEntityId"></span>
                          </div>
                        </div>
                        <div class="col-md-3">
                          <div class="form-group">
                            <label class="font-2" for="tempLocationId">Location</label>
                            <br><span class="tempLocationId"></span>
                          </div>
                        </div>
                        <div class="col-md-3">
                          <div class="form-group">
                            <label class="font-3" for="userPhoneNumber">Phone No</label>
                            <br><span class="userPhoneNumber"></span>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group">
                            <label class="font-1" for="userReportingManagerName">Reporting Manager Name</label>
                            <br><span class="userReportingManagerName"></span>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group">
                            <label class="font-2" for="userReportingManagerMail">Reporting Manager Mail ID</label>
                            <br><span class="userReportingManagerMail"></span>
                          </div>
                        </div>
		              </div>
		            </div>
		          </div>
		        </div>
		      </div>
		      <div class="modal-footer justify-content-between">
		        <button title="Close" id="userInfoCloase" type="button" class="btn sequence-bg-1" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		  </div>
		</div>

      </div>
      <%@include file="includeJSP/footer.jsp"%>
    </div>
    <%@include file="../includeJSP/jsFiles.jsp"%>
    <%@include file="../includeJSP/dataTablesImport.jsp"%>
    <script src="usedStaticFiles/essentials/js/jsp_js_files/masters/user.js"></script>
  </body>
</html>
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
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>REGISTER USER<%@include file="../includeJSP/company_name_title.jsp"%></title>
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
                <h5 class="font-3 font-weight-bold">NEW REGISTRATION</h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item font-1"><a href="dashboard" title="Dashboard">Dashboard</a></li>
                  <c:if test="${itAdmin eq 1 }">
                    <li class="breadcrumb-item font-1"><a href="master" title="Masters Dashboard">Masters</a></li>
                  </c:if>
                  <li class="breadcrumb-item font-3 active">Registration</li>
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
		        <div class="card card-secondary">
		          <form:form modelAttribute="user" action="vims-registration" id="signUpForm" method="post">
		          <form:hidden id="mUserId" path="mUserId"/>
		          <div class="card-header bg-3">
		            <h5 class="card-title font-weight-bold">New User Registration</h5>
		          </div>
		          <form:hidden id="userId" path="mUserId" />
		            <div class="card-body">
		              <div class="row">
		                <c:if test="${not empty regMsg_login }">
		                  <div class="alert alert-${css_login } alert-dismissible">
		                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true"><i class="fas fa-close"></i></button>
		                    <c:if test="${css_login eq 'danger'}">
		                      <h5><i class="icon fas fa-ban"></i>${regMsg_login }</h5>
		                    </c:if>
		                    <c:if test="${css_login ne 'danger'}">
		                      <h5><i class="icon fas fa-check"></i>${regMsg_login }</h5>
		                    </c:if>
		                  </div>
		                </c:if>
		                <div class="col-md-4">
		                  <div class="form-group">
		                    <label for="userFirstName" class="font-1"><span class="mandatory">*</span>First Name</label>
		                    <form:input id="userFirstName" path="userFirstName" type="text" class="form-control" placeholder="First Name" />
		                    <span class="error invalid-feedback" id="userFirstNameError"></span>
		                  </div>
		                </div>
		                <div class="col-md-4">
		                  <div class="form-group">
		                    <label for="userMiddleName" class="font-2">Middle Name</label>
		                    <form:input id="userMiddleName" path="userMiddleName" type="text" class="form-control" placeholder="Middle Name" />
		                    <span class="error invalid-feedback" id="userMiddleNameError"></span>
		                  </div>
		                </div>
		                <div class="col-md-4">
		                  <div class="form-group">
		                    <label for="userLastName" class="font-3"><span class="mandatory">*</span>Last Name</label>
		                    <form:input id="userLastName" path="userLastName" type="text" class="form-control" placeholder="Last Name" />
		                    <span class="error invalid-feedback" id="userLastNameError"></span>
		                  </div>
		                </div>
		                <div class="col-md-6">
		                  <div class="form-group">
		                    <label for="userLoginId" class="font-1"><span class="mandatory">*</span>Email ID</label>
		                    <input id="loadTimeEmailId" value="${user.userLoginId }" type="hidden" />
		                    <form:input id="userLoginId" path="userLoginId" type="text" class="form-control" placeholder="Email ID" />
		                    <span class="error invalid-feedback" id="userLoginIdError"></span>
		                    <span class="error invalid-feedback formError" id="emailCheckLoader" style="display:none;color:black;">
		                      Checking for email uniqueness&nbsp;<img src="usedStaticFiles/essentials/images/dotted_loader.gif" height="10px" />
		                    </span>
		                  </div>
		                </div>
		                <div class="col-md-3">
		                  <div class="form-group">
		                    <label for="userPassword" class="font-2"><span class="mandatory">*</span>Password</label>
		                    <form:input id="userPassword" path="userPassword" type="password" class="form-control" placeholder="Password" />
		                    <span class="error invalid-feedback" id="userPasswordError"></span>
		                  </div>
		                </div>
		                <div class="col-md-3">
		                  <div class="form-group">
		                    <label for="userPasswordTwo" class="font-3"><span class="mandatory">*</span>Re-Type Password</label>
		                    <form:input id="userPasswordTwo" path="userPasswordTwo" type="password" class="form-control" placeholder="Re-Type Password" />
		                    <span class="error invalid-feedback" id="userPasswordTwoError"></span>
		                  </div>
		                </div>
		                <div class="col-md-4">
		                  <div class="form-group">
		                    <label for="tempEntityId" class="font-1"><span class="mandatory">*</span>Entity</label>
		                    <form:select path="tempEntityId" id="tempEntityId" class="form-control select2">
		                      <form:option value="-1">-- Select Entity --</form:option>
		                      <%-- <c:forEach items="${activeChildEntityList }" var="entity" varStatus="entityStatus"> --%>
		                      <c:forEach items="${entityList }" var="entity" varStatus="entityStatus">
		                        <c:choose>
		                          <c:when test="${itAdmin eq 1 || vimsAdmin eq 1 }">
		                            <form:option value="${entity.mEntityId }">${entity.locationId.locationName } - ${entity.entityName } - ${entity.entityAcronym }</form:option>
		                          </c:when>
		                          <c:when test="${vimsReception eq 1 }">
		                            <form:option value="${entity.mEntityId }">${entity.locationId.locationName } - ${entity.entityName } - ${entity.entityAcronym }</form:option>
		                          </c:when>
		                        </c:choose>
		                      </c:forEach>
		                    </form:select>
		                    <span class="error invalid-feedback" id="tempEntityIdError"></span>
		                  </div>
		                </div>
		                <div class="col-md-4">
		                  <div class="form-group">
		                    <label for="tempDesignationId" class="font-2"><span class="mandatory">*</span>Designation</label>
		                    <form:select id="tempDesignationId" path="tempDesignationId" class="form-control select2">
		                      <form:option value="-1">-- Select Designation --</form:option>
		                      <c:forEach items="${activeDesignationList }" var="designation" varStatus="desginationStatus">
		                        <form:option value="${designation.mDesignationId }">${designation.designationName }</form:option>
		                      </c:forEach>
		                    </form:select>
		                    <span class="error invalid-feedback" id="tempDesignationIdError"></span>
		                  </div>
		                </div>
		                <div class="col-md-4">
		                  <div class="form-group">
		                    <label for="tempDepartmentId" class="font-3"><span class="mandatory">*</span>Department</label>
		                    <form:select id="tempDepartmentId" path="tempDepartmentId" class="form-control select2">
		                      <form:option value="-1">-- Select Department --</form:option>
		                      <c:forEach items="${activeDepartmentList }" var="department" varStatus="departmentStatus">
		                        <form:option value="${department.mDepartmentId }">${department.departmentName }</form:option>
		                      </c:forEach>
		                    </form:select>
		                    <span class="error invalid-feedback" id="tempDepartmentIdError"></span>
		                  </div>
		                </div>
		                <div class="col-md-6">
		                  <div class="form-group">
		                    <label class="font-1" for="userEntitysTemp"><span class="mandatory">*</span>Entity Allowed</label>
		                    <input type="hidden" id="entityiesTempId" value="${user.userEntitysTemp }" />
		                    <form:select id="userEntitysTemp" path="userEntitysTemp" class="form-control select2" multiple="multiple">
		                      <form:option value="-1">-- Select Entities --</form:option>
		                      <c:forEach items="${entityList }" var="entity" varStatus="roleStatus">
		                        <c:if test="${entity.entityActive eq 1 }">
		                          <form:option value="${entity.mEntityId }">${entity.locationId.locationName } - ${entity.entityName }</form:option>
		                        </c:if>
		                      </c:forEach>
		                    </form:select>
		                    <span class="error invalid-feedback" id="userEntitysTempError"></span>
		                  </div>
		                </div>
		                <div class="col-md-6">
		                  <div class="form-group">
		                    <label class="font-2" for="userRolesTemp"><span class="mandatory">*</span>Roles</label>
		                    <input type="hidden" id="entityiesTempId1" value="${user.userRolesTemp }" />
		                    <form:select id="userRolesTemp" path="userRolesTemp" class="form-control select2" multiple="multiple">
		                      <form:option value="-1">-- Select Roles --</form:option>
		                      <c:forEach items="${roleList }" var="role" varStatus="roleStatus">
		                        <c:if test="${fn:contains(role.roleName, 'VIMS') && role.roleActive eq 1}">
		                          <form:option value="${role.mRoleId }">${role.roleName }</form:option>
		                        </c:if>
		                      </c:forEach>
		                    </form:select>
		                    <span class="error invalid-feedback" id="userRolesTempError"></span>
		                  </div>
		                </div>
		              </div>
		            </div>
		            <div class="card-footer">
		              <button id="submitSignUpForm" type="submit" title="Submit Sign-Up Information" class="btn bg-1 float-right font-weight-bold">Register User</button>
		            </div>
		          </form:form>
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
    <script src="usedStaticFiles/essentials/js/jsp_js_files/vims/vims-registration.js"></script>
  </body>
</html>
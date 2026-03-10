<!-- ****************************************************************************************
# *******************************************************************************************
# Copyright Â© 2021 Anand Group India. All rights reserved. *
# No part of this product may be reproduced in any form by any means without prior *
# written authorization of Anand Automotive Private Limited and its licensors, if any. *
# *******************************************************************************************
# Author - Sheshadhri Iyer *
# *************************************************************************************** -->
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
	<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
	<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
	
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>ADD NEW USER<%@include file="../includeJSP/company_name_title.jsp"%></title>
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
         <form modelAttribute="user" action="signup" id="signUpForm" method="post">
         <div class="card-header bg-3">
           <h5 class="card-title font-weight-bold">New User Registration</h5>
         </div>
         
         
         <hidden id="userId" name="mUserId" />
                              <div class="card-body">
                                 <div class="row">
                                    <c:if test="${not empty regMsg_login }">
                                    <div class="alert alert-${css_login } alert-dismissible">
                                       <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
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
                                          <input id="userFirstName" name="userFirstName" type="text" class="form-control" placeholder="First Name" />
                                          <span class="error invalid-feedback" id="userFirstNameError"></span>
                                       </div>
                                    </div>
                                    <div class="col-md-4">
                                       <div class="form-group">
                                          <label for="userMiddleName" class="font-2">Middle Name</label>
                                          <input id="userMiddleName" name="userMiddleName" type="text" class="form-control" placeholder="Middle Name" />
                                          <span class="error invalid-feedback" id="userMiddleNameError"></span>
                                       </div>
                                    </div>
                                    <div class="col-md-4">
                                       <div class="form-group">
                                          <label for="userLastName" class="font-3"><span class="mandatory">*</span>Last Name</label>
                                          <input id="userLastName" name="userLastName" type="text" class="form-control" placeholder="Last Name" />
                                          <span class="error invalid-feedback" id="userLastNameError"></span>
                                       </div>
                                    </div>
                                    <div class="col-md-6">
                                       <div class="form-group">
                                          <label for="userLoginId" class="font-1"><span class="mandatory">*</span>Email ID</label>
                                          <input id="userLoginId" name="userLoginId" type="text" class="form-control" placeholder="Email ID" />
                                          <span class="error invalid-feedback" id="userLoginIdError"></span>
                                          <span class="error invalid-feedback formError" id="emailCheckLoader" style="display:none;color:black;">
                                             Checking for email uniqueness&nbsp;<img src="usedStaticFiles/essentials/images/dotted_loader.gif" height="10px" />
                                          </span>
                                       </div>
                                    </div>
                                    <div class="col-md-6">
                                       <div class="form-group">
                                          <label for="tempEntityId" class="font-1"><span class="mandatory">*</span>Entity</label>
                                          <select name="tempEntityId" id="tempEntityId" class="form-control select2">
                                             <option value="-1">-- Select Entity --</option>
                                             <c:forEach items="${activeChildEntityList }" var="entity" varStatus="entityStatus">
                                               <option value="${entity.mEntityId }">${entity.entityName } - ${entity.locationId.locationName } - ${entity.entityAcronym }</option>
                                             </c:forEach>
                                          </select>
                                          <span class="error invalid-feedback" id="tempEntityIdError"></span>
                                       </div>
                                    </div>
                                    <div class="col-md-4">
                                       <div class="form-group">
                                          <label for="tempDesignationId" class="font-2"><span class="mandatory">*</span>Designation</label>
                                          <select id="tempDesignationId" name="tempDesignationId" class="form-control select2">
                                             <option value="-1">-- Select Designation --</option>
                                             <c:forEach items="${activeDesignationList }" var="designation" varStatus="desginationStatus">
                                                <option value="${designation.mDesignationId }">${designation.designationName }</option>
                                             </c:forEach>
                                          </select>
                                          <span class="error invalid-feedback" id="tempDesignationIdError"></span>
                                       </div>
                                    </div>
                                    <div class="col-md-4">
                                       <div class="form-group">
                                          <label for="tempDepartmentId" class="font-3"><span class="mandatory">*</span>Department</label>
                                          <select id="tempDepartmentId" name="tempDepartmentId" class="form-control select2">
                                             <option value="-1">-- Select Department --</option>
                                             <c:forEach items="${activeDepartmentList }" var="department" varStatus="departmentStatus">
                                                <option value="${department.mDepartmentId }">${department.departmentName }</option>
                                             </c:forEach>
                                          </select>
                                          <span class="error invalid-feedback" id="tempDepartmentIdError"></span>
                                       </div>
                                    </div>
                                    <div class="col-md-2">
                                       <div class="form-group">
                                          <label for="userPassword" class="font-2"><span class="mandatory">*</span>Password</label>
                                          <input id="userPassword" name="userPassword" type="password" class="form-control" placeholder="Password" />
                                          <span class="error invalid-feedback" id="userPasswordError"></span>
                                       </div>
                                    </div>
                                    <div class="col-md-2">
                                       <div class="form-group">
                                          <label for="userPasswordTwo" class="font-3"><span class="mandatory">*</span>Re-Type Password</label>
                                          <input id="userPasswordTwo" name="userPasswordTwo" type="password" class="form-control" placeholder="Re-Type Password" />
                                          <span class="error invalid-feedback" id="userPasswordTwoError"></span>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                              <div class="card-footer">
                                <!-- <button type="submit" id="saveAppChanges" class="btn bg-1" title="Edit App Details">Edit App Details</button> -->
                                <button id="submitSignUpForm" type="submit" title="Submit Sign-Up Information" class="btn bg-1 float-right font-weight-bold">Register User</button>
                              </div>
         
         </form>
       </div>
     </div>
   </div>

 </div>
</section>
      </div>
      <%@include file="../includeJSP/footer.jsp"%>
    </div>
    <%@include file="../includeJSP/jsFiles.jsp"%>
    <%@include file="../includeJSP/dataTablesImport.jsp"%>
    <script src="usedStaticFiles/essentials/js/jsp_js_files/masters/sign-up.js"></script>
  </body>
</html>

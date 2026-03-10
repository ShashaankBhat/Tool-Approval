<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
   <head>
      <%@include file="includeJSP/cssFiles.jsp"%>
      <title>SIGNUP | COMPANY-NAME</title>
   </head>
   <body class="hold-transition layout-top-nav pace-primary">
      <div class="wrapper">
         <nav class="main-header navbar navbar-expand-md navbar-light navbar-white">
            <h4 class="nav-link brand-text font-1" style="width: 100%;">
               <strong>COMPANY-NAME</strong>
               Central - Self Registration
            </h4>
            <div class="container">
               <button class="navbar-toggler order-1" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                  <span class="navbar-toggler-icon"></span>
               </button>
               <ul class="order-1 order-md-3 navbar-nav navbar-no-expand ml-auto">
                  <li class="nav-item">
                     <a target="_blank" href="https://www.anandgroupindia.com/" title="Anand Group India" target="_" class="navbar-brand">
                        <img src="" style="height:27px;padding-top:2px" alt="Company Logo" class="brand-image">
                     </a>
                  </li>
               </ul>
            </div>
         </nav>
         <div class="package-loader">
            <img id = "packageLoaderImage" src="usedStaticFiles/essentials/images/loader.gif" width="64" alt="">
         </div>
         <!-- <div class="content-wrapper bg-image"> -->
         <div class="content-wrapper">
            <form:form modelAttribute="user" action="signup" id="signUpForm" method="post">
               <div class="content">
                  <c:if test="${not empty regMsg }">
                     <div class="alert alert-${css } alert-dismissible">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <c:if test="${css eq 'danger'}">
                           <h5><i class="icon fas fa-ban"></i>${regMsg }</h5>
                        </c:if>
                        <c:if test="${css ne 'danger'}">
                           <h5><i class="icon fas fa-check"></i>${regMsg }</h5>
                        </c:if>
                     </div>
                  </c:if>
                  <div class="container">
                     <div class="row">
                        <div class="col-md-12"><br>
                           <div class="card card-primary">
                              <form:hidden id="userId" path="mUserId" />
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
                                          <form:input id="userFirstName" path="userFirstName" type="text" class="form-control" placeholder="First Name" />
                                          <span class="error invalid-feedback" id="userFirstNameError"></span>
                                       </div>
                                    </div>
                                    <div class="col-md-4">
                                       <div class="form-group">
                                          <label for="userMiddleName" class="font-2"><span class="mandatory">*</span>Middle Name</label>
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
                                    <div class="col-md-8">
                                       <div class="form-group">
                                          <label for="userLoginId" class="font-1"><span class="mandatory">*</span>Email ID</label>
                                          <form:input id="userLoginId" path="userLoginId" type="text" class="form-control" placeholder="Email ID" />
                                          <span class="error invalid-feedback" id="userLoginIdError"></span>
                                          <span class="error invalid-feedback formError" id="emailCheckLoader" style="display:none;color:black;">
                                             Checking for email uniqueness&nbsp;<img src="usedStaticFiles/essentials/images/dotted_loader.gif" height="10px" />
                                          </span>
                                       </div>
                                    </div>
                                    <div class="col-md-4">
                                       <div class="form-group">
                                          <label for="userPhoneNumber" class="font-2"><span class="mandatory">*</span>Phone No</label>
                                          <form:input id="userPhoneNumber" path="userPhoneNumber" type="text" class="form-control" placeholder="Phone No" />
                                          <span class="error invalid-feedback" id="userPhoneNumberError"></span>
                                       </div>
                                    </div>
                                    <div class="col-md-4">
                                       <div class="form-group">
                                          <label for="tempEntityId" class="font-1"><span class="mandatory">*</span>Entity</label>
                                          <form:select path="tempEntityId" id="tempEntityId" class="form-control select2">
                                             <form:option value="-1">-- Select Entity --</form:option>
                                             <c:forEach items="${activeChildEntityList }" var="entity" varStatus="entityStatus">
                                                <form:option value="${entity.mEntityId }">${entity.entityName } - ${entity.entityAcronym } - ${entity.locationId.locationName }</form:option>
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
                                          <label for="userManagerId" class="font-1"><span class="mandatory">*</span>Reporting Manager</label>
                                          <form:select id="userManagerId" path="userManagerId" class="form-control select2" style="height:100%">
                                             <form:option value="-1">-- Select Reporting Manager --</form:option>
                                             <c:forEach items="${activeUsers }" var="user" varStatus="userStatus">
                                                <form:option value="${user.mUserId }">${user.userFirstName } ${user.userLastName }, ${user.mDesignationId.designationName }, ${user.mDepartmentId.departmentName }</form:option>
                                             </c:forEach>
                                          </form:select>
                                          <span class="error invalid-feedback" id="userManagerIdError"></span>
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
                                 </div>
                                 <div class="row">
                                    <div class="col-10">
                                      <p class="mb-1 font-weight-bold">
                                        <a href="login.html" title="Back to login page." class="font-2">Login</a>
                                      </p>
                                    </div>
                                    <div class="col-2">
                                       <button id="submitSignUpForm" type="submit" onclick="" title="Submit Sign-Up Information" 
                                         class="btn bg-1 float-right font-weight-bold">Sign Up</button>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </form:form>
         </div>
      </div>
      <footer class="main-footer" style="margin-left: 0px;">
        <strong>Copyright © 2023&ensp;<a href="#" title="Website Link">COMPANY-NAME</a>.</strong>
        All rights reserved.
        <div class="float-right d-none d-sm-inline-block">
          <b>COMPANY-NAME Central</b>&ensp;v.1.0.0
        </div>
      </footer>
      <%@include file="includeJSP/jsFiles.jsp"%>
      <script type="text/javascript" src="usedStaticFiles/essentials/js/jsp_js_files/signup.js"></script>
   </body>
</html>
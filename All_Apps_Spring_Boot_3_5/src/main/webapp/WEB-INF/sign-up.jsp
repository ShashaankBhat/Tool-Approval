<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<!-- Favicon Image -->
		<link rel="shortcut icon" href="usedStaticFiles/essentials/images/favicon/favicon_blue.ico" type="image/x-icon">
		<title>LOGIN<%@include file="includeJSP/company_name_title.jsp"%></title>
    <%@include file="includeJSP/cssFiles.jsp"%>
  </head>
  <body class="hold-transition login-page pace-primary">
    <div class="package-loader">
      <img id = "packageLoaderImage" src="usedStaticFiles/essentials/images/loader.gif" width="64" alt="">
    </div>
    <div class="login-box">
      <div class="login-logo">
        <img src="usedStaticFiles/essentials/images/logo.png" style="height:50px;" alt="Company Logo" class="brand-image">
        <h5 class="login-box-msg font-3 font-weight-bold">Register Yourself</h5>
      </div>
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
      
      <div class="card">
        <div class="card-body login-card-body">
          <h5 class="login-box-msg font-2 font-weight-bold">${firstName } ${lastName }</h5>
          <h5 class="login-box-msg" style='font-size:13px'>
            <a href="https://anandgroupindia.com"  target="_blank" class="font-3 font-wight-bold">
              ${email }
            </a>
          </h5>
          <input type="hidden" value="${email }" id="emailTemp" />
          <input type="hidden" value="${firstName }" id="firstNameTemp" />
          <input type="hidden" value="${lastName }" id="lastNameTemp" />
          <form:form action="sign-up" modelAttribute="user" method="post" id="loginFormSignUp">
          <!-- <form action="login" method="post" id="loginForm"> -->
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
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <div class="input-group mb-3" style="display:none">
              <form:input id="userLoginId" path="userLoginId" type="text" class="form-control" placeholder="User Email ID" />
              <div class="input-group-append">
                <div class="input-group-text">
                  <span class="fas fa-envelope"></span>
                </div>
              </div>
              <span class="error invalid-feedback" id="userLoginIdError" style="display:block"></span>
            </div>
            <div class="input-group mb-3" style="display:none">
              <form:input id="userFirstName" path="userFirstName" type="text" class="form-control" placeholder="userFirstName" />
              <div class="input-group-append">
                <div class="input-group-text">
                  <span class="fas fa-user"></span>
                </div>
              </div>
              <span class="error invalid-feedback" id="userFirstNameError" style="display:block"></span>
            </div>
            <div class="input-group mb-3" style="display:none">
              <form:input value="${lastName }" id="userLastName" path="userLastName" type="text" class="form-control" placeholder="userLastName" />
              <div class="input-group-append">
                <div class="input-group-text">
                  <span class="fas fa-user"></span>
                </div>
              </div>
              <span class="error invalid-feedback" id="userLastNameError" style="display:block"></span>
            </div>
            <div class="input-group mb-3">
              <div class="form-group">
                <label for="tempEntityId" class="font-1"><span class="mandatory">*</span>Entity</label>
                <form:select path="tempEntityId" id="tempEntityId" class="form-control select2">
                  <form:option value="-1">-- Select Entity --</form:option>
                  <c:forEach items="${activeChildEntityList }" var="entity" varStatus="entityStatus">
                    <form:option value="${entity.mEntityId }">${entity.locationId.locationName } - ${entity.entitySource.entityName }</form:option>
                  </c:forEach>
                </form:select>
                <span class="error invalid-feedback" id="tempEntityIdError"></span>
              </div>
            </div>
            <div class="input-group mb-3">
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
            <div class="input-group mb-3">
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
            
            <div class="row">
              <div class="col-4 nextButton">
                <button type="submit" class="btn btn-block bg-2 font-weight-bold">Submit</button>
              </div>
            </div>
          </form:form>
        </div>
        <div class="card-footer login-card-footer text-center font-3">
          Copyright &copy; 2024 &nbsp;
          <a href="https://www.anandgroupindia.com/" target="_blank">Anand Group India</a>
          <br>All rights reserved.
        </div>
        
      </div>
    </div>
    <%@include file="includeJSP/jsFiles.jsp"%>
    <script type="text/javascript" src="usedStaticFiles/essentials/js/jsp_js_files/login_page.js"></script>
    <script>
    </script>
  </body>
</html>

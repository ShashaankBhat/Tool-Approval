<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>LOGIN | SPS CENTRAL</title>
    <%@include file="/WEB-INF/includeJSP/cssFiles.jsp"%>
  </head>
  <body class="hold-transition login-page pace-primary">
    <div class="package-loader">
      <img id = "packageLoaderImage" src="usedStaticFiles/essentials/images/loader.gif" width="64" alt="">
    </div>
    <div class="login-box">
      <div class="login-logo">
        <img src="" style="height:30px;" alt="Company Logo" class="brand-image"><br>
        <a href="#" class="font-weight-bold">COMPANY-NAME</a>
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
          <h5 class="login-box-msg font-weight-bold">COMPANY-NAME Central</h5>
          <p class="login-box-msg">Change your password and proceed.</p>
          <form action="resetPassword" method="post" id="resetPasswordForm">
            <input type="hidden" name="email" value="${userInfo.userLoginId }" />
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
            <div class="input-group mb-3">
                              <p>
                                 ${userInfo.userFirstName } ${userInfo.userLastName }
                                 <br>
                                 ${userInfo.userLoginId }
                              </p>
                           </div>
            <div class="input-group mb-3">
                              <input type="password" class="form-control" id="currentPassword" placeholder="Current Password" name = "currentPassword">
                              <div class="input-group-append">
                                 <div class="input-group-text">
                                    <span class="fas fa-lock"></span>
                                 </div>
                              </div>
                              <span class="error invalid-feedback" id="currentPasswordError" style="display:block"></span>
                           </div>
            <div class="input-group mb-3">
                              <input type="password" class="form-control" id="newPassword" placeholder="New Password" name = "newPassword">
                              <div class="input-group-append">
                                 <div class="input-group-text">
                                    <span class="fas fa-lock"></span>
                                 </div>
                              </div>
                              <span class="error invalid-feedback" id="newPasswordError" style="display:block"></span>
                           </div>
                           <div class="input-group mb-3">
                              <input type="password" class="form-control" id="confirmNewPassword" placeholder="Re-Enter New Password" name = "confirmNewPassword">
                              <div class="input-group-append">
                                 <div class="input-group-text">
                                    <span class="fas fa-lock"></span>
                                 </div>
                              </div>
                              <span class="error invalid-feedback" id="confirmNewPasswordError" style="display:block"></span>
                           </div>
            <div class="row">
              <div class="col-6"></div>
              <div class="col-6">
                <button id="submitReSetPassword" type="submit" class="btn btn-primary">Reset Password</button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
    <%@include file="/WEB-INF/includeJSP/jsFiles.jsp"%>
    <script type="text/javascript" src="usedStaticFiles/essentials/js/jsp_js_files/resetPassword.js"></script>
  </body>
</html>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
      </div>
      <c:if test="${not empty regMsg }">
        <div class="alert ${css } alert-dismissible">
          <button type="button" class="close text-white" data-dismiss="alert" aria-hidden="true">
            <i class="fas fa-times"></i>
          </button>
          <c:if test="${css eq 'sequence-bg-1'}">
            <h5><i class="icon fas fa-ban"></i>${regMsg }</h5>
          </c:if>
          <c:if test="${css ne 'sequence-bg-1'}">
            <h5><i class="icon fas fa-check"></i>${regMsg }</h5>
          </c:if>
        </div>
      </c:if>
      
      <div class="card">
        <div class="card-body login-card-body">
          <h5 class="login-box-msg">
            <a href="https://anandgroupindia.com"  target="_blank" class="font-2 font-wight-bold">
              ANAND Group India
            </a>
          </h5>
          <h5 class="login-box-msg font-3 font-weight-bold">Driving with you since 1961</h5>
          <form action="login" method="post" id="loginForm">
            <c:if test="${not empty regMsg_login }">
              <div class="alert ${css_login } alert-dismissible">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">X</button>
                <c:if test="${css_login eq 'sequence-bg-1'}">
                  <h5><i class="icon fas fa-ban"></i>${regMsg_login }</h5>
                </c:if>
                <c:if test="${css_login eq ' sequence-bg-1'}">
                  <h5><i class="icon fas fa-ban"></i>${regMsg_login }</h5>
                </c:if>
                <c:if test="${css_login eq 'sequence-bg-5'}">
                  <h5><i class="icon fas fa-check"></i>${regMsg_login }</h5>
                </c:if>
                <c:if test="${css_login eq ' sequence-bg-5'}">
                  <h5><i class="icon fas fa-check"></i>${regMsg_login }</h5>
                </c:if>
              </div>
            </c:if>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <div class="input-group mb-3 emailForSSO">
              <input id="email" name="email" type="text" class="form-control" placeholder="Username">
              <div class="input-group-append">
                <div class="input-group-text">
                  <span class="fas fa-envelope"></span>
                </div>
              </div>
              <span class="error invalid-feedback" id="emailError" style="display:block"></span>
            </div>
            <div class="input-group mb-3 passwordForSSO">
              <input id="password" name="password" type="password" class="form-control" placeholder="Password">
              <div class="input-group-append">
                <div class="input-group-text">
                  <span class="fas fa-lock"></span>
                </div>
              </div>
              <span class="error invalid-feedback" id="passwordError" style="display:block"></span>
            </div>
            <div class="row">
              <div class="col-4 nextButton">
                <button id="nextButton" type="button" class="btn btn-block bg-2 font-weight-bold">Next</button>
              </div>
              <div class="col-8 ssoButton">
                <button id="singleSignOnButton" type="button" onclick="" class="btn btn-block bg-1 font-weight-bold" title="Single Sign On">
                  ANAND Single Sign On
                </button>
              </div>
              <div class="col-4 passwordButton">
                <button id="submitLogin" type="submit" class="btn btn-block bg-2 font-weight-bold">Sign In</button>
              </div>
            </div>
          </form>
          <p class="mb-1 passwordButton">
            <a href="forgot-password" title="Forgot Password? Click here to re-set your password" 
            	class="font-2 font-weight-bold">I forgot my password</a>
          </p>
          <!-- <p class="mb-0 passwordButton">
            <a href="signup" title="New to the portal? Click here to Sign-Up" 
            	class="text-center font-3 font-weight-bold">Register a new membership</a>
          </p> -->
        </div>
        <div class="card-footer login-card-footer text-center font-3">
          Copyright &copy; 2025&ensp;<a href="https://www.anandgroupindia.com/" target="_blank">ANAND Group India</a>
          <br>All rights reserved.
        </div>
      </div>
    </div>
    <%@include file="includeJSP/jsFiles.jsp"%>
    <script type="text/javascript" src="usedStaticFiles/essentials/js/jsp_js_files/login_page.js"></script>
  </body>
</html>

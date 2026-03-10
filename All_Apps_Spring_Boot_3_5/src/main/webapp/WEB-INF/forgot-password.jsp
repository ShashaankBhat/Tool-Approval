<!DOCTYPE html>
<html lang="en">
  <head>
    <title>FORGOT PASSWORD | COMPANY-NAME</title>
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
          <h5 class="login-box-msg">
            <a href="https://anandgroupindia.com"  target="_blank" class="font-2 font-wight-bold">
              ANAND Group India
            </a>
          </h5>
          <p class="login-box-msg">You forgot your password? Here you can easily retrieve a new password.</p>
          <form action="forgot-password" method="post" id="forgotPasswordForm">
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
              <input id="email" name="email" type="text" class="form-control" placeholder="Username">
              <div class="input-group-append">
                <div class="input-group-text">
                  <span class="fas fa-envelope"></span>
                </div>
              </div>
              <span class="error invalid-feedback" id="emailError" style="display:block"></span>
            </div>
            <div class="row">
              <div class="col-4"></div>
              <div class="col-8">
                <button id="submitLogin" type="submit" class="btn btn-block bg-1 font-weight-bold">Request new password</button>
              </div>
            </div>
            <p class="mb-1 font-weight-bold">
              <a href="login" title="Login">Login</a>
            </p>
          </form>
        </div>
      </div>
    </div>
    <%@include file="includeJSP/jsFiles.jsp"%>
    <script type="text/javascript" src="usedStaticFiles/essentials/js/jsp_js_files/login_page.js"></script>
  </body>
</html>

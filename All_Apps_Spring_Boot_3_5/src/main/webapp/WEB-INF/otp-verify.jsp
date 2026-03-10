<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<!-- Favicon Image -->
		<link rel="shortcut icon" href="usedStaticFiles/essentials/images/favicon/favicon_blue.ico" type="image/x-icon">
		<title>OTP<%@include file="includeJSP/company_name_title.jsp"%></title>
    <%@include file="includeJSP/cssFiles.jsp"%>
  </head>
  <body class="hold-transition login-page pace-primary">
    <div class="package-loader">
      <img id = "packageLoaderImage" src="usedStaticFiles/essentials/images/loader.gif" width="64" alt="">
    </div>
    <div class="login-box">
     
      <c:if test="${not empty regMsg }">
        <div class="alert ${css } alert-dismissible">
          <button type="button" class="close" data-dismiss="alert" aria-hidden="true">�</button>
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
              ANAND Group
            </a>
          </h5>
          <h5 class="login-box-msg font-3 font-weight-bold">Driving with you since 1961</h5>
          <form action="otp-validate" method="post" id="loginForm">
            <c:if test="${not empty regMsg_login }">
              <div class="alert ${css_login } alert-dismissible sequence-bg-1">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                <h5><i class="icon fas fa-ban "></i>${regMsg_login }</h5>
              </div>
            </c:if>
          
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
          
            <div class="input-group mb-3">
              <input id="otp" name="otp" type="text" class="form-control" placeholder="Enter OTP" maxlength="6" />
              <div class="input-group-append">
                <div class="input-group-text">
                  <span class="fas fa-lock"></span>
                </div>
              </div>
              <span class="error invalid-feedback" id="otpError" style="display:block"></span>
            </div>
          
            <div class="row">
              <div class="col-4">
                <button id="submitOtp" type="submit" class="btn btn-block bg-2 font-weight-bold" disabled>Verify</button>
              </div>
            </div>
          </form>
        
       
        </div>
        
        <div class="card-footer login-card-footer text-center font-3">
				Copyright &copy; 2024 &nbsp;
				<a href="https://www.anandgroupindia.com/" target="_blank">Anand Group India</a>
				<br>All rights reserved.
			</div>
        
      </div>
    </div>
    <%@include file="includeJSP/jsFiles.jsp"%>
    <script>
      const otpInput = document.getElementById("otp");
      const submitButton = document.getElementById("submitOtp");
    
      otpInput.addEventListener("input", function () {
        // Remove non-numeric characters
        this.value = this.value.replace(/[^0-9]/g, "");
    
        // Enable submit button only if OTP is 4 digits
        if (this.value.length === 6) {
          submitButton.disabled = false;
        } else {
          submitButton.disabled = true;
        }
      });
    </script>
    <script type="text/javascript" src="usedStaticFiles/essentials/js/jsp_js_files/login_page.js"></script>
  </body>
</html>

	<nav class="main-header navbar navbar-expand navbar-white navbar-light">
	  <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
        </li>
        <li class="nav-link font-1 font-weight-bold">
          <c:if test="${sessionUserInfo.mEntityId.entityAcronym ne 'AAPL' }">
            <img src="usedStaticFiles/essentials/images/company_images/${sessionUserInfo.mEntityId.entityAcronym }.png" style="height:27px;" alt="Company Logo" class="brand-image">
          </c:if>
        </li>
      </ul>
      <ul class="navbar-nav ml-auto">
        <!-- Full Screen -->
        <!-- <li class="nav-item">
          <a class="nav-link" data-widget="fullscreen" href="#" role="button">
            <i class="fas fa-expand-arrows-alt"></i>
          </a>
        </li> -->
        <li class="nav-item d-none d-sm-inline-block">
          <img src="usedStaticFiles/essentials/images/logo.png" style="height:40px;" alt="Company Logo" class="brand-image">
        </li>
        <li class="nav-item dropdown">
      	  <a class="nav-link" href="#" title="Logout" data-toggle="dropdown">
            <i class="fas fa-sign-out-alt"></i>
          </a>
          <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
        	<a href="logout" class="dropdown-item">
              <i class="fas fa-sign-out-alt"></i> Logout
            </a>
          </div>
        </li>
      </ul>
    </nav>
    <div class="package-loader">
        <img id = "packageLoaderImage" src="usedStaticFiles/essentials/images/loader.gif" width="64" alt="">
      </div>
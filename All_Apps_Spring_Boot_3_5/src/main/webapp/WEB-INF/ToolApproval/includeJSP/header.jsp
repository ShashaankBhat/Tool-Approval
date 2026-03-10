	<nav class="main-header navbar navbar-expand navbar-white navbar-light">
	  <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
        </li>
        <li class="nav-link font-1 full-name font-weight-bold">${sessionUserInfo.userFirstName } ${sessionUserInfo.userLastName }, ${sessionUserInfo.mDepartmentId.departmentName }, ${sessionUserInfo.mEntityId.entityAcronym }, ${sessionUserInfo.mEntityId.locationId.locationName }</li>
        <li class="nav-link font-1 short-name font-weight-bold">${sessionUserInfo.userFirstName } ${sessionUserInfo.userLastName }</li>
      </ul>
      <ul class="navbar-nav ml-auto">
        <!-- <li class="nav-item">
          <a class="nav-link" data-widget="fullscreen" href="#" role="button">
            <i class="fas fa-expand-arrows-alt"></i>
          </a>
        </li> -->
        <li class="nav-item d-none d-sm-inline-block">
          <img src="usedStaticFiles/essentials/images/logo.png" style="height:40px;" alt="Company Logo" class="brand-image">
        </li>
        <li class="nav-item">
          <a class="nav-link" data-widget="control-sidebar" data-slide="true" href="#" role="button">
            <i class="fas fa-th-large"></i>
          </a>
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
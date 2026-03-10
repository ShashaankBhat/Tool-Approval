	<aside class="main-sidebar sidebar-dark-primary elevation-4 bg-2">
	  <a href="dashboard" class="brand-link bg-2" title="ANAND Central">
	    <img src="usedStaticFiles/essentials/images/favicon_white.ico" alt="Company Icon" class="brand-image img-circle img-circle elevation-5">
	    <span class="brand-text font-weight-light font-weight-bold text-white">${sessionUserInfo.userFirstName }</span>
	  </a>
	  <div class="sidebar">
	    <nav class="mt-2">
	      <ul class="nav nav-pills nav-sidebar flex-column nav-flat nav-child-indent" data-widget="treeview" role="menu" data-accordion="false">
	        <li class="nav-item">
	          <a href="dashboard" class="nav-link text-white" title="Dashboard" id="mainDashboard">
	            <i class="nav-icon fas fa-tachometer-alt"></i>
	            <p class="font-weight-bold">Dashboard</p>             
	          </a>
	        </li>
	        <li class="nav-item">
	          <a href="master" class="nav-link text-white" title="Admin Dashboard" id="adminDashboard">
	              <i class="nav-icon fas fa-database"></i>
	              <p class="font-weight-bold">Admin Dashboard</p>             
	            </a>
	        </li>
	        <c:if test="${itAdmin eq 1 || checkSheetAdmin eq 1 || plantCheckSheetAdmin eq 1 }">
	          <li class="nav-item">
	            <a href="signup" class="nav-link text-white" title="Register User">
	              <i class="nav-icon fas fa-user-plus"></i>
	              <p class="font-weight-bold">Register User</p>             
	            </a>
	          </li>
	        </c:if>
	      </ul>
        </nav>
      </div>
    </aside>
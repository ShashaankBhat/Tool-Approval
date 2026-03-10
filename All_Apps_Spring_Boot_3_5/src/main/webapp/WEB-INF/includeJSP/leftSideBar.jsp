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
	        <c:forEach items="${sessionUserApps }" var="userApps" varStatus="userAppsLoop">
	          <c:if test="${userApps.userAppActive eq 1 }">
	            <c:if test="${userApps.appInfoForUsers.appActive eq 1 }">
	              <li class="nav-item">
	                <a href="${userApps.appInfoForUsers.appLink }" class="nav-link text-white" title="Admin Dashboard" id="adminDashboard">
	                  <i class="nav-icon ${userApps.appInfoForUsers.appIcon }"></i>
	                  <p class="font-weight-bold">${userApps.appInfoForUsers.appName }</p>             
	                </a>
	              </li>
	            </c:if>
	          </c:if>
            </c:forEach>
	      </ul>
        </nav>
      </div>
    </aside>
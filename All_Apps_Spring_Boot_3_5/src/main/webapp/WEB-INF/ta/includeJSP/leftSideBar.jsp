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
	          <a href="dashboard-tool-approval" class="nav-link text-white" title="TA Masters" id="taMastersDashboard">
	            <i class="nav-icon fas fa-chart-line"></i>
	            <p class="font-weight-bold">TA Dashboard</p>             
	          </a>
	        </li>
	        <li class="nav-item">
	          <a href="ta-masters-dashboard" class="nav-link text-white" title="TA Masters" id="taMastersDashboard">
	            <i class="nav-icon fas fa-database"></i>
	            <p class="font-weight-bold">TA Masters</p>             
	          </a>
	        </li>
	        <li class="nav-item">
	          <a href="ta-approval-reqeust" class="nav-link text-white" title="TA Masters" id="taMastersDashboard">
	            <i class="nav-icon fas fa-plus-square"></i>
	            <p class="font-weight-bold">New Request</p>             
	          </a>
	        </li>
	        <li class="nav-item has-treeview">
	          <a href="#" class="nav-link text-white">
	            <i class="nav-icon fas fa-list"></i>
	            <p class="font-weight-bold">Reports<i class="right fas fa-angle-left"></i></p>
	          </a>
	          <ul class="nav nav-treeview" style="display: none;">
	            <li class="nav-item">
	              <a href="emc-coachee-list?batch-id=${emclatestBatchDetails.actCoachingBatchId }" class="nav-link text-white">
	                <i class="nav-icon fas fa-spinner sequence-font-3"></i>
	                <p class="font-weight-bold">Pending Requests</p>
	              </a>
	            </li>
	            <li class="nav-item">
	              <a href="emc-coachee-list?batch-id=${emclatestBatchDetails.actCoachingBatchId }" class="nav-link text-white">
	                <i class="nav-icon fas fa-thumbs-down sequence-font-1"></i>
	                <p class="font-weight-bold">Rejected Requests</p>
	              </a>
	            </li>
	            <li class="nav-item">
	              <a href="emc-coachee-list?batch-id=${emclatestBatchDetails.actCoachingBatchId }" class="nav-link text-white">
	                <i class="nav-icon fas fa-thumbs-up sequence-font-5"></i>
	                <p class="font-weight-bold">Approved Requests</p>
	              </a>
	            </li>
	          </ul>
	        </li>
	      </ul>
        </nav>
      </div>
    </aside>
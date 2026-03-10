    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<aside class="main-sidebar sidebar-dark-primary elevation-4 bg-2">
	  <a href="dashboard" class="brand-link bg-2" title="ANAND Central">
	    <img src="usedStaticFiles/essentials/images/favicon_white.ico" alt="Company Icon" class="brand-image img-circle img-circle elevation-5">
	    <span class="brand-text font-weight-light font-weight-bold text-white">Admin</span>
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
					<a href="dashboard-emc" class="nav-link text-white" title="EMC Dashboard">
						<i class="nav-icon fas fa-graduation-cap"></i>
						<p class="font-weight-bold">EMC Dashboard</p>
					</a>
				</li>
				<c:if test="${itAdmin eq 1 || emcAdmin eq 1 }">
				<li class="nav-item">
					<a href="emc-coaching-batch" class="nav-link text-white" title="Dashboard">
						<i class="nav-icon fas fa-book-reader"></i>
						<p class="font-weight-bold">EMC Batch</p>
					</a>
				</li>
				</c:if>
				<c:if test="${emcAdmin eq 1 || itAdmin eq 1 }">
				<li class="nav-item">
					<a href="emc-coaching-batch-details" class="nav-link text-white">
						<i class="fas fa-info nav-icon"></i>
						<p class="font-weight-bold">Batch Details</p>
					</a>
				</li>
				<li class="nav-item">
					<a href="emc-coaching-mis-report" class="nav-link text-white" title="EMC Dashboard">
						<i class="nav-icon fas fa-graduation-cap"></i>
						<p class="font-weight-bold">MIS Report</p>
					</a>
				</li>
				</c:if>
				<c:if test="${emcMentor eq 1 || emcMentee eq 1 }">
				<li class="nav-item has-treeview">
					<a href="#" class="nav-link text-white">
						<i class="nav-icon fas fa-info-circle"></i>
						<p class="font-weight-bold">Mentoring Details<i class="right fas fa-angle-left"></i></p>
					</a>
					<ul class="nav nav-treeview" style="display: none;">
						<c:if test="${emcMentor eq 1 }">
						<li class="nav-item">
							<a href="emc-coachee-list?batch-id=${emclatestBatchDetails.actCoachingBatchId }" class="nav-link text-white">
								<i class="nav-icon fas fa-list"></i>
								<p class="font-weight-bold">List My Mentee</p>
							</a>
						</li>
						</c:if>
						<c:if test="${emcMentee eq 1 }">
							
						<li class="nav-item">
							<!-- <a href="emc-coaching-batch-details" class="nav-link text-white"> -->
							<a href="emc-coaching-goals?batch-id=${emclatestBatchDetails.actCoachingBatchId }&coachee-id=${sessionUserInfo.mUserId }" class="nav-link text-white">
								<i class="nav-icon fas fa-bullseye"></i>
								<p class="font-weight-bold">Add Mentoring Goals</p>
							</a>
						</li>
						<li class="nav-item">
							<!-- <a href="emc-coaching-batch-details" class="nav-link text-white"> -->
							<a href="emc-coaching-report?batch-id=${emclatestBatchDetails.actCoachingBatchId }&coachee-id=${sessionUserInfo.mUserId }" class="nav-link text-white">
								<i class="nav-icon fas fa-list"></i>
								<p class="font-weight-bold">Add Mentoring Report</p>
							</a>
						</li>
						</c:if>
					</ul>


				</li>
				</c:if>


					<c:if test="${emcMentor eq 1 || emcMentee eq 1 ||emcAdmin eq 1 || itAdmin eq 1 }">
				<li class="nav-item">
					<a href="emc-feedback-list?batch-id=${emclatestBatchDetails.actCoachingBatchId }" class="nav-link text-white">
					<i class="nav-icon fas fa-list"></i>
						<p class="font-weight-bold">Feedback</p>
					</a>
				</li>
				</c:if>
	      </ul>
        </nav>
      </div>
    </aside>
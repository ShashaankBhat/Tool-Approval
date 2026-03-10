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
	            <a href="list-appointment" class="nav-link text-white" title="List Appointments">
	              <i class="nav-icon fas fa-clipboard-list"></i>
	              <p class="font-weight-bold">Visitor's Dashboard</p>             
	            </a>
	          </li>
	        <li class="nav-item">
	          <a href="book-appointment" class="nav-link text-white" title="Book Appointment" id="bookAppointment">
	              <i class="nav-icon fas fa-calendar-check"></i>
	              <p class="font-weight-bold">Book Appointment</p>             
	            </a>
	        </li>
	        <c:if test="${itAdmin eq 1 || vimsReception eq 1 }">
	          <li class="nav-item">
	            <a href="visitor-time-out" class="nav-link text-white" title="Book Appointment" id="bookAppointment">
	              <i class="nav-icon fas fa-hourglass-end"></i>
	              <p class="font-weight-bold">Visitor Time Out</p>
	            </a>
	          </li>
	        </c:if>
	        <c:if test="${itAdmin eq 1 || vimsAdmin eq 1 }">
	          <li class="nav-item">
	            <a href="#" class="nav-link text-white">
	              <i class="nav-icon fas fa-database"></i>
	              <p>
	                VIMS Masters
	                <i class="fas fa-angle-left right"></i>
	              </p>
	            </a>
	            <ul class="nav nav-treeview" style="display: none;">
	              <c:if test="${itAdmin eq 1 || vimsAdmin eq 1 }">
	              <li class="nav-item">
	                <a href="visitor-type" class="nav-link text-white" title="Visitor Type">
	                  <i class="nav-icon fas fa-layer-group"></i>
	                  <p class="font-weight-bold">Visitor Type</p>             
	                </a>
	              </li>
	              </c:if>
	              <c:if test="${itAdmin eq 1 || vimsAdmin eq 1 }">
	              <li class="nav-item">
	                <a href="visitor-purpose" class="nav-link text-white" title="Visitor Purpose">
	                  <i class="nav-icon fas fa-bullseye"></i>
	                  <p class="font-weight-bold">Visitor Purpose</p>             
	                </a>
	              </li>
	              </c:if>
	              <c:if test="${itAdmin eq 1 || vimsAdmin eq 1 }">
	              <li class="nav-item">
	                <a href="visitor-govt-type" class="nav-link text-white" title="Visitor Type">
	                  <i class="nav-icon fas fa-layer-group"></i>
	                  <p class="font-weight-bold">Visitor Govt ID Type</p>             
	                </a>
	              </li>
	              </c:if>
	              <c:if test="${itAdmin eq 1 || vimsAdmin eq 1 }">
	                <li class="nav-item">
	                  <a href="vims-user" class="nav-link text-white" title="List Users">
	                    <i class="nav-icon fas fa-clipboard-list"></i>
	                    <p class="font-weight-bold">List Users</p>             
	                  </a>
	                </li>
	                <li class="nav-item">
	                  <a href="vims-registration" class="nav-link text-white" title="Register User">
	                    <i class="nav-icon fas fa-user-plus"></i>
	                    <p class="font-weight-bold">Register User</p>             
	                  </a>
	                </li>
	              </c:if>
	            </ul>
	          </li>
	        </c:if>
	      </ul>
        </nav>
      </div>
    </aside>
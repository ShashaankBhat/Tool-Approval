<!-- ****************************************************************************************
# *******************************************************************************************
# Copyright © 2021 Anand Group India. All rights reserved.									*
# No part of this product may be reproduced in any form by any means without prior			*
# written authorization of Anand Automotive Private Limited and its licensors, if any.		*
# *******************************************************************************************
# Author - Sheshadhri Iyer																	*
# *************************************************************************************** -->
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>ADMIN DASHBOARD<%@include file="../includeJSP/company_name_title.jsp"%></title>
    <%@include file="../includeJSP/cssFiles.jsp"%>
  </head>
  <body class="sidebar-mini layout-navbar-fixed sidebar-collapse pace-primary">
    <div class="wrapper">
    <%@include file="includeJSP/header.jsp"%>
    <%@include file="includeJSP/leftSideBar.jsp"%>
    <div class="content-wrapper">
      <section class="content-header ">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-6">
              <h5 class="font-3 font-weight-bold">ADMIN DASHBOARD</h5>
            </div>
            <div class="col-sm-6">
              <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item font-weight-bold"><a href="dashboard" title="Dashboard">Dashboard</a></li>
                <li class="breadcrumb-item active font-weight-bold">Admin Dashboard</li>
              </ol>
            </div>
          </div>
        </div>
      </section>
      <c:if test="${not empty regMsg }">
          <section class="content content-margin">
            <div class="container-fluid">
              <div class="alert ${css } alert-dismissible">
                <button type="button" title="CLose Alert Box" class="close" data-dismiss="alert" aria-hidden="true"><i class="fas fa-times"></i></button>
                <c:if test="${css eq 'sequence-bg-1'}">
                  <h5><i class="icon fas fa-ban"></i>${regMsg }</h5>
                </c:if>
                <c:if test="${css ne 'sequence-bg-1'}">
                  <h5><i class="icon fas fa-check"></i>${regMsg }</h5>
                </c:if>
              </div>
            </div>
          </section>
        </c:if>
      <section class="content content-margin">
        <div class="container-fluid">
        
		  <c:if test="${itAdmin eq 1 }">
		  <div class="row">
		    
		    <div class="col-sm-6 col-lg-4 col-md-3">
		      <div class="card card-widget widget-user-2 shadow">
		        <div class="widget-user-header bg-${bg_counter }" title="Department Master" onclick="location.href='app';" style="cursor: pointer;">
		          <h4 class="font-weight-bold"><i class="fas fa-puzzle-piece"></i>&emsp;Applications</h4>
		        </div>
		        <div class="card-footer p-0">
		          <ul class="nav flex-column">
		            <li class="nav-item" title="Load All Application" style="cursor: pointer;" onclick="location.href='app?all=1';">
		              <div class="nav-link font-weight-bold font-${bg_counter }">Total Applications<span class="float-right badge span-info-width">${activeApps + inActiveApps }</span></div>
		            </li>
		            <li class="nav-item">
		              <div class="nav-link font-weight-bold sequence-font-5">Active<span title="Active Applications" class="float-right badge span-info-width">${activeApps }</span></div>
		            </li>
		            <li class="nav-item">
		              <div class="nav-link font-weight-bold sequence-font-1">In-Active<span title="In-Active Applications" class="float-right badge span-info-width">${inActiveApps }</span></div>
		            </li>
		          </ul>
		        </div>
		      </div>
		      <c:set var="bg_counter" value="${bg_counter + 1 }" />
		      <c:if test="${bg_counter eq 4 }">
		        <c:set var="bg_counter" value="1" />
		      </c:if>
		    </div>
		    <div class="col-sm-6 col-lg-4 col-md-3">
		      <div class="card card-widget widget-user-2 shadow">
		        <div class="widget-user-header bg-${bg_counter }" title="Application Dump Master" onclick="location.href='app-dump?all=1';" style="cursor: pointer;">
		          <h4 class="font-weight-bold"><i class="fas fa-puzzle-piece"></i>&emsp;Applications Dump</h4>
		        </div>
		        <div class="card-footer p-0">
		          <ul class="nav flex-column">
		            <li class="nav-item" title="Load All Application" style="cursor: pointer;" onclick="location.href='app?all=1';">
		              <div class="nav-link font-weight-bold font-${bg_counter }">Total Applications Dump<span class="float-right badge span-info-width">${activeApps + inActiveApps }</span></div>
		            </li>
		            <li class="nav-item">
		              <div class="nav-link font-weight-bold sequence-font-5">Active<span title="Active Applications" class="float-right badge span-info-width">${activeApps }</span></div>
		            </li>
		            <li class="nav-item">
		              <div class="nav-link font-weight-bold sequence-font-1">In-Active<span title="In-Active Applications" class="float-right badge span-info-width">${inActiveApps }</span></div>
		            </li>
		          </ul>
		        </div>
		      </div>
		      <c:set var="bg_counter" value="${bg_counter + 1 }" />
		      <c:if test="${bg_counter eq 4 }">
		        <c:set var="bg_counter" value="1" />
		      </c:if>
		    </div>
		    
		    <div class="col-sm-6 col-lg-4 col-md-3">
		      <div class="card card-widget widget-user-2 shadow">
		        <div class="widget-user-header bg-${bg_counter }" title="Entity Master" onclick="location.href='entity';" style="cursor: pointer;">
		          <h4 class="font-weight-bold"><i class="fas fa-building"></i>&emsp;Entity</h4>
		        </div>
		        <div class="card-footer p-0">
		          <ul class="nav flex-column">
		            <li class="nav-item" title="Load All Documents" style="cursor: pointer;" onclick="location.href='entity?all=1';">
		              <div class="nav-link font-weight-bold font-${bg_counter } font-weight-bold">Total Entities<span class="float-right badge span-info-width">${activeEntity + inActiveEntity }</span></div>
		            </li>
		            <li class="nav-item">
		              <div class="nav-link font-weight-bold font-weight-bold sequence-font-5">Active<span title="Active Entities" class="float-right badge span-info-width">${activeEntity }</span></div>
		            </li>
		            <li class="nav-item">
		              <div class="nav-link font-weight-bold font-weight-bold sequence-font-1">In-Active<span title="In-Active Entities" class="float-right badge span-info-width">${inActiveEntity }</span></div>
		            </li>
		          </ul>
		        </div>
		      </div>
		      <c:set var="bg_counter" value="${bg_counter + 1 }" />
		      <c:if test="${bg_counter eq 4 }">
		        <c:set var="bg_counter" value="1" />
		      </c:if>
		    </div>
		    <div class="col-sm-6 col-lg-4 col-md-3">
		      <div class="card card-widget widget-user-2 shadow">
		        <div class="widget-user-header bg-${bg_counter }" title="Location Master" onclick="location.href='location';" style="cursor: pointer;">
		          <h4 class="font-weight-bold"><i class="fas fa-street-view"></i>&emsp;Location</h4>
		        </div>
		        <div class="card-footer p-0">
		          <ul class="nav flex-column">
		            <li class="nav-item" title="Load All Documents" style="cursor: pointer;" onclick="location.href='location?all=1';">
		              <div class="nav-link font-weight-bold font-${bg_counter }">Total Locations<span class="float-right badge span-info-width">${activeLocation + inActiveLocation }</span></div>
		            </li>
		            <li class="nav-item">
		              <div class="nav-link font-weight-bold sequence-font-5">Active<span title="Active Location" class="float-right badge span-info-width">${activeLocation }</span></div>
		            </li>
		            <li class="nav-item">
		              <div class="nav-link font-weight-bold sequence-font-1">In-Active<span title="In-Active Location" class="float-right badge span-info-width">${inActiveLocation }</span></div>
		            </li>
		          </ul>
		        </div>
		      </div>
		      <c:set var="bg_counter" value="${bg_counter + 1 }" />
		      <c:if test="${bg_counter eq 4 }">
		        <c:set var="bg_counter" value="1" />
		      </c:if>
		    </div>
		    <div class="col-sm-6 col-lg-4 col-md-3">
		      <div class="card card-widget widget-user-2 shadow">
		        <div class="widget-user-header bg-${bg_counter }" title="Zone Master" onclick="location.href='zone';" style="cursor: pointer;">
		          <h4 class="font-weight-bold"><i class="fas fa-search-location"></i>&emsp;Zone</h4>
		        </div>
		        <div class="card-footer p-0">
		          <ul class="nav flex-column">
		            <li class="nav-item" title="Load All Documents" style="cursor: pointer;" onclick="location.href='zone?all=1';">
		              <div class="nav-link font-weight-bold font-${bg_counter }">Total Zones<span class="float-right badge span-info-width">${activeZone + inActiveZone }</span></div>
		            </li>
		            <li class="nav-item">
		              <div class="nav-link font-weight-bold sequence-font-5">Active<span title="Active Zones" class="float-right badge span-info-width">${activeZone }</span></div>
		            </li>
		            <li class="nav-item">
		              <div class="nav-link font-weight-bold sequence-font-1">In-Active<span title="In-Active Zones" class="float-right badge span-info-width">${inActiveZone }</span></div>
		            </li>
		          </ul>
		        </div>
		      </div>
		      <c:set var="bg_counter" value="${bg_counter + 1 }" />
		      <c:if test="${bg_counter eq 4 }">
		        <c:set var="bg_counter" value="1" />
		      </c:if>
		    </div>
		    <div class="col-sm-6 col-lg-4 col-md-3">
		      <div class="card card-widget widget-user-2 shadow">
		        <div class="widget-user-header bg-${bg_counter }" title="Role Master" onclick="location.href='user';" style="cursor: pointer;">
		          <h4 class="font-weight-bold"><i class="fas fa-users"></i>&emsp;User</h4>
		        </div>
		        <div class="card-footer p-0">
		          <ul class="nav flex-column">
		            <li class="nav-item" title="Load All Role" style="cursor: pointer;" onclick="location.href='user?all=1';">
		              <div class="nav-link font-weight-bold font-${bg_counter }">Total Users<span class="float-right badge span-info-width">${activeUsers + inActiveUsers }</span></div>
		            </li>
		            <li class="nav-item">
		              <div class="nav-link font-weight-bold sequence-font-5">Active<span title="Active Users" class="float-right badge span-info-width">${activeUsers }</span></div>
		            </li>
		            <li class="nav-item">
		              <div class="nav-link font-weight-bold sequence-font-1">In-Active<span title="In-Active Users" class="float-right badge span-info-width">${inActiveUsers }</span></div>
		            </li>
		          </ul>
		        </div>
		      </div>
		      <c:set var="bg_counter" value="${bg_counter + 1 }" />
		      <c:if test="${bg_counter eq 4 }">
		        <c:set var="bg_counter" value="1" />
		      </c:if>
		    </div>
		    <div class="col-sm-6 col-lg-4 col-md-3">
		      <div class="card card-widget widget-user-2 shadow">
		        <div class="widget-user-header bg-${bg_counter }" title="Department Master" onclick="location.href='department';" style="cursor: pointer;">
		          <h4 class="font-weight-bold"><i class="fas fa-puzzle-piece"></i>&emsp;Department</h4>
		        </div>
		        <div class="card-footer p-0">
		          <ul class="nav flex-column">
		            <li class="nav-item" title="Load All Documents" style="cursor: pointer;" onclick="location.href='department?all=1';">
		              <div class="nav-link font-weight-bold font-${bg_counter }">Total Departments<span class="float-right badge span-info-width">${activeDepartments + inActiveDepartments }</span></div>
		            </li>
		            <li class="nav-item">
		              <div class="nav-link font-weight-bold sequence-font-5">Active<span title="Active Departments" class="float-right badge span-info-width">${activeDepartments }</span></div>
		            </li>
		            <li class="nav-item">
		              <div class="nav-link font-weight-bold sequence-font-1">In-Active<span title="In-Active Departments" class="float-right badge span-info-width">${inActiveDepartments }</span></div>
		            </li>
		          </ul>
		        </div>
		      </div>
		      <c:set var="bg_counter" value="${bg_counter + 1 }" />
		      <c:if test="${bg_counter eq 4 }">
		        <c:set var="bg_counter" value="1" />
		      </c:if>
		    </div>
		    <div class="col-sm-6 col-lg-4 col-md-3">
		      <div class="card card-widget widget-user-2 shadow">
		        <div class="widget-user-header bg-${bg_counter }" title="Designation Master" onclick="location.href='designation';" style="cursor: pointer;">
		          <h4 class="font-weight-bold"><i class="fas fa-user-tie"></i>&emsp;Designation</h4>
		        </div>
		        <div class="card-footer p-0">
		          <ul class="nav flex-column">
		            <li class="nav-item" title="Load All Documents" style="cursor: pointer;" onclick="location.href='designation?all=1';">
		              <div class="nav-link font-weight-bold font-${bg_counter }">Total Designations<span class="float-right badge span-info-width">${activeDesignation + inActiveDesignation }</span></div>
		            </li>
		            <li class="nav-item">
		              <div class="nav-link font-weight-bold sequence-font-5">Active<span title="Active Designation" class="float-right badge span-info-width">${activeDesignation }</span></div>
		            </li>
		            <li class="nav-item">
		              <div class="nav-link font-weight-bold sequence-font-1">In-Active<span title="In-Active Designation" class="float-right badge span-info-width">${inActiveDesignation }</span></div>
		            </li>
		          </ul>
		        </div>
		      </div>
		      <c:set var="bg_counter" value="${bg_counter + 1 }" />
		      <c:if test="${bg_counter eq 4 }">
		        <c:set var="bg_counter" value="1" />
		      </c:if>
		    </div>
		    <div class="col-sm-6 col-lg-4 col-md-3">
		      <div class="card card-widget widget-user-2 shadow">
		        <div class="widget-user-header bg-${bg_counter }" title="Level" onclick="location.href='level';" style="cursor: pointer;">
		          <h4 class="font-weight-bold"><i class="fas fa-layer-group"></i>&emsp;Level</h4>
		        </div>
		        <div class="card-footer p-0">
		          <ul class="nav flex-column">
		            <li class="nav-item" title="Load All Documents" style="cursor: pointer;" onclick="location.href='level?all=1';">
		              <div class="nav-link font-weight-bold font-${bg_counter }">Total Levels<span class="float-right badge span-info-width">${activeMemberLevels + inActiveMemberLevels }</span></div>
		            </li>
		            <li class="nav-item">
		              <div class="nav-link font-weight-bold sequence-font-5">Active<span title="Active Levels" class="float-right badge span-info-width">${activeMemberLevels }</span></div>
		            </li>
		            <li class="nav-item">
		              <div class="nav-link font-weight-bold sequence-font-1">In-Active<span title="In-Active Levels" class="float-right badge span-info-width">${inActiveMemberLevels }</span></div>
		            </li>
		          </ul>
		        </div>
		      </div>
		      <c:set var="bg_counter" value="${bg_counter + 1 }" />
		      <c:if test="${bg_counter eq 4 }">
		        <c:set var="bg_counter" value="1" />
		      </c:if>
		    </div>
		    <div class="col-sm-6 col-lg-4 col-md-3">
		      <div class="card card-widget widget-user-2 shadow">
		        <div class="widget-user-header bg-${bg_counter }" title="Role Master" onclick="location.href='role';" style="cursor: pointer;">
		          <h4 class="font-weight-bold"><i class="fas fa-star"></i>&emsp;Role</h4>
		        </div>
		        <div class="card-footer p-0">
		          <ul class="nav flex-column">
		            <li class="nav-item" title="Load All Role" style="cursor: pointer;" onclick="location.href='role?all=1';">
		              <div class="nav-link font-weight-bold font-${bg_counter }">Total Role<span class="float-right badge span-info-width">${activeRoles + inActiveRoles }</span></div>
		            </li>
		            <li class="nav-item">
		              <div class="nav-link font-weight-bold sequence-font-5">Active<span title="Active Roles" class="float-right badge span-info-width">${activeRoles }</span></div>
		            </li>
		            <li class="nav-item">
		              <div class="nav-link font-weight-bold sequence-font-1">In-Active<span title="In-Active Roles" class="float-right badge span-info-width">${inActiveRoles }</span></div>
		            </li>
		          </ul>
		        </div>
		      </div>
		      <c:set var="bg_counter" value="${bg_counter + 1 }" />
		      <c:if test="${bg_counter eq 4 }">
		        <c:set var="bg_counter" value="1" />
		      </c:if>
		    </div>
		    <div class="col-sm-6 col-lg-4 col-md-3">
		      <div class="card card-widget widget-user-2 shadow">
		        <div class="widget-user-header bg-${bg_counter }" title="Mail Configuration Master" onclick="location.href='mail-configuration';" style="cursor: pointer;">
		          <h5 class="font-weight-bold"><i class="fas fa-mail-bulk"></i>&emsp;Mail Configuration</h5>
		        </div>
		        <div class="card-footer p-0">
		          <ul class="nav flex-column">
		            <li class="nav-item" title="Load All Documents" style="cursor: pointer;" onclick="location.href='mail-configuration?all=1';">
		              <div class="nav-link font-weight-bold font-${bg_counter }">Total Mail Configuration<span class="float-right badge span-info-width">${activeMailConfiguration + inActiveMailConfiguration }</span></div>
		            </li>
		            <li class="nav-item">
		              <div class="nav-link font-weight-bold sequence-font-5">Active<span title="Active Mail Config" class="float-right badge span-info-width">${activeMailConfiguration }</span></div>
		            </li>
		            <li class="nav-item">
		              <div class="nav-link font-weight-bold sequence-font-1">In-Active<span title="In-Active Mail Config" class="float-right badge span-info-width">${inActiveMailConfiguration }</span></div>
		            </li>
		          </ul>
		        </div>
		      </div>
		      <c:set var="bg_counter" value="${bg_counter + 1 }" />
		      <c:if test="${bg_counter eq 4 }">
		        <c:set var="bg_counter" value="1" />
		      </c:if>
		    </div>
		  </div>
		  </c:if>
		  
		</div>
	  </section>
    </div>
    <%@include file="../includeJSP/footer.jsp"%>
    </div>
    <%@include file="../includeJSP/jsFiles.jsp"%>
    <!-- <script>
    $("#adminDashboard").addClass("active");
    </script> -->
  </body>
</html>
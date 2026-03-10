<!-- ****************************************************************************************
# *******************************************************************************************
# Copyright © 2021 Anand Group India. All rights reserved.									*
# No part of this product may be reproduced in any form by any means without prior			*
# written authorization of Anand Automotive Private Limited and its licensors, if any.		*
# *******************************************************************************************
# Author - Sheshadhri Iyer																	*
# *************************************************************************************** -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>DASHBOARD<%@include file="includeJSP/company_name_title.jsp"%></title>
    <%@include file="includeJSP/cssFiles.jsp"%>
  </head>
  <body class="sidebar-mini layout-navbar-fixed sidebar-collapse pace-primary">
    <div class="wrapper">
      <%@include file="includeJSP/header.jsp"%>
      <%@include file="includeJSP/leftSideBar.jsp"%>
      <div class="content-wrapper">
        
        <section class="content-header">
          <div class="container-fluid">
            <div class="row mb-2">
              <div class="col-sm-9">
                <h5 class="font-3 full-name">${sessionUserInfo.userFirstName } ${sessionUserInfo.userLastName }, ${sessionUserInfo.mDepartmentId.departmentName }, ${sessionUserInfo.mEntityId.entityAcronym }, ${sessionUserInfo.mEntityId.locationId.locationName }</h5>
                <h5 class="font-3 short-name">${sessionUserInfo.userFirstName } ${sessionUserInfo.userLastName }</h5>
              </div>
              <div class="col-sm-3">
                <ol class="breadcrumb float-sm-right">
                  <!-- <li class="breadcrumb-item font-weight-bold"><a href="dashboard_v2">Dashboard v2</a></li> -->
                  <li class="breadcrumb-item font-weight-bold active">Dashboard</li>
                </ol>
              </div>
            </div>
          </div>
        </section>
        <c:if test="${not empty regMsg }">
          <section class="content content-margin">
            <div class="container-fluid">
              <div class="alert bg-${css } alert-dismissible">
                <button type="button" title="CLose Alert Box" class="close" data-dismiss="alert" aria-hidden="true"><i class="fas fa-times"></i></button>
                <c:if test="${css eq 'danger'}">
                  <h5><i class="icon fas fa-ban"></i>${regMsg }</h5>
                </c:if>
                <c:if test="${css ne 'danger'}">
                  <h5><i class="icon fas fa-check"></i>${regMsg }</h5>
                </c:if>
              </div>
            </div>
          </section>
        </c:if>


     
		<section class="content content-margin">
		  <div class="container-fluid">
		    <div class="row">
		        
		        <c:if test="${itAdmin eq 1 }">
                <div class="col-sm-12 col-md-6 col-lg-4">
                  <div class="small-box bg-${bg_counter }">
                    <div class="inner">
                      <h3>Admin</h3>
                      <p class="text-md font-weight-bold">
                        IT &amp; Functional Admin<br>
                        Masters &amp; Configuration Information
                      </p>
                    </div>
                    <div class="icon text-white">
                      <i class="fas fa-user-cog"></i>
                    </div>
                    <a href="master" class="small-box-footer font-weight-bold" title="Admin" >
                      More info&ensp;<i class="fas fa-arrow-circle-right"></i>
                    </a>
                  </div>
                </div>
                <c:set var="bg_counter" value="${bg_counter + 1 }" />
                </c:if>
                <div class="col-sm-12 col-md-6 col-lg-4">
                  <div class="small-box bg-${bg_counter }">
                    <div class="inner">
                      <h3>VIMS</h3>
                      <p class="text-md font-weight-bold">
                        Visitor Management System<br>
                        Visitor Management System
                      </p>
                    </div>
                    <div class="icon text-white">
                      <i class="fas fa-door-open"></i>
                    </div>
                    <a href="list-appointment" class="small-box-footer font-weight-bold" title="Visitor Management" >
                      More info&ensp;<i class="fas fa-arrow-circle-right"></i>
                    </a>
                  </div>
                </div>
                <c:set var="bg_counter" value="${bg_counter + 1 }" />
                <c:forEach items="${sessionUserApps }" var="userApps" varStatus="userAppsLoop">
                  <c:if test="${userApps.userAppActive eq 1 }">
                    <c:if test="${userApps.appInfoForUsers.appActive eq 1 }">
                      <div class="col-sm-12 col-md-6 col-lg-4">
                        <div class="small-box bg-${bg_counter }">
                          <div class="inner">
                            <h3>${userApps.appInfoForUsers.appName }</h3>
                            <p class="text-md font-weight-bold">
                              ${userApps.appInfoForUsers.appDescription }
                              <br>
                              ${userApps.appInfoForUsers.appDescription2 }
                            </p>
                          </div>
                          <div class="icon text-white">
                            <i class="${userApps.appInfoForUsers.appIcon }"></i>
                          </div>
                          <a href="${userApps.appInfoForUsers.appLink }" title="${userApps.appInfoForUsers.appName }" 
                          	class="small-box-footer font-weight-bold">
                            More info&ensp;<i class="fas fa-arrow-circle-right style"></i>
                          </a>
                        </div>
                      </div>
                      <c:set var="bg_counter" value="${bg_counter + 1 }" />
                    </c:if>
                  </c:if>
                  <c:if test="${bg_counter eq 4 }">
                    <c:set var="bg_counter" value="1" />
                  </c:if>
                </c:forEach>
		        
		    </div>

		  </div>
		</section>
      </div>
      <%@include file="includeJSP/footer.jsp"%>
    </div>
    <%@include file="includeJSP/jsFiles.jsp"%>
  </body>
</html>
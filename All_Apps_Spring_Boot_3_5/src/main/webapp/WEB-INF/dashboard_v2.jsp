<!-- ****************************************************************************************
# *******************************************************************************************
# Copyright © 2022 Anand Group India. All rights reserved.									*
# No part of this product may be reproduced in any form by any means without prior			*
# written authorization of Anand Automotive Private Limited and its licensors, if any.		*
# *******************************************************************************************
# Author - Sheshadhri Iyer																	*
# *************************************************************************************** -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>DASHBOARD<%@include file="includeJSP/company_name_title.jsp"%></title>
    <%@include file="includeJSP/cssFiles.jsp"%>
  </head>
  <body class="hold-transition layout-top-nav pace-primary">
    <div class="wrapper">
      <nav class="main-header navbar navbar-expand-md navbar-light navbar-white">
        <h4 class="nav-link font-1" style="width: 100%;">
          <strong><span class="firstletter">ANAND</span></strong>
          <strong><span class="firstletter">C</span></strong>entral
        </h4>
        <div class="container">
          <button class="navbar-toggler order-1" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <ul class="order-1 order-md-3 navbar-nav navbar-no-expand ml-auto">
            <li class="nav-item">
              <a target="_blank" href="https://www.anandgroupindia.com/" title="Anand Group India" target="_" class="navbar-brand">
                <img src="usedStaticFiles/essentials/images/logo.png" style="height:40px;" alt="Company Logo" class="brand-image">
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
        </div>
      </nav>
      <div class="package-loader">
        <img id = "packageLoaderImage" src="usedStaticFiles/essentials/images/loader.gif" width="64" alt="">
      </div>
      <div class="content-wrapper">
        
        <c:if test="${not empty regMsg }">
          <section class="content">
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
        
        <section class="content-header">
          <div class="wrapper">
            <div class="container-fluid">
            <div class="row mb-2">
              <div class="col-sm-7">
                <h5 class="font-2 font-weight-bold">${sessionUserInfo.userFirstName } ${sessionUserInfo.userLastName },</strong> ${sessionUserInfo.mDepartmentId.departmentName }, ${sessionUserInfo.mEntityId.entityAcronym }, ${sessionUserInfo.mEntityId.locationId.locationName }</h5>
              </div>
              <div class="col-sm-5">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item font-weight-bold"><a href="dashboard">Dashboard v2</a></li>
                  <li class="breadcrumb-item font-weight-bold">
                    <input class="form-control" type="text" id="searchId" />
                    &emsp;<button class="btn btn-block bg-2 font-weight-bold" id="searchButtonId" onclick='$("#searchId").val("");searchForIt();'>Clear</button>
                  </li>
                </ol>
              </div>
            </div>
            </div>
          </div>
        </section>
        
        <section class="content content-margin">
          <div class="wrapper">
            <div class="container-fluid">
              <div class="row">
          <div class="col-lg-12 col-lg-6 col-sm-4">
            <div class="card card-primary card-tabs">
              <div class="card-header p-0 pt-1 bg-3">
                <ul class="nav nav-tabs" id="custom-tabs-one-tab" role="tablist">
                  <li class="nav-item">
                    <a class="nav-link active" id="custom-tabs-one-home-tab" data-toggle="pill" href="#custom-tabs-one-home" role="tab" aria-controls="custom-tabs-one-home" aria-selected="true">Tile View</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" id="custom-tabs-one-profile-tab" data-toggle="pill" href="#custom-tabs-one-profile" role="tab" aria-controls="custom-tabs-one-profile" aria-selected="false">Department View</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" id="custom-tabs-one-messages-tab" data-toggle="pill" href="#custom-tabs-one-messages" role="tab" aria-controls="custom-tabs-one-messages" aria-selected="false">Table View</a>
                  </li>
                </ul>
              </div>
              <div class="card-body">
                <div class="tab-content" id="custom-tabs-one-tabContent">
                  <div class="tab-pane fade show active" id="custom-tabs-one-home" role="tabpanel" aria-labelledby="custom-tabs-one-home-tab">
                     
                     
                     <div class="row">
                
                <!-- app dump -->
                <c:set var="searchDivCounter" value="1" />
                <c:forEach items="${commonApp }" var="appInfo" varStatus="appInfoLoop">
                  <c:if test="${appInfo.appDumpActive eq 1 }">
                    <div class="col-sm-12 col-md-6 col-lg-4 search-div-${searchDivCounter }">
                      <c:set var="searchDivCounter" value="${searchDivCounter + 1 }" />
                      <div class="small-box bg-${bg_counter }">
                        <div class="inner">
                          <h4 class="font-weight-bold">${appInfo.appDumpName }</h4>
                          <p class="" style='font-size: 0.85rem !important'>
                            ${appInfo.appDumpDescription }<br>
                            ${appInfo.appDumpDescription2 }
                          </p>
                        </div>
                        <div class="icon">
                          <i class="${appInfo.appDumpIcon }"></i>
                        </div>
                        <a href="${appInfo.appDumpLink }" title="${appInfo.appDumpName }" 
                          class="small-box-footer font-weight-bold" target="_blank">
                          ${appInfo.appDumpName }&ensp;<i class="fas fa-arrow-circle-right"></i>
                        </a>
                      </div>
                    </div>
                    <c:set var="bg_counter" value="${bg_counter + 1 }" />
                  </c:if>
                  <c:if test="${bg_counter eq 4 }">
                    <c:set var="bg_counter" value="1" />
                  </c:if>
                </c:forEach>
                <c:forEach items="${companyApps }" var="appInfo" varStatus="appInfoLoop">
                  <c:if test="${appInfo.appDumpActive eq 1 }">
                    <div class="col-sm-12 col-md-6 col-lg-4 search-div-${searchDivCounter }">
                      <c:set var="searchDivCounter" value="${searchDivCounter + 1 }" />
                      <div class="small-box bg-${bg_counter }">
                        <div class="inner">
                          <h4 class="font-weight-bold">${appInfo.appDumpName }</h4>
                          <p class="" style='font-size: 0.85rem !important'>
                            ${appInfo.appDumpDescription }<br>
                            ${appInfo.appDumpDescription2 }
                          </p>
                        </div>
                        <div class="icon">
                          <i class="${appInfo.appDumpIcon }"></i>
                        </div>
                        <a href="${appInfo.appDumpLink }" title="${appInfo.appDumpName }" 
                          class="small-box-footer font-weight-bold" target="_blank">
                          ${appInfo.appDumpName }&ensp;<i class="fas fa-arrow-circle-right"></i>
                        </a>
                      </div>
                    </div>
                    <c:set var="bg_counter" value="${bg_counter + 1 }" />
                  </c:if>
                  <c:if test="${bg_counter eq 4 }">
                    <c:set var="bg_counter" value="1" />
                  </c:if>
                </c:forEach>
              </div>
              <c:set var="bg_counter" value="1" />
              <div class="row">
                <c:forEach items="${commonApp }" var="appInfo" varStatus="appInfoLoop">
                  <c:if test="${appInfo.appDumpActive eq 1 }">
                    <div class="col-sm-12 col-md-4 col-lg-2 search-div-${searchDivCounter }">
                      <c:set var="searchDivCounter" value="${searchDivCounter + 1 }" />
                      <div class="small-box bg-${bg_counter }">
                        <div class="inner">
                          <h4 class="font-weight-bold">${appInfo.appDumpName }</h4>
                          <p class="" style='font-size: 0.85rem !important'>
                            ${appInfo.appDumpDescription }<br>
                            ${appInfo.appDumpDescription2 }
                          </p>
                        </div>
                        <div class="icon">
                          <i class="${appInfo.appDumpIcon }"></i>
                        </div>
                        <a href="${appInfo.appDumpLink }" title="${appInfo.appDumpName }" 
                          class="small-box-footer font-weight-bold" target="_blank">
                          ${appInfo.appDumpName }&ensp;<i class="fas fa-arrow-circle-right"></i>
                        </a>
                      </div>
                    </div>
                    <c:set var="bg_counter" value="${bg_counter + 1 }" />
                  </c:if>
                  <c:if test="${bg_counter eq 4 }">
                    <c:set var="bg_counter" value="1" />
                  </c:if>
                </c:forEach>
                <c:forEach items="${companyApps }" var="appInfo" varStatus="appInfoLoop">
                  <c:if test="${appInfo.appDumpActive eq 1 }">
                    <div class="col-sm-12 col-md-4 col-lg-2 search-div-${searchDivCounter }">
                      <c:set var="searchDivCounter" value="${searchDivCounter + 1 }" />
                      <div class="small-box bg-${bg_counter }">
                        <div class="inner">
                          <h4 class="font-weight-bold">${appInfo.appDumpName }</h4>
                          <p class="" style='font-size: 0.85rem !important'>
                            ${appInfo.appDumpDescription }<br>
                            ${appInfo.appDumpDescription2 }
                          </p>
                        </div>
                        <div class="icon">
                          <i class="${appInfo.appDumpIcon }"></i>
                        </div>
                        <a href="${appInfo.appDumpLink }" title="${appInfo.appDumpName }" 
                          class="small-box-footer font-weight-bold" target="_blank">
                          ${appInfo.appDumpName }&ensp;<i class="fas fa-arrow-circle-right"></i>
                        </a>
                      </div>
                    </div>
                    <c:set var="bg_counter" value="${bg_counter + 1 }" />
                  </c:if>
                  <c:if test="${bg_counter eq 4 }">
                    <c:set var="bg_counter" value="1" />
                  </c:if>
                </c:forEach>
              </div>
                  </div>
                  <div class="tab-pane fade" id="custom-tabs-one-profile" role="tabpanel" aria-labelledby="custom-tabs-one-profile-tab">
                    <div class="row">
                      <c:set var="bg_counter_dept" value="1" />
                      <c:forEach items="${activeDepartmentList }" var="department" varStatus="departmentLoop">
                        <c:if test="${department.departmentActive eq 1 && department.appDumpDepartment.size() ne 0 }">
                          <div class="col-sm-12 col-md-6 col-lg-4 search-div-${searchDivCounter }">
                            <c:set var="searchDivCounter" value="${searchDivCounter + 1 }" />
                            <div class="card card-widget widget-user-2 shadow">
                              <div class="widget-user-header bg-${bg_counter_dept }" title="${department.departmentName }">
                                <h5 class="font-weight-bold"><!-- <i class="fas fa-users"></i>&nbsp; -->${department.departmentName }</h5>
                              </div>
                              <div class="card-footer p-0">
                                <ul class="nav flex-column">
                                  <%-- <c:set var="bg_counter" value="1" /> --%>
                                  <c:forEach items="${commonApp }" var="appInfo" varStatus="appInfoLoop">
                                    <c:if test="${appInfo.appDumpActive eq 1 and appInfo.appDumpDepartment.departmentName eq department.departmentName }">
                                      <li class="nav-item">
                                        <div class="nav-link font-weight-bold font-${bg_counter_dept } font-weight-bold">
                                          ${appInfo.appDumpName }<br>
                                          ${appInfo.appDumpDescription }<br>
                                          ${appInfo.appDumpDescription2 }
                                          <span class="float-right badge font-${bg_counter_dept } span-info-width">
                                          <a href="${appInfo.appDumpLink }" title="${appInfo.appDumpName }" 
                                            class="font-${bg_counter_dept } small-box-footer font-weight-bold" target="_blank">
                                            <i class="fas fa-arrow-circle-right"></i>
                                          </a>
                                          </span>
                                        </div>
                                        <c:set var="bg_counter" value="${bg_counter + 1 }" />
                                      </li>
                                      <c:if test="${bg_counter eq 4 }">
                                        <c:set var="bg_counter" value="13" />
                                      </c:if>
                                      <c:if test="${bg_counter eq 13 }">
                                        <c:set var="bg_counter" value="1" />
                                      </c:if>
                                    </c:if>
                                  </c:forEach>
                                  <c:forEach items="${companyApps }" var="appInfo" varStatus="appInfoLoop">
                                    <c:if test="${appInfo.appDumpActive eq 1 and appInfo.appDumpDepartment.departmentName eq department.departmentName }">
                                      <li class="nav-item">
                                        <div class="nav-link font-weight-bold font-${bg_counter_dept } font-weight-bold">
                                          ${appInfo.appDumpName }<br>
                                          ${appInfo.appDumpDescription }<br>
                                          ${appInfo.appDumpDescription2 }
                                          <span class="float-right badge font-${bg_counter_dept } span-info-width">
                                          <a href="${appInfo.appDumpLink }" title="${appInfo.appDumpName }" 
                                            class="font-${bg_counter_dept } small-box-footer font-weight-bold" target="_blank">
                                            <i class="fas fa-arrow-circle-right"></i>
                                          </a>
                                          </span>
                                        </div>
                                        <c:set var="bg_counter" value="${bg_counter + 1 }" />
                                      </li>
                                      <c:if test="${bg_counter eq 4 }">
                                        <c:set var="bg_counter" value="1" />
                                      </c:if>
                                    </c:if>
                                  </c:forEach>
                                </ul>
                              </div>
                            </div>
                          </div>
                        </c:if>
                        <c:set var="bg_counter_dept" value="${bg_counter_dept + 1 }" />
                        <c:if test="${bg_counter_dept eq 4 }">
                          <c:set var="bg_counter_dept" value="1" />
                        </c:if>
                      </c:forEach>
                    </div>
                    
                    
                    <div class="row">
                      <c:set var="bg_counter_dept" value="1" />
                      <c:forEach items="${activeDepartmentList }" var="department" varStatus="departmentLoop">
                        <c:if test="${department.departmentActive eq 1 && department.appDumpDepartment.size() ne 0 }">
                          <div class="col-sm-12 col-md-6 col-lg-2 search-div-${searchDivCounter }">
                            <c:set var="searchDivCounter" value="${searchDivCounter + 1 }" />
                            <div class="card card-widget widget-user-2 shadow">
                              <div class="widget-user-header bg-${bg_counter_dept }" title="${department.departmentName }">
                                <h5 class="font-weight-bold"><!-- <i class="fas fa-users"></i>&nbsp; -->${department.departmentName }</h5>
                              </div>
                              <div class="card-footer p-0">
                                <ul class="nav flex-column">
                                  <c:set var="bg_counter" value="1" />
                                  <c:forEach items="${commonApp }" var="appInfo" varStatus="appInfoLoop">
                                    <c:if test="${appInfo.appDumpActive eq 1 and appInfo.appDumpDepartment.departmentName eq department.departmentName }">
                                      <li class="nav-item">
                                        <div class="nav-link font-weight-bold font-${bg_counter_dept } font-weight-bold">
                                          ${appInfo.appDumpName }
                                          <span class="float-right badge font-${bg_counter_dept } span-info-width">
                                          <a href="${appInfo.appDumpLink }" title="${appInfo.appDumpName }" 
                                            class="font-${bg_counter_dept } small-box-footer font-weight-bold" target="_blank">
                                            <i class="fas fa-arrow-circle-right"></i>
                                          </a>
                                          </span>
                                        </div>
                                        <c:set var="bg_counter" value="${bg_counter + 1 }" />
                                      </li>
                                      <c:if test="${bg_counter eq 4 }">
                                        <c:set var="bg_counter" value="13" />
                                      </c:if>
                                      <c:if test="${bg_counter eq 13 }">
                                        <c:set var="bg_counter" value="1" />
                                      </c:if>
                                    </c:if>
                                  </c:forEach>
                                  <c:forEach items="${companyApps }" var="appInfo" varStatus="appInfoLoop">
                                    <c:if test="${appInfo.appDumpActive eq 1 and appInfo.appDumpDepartment.departmentName eq department.departmentName }">
                                      <li class="nav-item">
                                        <div class="nav-link font-weight-bold font-${bg_counter_dept } font-weight-bold">
                                          ${appInfo.appDumpName }
                                          <span class="float-right badge font-${bg_counter_dept } span-info-width">
                                          <a href="${appInfo.appDumpLink }" title="${appInfo.appDumpName }" 
                                            class="font-${bg_counter_dept } small-box-footer font-weight-bold" target="_blank">
                                            <i class="fas fa-arrow-circle-right"></i>
                                          </a>
                                          </span>
                                        </div>
                                        <c:set var="bg_counter" value="${bg_counter + 1 }" />
                                      </li>
                                      <c:if test="${bg_counter eq 4 }">
                                        <c:set var="bg_counter" value="1" />
                                      </c:if>
                                    </c:if>
                                  </c:forEach>
                                </ul>
                              </div>
                            </div>
                          </div>
                        </c:if>
                        <c:set var="bg_counter_dept" value="${bg_counter_dept + 1 }" />
                        <c:if test="${bg_counter_dept eq 4 }">
                          <c:set var="bg_counter_dept" value="1" />
                        </c:if>
                      </c:forEach>
                    </div>
                    <input type="text" value="${searchDivCounter }" id="inputSearchDiv" />
                    
                  </div>
                  
                  <div class="tab-pane fade" id="custom-tabs-one-messages" role="tabpanel" aria-labelledby="custom-tabs-one-messages-tab">
                     <c:set var="bg_counter" value="1" />
                     <div class="row">
                       <div class="col-md-12 tableOverFlowDiv">
		                <table class="table table-bordered table-striped dataTable" id="entityTable">
		                  <thead>
		                    <tr class="bg-table-head">
		                      <th>Link</th>
		                      <th>Name</th>
		                      <th>Description</th>
		                      <th>Department</th>
		                    </tr>
		                  </thead>
		                  <tbody>
		                    <c:forEach items="${commonApp }" var="appInfo" varStatus="appInfoLoop">
		                      <c:if test="${appInfo.appDumpActive eq 1 }">
		                      <tr<%--  class="bg-table-${appInfoLoop.index % 2 }" --%>>
		                        <td>
		                          <a class="font-${bg_counter } small-box-footer" target="_target" href="${appInfo.appDumpLink }">
		                            <i class="fas fa-arrow-circle-right"></i>
		                          </a>
		                        </td>
		                        <td>${appInfo.appDumpName }</td>
		                        <td>${appInfo.appDumpDescription }</td>
		                        <td>${appInfo.appDumpDepartment.departmentName }</td>
		                        <c:set var="bg_counter" value="${bg_counter + 1 }" />
		                      </tr>
		                      </c:if>
		                      <c:if test="${bg_counter eq 4 }">
		                  <c:set var="bg_counter" value="1" />
		                </c:if>
		                    </c:forEach>
		                    <c:forEach items="${companyApps }" var="appInfo" varStatus="appInfoLoop">
		                      <c:if test="${appInfo.appDumpActive eq 1 }">
		                      <tr>
		                        <td>
		                          <a class="font-${bg_counter } small-box-footer" target="_target" href="${appInfo.appDumpLink }">
		                            <i class="fas fa-arrow-circle-right"></i>
		                          </a>
		                        </td>
		                        <td>${appInfo.appDumpName }</td>
		                        <td>${appInfo.appDumpDescription }</td>
		                        <td>${appInfo.appDumpDepartment.departmentName }</td>
		                        <c:set var="bg_counter" value="${bg_counter + 1 }" />
		                      </tr>
		                      </c:if>
		                      <c:if test="${bg_counter eq 4 }">
		                  <c:set var="bg_counter" value="1" />
		                </c:if>
		                    </c:forEach>
		                    <%-- <tr>
		                      <td>
		                        <a class="font-${bg_counter } small-box-footer" target="_target" href="https://digihrconnectag.darwinbox.in/user/login">
		                          <i class="fas fa-arrow-circle-right"></i>
		                        </a>
		                      </td>
		                      <td>DigiHR Connect</td>
		                      <td>Human Resources &amp; Administration</td>
		                      <td>Darwinbox HR Tool</td>
		                      <c:set var="bg_counter" value="${bg_counter + 1 }" />
		                    </tr>
		                    <tr>
		                      <td>
		                        <a class="font-${bg_counter } small-box-footer" target="_target" href="https://anand.ascentpayroll.net/Default.htm">
		                          <i class="fas fa-arrow-circle-right"></i>
		                        </a>
		                      </td>
		                      <td>Ascent</td>
		                      <td>Human Resources &amp; Administration</td>
		                      <td>Ascent Attendance &amp; Visitor Management</td>
		                      <c:set var="bg_counter" value="${bg_counter + 1 }" />
		                    </tr>
		                    <tr>
		                      <td>
		                        <a class="font-${bg_counter } small-box-footer" target="_target" href="https://www.dkmonline.co.in/Login.aspx?CompanyID=ANAND">
		                          <i class="fas fa-arrow-circle-right"></i>
		                        </a>
		                      </td>
		                      <td>DKM ESS</td>
		                      <td>Human Resources &amp; Administration</td>
		                      <td>Payroll &amp; Investment Processing</td>
		                      <c:set var="bg_counter" value="${bg_counter + 1 }" />
		                    </tr>
		                    <tr>
		                      <td>
		                        <a class="font-1 small-box-footer" target="_target" href="https://soh.anandgroupindia.com/auth">
		                          <i class="fas fa-arrow-circle-right"></i>
		                        </a>
		                      </td>
		                      <td>SOH</td>
		                      <td>Human Resources &amp; Administration</td>
		                      <td>State of Health, Internal Control</td>
		                      <c:set var="bg_counter" value="${bg_counter + 1 }" />
		                    </tr> --%>
		                  </tbody>
		                  <tfoot>
		                    <tr class="bg-table-foot">
		                      <th>Link</th>
		                      <th>Name</th>
		                      <th>Description</th>
		                      <th>Department</th>
		                    </tr>
		                  </tfoot>
		                </table>
		              </div>
                     </div>
                     
                     
                  </div>
                </div>
              </div>
              <!-- /.card -->
            </div>
          </div>
        </div>
            </div>
            </div>
        </section>
      </div>
    </div>
    <%-- <%@include file="includeJSP/footer.jsp"%> --%>
    <footer class="main-footer" style="color: #002E6D;margin-left: 0px;font-size: 12px;">
      <div class="float-right d-none d-sm-block"><b>ANAND Central - ANAND Group</b> v.1.0.0<br></div>
      <div class="float-left d-none d-sm-block">
        Developed &amp; Maintained by <b>Group Information Technology, ANAND Automotive Private Limited</b>
      </div>
      <img width="100%" src="usedStaticFiles/essentials/images/anand_footer_large.png">
    </footer>
    <%@include file="includeJSP/jsFiles.jsp"%>
    <%@include file="includeJSP/dataTablesImport.jsp"%>
    <script>
    var pagination = false;
	$("#entityTable").DataTable({
		"ordering": false,
		"paging": true,
		"info": true,
		"scrollX": false,
		"lengthChange": true,
		"searching": true,
		"autoWidth": false,
		"responsive": false,
		"drawCallback": function(settings) {
			if (pagination) {
				$('#entityTable_paginate').find(".pagination").append('<li class="paginate_button page-item"><a onclick="loadNextSetValues()" id="loadMore_entityTable" class="fa fa-arrow-right page-link" href="#" title="Load More"></a></li>');
			}
		},
		"createdRow": function (row,data,index) {
			$(row).removeClass("even");
			$(row).removeClass("odd");
	    	if(index % 2 == 0) {
	    		$(row).addClass("bg-table-0");
	    	} else {
	    		$(row).addClass("bg-table-1");
	    	}
	    },
		"buttons": ["csv", "excel", {
			extend: 'pdf',
			className:'buttons-pdf',
			text:'PDF',
			titleAttr: 'Download in PDF',
			title:"Entity List",
			orientation: 'landscape',
			customize: function (doc) {
				var now = new Date();
				var jsDate = now.getDate()+'-'+(now.getMonth()+1)+'-'+now.getFullYear();
				/*var logo = 'data:image/png;base64,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';*/
				var logo = '';
				doc['header']=(function() { return {
					columns: [{
						alignment: 'left',
						fontSize: 15,
						text: "COMPANY-NAME Central",
					}, /*{
						alignment: 'right',
						image: logo,
						width: 100,
						height:20
					}*/],
					margin: 10
				}});
				doc['footer']=(function(page, pages) { return {
					columns: [{
						alignment: 'left',
						text: ['Created on: ', { text: jsDate.toString() }]
					}, {
						alignment: 'right',
						text: ['page ', { text: page.toString() },	' of ',	{ text: pages.toString() }]
					}],
					margin: 20
				}});
			},
			pageSize: 'LEGAL',
			exportOptions: {
				columns: ':visible thead th:not(.noExport)'
			}
		}, "print", "colvis"]
	}).buttons().container().appendTo('#entityTable_wrapper .col-md-6:eq(0)');
	$("#searchId").keypress(function(){
		console.log($("#searchId").val());
		searchForIt();
	});
	function searchForIt(){
		var searchId = $("#searchId").val().toLowerCase();
		if(searchId == "") {
			for(var i = 1; i < parseInt($("#inputSearchDiv").val()); i++) {
				var divId = ".search-div-"+i;
				$(divId).show();
			}
		} else {
			for(var i = 1; i < parseInt($("#inputSearchDiv").val()); i++) {
				var divId = ".search-div-"+i;
				console.log(searchId+"-"+$(divId).text().toLowerCase().indexOf(searchId));
				if($(divId).text().toLowerCase().indexOf(searchId) != -1) {
					$(divId).show();
				} else {
					$(divId).hide();
				}
			}
		}
	}
    </script>
  </body>
</html>text indx of ignore case 
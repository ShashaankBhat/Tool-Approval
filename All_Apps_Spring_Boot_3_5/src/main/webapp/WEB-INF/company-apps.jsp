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
    <title>EKAYANA<%@include file="includeJSP/company_name_title.jsp"%></title>
    <%@include file="includeJSP/cssFiles.jsp"%>
  </head>
  <body class="hold-transition layout-top-nav pace-primary">
    <div class="wrapper">
      <nav class="main-header navbar navbar-expand-md navbar-light navbar-white">
        <h4 class="nav-link font-1" style="width: 100%;">
          <strong><span class="firstletter font-1">EKAYANA</span></strong>
          <strong><span class="firstletter font-2"> - Sanskrit word meaning ONE PATH</span></strong>
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
          </ul>
        </div>
      </nav>
      <div class="package-loader">
        <img id = "packageLoaderImage" src="usedStaticFiles/essentials/images/loader.gif" width="64" alt="">
      </div>
      <div class="content-wrapper">
        
        <section class="content-header" style="padding-bottom:25px">
          <div class="wrapper">
            <div class="container-fluid">
            <div class="row mb-2">
              <div class="col-sm-8">
                <h5 class="font-3 font-weight-bold">${firstName }&nbsp;${lastName },&ensp;${entityAcronymnForDisplay }</h5>
                <input value="${userEmailId }" id="userEmailId" type="hidden" />
              </div>
              <div class="col-sm-4">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item font-weight-bold">
                    <input class="form-control" type="text" id="searchId" style="width:350px" placeholder="Search Application" />
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
            
            <c:set var="bg_counter" value="1" />
              <div class="row">
                <c:set var="searchDivCounter" value="1" />
                <c:forEach items="${commonApp }" var="appInfo" varStatus="appInfoLoop">
                  <c:if test="${appInfo.appDumpActive eq 1 }">
                    <div class="col-sm-12 col-md-4 col-lg-2 search-div-${searchDivCounter }" title = "${appInfo.appDumpName }">
                      <a href="${appInfo.appDumpLink }" title="${appInfo.appDumpName }" 
                          class="small-box-footer font-weight-bold" target="_blank" style="text-align: left;padding-left: 10px;">
                      <c:set var="searchDivCounter" value="${searchDivCounter + 1 }" />
                      <div class="small-box bg-${bg_counter }">
                        <div class="inner">
                          <h4 class="font-weight-bold">${appInfo.appDumpName }</h4>
                          <p class="" style="font-size:15px">
                            ${appInfo.appDumpDescription }
                          </p>
                          <p class="" style="font-size:0px; display:none">
                            ${appInfo.appDumpDescription2 }
                          </p>
                        </div>
                        <div class="icon">
                          <i class="${appInfo.appDumpIcon }"></i>
                        </div>
                        <%-- <a href="${appInfo.appDumpLink }" title="${appInfo.appDumpName }" 
                          class="small-box-footer font-weight-bold" target="_blank">
                          ${appInfo.appDumpName }&ensp;<i class="fas fa-arrow-circle-right"></i>
                        </a> --%>
                      </div>
                      </a>
                    </div>
                    <c:set var="bg_counter" value="${bg_counter + 1 }" />
                  </c:if>
                  <c:if test="${bg_counter eq 16 }">
                    <c:set var="bg_counter" value="1" />
                  </c:if>
                  <c:if test="${bg_counter eq 4 }">
                    <c:set var="bg_counter" value="13" />
                  </c:if>
                </c:forEach>
                <c:forEach items="${companyApps }" var="appInfo" varStatus="appInfoLoop">
                  <c:if test="${appInfo.appDumpActive eq 1 }">
                    <div class="col-sm-12 col-md-4 col-lg-2 search-div-${searchDivCounter }" title = "${appInfo.appDumpName }">
                      <a href="${appInfo.appDumpLink }" title="${appInfo.appDumpName }" 
                          class="small-box-footer font-weight-bold" target="_blank" style="text-align: left;padding-left: 10px;">
                      <c:set var="searchDivCounter" value="${searchDivCounter + 1 }" />
                      <div class="small-box bg-${bg_counter }">
                        <div class="inner">
                          <h4 class="font-weight-bold">${appInfo.appDumpName }</h4>
                          <p class="" style="font-size:15px">
                            ${appInfo.appDumpDescription }
                          </p>
                          <p class="" style="font-size:0px; display:none">
                            ${appInfo.appDumpDescription2 }
                          </p>
                        </div>
                        <div class="icon">
                          <i class="${appInfo.appDumpIcon }"></i>
                        </div>
                        <%-- <a href="${appInfo.appDumpLink }" title="${appInfo.appDumpName }" 
                          class="small-box-footer font-weight-bold" target="_blank">
                          ${appInfo.appDumpName }&ensp;<i class="fas fa-arrow-circle-right"></i>
                        </a> --%>
                      </div>
                      </a>
                    </div>
                    <c:set var="bg_counter" value="${bg_counter + 1 }" />
                  </c:if>
                  <c:if test="${bg_counter eq 16 }">
                    <c:set var="bg_counter" value="1" />
                  </c:if>
                  <c:if test="${bg_counter eq 4 }">
                    <c:set var="bg_counter" value="13" />
                  </c:if>
                </c:forEach>
              </div>
            
            
            
            
            
              <%-- <div class="row">
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
                    <div class="col-sm-12 col-md-6 col-lg-3 search-div-${searchDivCounter }">
                      <c:set var="searchDivCounter" value="${searchDivCounter + 1 }" />
                      <div class="small-box bg-${bg_counter }">
                        <div class="inner">
                          <h4 class="font-weight-bold">${appInfo.appDumpName }</h4>
                          <p class="" style="font-size:15px">
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
                  <c:if test="${bg_counter eq 15 }">
                    <c:set var="bg_counter" value="1" />
                  </c:if>
                  <c:if test="${bg_counter eq 4 }">
                    <c:set var="bg_counter" value="14" />
                  </c:if>
                </c:forEach>
                <c:forEach items="${companyApps }" var="appInfo" varStatus="appInfoLoop">
                  <c:if test="${appInfo.appDumpActive eq 1 }">
                    <div class="col-sm-12 col-md-6 col-lg-3 search-div-${searchDivCounter }">
                      <c:set var="searchDivCounter" value="${searchDivCounter + 1 }" />
                      <div class="small-box bg-${bg_counter }">
                        <div class="inner">
                          <h4 class="font-weight-bold">${appInfo.appDumpName }</h4>
                          <p class="" style="font-size:15px">
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
                  <c:if test="${bg_counter eq 15 }">
                    <c:set var="bg_counter" value="1" />
                  </c:if>
                  <c:if test="${bg_counter eq 4 }">
                    <c:set var="bg_counter" value="14" />
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
                          <p class="" style="font-size:15px">
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
                  <c:if test="${bg_counter eq 16 }">
                    <c:set var="bg_counter" value="1" />
                  </c:if>
                  <c:if test="${bg_counter eq 4 }">
                    <c:set var="bg_counter" value="13" />
                  </c:if>
                </c:forEach>
                <c:forEach items="${companyApps }" var="appInfo" varStatus="appInfoLoop">
                  <c:if test="${appInfo.appDumpActive eq 1 }">
                    <div class="col-sm-12 col-md-4 col-lg-2 search-div-${searchDivCounter }">
                      <c:set var="searchDivCounter" value="${searchDivCounter + 1 }" />
                      <div class="small-box bg-${bg_counter }">
                        <div class="inner">
                          <h4 class="font-weight-bold">${appInfo.appDumpName }</h4>
                          <p class="" style="font-size:15px">
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
                  <c:if test="${bg_counter eq 16 }">
                    <c:set var="bg_counter" value="1" />
                  </c:if>
                  <c:if test="${bg_counter eq 4 }">
                    <c:set var="bg_counter" value="13" />
                  </c:if>
                </c:forEach>
              </div>
                  </div>
                  <c:set var="bg_counter_dept" value="1" />
                  <div class="tab-pane fade" id="custom-tabs-one-profile" role="tabpanel" aria-labelledby="custom-tabs-one-profile-tab">
                    <div class="row">
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
                                  <c:set var="bg_counter" value="1" />
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
                                      </li>
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
                                      </li>
                                    </c:if>
                                  </c:forEach>
                                </ul>
                              </div>
                            </div>
                          </div>
                          <c:set var="bg_counter_dept" value="${bg_counter_dept + 1 }" />
                          <c:if test="${bg_counter_dept eq 15 }">
                            <c:set var="bg_counter_dept" value="1" />
                          </c:if>
                          <c:if test="${bg_counter_dept eq 4 }">
                            <c:set var="bg_counter_dept" value="14" />
                          </c:if>
                        </c:if>
                      </c:forEach>
                    </div>
                    <div class="row">
                      <c:set var="bg_counter_dept" value="1" />
                      <c:forEach items="${activeDepartmentList }" var="department" varStatus="departmentLoop">
                        <c:if test="${department.departmentActive eq 1 && department.appDumpDepartment.size() ne 0 }">
                          <div class="col-sm-12 col-md-6 col-lg-3 search-div-${searchDivCounter }">
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
                          <c:set var="bg_counter_dept" value="${bg_counter_dept + 1 }" />
                          <c:if test="${bg_counter_dept eq 15 }">
                            <c:set var="bg_counter_dept" value="1" />
                          </c:if>
                          <c:if test="${bg_counter_dept eq 4 }">
                            <c:set var="bg_counter_dept" value="14" />
                          </c:if>
                        </c:if>
                      </c:forEach>
                    </div>
                    
                    
                    <div class="row">
                      <c:set var="bg_counter_dept" value="1" />
                      <c:forEach items="${activeDepartmentList }" var="department" varStatus="departmentLoop">
                        <c:if test="${department.departmentActive eq 1 && department.appDumpDepartment.size() ne 0 }">
                          <div class="col-sm-12 col-md-6 col-lg-3 search-div-${searchDivCounter }">
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
                          <c:set var="bg_counter_dept" value="${bg_counter_dept + 1 }" />
                          <c:if test="${bg_counter_dept eq 15 }">
                            <c:set var="bg_counter_dept" value="1" />
                          </c:if>
                          <c:if test="${bg_counter_dept eq 4 }">
                            <c:set var="bg_counter_dept" value="14" />
                          </c:if>
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
                    <input type="hidden" value="${searchDivCounter }" id="inputSearchDiv" />
                    
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div> --%>
        <input type="hidden" value="${searchDivCounter }" id="inputSearchDiv" />
            </div>
            </div>
        </section>
      </div>
    </div>
    <%-- <%@include file="includeJSP/footer.jsp"%> --%>
    <footer class="main-footer" style="color: #002E6D;margin-left: 0px;font-size: 12px;">
      <!-- <div class="float-right d-none d-sm-block"><b>ANAND Central - ANAND Group</b> v.1.0.0<br></div> -->
      <div class="float-left d-none d-sm-block">
        Developed &amp; Maintained by <b>Group Information Technology, ANAND Automotive Private Limited</b>
      </div>
      <img width="100%" src="usedStaticFiles/essentials/images/anand_footer_large.png">
    </footer>
    <%@include file="includeJSP/jsFiles.jsp"%>
    <%@include file="includeJSP/dataTablesImport.jsp"%>
    <script>
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
	function authenticateUserCompanyAppPage() {
		$.ajax({
			url: 'authenticateUserCompanyAppPage',
			type: 'POST',
			contentType: 'application/json',
			data: {userEmail: $("#userEmailId").val()},
			success: function (response) {
				console.log('Login successful:', response);
				// Handle the success response as needed
				window.location.href = '/main';
			},
			error: function (error) {
				console.error('Error performing login:', error);
			}
		});
	}
    </script>
  </body>
</html> 
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
    <title>APPLICATION CENTRAL<%@include file="includeJSP/company_name_title.jsp"%></title>
    <%@include file="includeJSP/cssFiles.jsp"%>
  </head>
  <body class="hold-transition layout-top-nav pace-primary">
    <div class="wrapper">
      <nav class="main-header navbar navbar-expand-md navbar-light navbar-white">
        <h4 class="nav-link font-1" style="width: 100%;">
          <strong><span class="firstletter">ANAND Application</span></strong>
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
                <!-- <h5 class="font-2 font-weight-bold">Click On Company </h5> -->
              </div>
              <div class="col-sm-4">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item font-weight-bold">
                    <input class="form-control" type="text" id="searchId" style="width:350px" placeholder="Search entity" />
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
                            <!-- Active Entity List -->
                            <c:set var="searchDivCounter" value="1" />
                            <c:forEach items="${activeParentEntityList }" var="activeEntity" varStatus="activeEntityLoop">
                              <c:if test="${activeEntity.entityActive eq 1 }">
                                <div class="col-sm-12 col-md-6 col-lg-3 search-div-${searchDivCounter }">
                                  <c:set var="searchDivCounter" value="${searchDivCounter + 1 }" />
                                  <div class="small-box bg-${bg_counter }">
                                    <div class="inner">
                                      <h4 class="font-weight-bold">${activeEntity.entityAcronym }</h4>
                                      <p class="" style="font-size:15px">
                                        ${activeEntity.entityShortName }<br>
                                        ${activeEntity.entityName }
                                      </p>
                                    </div>
                                    <div class="icon">
                                      <i class="${activeEntity.entityAcronym }"></i>
                                    </div>
                                    <a href="app-company?company-id=${activeEntity.entityAcronym }" title="${activeEntity.entityAcronym }" 
                                      class="small-box-footer font-weight-bold" >
                                      Go to applications of ${activeEntity.entityAcronym }&ensp;<i class="fas fa-arrow-circle-right"></i>
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
                            <input type="hidden" value="${searchDivCounter }" id="inputSearchDiv" />
                          </div>
              
              
              <%-- <div class="row">
                <div class="col-lg-12 col-lg-6 col-sm-4">
                  <div class="card card-primary card-tabs">
                    <div class="card-header p-0 pt-1 bg-3">
                      <ul class="nav nav-tabs" id="custom-tabs-one-tab" role="tablist">
                        <li class="nav-item">
                          <a class="nav-link active" id="custom-tabs-one-home-tab" data-toggle="pill" href="#custom-tabs-one-home" role="tab" aria-controls="custom-tabs-one-home" aria-selected="true">List Of Entities</a>
                        </li>
                      </ul>
                    </div>
                    <div class="card-body">
                      <div class="tab-content" id="custom-tabs-one-tabContent">
                        <div class="tab-pane fade show active" id="custom-tabs-one-home" role="tabpanel" aria-labelledby="custom-tabs-one-home-tab">
                          <div class="row">
                            <!-- Active Entity List -->
                            <c:set var="searchDivCounter" value="1" />
                            <c:forEach items="${activeParentEntityList }" var="activeEntity" varStatus="activeEntityLoop">
                              <c:if test="${activeEntity.entityActive eq 1 }">
                                <div class="col-sm-12 col-md-6 col-lg-3 search-div-${searchDivCounter }">
                                  <c:set var="searchDivCounter" value="${searchDivCounter + 1 }" />
                                  <div class="small-box bg-${bg_counter }">
                                    <div class="inner">
                                      <h4 class="font-weight-bold">${activeEntity.entityAcronym }</h4>
                                      <p class="">
                                        ${activeEntity.entityShortName }<br>
                                        ${activeEntity.entityName }
                                      </p>
                                    </div>
                                    <div class="icon">
                                      <i class="${activeEntity.entityAcronym }"></i>
                                    </div>
                                    <a href="app-company?company-id=${activeEntity.entityAcronym }" title="${activeEntity.entityAcronym }" 
                                      class="small-box-footer font-weight-bold" >
                                      Go to applications of ${activeEntity.entityAcronym }&ensp;<i class="fas fa-arrow-circle-right"></i>
                                    </a>
                                  </div>
                                </div>
                                <c:set var="bg_counter" value="${bg_counter + 1 }" />
                              </c:if>
                              <c:if test="${bg_counter eq 13 }">
                                <c:set var="bg_counter" value="1" />
                              </c:if>
                              <c:if test="${bg_counter eq 4 }">
                                <c:set var="bg_counter" value="13" />
                              </c:if>
                            </c:forEach>
                            <input type="hidden" value="${searchDivCounter }" id="inputSearchDiv" />
                          </div>
                          <c:set var="bg_counter" value="1" />
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div> --%>
            </div>
          </div>
        </section>
      </div>
    </div>
    <footer class="main-footer" style="color: #002E6D;margin-left: 0px;font-size: 12px;">
      <div class="float-right d-none d-sm-block"><b>ANAND Central - ANAND Group</b> v.1.0.0<br></div>
      <div class="float-left d-none d-sm-block">
        Developed &amp; Maintained by <b>Group Information Technology, ANAND Automotive Private Limited</b>
      </div>
      <img width="100%" src="usedStaticFiles/essentials/images/anand_footer_large.png">
    </footer>
    <%@include file="includeJSP/jsFiles.jsp"%>
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
    </script>
  </body>
</html> 
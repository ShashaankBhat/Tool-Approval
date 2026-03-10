<!-- ****************************************************************************************
# *******************************************************************************************
# Copyright © 2021 Anand Group India. All rights reserved.									*
# No part of this product may be reproduced in any form by any means without prior			*
# written authorization of Anand Automotive Private Limited and its licensors, if any.		*
# *******************************************************************************************
# Author - Sheshadhri Iyer																	*
# *************************************************************************************** -->
<%-- <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> --%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>VISITOR INFORMATION<%@include file="../includeJSP/company_name_title.jsp"%></title>
    <%@include file="../includeJSP/cssFiles.jsp"%>
    <link rel="stylesheet" href="usedStaticFiles/essentials/daterangepicker/daterangepicker - Copy.css">
    <link rel="stylesheet" href="usedStaticFiles/essentials/daterangepicker/bootstrap-colorpicker.min.css">
    <link rel="stylesheet" href="usedStaticFiles/essentials/daterangepicker/tempusdominus-bootstrap-4.min.css">
  </head>
  <body class="sidebar-mini layout-navbar-fixed sidebar-collapse pace-primary">
    <div class="wrapper">
      <%@include file="includeJSP/header.jsp"%>
      <%@include file="includeJSP/leftSideBar.jsp"%>
      <div class="content-wrapper">
        <section class="content-header">
          <div class="container-fluid">
            <div class="row mb-2">
              <div class="col-sm-6">
                <h5 class="font-3 font-weight-bold">VISITOR INFORMATION</h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item font-1"><a href="dashboard" title="Dashboard">Dashboard</a></li>
                  <li class="breadcrumb-item font-1"><a href="list-appointment" title="List Appointments">List Appointment</a></li>
                  <li class="breadcrumb-item font-3 active">Visitor Information</li>
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
		    <div class="row">
		      <div class="col-md-12">
		        <div class="card">
		          <div class="card-header bg-1">
		            <h5 class="card-title font-weight-bold">Meeting Details</h5>
		          </div>
		          <c:set var="govtIdIndex" value="0" />
		          <c:forEach items="${govtIdTypes }" var="govtIdType" varStatus="govtIdTypeStatus">
		            <input type="hidden" id="govtId${govtIdTypeStatus.index }" value="${govtIdType.MVisitorTypeId }" />
		            <input type="hidden" id="govtIdName${govtIdTypeStatus.index }" value="${govtIdType.visitorTypeName }" />
		            <c:set var="govtIdIndex" value="${govtIdIndex + 1 }" />
		          </c:forEach>
		          <input id="govtIndex" type="hidden" value="${govtIdIndex }" />
		                                
		          <div class="card-body">
		            <div class="row">
		              <div class="col-md-4">
		                <div class="form-group">
		                  <label class="font-1" for="visitorName">Visitor Information</label>
		                  <table class="table table-striped" style="font-size:0.9rem">
		                    <tr class="bg-table-row-0">
		                      <td>Name</td>
		                      <td>${visitor.visitorName }</td>
		                    </tr>
		                    <tr class="bg-table-row-1">
		                      <td>Email</td>
		                      <td>${visitor.visitorEmail }</td>
		                    </tr>
		                    <tr class="bg-table-row-0">
		                      <td>Company</td>
		                      <td>${visitor.visitorCompanyName }</td>
		                    </tr>
		                    <tr class="bg-table-row-1">
		                      <td>Total Visitors</td>
		                      <td>${visitor.totalVisitor }</td>
		                    </tr>
		                    <tr class="bg-table-row-0">
		                      <td>Address</td>
		                      <td>${visitor.visitorCompanyAddress }</td>
		                    </tr>
		                  </table>
		                </div>
		              </div>
		              <div class="col-md-4">
		                <div class="form-group">
		                  <label class="font-2" for="visitorName">Other Information</label>
		                  <table class="table table-striped" style="font-size:0.9rem">
		                    <tr class="bg-table-row-0">
		                      <td>Location</td>
		                      <td>${visitor.visitingLocation.entityName } - ${visitor.visitingLocation.locationId.locationName }</td>
		                    </tr>
		                    <tr class="bg-table-row-1">
		                      <td>Visitor Type</td>
		                      <td>${visitor.MVisitorType.visitorTypeName }</td>
		                    </tr>
		                    <tr class="bg-table-row-0">
		                      <td>Visitor Purpose</td>
		                      <td>${visitor.MVisitorPurpose.visitorPurposeName }</td>
		                    </tr>
		                    <tr class="bg-table-row-1">
		                      <td>Plant Entry</td>
		                      <td>${visitor.MVisitorPurpose.visitorPurposeName }</td>
		                    </tr>
		                    <tr class="bg-table-row-0">
		                      <td>Plant Entry</td>
		                      <td>
		                        <c:choose>
		                          <c:when test="${visitor.visitorPlantEntry eq 0 }">
		                            <code class='sequence-font-1'>Plant Entry - Prohibited</code>
		                          </c:when>
		                          <c:otherwise>
		                            <code class='sequence-font-5'>Plant Entry - Granted</code>
		                          </c:otherwise>
		                        </c:choose>
		                      </td>
		                    </tr>
		                  </table>
		                </div>
		              </div>
		              <div class="col-md-4">
		                <label class="font-3" for="visitorName">Total Visitors &amp; Remarks</label>
		                <table class="table table-striped" style="font-size:0.9rem">
		                  <tr class="bg-table-row-0">
		                    <td>Total Visitors</td>
		                    <td>${visitor.totalVisitor }</td>
		                  </tr>
		                  <tr class="bg-table-row-1">
		                    <td>Remarks</td>
		                    <td>${visitor.visitorRemarks }</td>
		                  </tr>
		                  
		                  <tr class="bg-table-row-0">
		                    <td>Canteen Access</td>
		                    <td>
		                      <c:choose>
		                        <c:when test="${visitor.visitorCanteenAccess eq 1 }">
		                          <code class='sequence-font-5'>Canteen Access Allowed</code>
		                        </c:when>
		                        <c:when test="${visitor.visitorCanteenAccess eq 0 }">
		                          <code class='sequence-font-1'>Canteen NOT Allowed</code>
		                        </c:when>
		                      </c:choose>
		                    </td>
		                  </tr>
		                  <tr class="bg-table-row-1">
		                    <td>Laptop Access</td>
		                    <td>
		                      <c:choose>
		                        <c:when test="${visitor.visitorLaptopAllowed eq 1 }">
		                          <code class='sequence-font-5'>Laptop Access Allowed</code>
		                        </c:when>
		                        <c:when test="${visitor.visitorLaptopAllowed eq 0 }">
		                          <code class='sequence-font-1'>Laptop NOT Allowed</code>
		                        </c:when>
		                      </c:choose>
		                    </td>
		                  </tr>
		                  <tr class="bg-table-row-0">
		                    <td>Mobile Phone</td>
		                    <td>
		                      <c:choose>
		                        <c:when test="${visitor.visitorCellPhoneAllowed eq 1 }">
		                          <code class='sequence-font-5'>Mobile Phone Allowed</code>
		                        </c:when>
		                        <c:when test="${visitor.visitorCellPhoneAllowed eq 0 }">
		                          <code class='sequence-font-1'>Mobile Phone NOT Allowed</code>
		                        </c:when>
		                      </c:choose>
		                    </td>
		                  </tr>
		                  <tr class="bg-table-row-1">
		                    <td>Escort</td>
		                    <td>
		                      <c:choose>
		                        <c:when test="${visitor.visitorEscortRequired eq 1 }">
		                          <code class='sequence-font-1'>Escort REQUIRED</code>
		                        </c:when>
		                        <c:when test="${visitor.visitorEscortRequired eq 0 }">
		                          <code class='sequence-font-5'>Escort Not	 Required</code>
		                        </c:when>
		                      </c:choose>
		                    </td>
		                  </tr>
		                </table>
		              </div>
		            </div>
		          </div>
		        </div>
		        
		        <div class="card">
		          <div class="card-header bg-2">
		            <h5 class="card-title font-weight-bold">Host &amp; Meeting Information</h5>
		          </div>
		          <div class="card-body">
		            <div class="row">
		              <div class="col-md-6">
		                <div class="form-group">
		                  <label class="font-1" for="visitorName">Host Information</label>
		                  <table class="table table-striped" style="font-size:0.9rem">
		                    <tr class="bg-table-row-0">
		                      <td>Name</td>
		                      <td>${visitor.hostName.userFirstName } ${visitor.hostName.userLastName }</td>
		                    </tr>
		                    <tr class="bg-table-row-1">
		                      <td>Extension</td>
		                      <td>${visitor.hostExtensionNumber }</td>
		                    </tr>
		                    <tr class="bg-table-row-0">
		                      <td>Meeting Place</td>
		                      <td>${visitor.meetingPlace }</td>
		                    </tr>
		                  </table>
		                </div>
		              </div>
		              <div class="col-md-6">
		                <div class="form-group">
		                  <label class="font-2" for="visitorName">Meeting Information</label>
		                  <table class="table table-striped" style="font-size:0.9rem">
		                    <tr class="bg-table-row-0">
		                      <td>Meeting Start Date &amp; Time</td>
		                      <td>${visitor.meetingStartDateTemp } ${visitor.meetingStartTimeTemp }</td>
		                    </tr>
		                    <tr class="bg-table-row-1">
		                      <td>Meeting End Date</td>
		                      <td>${visitor.meetingEndDateTemp } ${visitor.meetingEndTimeTemp }</td>
		                    </tr>
		                  </table>
		                </div>
		              </div>
		            </div>
		          </div>
		        </div>
		        <c:set var="checkForVisitorInfo" value="0" />
		        <div class="card">
		          <form modelAttribute="visitor" id="visitor" action="visitor-information" method="post">
		          <input type="hidden" name="visitorId" value="${visitor.visitorId }" id="visitorId" />
		          <div class="card-header bg-3">
		            <h5 class="card-title font-weight-bold">Host &amp; Meeting Information</h5>
		            <video style="display:none" id="webcamVideoVisitor" autoplay playsinline width="320" height="240"></video>
		          </div>
		          <div class="card-body visitorBodyDiv">
		            <c:set var="visitorInfoCount" value="0" />
		            <c:forEach items="${visitor.visitorInformationList }" var="visitorInfo" varStatus="visitorInformationLoop">
		              <c:if test="${visitorInfo.visitorActive eq 1 }">
		                <c:set var="visitorInfoCount" value="${visitorInfoCount + 1 }" />
		                <div class="card visitorInfo${visitorInformationLoop.index }">
		                  <div class="card-header bg-1">
		                    <h5 class="card-title font-weight-bold">Visitor Information ${visitorInformationLoop.index + 1 }</h5>
		                    <input type="hidden" name="visitorInformationList[${visitorInformationLoop.index }].visitorInformationId" id="visitorInformationId${visitorInformationLoop.index }" value="${visitorInfo.visitorInformationId }" />
		                    <c:if test="${not empty visitorInfo.visitorInformationId }">
		                      <c:set var="checkForVisitorInfo" value="${checkForVisitorInfo + 1 }" />
		                    </c:if>
		                    <input type="hidden" name="visitorInformationList[${visitorInformationLoop.index }].visitorActive" id="visitorActive${visitorInformationLoop.index }" value="${visitorInfo.visitorActive }" />
		                    <input type="hidden" name="visitorInformationList[${visitorInformationLoop.index }].parentVisitorId" id="parentVisitorId${visitorInformationLoop.index }" value="${visitorInfo.parentVisitorId }" />
		                    <c:if test="${visitor.visitorEmail ne visitorInfo.visitorEmail }">
		                    <div class="card-tools">
		                      <button type="button" class="btn btn-tool" onclick='removeUser(${visitorInformationLoop.index })'>
		                        <i class="fas fa-user-slash text-white font-weight-bold"></i>
		                      </button>
		                    </div>
		                    </c:if>
		                  </div>
		                  <div class="card-body">
		                    <div class="row">
		                      <div class="col-md-3">
		                        <div class="form-group">
		                          <label class="font-3" for="visitorName${visitorInformationLoop.index }"><span class="mandatory">*</span>Visitor Name</label>
		                          <input type="text" value="${visitorInfo.visitorName }" name="visitorInformationList[${visitorInformationLoop.index }].visitorName" id="visitorName${visitorInformationLoop.index }" class="form-control" />
		                          <span class="error invalid-feedback" id="visitorNameError${visitorInformationLoop.index }"></span>
		                        </div>
		                      </div>
		                      <div class="col-md-3">
		                        <div class="form-group">
		                          <label class="font-3" for="visitorEmail"><span class="mandatory">*</span>Visitor Email</label>
		                          <input type="text" value="${visitorInfo.visitorEmail }" name="visitorInformationList[${visitorInformationLoop.index }].visitorEmail" id="visitorEmail${visitorInformationLoop.index }" class="form-control" />
		                          <span class="error invalid-feedback" id="visitorEmailError${visitorInformationLoop.index }"></span>
		                        </div>
		                      </div>
		                      <div class="col-md-3">
		                        <div class="form-group">
		                          <label class="font-3" for="visitorGovtIdTemp"><span class="mandatory">*</span>Govt ID Type</label>
		                          <select value="${visitorInfo.visitorGovtId.MVisitorTypeId }" class="form-control" name="visitorInformationList[${visitorInformationLoop.index }].visitorGovtIdTemp" id="visitorGovtIdTemp${visitorInformationLoop.index }">
		                            <option value="-1">Select Govt ID Type</option>
		                            <c:forEach items="${govtIdTypes }" var="govtIdType" varStatus="govtIdTypeStatus">
		                              <c:if test="${visitorInfo.visitorGovtId.MVisitorTypeId eq govtIdType.MVisitorTypeId }">
		                                <option selected="selected" value="${govtIdType.MVisitorTypeId }">${govtIdType.visitorTypeName }</option>
		                              </c:if>
		                              <c:if test="${visitorInfo.visitorGovtId.MVisitorTypeId ne govtIdType.MVisitorTypeId }">
		                                <option value="${govtIdType.MVisitorTypeId }">${govtIdType.visitorTypeName }</option>
		                              </c:if>
		                            </c:forEach>
		                          </select>
		                          <span class="error invalid-feedback" id="visitorGovtIdTempError${visitorInformationLoop.index }"></span>
		                        </div>
		                      </div>
		                      <div class="col-md-3">
		                        <div class="form-group">
		                          <label class="font-3" for="visitorGovtIdNumber${visitorInformationLoop.index }"><span class="mandatory">*</span>Govt ID Referecne</label>
		                          <input type="text" name="visitorInformationList[${visitorInformationLoop.index }].visitorGovtIdNumber" id="visitorGovtIdNumber${visitorInformationLoop.index }" class="form-control"  value="${visitorInfo.visitorGovtIdNumber }" />
		                          <span class="error invalid-feedback" id="visitorGovtIdNumberError${visitorInformationLoop.index }"></span>
		                        </div>
		                      </div>
		                      <div class="col-md-4">
		                        <div class="form-group">
		                          <label class="font-3" for="liveFeed${visitorInformationLoop.index }">Live Feed</label><br>
		                          <video id="webcamVideoVisitor${visitorInformationLoop.index }" autoplay playsinline width="100%" height="240"></video>
		                        </div>
		                      </div>
		                      <div class="col-md-4">
		                        <div class="form-group">
		                          <label class="font-3" for="visitorBatch">Picture Taken</label><br>
		                          <canvas style="display:none" id="photoCanvasVisitor${visitorInformationLoop.index }" width="320" height="240"></canvas>
		                          <img src="${visitorInfo.visitorImage }" id="vendorImage${visitorInformationLoop.index }" class="" />
		                          <input type="hidden" name="visitorInformationList[${visitorInformationLoop.index }].visitorImage" id="visitorImageText${visitorInformationLoop.index }" class="form-control" value="${visitorInfo.visitorImage }" />
		                          <br><button class="btn bg-2" onclick="getImage(${visitorInformationLoop.index })" style="float: right" type="button" id="takePhotoBtnVisitor${visitorInformationLoop.index }" >Take Photo</button>
		                          <span style='display:block' class="error invalid-feedback" id="visitorImageTextError${visitorInformationLoop.index }"></span>
		                        </div>
		                      </div>
		                      <div class="col-md-4">
		                        <div class="form-group">
		                          <label class="font-3" for="visitorBatch${visitorInformationLoop.index }"><span class="mandatory">*</span>Badge Number</label>
		                          <input value="${visitorInfo.visitorBatch }" type="text" name="visitorInformationList[${visitorInformationLoop.index }].visitorBatch" id="visitorBatch${visitorInformationLoop.index }" class="form-control" />
		                          <span class="error invalid-feedback" id="visitorBatchError${visitorInformationLoop.index }"></span>
		                        </div>
		                      </div>
		                    </div>
		                  </div>
		                </div>
		              </c:if>
		            </c:forEach>
		          </div>
		          <div class="card-footer">
		            <button style="float: left;" title="Add More Visitor" onclick="addMoreVisitor()" type="button" id="submitVisitorPurposeButton" class="btn bg-3"><i class="fas fa-user-plus"></i>&ensp;Add More Visitor</button>
		            <%-- <c:if test="${itAdmin eq 1 }">
		            &emsp;<button style="float: left;" title="Add Camera" onclick="runVideo()" type="button" id="submitVisitorPurposeButton" class="btn bg-3"><i class="fas fa-cam"></i>&ensp;Add Camera</button>
		            </c:if> --%>
		            <button style="float: right;" title="Submit Visitor Information" type="submit" id="submitVisitorInformation" class="btn bg-2"><i class="fas fa-plus"></i>&ensp;Update Visitor Information</button>
		            <input type="hidden" type="number" value="${visitorInfoCount }" id = "visitorInfoCount" />
		          </div>
		          </form>
		        </div>
		      </div>
		    </div>
		  </div>
		</section>
      </div>
      <%@include file="includeJSP/footer.jsp"%>
    </div>
    <%@include file="../includeJSP/jsFiles.jsp"%>
    <script src="usedStaticFiles/essentials/js/jsp_js_files/vims/vims-information.js"></script>
  </body>
</html>
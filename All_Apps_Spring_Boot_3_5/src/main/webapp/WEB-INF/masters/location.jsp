<!-- ****************************************************************************************
# *******************************************************************************************
# Copyright © 2021 Anand Group India. All rights reserved.									*
# No part of this product may be reproduced in any form by any means without prior			*
# written authorization of Anand Automotive Private Limited and its licensors, if any.		*
# *******************************************************************************************
# Author - Sheshadhri Iyer																	*
# *************************************************************************************** -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>LOCATION<%@include file="../includeJSP/company_name_title.jsp"%></title>
    <%@include file="../includeJSP/cssFiles.jsp"%>
    <style>
        div.dataTables_scroll {
        	width: 100% !important;
        	margin: 0 auto  !important;
        }
      </style>
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
                <h5 class="font-3">LOCATION LIST</h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item font-1"><a href="dashboard" title="Dashboard">Dashboard</a></li>
                  <li class="breadcrumb-item font-1"><a href="master" title="Masters Dashboard">Masters</a></li>
                  <li class="breadcrumb-item active font-3">Location</li>
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
		        <form modelAttribute="location" action="location" id="location" method="post">
		        <div class="card card-primary collapsed-card">
		          <div class="card-header bg-1" data-card-widget="collapse">
		            <h5 class="card-title font-weight-bold">Add Location</h5>
		            <div class="card-tools">
		              <button type="button" class="btn btn-tool text-white font-weight-bold" data-card-widget="collapse">
		                <i class="fas fa-plus"></i>
		              </button>
		              <input type="hidden" value="${openAddModal }" id="openAddModel" />
		              <input type="hidden" value="${openEditModel }" id="openEditModel" />
		            </div>
		          </div>
		          <div class="card-body" style="display: none;">
		            <div class="row">
		              <div class="col-md-3">
		                <div class="form-group">
		                  <label for="locationName" class="font-1"><span class="mandatory">*</span>Location Name</label>
		                  <input type="text" class="form-control" id="locationName" placeholder="Enter Location Name" name="locationName" />
		                  <span class="error invalid-feedback" id="locationNameError"></span>
		                </div>
		              </div>
		              <div class="col-md-3">
		                <div class="form-group">
		                  <label for="locationActive" class="font-2"><span class="mandatory">*</span>Location Zone</label>
		                  <select name="zoneIdTemp" id="zoneIdTemp" class="form-control">
		                    <option value="-1">Select Zone</option>
		                    <c:forEach items="${activeZoneList }" var="zone" varStatus="zoneStatus">
		                      <option value="${zone.mZoneId }">${zone.zoneName }</option>
		                    </c:forEach>
		                  </select>
		                  <span class="error invalid-feedback" id="zoneIdTempError"></span>
		                </div>
		              </div>
		              <div class="col-md-3">
		                <div class="form-check" id="isActiveDiv">
		                  <label class="font-3"><span class="mandatory">*</span>Location Active/InActive</label>
		                  <div class="custom-control custom-radio">
		                    <input type="radio" name="locationActive" class="custom-control-input" value="1" id="locationActive1" name="locationActive" />
		                    <label for="locationActive1" class="custom-control-label sequence-font-5">Active</label>
		                  </div>
		                  <div class="custom-control custom-radio">
		                    <input type="radio" name="locationActive" class="custom-control-input" value="0" id="locationActive2" name="locationActive" />
		                    <label for="locationActive2" class="custom-control-label sequence-font-1">Inactive</label>
		                  </div>
		                  <span class="error invalid-feedback" id="isActiveError" style="display:block" ></span> 
		                </div>
		              </div>
		              <div class="col-md-3">
		                <div class="form-check">
		                  <br>
		                  <button style="float: left;" title="Add Location" type="submit" id="submitLocationButton" class="btn bg-1">Submit</button>
		                </div>
		              </div>
		            </div>
		          </div>
		        </div>
		        </form>
		      </div>
		    </div>
		    
		    <div class="row">
		      <div class="col-md-12">
		        <div class="card card-secondary">
		          <div class="card-header bg-3">
		            <h5 class="card-title font-weight-bold">List of Locations</h5>
		          </div>
		          <div class="card-body">
		            <div class="row">
		              <div class="col-md-12 tableOverFlowDiv">
		                <table class="table table-bordered table-striped dataTable" id="locationTable">
		                  <thead>
		                    <tr class="bg-table-head">
		                      <th>Action</th>
		                      <th>Location</th>
		                      <th>Zone</th>
		                      <th>Active/In-Active</th>
		                      <th>Created By</th>
		                      <th>Created On</th>
		                      <th>Updated By</th>
		                      <th>Updated On</th>
		                    </tr>
		                  </thead>
		                  <tbody>
		                    <c:forEach items="${locationList }" var="location" varStatus="locationLoop">
		                      <tr class="bg-table-row-${locationLoop.index %2 }">
		                        <td>${location.actionForList }</td>
		                        <td>${location.locationName }</td>
		                        <td>${location.mZoneId.zoneName }</td>
		                        <td>
		                          <c:choose>
		                            <c:when test="${location.locationActive eq 1 }"><span class="badge sequence-bg-5">Active</span></c:when>
		                            <c:otherwise><span class="badge sequence-bg-1">In-Active</span></c:otherwise>
		                          </c:choose>
		                        </td>
		                        <td>${location.mUserId.userFirstName } ${location.mUserId.userLastName }</td>
		                        <td><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${location.createdOn }" /></td>
		                        <td>${location.mUserIdUpdated.userFirstName } ${location.mUserIdUpdated.userLastName }</td>
		                        <td><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${location.updatedOn }" /></td>
		                      </tr>
		                    </c:forEach>
		                  </tbody>
		                  <tfoot>
		                    <tr class="bg-table-foot">
		                      <th>Action</th>
		                      <th>Location</th>
		                      <th>Zone</th>
		                      <th>Active/In-Active</th>
		                      <th>Created By</th>
		                      <th>Created On</th>
		                      <th>Updated By</th>
		                      <th>Updated On</th>
		                    </tr>
		                  </tfoot>
		                </table>
		              </div>
		            </div>
		          </div>
		        </div>
		      </div>
		    </div>

		  </div>
		</section>

		<div class="modal fade" id="editLocationModal">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <form modelAttribute="location" action="location" id="locationEdit" method="post">
		      <input type="hidden" name="mLocationId" id="mLocationId" />
		      <div class="modal-header bg-3">
		        <h4 class="modal-title font-weight-bold">Edit Location</h4>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	              <span aria-hidden="true"><i class="text-white font-weight-bold fas fa-times"></i></span>
	            </button>
		      </div>
		      <div class="modal-body">
		        <div class="row">
		          <c:if test="${not empty regMsgEdit }">
		            <div class="col-md-12">
		              <div class="alert bg-${cssEdit } alert-dismissible">
		                <button type="button" title="CLose Alert Box" class="close" data-dismiss="alert" aria-hidden="true"><i class="fas fa-times"></i></button>
		                <c:if test="${css eq 'sequence-bg-1'}">
		                  <h5><i class="icon fas fa-ban"></i>${regMsgEdit }</h5>
		                </c:if>
		                <c:if test="${css ne 'sequence-bg-1'}">
		                  <h5><i class="icon fas fa-check"></i>${regMsgEdit }</h5>
		                </c:if>
		              </div>
		            </div>
		          </c:if>
		          <div class="col-md-12">
		            <div class="card-body">
		              <div class="row">
		                <div class="col-md-12">
		                  <div class="form-group">
		                    <label for="locationNameEdit"><span class="mandatory">*</span>Location Name</label>
		                    <input type="text" class="form-control font-1" id="locationNameEdit" placeholder="Enter Location Name" name="locationName" />
		                    <span class="error invalid-feedback" id="locationNameErrorEdit"></span>
		                  </div>
		                </div>
		                <div class="col-md-12">
		                  <div class="form-group">
		                    <label for="locationActive" class="font-2"><span class="mandatory">*</span>Location Zone</label>
		                    <select name="zoneIdTemp" id="zoneIdTempEdit" class="form-control">
		                      <option value="-1">Select Zone</option>
		                      <c:forEach items="${activeZoneList }" var="zone" varStatus="zoneStatus">
		                        <option value="${zone.mZoneId }">${zone.zoneName }</option>
		                      </c:forEach>
		                    </select>
		                    <span class="error invalid-feedback" id="zoneIdTempErrorEdit"></span>
		                  </div>
		                </div>
		                <div class="col-md-12">
		                  <div class="form-check" id="isActiveEditDiv">
		                    <label class="font-3"><span class="mandatory">*</span>Location Active/InActive</label>
		                    <div class="custom-control custom-radio">
		                      <input type="radio" name="locationActive" class="custom-control-input" value="1" id="locationActiveEdit1" name="locationActive" />
		                      <label for="locationActiveEdit1" class="custom-control-label sequence-font-5">Active</label>
		                    </div>
		                    <div class="custom-control custom-radio">
		                      <input type="radio" name="locationActive" class="custom-control-input" value="0" id="locationActiveEdit2" name="locationActive" />
		                      <label for="locationActiveEdit2" class="custom-control-label sequence-font-1">Inactive</label>
		                    </div>
		                    <span class="error invalid-feedback" id="isActiveEditError" style="display:block" ></span> 
		                  </div>
		                </div>
		              </div>
		            </div>
		          </div>
		        </div>
		      </div>
		      <div class="modal-footer justify-content-between">
		        <button title="Close" type="button" id="closeEditLocationModal" class="btn sequence-bg-1" data-dismiss="modal">Close</button>
		        <button title="Edit Location Details" type="submit" id="saveLocationChanges" class="btn bg-1">Edit Location Details</button>
		      </div>
		      </form>
		    </div>
		  </div>
		</div>

      </div>
      <%@include file="../includeJSP/footer.jsp"%>
    </div>
    <%@include file="../includeJSP/jsFiles.jsp"%>
    <%@include file="../includeJSP/dataTablesImport.jsp"%>
    <script src="usedStaticFiles/essentials/js/jsp_js_files/masters/location.js"></script>
  </body>
</html>
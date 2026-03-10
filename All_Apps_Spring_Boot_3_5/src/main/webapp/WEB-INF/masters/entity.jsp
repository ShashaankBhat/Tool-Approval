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
    <title>ENTITY<%@include file="../includeJSP/company_name_title.jsp"%></title>
    <%@include file="../includeJSP/cssFiles.jsp"%>
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
                <h5 class="font-3">ENTITY LIST</h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item font-1"><a href="dashboard" title="Dashboard">Dashboard</a></li>
                  <li class="breadcrumb-item font-1"><a href="master" title="Masters Dashboard">Masters</a></li>
                  <li class="breadcrumb-item font-3active">Entity</li>
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
		        <form modelAttribute="entity" action="entity" id="entity" method="post">
		        <div class="card card-primary collapsed-card">
		          <div class="card-header bg-1" data-card-widget="collapse">
		            <h5 class="card-title font-weight-bold">Add Entity</h5>
		            <div class="card-tools">
		              <button type="button" class="btn btn-tool text-white" data-card-widget="collapse">
		                <i class="fas fa-plus"></i>
		              </button>
		              <input type="hidden" value="${openAddModal }" id="openAddModel" />
		              <input type="hidden" value="${openEditModel }" id="openEditModel" />
		            </div>
		          </div>
		          <div class="card-body" style="display: none;">
		            <div class="row">
		              <div class="col-md-12">
		                <div class="row">
		                  <div class="col-md-4">
		                    <div class="form-group">
		                      <label for="entityName" class="font-1"><span class="mandatory">*</span>Name</label>
		                      <input type="text" class="form-control" id="entityName" placeholder="Enter Company Name" name="entityName" />
		                      <span class="error invalid-feedback" id="entityNameError"></span>
		                    </div>
		                  </div>
		                  <div class="col-md-4">
		                    <div class="form-group">
		                      <label for="entityName" class="font-2"><span class="mandatory">*</span>Entity Source</label>
		                      <select name="parentEntityId" id="parentEntityId" class="form-control select2">
		                        <option value="-1">Select Entity Source</option>
		                        <option value="0">Parent Entity</option>
		                        <c:forEach items="${activeParentEntityList }" var="activeEntity" varStatus="activeEntityLoop">
		                          <option value="${activeEntity.mEntityId }">${activeEntity.entityShortName } - ${activeEntity.entityAcronym }</option>
		                        </c:forEach>
		                      </select>
		                      <span class="error invalid-feedback" id="parentEntityIdError"></span>
		                    </div>
		                  </div>
		                  <div class="col-md-3">
		                    <div class="form-check" id="isActiveDiv">
		                      <label class="font-3"><span class="mandatory">*</span>Entity Active/InActive</label>
		                      <div class="custom-control custom-radio">
		                        <input type="radio" name="entityActive" class="custom-control-input" value="1" id="entityActive1" name="entityActive" />
		                        <label for="entityActive1" class="custom-control-label sequence-font-5">Active</label>
		                      </div>
		                      <div class="custom-control custom-radio">
		                        <input type="radio" name="entityActive" class="custom-control-input" value="0" id="entityActive2" name="entityActive" />
		                        <label for="entityActive2" class="custom-control-label sequence-font-1">Inactive</label>
		                      </div>
		                      <span class="error invalid-feedback" id="isActiveError" style="display:block" ></span> 
		                    </div>
		                  </div>
		                  <div class="col-md-1">
		                    <div class="form-check">
		                      <br>
		                      <button style="float: left;" title="Add Entity" type="submit" id="submitEntityButton" 
		                      	class="btn bg-1 font-weight-bold">Save</button>
		                    </div>
		                  </div>
		                  <div class="col-md-4 shortName" style="display: block;">
		                    <div class="form-group">
		                      <label for="entityShortName" class="font-1"><span class="mandatory">*</span>Short Name</label>
		                      <input type="text" class="form-control" id="entityShortName" placeholder="Enter Entity Short Name" name="entityShortName" />
		                      <span class="error invalid-feedback" id="entityShortNameError"></span>
		                    </div>
		                  </div>
		                  <div class="col-md-4 acronym" style="display: block;">
		                    <div class="form-group">
		                      <label for="entityAcronym" class="font-2"><span class="mandatory">*</span>Acronym</label>
		                      <input type="text" class="form-control" id="entityAcronym" placeholder="Enter Entity Acronym" name="entityAcronym" />
		                      <span class="error invalid-feedback" id="entityAcronymError"></span>
		                    </div>
		                  </div>
		                  <div class="col-md-4 location" style="display: block;">
		                    <div class="form-group">
		                      <label for="zoneName" class="font-3"><span class="mandatory">*</span>Location</label>
		                      <select name="loationIdTemp" id="loationIdTemp" class="form-control">
		                        <option value="-1">Select Location</option>
		                        <c:forEach items="${activeLocationList }" var="location" varStatus="locationLoop">
		                          <option value="${location.mLocationId }">${location.locationName } - ${location.mZoneId.zoneName }</option>
		                        </c:forEach>
		                      </select>
		                      <span class="error invalid-feedback" id="loationIdTempError"></span>
		                    </div>
		                  </div>
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
		            <h5 class="card-title font-weight-bold">List of Entities</h5>
		          </div>
		          <div class="card-body">
		            <div class="row">
		              <div class="col-md-12 tableOverFlowDiv">
		                <table class="table table-bordered table-striped dataTable" id="entityTable">
		                  <thead>
		                    <tr class="bg-table-head">
		                      <th>Action</th>
		                      <th>Name</th>
		                      <th>Short Name</th>
		                      <th>Source</th>
		                      <th>Logo</th>
		                      <th>Location</th>
		                      <th>Zone</th>
		                      <th>Acronym</th>
		                      <th>Active/In-Active</th>
		                      <th>Created By</th>
		                      <th>Created On</th>
		                      <th>Updated By</th>
		                      <th>Updated On</th>
		                    </tr>
		                  </thead>
		                  <tbody>
		                    <c:forEach items="${entityList }" var="entity" varStatus="entityLoop">
		                      <tr>
		                        <td>${entity.actionForList }</td>
		                        <td>${entity.entityName }</td>
		                        <td>${entity.entityShortName }</td>
		                        <td>
		                          <c:choose>
		                            <c:when test="${empty entity.entitySource }"><span class="badge bg-1">Parent Entity</span></c:when>
		                            <c:when test="${not empty entity.entitySource }">${entity.entitySource.entityAcronym }</c:when>
		                          </c:choose>
		                        </td>
		                        <td>
		                          <c:choose>
		                            <c:when test="${empty entity.entityAcronym }"></c:when>
		                            <c:when test="${entity.entityAcronym ne 'AAPL' }">
		                              <img src="usedStaticFiles/essentials/images/company_images/${entity.entityAcronym }.png" style="height:25px;width:200px" alt="Company Logo" class="brand-image">
		                            </c:when>
		                            <c:when test="${entity.entityAcronym eq 'AAPL' }">
		                              <img src="usedStaticFiles/essentials/images/company_images/${entity.entityAcronym }.png" style="height:30px;width:200px" alt="Company Logo" class="brand-image">
		                            </c:when>
		                          </c:choose>
		                        </td>
		                        <td>${entity.locationId.locationName }</td>
		                        <td>
		                          <c:choose>
		                            <c:when test="${empty entity.locationId }"></c:when>
		                            <c:when test="${entity.locationId.mZoneId.mZoneId eq 1 }"><span class="badge bg-1">${entity.locationId.mZoneId.zoneName }</span></c:when>
		                            <c:when test="${entity.locationId.mZoneId.mZoneId eq 2 }"><span class="badge bg-2">${entity.locationId.mZoneId.zoneName }</span></c:when>
		                            <c:when test="${entity.locationId.mZoneId.mZoneId eq 3 }"><span class="badge bg-3">${entity.locationId.mZoneId.zoneName }</span></c:when>
		                            <c:when test="${entity.locationId.mZoneId.mZoneId eq 4 }"><span class="badge bg-13">${entity.locationId.mZoneId.zoneName }</span></c:when>
		                            <c:when test="${entity.locationId.mZoneId.mZoneId eq 5 }"><span class="badge bg-14">${entity.locationId.mZoneId.zoneName }</span></c:when>
		                          </c:choose>
		                        </td>
		                        <td>${entity.entityAcronym }</td>
		                        <td>
		                          <c:choose>
		                            <c:when test="${entity.entityActive eq 1 }"><span class="badge sequence-bg-5">Active</span></c:when>
		                            <c:otherwise><span class="badge sequence-bg-1">In-Active</span></c:otherwise>
		                          </c:choose>
		                        </td>
		                        <td>${entity.mUserId.userFirstName } ${entity.mUserId.userLastName }</td>
		                        <td><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${entity.createdOn }" /></td>
		                        <td>${entity.mUserIdUpdated.userFirstName } ${entity.mUserIdUpdated.userLastName }</td>
		                        <td><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${entity.updatedOn }" /></td>
		                      </tr>
		                    </c:forEach>
		                  </tbody>
		                  <tfoot>
		                    <tr class="bg-table-foot">
		                      <th>Action</th>
		                      <th>Name</th>
		                      <th>Short Name</th>
		                      <th>Source</th>
		                      <th>Logo</th>
		                      <th>Location</th>
		                      <th>Zone</th>
		                      <th>Acronym</th>
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

		<div class="modal fade" id="editEntityModal">
		  <div class="modal-dialog modal-lg">
		    <div class="modal-content">
		      <form modelAttribute="entity" action="entity" id="entityEdit" method="post">
		      <input type="hidden" name="mEntityId" id="mEntityId" />
		      <div class="modal-header bg-3">
		        <h4 class="modal-title  font-weight-bold">Edit Entity</h4>
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
		                <c:if test="${css eq 'danger'}">
		                  <h5><i class="icon fas fa-ban"></i>${regMsgEdit }</h5>
		                </c:if>
		                <c:if test="${css ne 'danger'}">
		                  <h5><i class="icon fas fa-check"></i>${regMsgEdit }</h5>
		                </c:if>
		              </div>
		            </div>
		          </c:if>
		          <div class="col-md-12">
		            <div class="card-body">
		              <div class="row">
		                
		                <div class="col-md-6">
		                  <div class="form-group">
		                    <label for="entityNameEdit" class="font-1"><span class="mandatory">*</span>Name</label>
		                    <input type="text" class="form-control" id="entityNameEdit" placeholder="Enter Company Name" name="entityName" />
		                    <span class="error invalid-feedback" id="entityNameErrorEdit"></span>
		                  </div>
		                </div>
		                <div class="col-md-6">
		                  <div class="form-group">
		                    <label for="parentEntityIdEdit" class="font-2"><span class="mandatory">*</span>Entity Source</label>
		                    <select name="parentEntityId" id="parentEntityIdEdit" class="form-control select2">
		                      <option value="-1">Select Entity Source</option>
		                      <option value="0">Parent Entity</option>
		                      <c:forEach items="${activeParentEntityList }" var="activeEntity" varStatus="activeEntityLoop">
		                        <option value="${activeEntity.mEntityId }">${activeEntity.entityShortName } - ${activeEntity.entityAcronym }</option>
		                      </c:forEach>
		                    </select>
		                    <span class="error invalid-feedback" id="parentEntityIdErrorEdit"></span>
		                  </div>
		                </div>
		                <div class="col-md-6">
		                  <div class="form-check" id="isActiveEditDiv">
		                    <label class="font-1"><span class="mandatory">*</span>Zone Active/InActive</label>
		                    <div class="custom-control custom-radio">
		                      <input type="radio" name="entityActive" class="custom-control-input" value="1" id="entityActiveEdit1" name="entityActive" />
		                      <label for="entityActiveEdit1" class="custom-control-label sequence-font-5">Active</label>
		                    </div>
		                    <div class="custom-control custom-radio">
		                      <input type="radio" name="entityActive" class="custom-control-input" value="0" id="entityActiveEdit2" name="entityActive" />
		                      <label for="entityActiveEdit2" class="custom-control-label sequence-font-1">Inactive</label>
		                    </div>
		                    <span class="error invalid-feedback" id="isActiveEditError" style="display:block" ></span> 
		                  </div>
		                </div>
		                <div class="col-md-6 shortNameEdit" style="display: block;">
		                  <div class="form-group">
		                    <label for="entityShortNameEdit" class="font-2"><span class="mandatory">*</span>Short Name</label>
		                    <input type="text" class="form-control" id="entityShortNameEdit" placeholder="Enter Entity Short Name" name="entityShortName" />
		                    <span class="error invalid-feedback" id="entityShortNameErrorEdit"></span>
		                  </div>
		                </div>
		                <div class="col-md-6 acronymEdit" style="display: block;">
		                  <div class="form-group">
		                    <label for="entityAcronymEdit" class="font-1"><span class="mandatory">*</span>Acronym</label>
		                    <input type="text" class="form-control" id="entityAcronymEdit" placeholder="Enter Entity Acronym" name="entityAcronym" />
		                    <span class="error invalid-feedback" id="entityAcronymErrorEdit"></span>
		                  </div>
		                </div>
		                <div class="col-md-6 locationEdit" style="display: block;">
		                  <div class="form-group">
		                    <label for="loationIdTempEdit" class="font-2"><span class="mandatory">*</span>Location</label>
		                    <select name="loationIdTemp" id="loationIdTempEdit" class="form-control">
		                      <option value="-1">Select Location</option>
		                      <c:forEach items="${activeLocationList }" var="location" varStatus="locationLoop">
		                        <option value="${location.mLocationId }">${location.locationName } - ${location.mZoneId.zoneName }</option>
		                      </c:forEach>
		                    </select>
		                    <span class="error invalid-feedback" id="loationIdTempErrorEdit"></span>
		                  </div>
		                </div>
		              </div>
		            </div>
		          </div>
		        </div>
		      </div>
		      <div class="modal-footer justify-content-between">
		        <button id="closeEditZoneModal" type="button" class="btn sequence-bg-1" title="Close" data-dismiss="modal">Close</button>
		        <button id="saveZoneChanges" type="submit" class="btn bg-1" title="Edit Entity Details">Edit Entity Details</button>
		      </div>
		      </form>
		    </div>
		  </div>
		</div>
      </div>
      <%@include file="../includeJSP/footer.jsp"%>
      <aside class="control-sidebar control-sidebar-dark bg-2">
        <form action="entity-filter" id="entity-filter" method="post">
          <input type="hidden" id="zoneIdNow" value="${zoneIdNow }" />
          <div class="p-3 control-sidebar-content">
            <h5>Filter</h5>
            <hr class="mb-2">
            <div class="mb-1">
              <h6>Parent Entity</h6>
              <div class="d-flex">
                <input type="hidden" name="all" value="1" />
                <input type="hidden" id="parentEntityFilterValue" value="${parentEntityFilterValue }" />
                <select id="parentEntityFilter" name="parentEntityFilter" class="custom-select mb-3 text-light border-0 bg-white">
                  <option value="-1">Select Parent Entity</option>
                  <c:forEach items="${activeParentEntityList }" var="activeEntity" varStatus="activeEntityLoop">
                    <option value="${activeEntity.mEntityId }">${activeEntity.entityShortName } - ${activeEntity.entityAcronym }</option>
                  </c:forEach>
                </select>
              </div>
            </div>
            <div class="mb-1">
              <h6>Location</h6>
              <div class="d-flex">
                <input type="hidden" id="locationFilterValue" value="${locationFilterValue }" /><br>
                <select id="locationFilter" name="locationFilter" class="custom-select mb-3 text-light border-0 bg-white">
                  <option value="-1">Select Entity Location</option>
                  <c:forEach items="${activeLocationList }" var="location" varStatus="locationLoop">
                    <option value="${location.mLocationId }">${location.locationName } - ${location.mZoneId.zoneName }</option>
                  </c:forEach>
                </select>
              </div>
            </div>
            <hr class="mb-2">
            <div class="d-flex">
              <button type="submit" title="Filter Entity Information" class="btn btn-default">Search</button>
              &emsp;<button onclick='$("#parentEntityFilter").val(-1);$("#locationFilter").val(-1);$("#entity-filter").submit();' title="Clear Filter" class="btn btn-default">Clear</button>
            </div>
          </div>
        </form>
      </aside>
    </div>
    <%@include file="../includeJSP/jsFiles.jsp"%>
    <%@include file="../includeJSP/dataTablesImport.jsp"%>
    <script src="usedStaticFiles/essentials/js/jsp_js_files/masters/entity.js"></script>
  </body>
</html>
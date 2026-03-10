<!-- ****************************************************************************************
# *******************************************************************************************
# Copyright © 2021 Anand Group India. All rights reserved.                                    *
# No part of this product may be reproduced in any form by any means without prior            *
# written authorization of Anand Automotive Private Limited and its licensors, if any.        *
# *******************************************************************************************
# Author - Sheshadhri Iyer                                                                    *
# *************************************************************************************** -->
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>STATUS<%@include file="../includeJSP/company_name_title.jsp"%></title>
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
                <h5 class="font-3">STATUS LIST</h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item font-1"><a href="dashboard" title="Dashboard">Dashboard</a></li>
                  <li class="breadcrumb-item font-1"><a href="ta-masters-dashboard" title="TA Masters Dashboard">TA Masters</a></li>
                  <li class="breadcrumb-item font-3 active">Status</li>
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
		        <form modelAttribute="taStatus" action="ta-status" id="taStatus" method="post">
		          <div class="card card-primary collapsed-card">
		            <div class="card-header bg-1" data-card-widget="collapse">
		              <h5 class="card-title font-weight-bold">Add Status</h5>
		              <div class="card-tools">
		                <button type="button" class="btn btn-tool text-white font-weight-bold" data-card-widget="collapse">
		                  <i class="fas fa-plus"></i>
		                </button>
		              </div>
		            </div>

		            <div class="card-body" style="display: none;">
		              <div class="row">

		                <div class="col-md-4">
		                  <div class="form-group">
		                    <label class="font-1" for="taStatusName"><span class="mandatory">*</span>Status Name</label>
		                    <input type="text" class="form-control" id="taStatusName" name="taStatusName" placeholder="Enter Status Name"/>
		                    <span class="invalid-feedback" id="taStatusNameError"></span>
		                  </div>
		                </div>

		                <div class="col-md-4">
		                  <div class="form-group">
		                    <label class="font-1" for="taStatusDescription"><span class="mandatory">*</span>Description</label>
		                    <input type="text" class="form-control" id="taStatusDescription" name="taStatusDescription" placeholder="Enter Status Description"/>
		                    <span class="invalid-feedback" id="taStatusDescriptionError"></span>
		                  </div>
		                </div>

		                <div class="col-md-4">
		                  <div class="form-check" id="isActiveDiv">
		                    <label class="font-2"><span class="mandatory">*</span>Status Active/InActive</label>
		                    <div class="custom-control custom-radio">
		                      <input type="radio" name="taStatusActive" class="custom-control-input" value="1" id="taStatusActive1">
		                      <label for="taStatusActive1" class="custom-control-label sequence-font-5">Active</label>
		                    </div>
		                    <div class="custom-control custom-radio">
		                      <input type="radio" name="taStatusActive" class="custom-control-input" value="0" id="taStatusActive2">
		                      <label for="taStatusActive2" class="custom-control-label sequence-font-1">Inactive</label>
		                    </div>
		                    <span class="invalid-feedback d-block" id="matrixActiveError"></span>
		                  </div>
		                </div>

		              </div>

		              <div class="row">
		                <div class="col-md-12">
		                  <button type="submit" class="btn bg-1">Submit</button>
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
		            <h5 class="card-title font-weight-bold">List of Statuses</h5>
		          </div>
		          <div class="card-body">
		            <div class="row">
		              <div class="col-md-12 tableOverFlowDiv">
		                <table class="table table-bordered table-striped dataTable nowrap" id="taStatusTable" style="width:100%">
		                  <thead>
		                    <tr class="bg-table-head">
		                      <th style="width:90px;">Action</th>
		                      <th>Name</th>
		                      <th>Description</th>
		                      <th>Active/In-Active</th>
		                      <th>Created By</th>
		                      <th>Created On</th>
		                      <th>Updated By</th>
		                      <th>Updated On</th>
		                    </tr>
		                  </thead>
		                  <tbody>
		                    <c:forEach items="${statusList }" var="taStatus" varStatus="taStatusLoop">
		                      <tr class="bg-table-row-${taStatusLoop.index %2 }">
		                        <td>${taStatus.actionForList}</td>
		                        <td>${taStatus.taStatusName }</td>
		                        <td>${taStatus.taStatusDescription }</td>
		                        <td>
		                          <c:choose>
		                            <c:when test="${taStatus.taStatusActive eq 1 }"><span class="badge sequence-bg-5">Active</span></c:when>
		                            <c:otherwise><span class="badge sequence-bg-1">In-Active</span></c:otherwise>
		                          </c:choose>
		                        </td>
		                        <td>${taStatus.createdBy.userFirstName } ${taStatus.createdBy.userLastName }</td>
		                        <td><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${taStatus.createdOn }" /></td>
		                        <td>${taStatus.updatedBy.userFirstName } ${taStatus.updatedBy.userLastName }</td>
		                        <td><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${taStatus.updatedOn }" /></td>
		                      </tr>
		                    </c:forEach>
		                  </tbody>
		                  <tfoot>
		                    <tr class="bg-table-foot">
		                      <th>Action</th>
		                      <th>Name</th>
		                      <th>Description</th>
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

      </div>
      <%@include file="../includeJSP/footer.jsp"%>
    </div>
    <%@include file="../includeJSP/jsFiles.jsp"%>
    <%@include file="../includeJSP/dataTablesImport.jsp"%>
    <script src="usedStaticFiles/essentials/js/jsp_js_files/toolApproval/taStatusMaster.js"></script>
    
    <div class="modal fade" id="editTaStatusModal">
      <div class="modal-dialog">
        <div class="modal-content">
          <form modelAttribute="taStatus" action="ta-status" id="taStatusEdit" method="post">
          <input type="hidden" name="taStatusId" id="taStatusId"/>
    
          <div class="modal-header bg-3">
            <h4 class="modal-title font-weight-bold">Edit Status</h4>
            <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
          </div>
    
          <div class="modal-body">
            <div class="row">
    
              <div class="col-md-6">
                <div class="form-group">
                  <label for="taStatusNameEdit"><span class="mandatory">*</span>Status Name</label>
                  <input type="text" class="form-control" id="taStatusNameEdit" name="taStatusName"/>
                  <span class="invalid-feedback" id="taStatusNameErrorEdit"></span>
                </div>
              </div>
    
              <div class="col-md-6">
                <div class="form-group">
                  <label for="taStatusDescriptionEdit"><span class="mandatory">*</span>Description</label>
                  <input type="text" class="form-control" id="taStatusDescriptionEdit" name="taStatusDescription"/>
                  <span class="invalid-feedback" id="taStatusDescriptionErrorEdit"></span>
                </div>
              </div>
    
              <div class="col-md-6">
                <div class="form-check" id="isActiveEditDiv">
                  <label><span class="mandatory">*</span>Status Active/InActive</label>
                  <div class="custom-control custom-radio">
                    <input type="radio" name="taStatusActive" class="custom-control-input" id="taStatusActiveEdit1" value="1">
                    <label for="taStatusActiveEdit1" class="custom-control-label">Active</label>
                  </div>
                  <div class="custom-control custom-radio">
                    <input type="radio" name="taStatusActive" class="custom-control-input" id="taStatusActiveEdit2" value="0">
                    <label for="taStatusActiveEdit2" class="custom-control-label">Inactive</label>
                  </div>
                  <span class="invalid-feedback d-block" id="matrixActiveEditError"></span>
                </div>
              </div>
    
            </div>
          </div>
    
          <div class="modal-footer justify-content-between">
            <button type="button" class="btn sequence-bg-1" data-dismiss="modal">Close</button>
            <button type="submit" class="btn bg-1">Edit Status</button>
          </div>
    
          </form>
        </div>
      </div>
    </div>
  </body>
</html>

<!-- ****************************************************************************************
# *******************************************************************************************
# Copyright Â© 2021 Anand Group India. All rights reserved.									*
# No part of this product may be reproduced in any form by any means without prior			*
# written authorization of Anand Automotive Private Limited and its licensors, if any.		*
# *******************************************************************************************
# Author - Sheshadhri Iyer																	*
# *************************************************************************************** -->
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>BUSINESS UNIT<%@include file="../includeJSP/company_name_title.jsp"%></title>
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
              <div class="col-sm-4">
                <h5 class="font-3">BUSINESS UNIT LIST</h5>
              </div>
              <div class="col-sm-8">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item"><a href="dashboard" title="Dashboard"><strong>Dashboard</strong></a></li>
                  <li class="breadcrumb-item"><a href="dashboard-tool-approval" title="TA Dashboard"><strong>TA Dashboard</strong></a></li>
                  <li class="breadcrumb-item"><a href="ta-masters-dashboard" title="TA Masters"><strong>TA Masters</strong></a></li>
                  <li class="breadcrumb-item active"><strong>Business Unit</strong></li>
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
		        <form modelAttribute="taBusinessUnit" action="ta-business-unit" id="taBusinessUnit" method="post">
		        <div class="card card-primary collapsed-card">
		          <div class="card-header bg-1" data-card-widget="collapse">
		            <h5 class="card-title font-weight-bold">Add Business Unit</h5>
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
		              <div class="col-md-4">
		                <div class="form-group">
		                  <label class="font-1" for="taBusinessUnitName"><span class="mandatory">*</span>Business Unit Name</label>
		                  <input type="text" value="${businessUnit.taBusinessUnitName }" class="form-control" id="taBusinessUnitName" placeholder="Enter Business Unit Name" name="taBusinessUnitName" />
		                  <span class="error invalid-feedback" id="taBusinessUnitNameError"></span>
		                </div>
		              </div>
		              <div class="col-md-4">
		                <div class="form-check" id="isActiveDiv">
		                  <label class="font-2"><span class="mandatory">*</span>Business Unit Active/InActive</label>
		                  <div class="custom-control custom-radio">
		                    <input type="radio" name="taBusinessUnitActive" class="custom-control-input" value="1" id="taBusinessUnitActive1" name="taBusinessUnitActive" />
		                    <label for="taBusinessUnitActive1" class="custom-control-label sequence-font-5">Active</label>
		                  </div>
		                  <div class="custom-control custom-radio">
		                    <input type="radio" name="taBusinessUnitActive" class="custom-control-input" value="0" id="taBusinessUnitActive2" name="taBusinessUnitActive" />
		                    <label for="taBusinessUnitActive2" class="custom-control-label sequence-font-1">Inactive</label>
		                  </div>
		                  <input type="hidden" id="activenessTemp" value="${businessUnit.taBusinessUnitActive }" />
		                  <span class="error invalid-feedback" id="isActiveError" style="display:block" ></span> 
		                </div>
		              </div>
		              <div class="col-md-4">
		                <div class="form-check">
		                  <br>
		                  <button style="float: left;" title="Add Business Unit" type="submit" id="submitTaBusinessUnitButton" class="btn bg-1">Submit</button>
		                </div>
		              </div>
		              <div class="col-md-6">
		                <div class="form-group">
		                  <label class="font-3" for="taBusinessUnitDescription"><span class="mandatory">*</span>Business Unit Description</label>
		                  <input type="text" value="${businessUnit.taBusinessUnitDescription }" class="form-control" id="taBusinessUnitDescription" placeholder="Enter Business Unit Description" name="taBusinessUnitDescription" />
		                  <span class="error invalid-feedback" id="taBusinessUnitDescriptionError"></span>
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
		            <h5 class="card-title font-weight-bold">List of Business Units</h5>
		          </div>
		          <div class="card-body">
		            <div class="row">
		              <div class="col-md-12 tableOverFlowDiv">
		                <table class="table table-bordered table-striped dataTable" id="taBusinessUnitTable">
		                  <thead>
		                    <tr class="bg-table-head">
		                      <th>Action</th>
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
		                    <c:forEach items="${businessUnitList }" var="taBusinessUnit" varStatus="taBusinessUnitLoop">
		                      <tr class="bg-table-row-${taBusinessUnitLoop.index %2 }">
		                        <td>${taBusinessUnit.actionForList }</td>
		                        <td>${taBusinessUnit.taBusinessUnitName }</td>
		                        <td>${taBusinessUnit.taBusinessUnitDescription }</td>
		                        <td>
		                          <c:choose>
		                            <c:when test="${taBusinessUnit.taBusinessUnitActive eq 1 }"><span class="badge sequence-bg-5">Active</span></c:when>
		                            <c:otherwise><span class="badge sequence-bg-1">In-Active</span></c:otherwise>
		                          </c:choose>
		                        </td>
		                        <td>${taBusinessUnit.createdBy.userFirstName } ${taBusinessUnit.createdBy.userLastName }</td>
		                        <td><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${taBusinessUnit.createdOn }" /></td>
		                        <td>${taBusinessUnit.updatedBy.userFirstName } ${taBusinessUnit.updatedBy.userLastName }</td>
		                        <td><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${taBusinessUnit.updatedOn }" /></td>
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
		<div class="modal fade" id="editTaBusinessUnitModal">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <form modelAttribute="taBusinessUnit" action="ta-business-unit" id="taBusinessUnitEdit" method="post">
		      <input type="hidden" name="taBusinessUnitId" id="taBusinessUnitId" />
		      <div class="modal-header bg-3">
		        <h4 class="modal-title font-weight-bold">Edit Business Unit</h4>
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
		                <div class="col-md-6">
		                  <div class="form-group">
		                    <label class="font-1" for="taBusinessUnitNameEdit"><span class="mandatory">*</span>Business Unit Name</label>
		                    <input value="${businessUnit.taBusinessUnitName }" type="text" class="form-control" id="taBusinessUnitNameEdit" placeholder="Enter Business Unit Name" name="taBusinessUnitName" />
		                    <span class="error invalid-feedback" id="taBusinessUnitNameErrorEdit"></span>
		                  </div>
		                </div>
		                <div class="col-md-6">
		                  <div class="form-check" id="isActiveEditDiv">
		                    <label class="font-2"><span class="mandatory">*</span>Business Unit Active/InActive</label>
		                    <div class="custom-control custom-radio">
		                      <input type="radio" name="taBusinessUnitActive" class="custom-control-input" value="1" id="taBusinessUnitActiveEdit1" name="taBusinessUnitActive" />
		                      <label for="taBusinessUnitActiveEdit1" class="custom-control-label sequence-font-5">Active</label>
		                    </div>
		                    <div class="custom-control custom-radio">
		                      <input type="radio" name="taBusinessUnitActive" class="custom-control-input" value="0" id="taBusinessUnitActiveEdit2" name="taBusinessUnitActive" />
		                      <label for="taBusinessUnitActiveEdit2" class="custom-control-label sequence-font-1">Inactive</label>
		                    </div>
		                    <span class="error invalid-feedback" id="isActiveEditError" style="display:block" ></span> 
		                  </div>
		                </div>
		                <div class="col-md-12">
		                  <div class="form-group">
		                    <label class="font-3" for="taBusinessUnitDescriptionEdit"><span class="mandatory">*</span>Business Unit Description</label>
		                    <input value="${businessUnit.taBusinessUnitDescription }" type="text" class="form-control" id="taBusinessUnitDescriptionEdit" placeholder="Enter Business Unit Description" name="taBusinessUnitDescription" />
		                    <span class="error invalid-feedback" id="taBusinessUnitDescriptionErrorEdit"></span>
		                  </div>
		                </div>
		              </div>
		            </div>
		          </div>
		        </div>
		      </div>
		      <div class="modal-footer justify-content-between">
		        <button title="Close" id="closeEditTaBusinessUnitModal" type="button" class="btn sequence-bg-1" data-dismiss="modal">Close</button>
		        <button type="submit" id="saveTaBusinessUnitChanges" class="btn bg-1" title="Edit Business Unit Details">Edit Business Unit Details</button>
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
    <script src="usedStaticFiles/essentials/js/jsp_js_files/toolApproval/taBusinessUnitMaster.js"></script>
  </body>
</html>
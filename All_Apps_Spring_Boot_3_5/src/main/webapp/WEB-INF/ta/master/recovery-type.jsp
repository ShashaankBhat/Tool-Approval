<!DOCTYPE html>
<html lang="en">
  <head>
    <title>RECOVERY TYPE | TOOL APPROVAL<%@include file="../../includeJSP/company_name_title.jsp"%></title>
    <%@include file="../../includeJSP/cssFiles.jsp"%>
  </head>
  <body class="sidebar-mini layout-navbar-fixed sidebar-collapse pace-primary">
    <div class="wrapper">
      <%@include file="../includeJSP/header.jsp"%>
      <%@include file="../includeJSP/leftSideBar.jsp"%>
      <div class="content-wrapper">
        <section class="content-header">	
          <div class="container-fluid">
            <div class="row mb-2">
              <div class="col-sm-6">
                <h5 class="font-3">RECOVERY TYPE LIST</h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item"><a href="dashboard" title="Dashboard"><strong>Dashboard</strong></a></li>
                  <li class="breadcrumb-item"><a href="dashboard-tool-approval" title="TA Dashboard"><strong>TA Dashboard</strong></a></li>
                  <li class="breadcrumb-item"><a href="ta-masters-dashboard" title="TA Masters"><strong>TA Masters</strong></a></li>
                  <li class="breadcrumb-item active"><strong>Recovery Type</strong></li>
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
		        <form modelAttribute="recoveryType" action="ta-recovery-type" id="taRecoveryType" method="post">
		        <div class="card card-primary collapsed-card">
		          <div class="card-header bg-1" data-card-widget="collapse">
		            <h5 class="card-title font-weight-bold">Add Recovery Type</h5>
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
		                  <label class="font-1" for="taRecoveryTypeName"><span class="mandatory">*</span>Recovery Type Name</label>
		                  <input type="text" value="${recoveryType.taRecoveryTypeName}" class="form-control" id="taRecoveryTypeName" placeholder="Enter Recovery Type Name" name="taRecoveryTypeName" />
		                  <span class="error invalid-feedback" id="taRecoveryTypeNameError"></span>
		                </div>
		              </div>
		              <div class="col-md-4">
		                <div class="form-check" id="isActiveDiv">
		                  <label class="font-2"><span class="mandatory">*</span>Recovery Type Active/InActive</label>
		                  <input type="hidden" id="activenessTemp" value="${recoveryType.taRecoveryTypeActive }" />
		                  <div class="custom-control custom-radio">
		                    <input type="radio" name="taRecoveryTypeActive" class="custom-control-input" value="1" id="taRecoveryTypeActive1" />
		                    <label for="taRecoveryTypeActive1" class="custom-control-label sequence-font-5">Active</label>
		                  </div>
		                  <div class="custom-control custom-radio">
		                    <input type="radio" name="taRecoveryTypeActive" class="custom-control-input" value="0" id="taRecoveryTypeActive2" />
		                    <label for="taRecoveryTypeActive2" class="custom-control-label sequence-font-1">Inactive</label>
		                  </div>
		                  <span class="error invalid-feedback" id="isActiveError" style="display:block" ></span> 
		                </div>
		              </div>
		              <div class="col-md-4">
		                <div class="form-check">
		                  <br>
		                  <button style="float: left;" title="Add Recovery Type" type="submit" id="submitTaRecoveryTypeButton" class="btn bg-1">Submit</button>
		                </div>
		              </div>
		              <div class="col-md-6">
		                <div class="form-group">
		                  <label class="font-3" for="taRecoveryTypeDescription"><span class="mandatory">*</span>Recovery Type Description</label>
		                  <input type="text" value="${recoveryType.taRecoveryTypeDescription}" class="form-control" id="taRecoveryTypeDescription" placeholder="Enter Recovery Type Description" name="taRecoveryTypeDescription" />
		                  <span class="error invalid-feedback" id="taRecoveryTypeDescriptionError"></span>
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
		            <h5 class="card-title font-weight-bold">List of Recovery Types</h5>
		          </div>
		          <div class="card-body">
		            <div class="row">
		              <div class="col-md-12 tableOverFlowDiv">
		                <table class="table table-bordered table-striped dataTable nowrap" id="taRecoveryTypeTable" style="width:100%">
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
		                    <c:forEach items="${recoveryTypeList }" var="taRecoveryType" varStatus="taRecoveryTypeLoop">
		                      <tr class="bg-table-row-${taRecoveryTypeLoop.index %2 }">
		                        <td>${taRecoveryType.actionForList }</td>
		                        <td>${taRecoveryType.taRecoveryTypeName }</td>
		                        <td>${taRecoveryType.taRecoveryTypeDescription }</td>
		                        <td>
		                          <c:choose>
		                            <c:when test="${taRecoveryType.taRecoveryTypeActive eq 1 }"><span class="badge sequence-bg-5">Active</span></c:when>
		                            <c:otherwise><span class="badge sequence-bg-1">In-Active</span></c:otherwise>
		                          </c:choose>
		                        </td>
		                        <td>${taRecoveryType.createdBy.userFirstName } ${taRecoveryType.createdBy.userLastName }</td>
		                        <td><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${taRecoveryType.createdOn }" /></td>
		                        <td>${taRecoveryType.updatedBy.userFirstName } ${taRecoveryType.updatedBy.userLastName }</td>
		                        <td><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${taRecoveryType.updatedOn }" /></td>
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
		<div class="modal fade" id="editTaRecoveryTypeModal">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <form modelAttribute="taRecoveryType" action="ta-recovery-type" id="taRecoveryTypeEdit" method="post">
		      <input type="hidden" name="taRecoveryTypeId" id="taRecoveryTypeId" />
		      <div class="modal-header bg-3">
		        <h4 class="modal-title font-weight-bold">Edit Recovery Type</h4>
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
		                    <label class="font-1" for="taRecoveryTypeNameEdit"><span class="mandatory">*</span>Recovery Type Name</label>
		                    <input type="text" class="form-control" id="taRecoveryTypeNameEdit" placeholder="Enter Recovery Type Name" name="taRecoveryTypeName" />
		                    <span class="error invalid-feedback" id="taRecoveryTypeNameErrorEdit"></span>
		                  </div>
		                </div>
		                <div class="col-md-6">
		                  <div class="form-check" id="isActiveEditDiv">
		                    <label class="font-2"><span class="mandatory">*</span>Recovery Type Active/InActive</label>
		                    <div class="custom-control custom-radio">
		                      <input type="radio" name="taRecoveryTypeActive" class="custom-control-input" value="1" id="taRecoveryTypeActiveEdit1" name="taRecoveryTypeActive" />
		                      <label for="taRecoveryTypeActiveEdit1" class="custom-control-label sequence-font-5">Active</label>
		                    </div>
		                    <div class="custom-control custom-radio">
		                      <input type="radio" name="taRecoveryTypeActive" class="custom-control-input" value="0" id="taRecoveryTypeActiveEdit2" name="taRecoveryTypeActive" />
		                      <label for="taRecoveryTypeActiveEdit2" class="custom-control-label sequence-font-1">Inactive</label>
		                    </div>
		                    <span class="error invalid-feedback" id="isActiveEditError" style="display:block" ></span> 
		                  </div>
		                </div>
		                <div class="col-md-12">
		                  <div class="form-group">
		                    <label class="font-3" for="taRecoveryTypeDescriptionEdit"><span class="mandatory">*</span>Recovery Type Description</label>
		                    <input type="text" class="form-control" id="taRecoveryTypeDescriptionEdit" placeholder="Enter Recovery Type Description" name="taRecoveryTypeDescription" />
		                    <span class="error invalid-feedback" id="taRecoveryTypeDescriptionErrorEdit"></span>
		                  </div>
		                </div>
		              </div>
		            </div>
		          </div>
		        </div>
		      </div>
		      <div class="modal-footer justify-content-between">
		        <button title="Close" id="closeEditTaRecoveryTypeModal" type="button" class="btn sequence-bg-1" data-dismiss="modal">Close</button>
		        <button type="submit" id="saveTaRecoveryTypeChanges" class="btn bg-1" title="Edit Recovery Type Details">Edit Recovery Type Details</button>
		      </div>
		      </form>
		    </div>
		  </div>
		</div>
      </div>
      <%@include file="../includeJSP/footer.jsp"%>
    </div>
    <%@include file="../../includeJSP/jsFiles.jsp"%>
    <%@include file="../../includeJSP/dataTablesImport.jsp"%>
    <script src="usedStaticFiles/essentials/js/jsp_js_files/ta/master/recovery-type.js"></script>
  </body>
</html>

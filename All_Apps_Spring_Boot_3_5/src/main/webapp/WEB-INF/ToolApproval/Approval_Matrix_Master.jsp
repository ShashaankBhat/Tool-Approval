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
    <title>APPROVAL MATRIX<%@include file="../includeJSP/company_name_title.jsp"%></title>
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
                <h5 class="font-3">APPROVAL MATRIX LIST</h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item font-1"><a href="dashboard" title="Dashboard">Dashboard</a></li>
                  <li class="breadcrumb-item font-1"><a href="ta-masters-dashboard" title="TA Masters Dashboard">TA Masters</a></li>
                  <li class="breadcrumb-item font-3 active">Approval Matrix</li>
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
		        <form modelAttribute="approvalMatrix" action="ta-approval-matrix" id="approvalMatrix" method="post">
		        <div class="card card-primary collapsed-card">
		          <div class="card-header bg-1" data-card-widget="collapse">
		            <h5 class="card-title font-weight-bold">Add Approval Matrix</h5>
		            <div class="card-tools">
		              <button type="button" class="btn btn-tool text-white font-weight-bold" data-card-widget="collapse">
		                <i class="fas fa-plus"></i>
		              </button>
		              <input type="hidden" value="${openAddModal }" id="openAddModel" />
		              <input type="hidden" value="${openEditModel }" id="openEditModel" />
		            </div>
		          </div>
		          <div class="card-body" style="display: none;">
		            <div class="row mt-3">
		              <div class="col-md-4">
		                <div class="form-group">
		                  <label class="font-1" for="mEntityId"><span class="mandatory">*</span>Entity</label>
		                  <select name="mEntity.mEntityId" required class="form-control" id="mEntityId">
		                  	<option value="">-- Select Entity --</option>
		                  	<c:forEach items="${entities}" var="en">
		                  		<option value="${en.mEntityId}">${en.locationId.locationName} - ${en.entityName} </option>
		                  	</c:forEach>
		                  </select>
		                  <span class="error invalid-feedback" id="mEntityIdError"></span>
		                </div>
		              </div>
		              <div class="col-md-4 d-flex align-items-center justify-content-between">
		                <div id="isActiveDiv">
		                  <label class="font-2">
		                    <span class="mandatory">*</span>
		                    Approval Matrix Active/InActive
		                  </label>

		                  <div class="custom-control custom-radio">
		                    <input type="radio"
		                           name="matrixActive"
		                           class="custom-control-input"
		                           value="1"
		                           id="matrixActive1" />
		                    <label for="matrixActive1"
		                           class="custom-control-label sequence-font-5">
		                      Active
		                    </label>
		                  </div>

		                  <div class="custom-control custom-radio">
		                    <input type="radio"
		                           name="matrixActive"
		                           class="custom-control-input"
		                           value="0"
		                           id="matrixActive2" />
		                    <label for="matrixActive2"
		                           class="custom-control-label sequence-font-1">
		                      Inactive
		                    </label>
		                  </div>
		                  <span class="invalid-feedback d-block" id="matrixActiveError"></span>
		                </div>

		                <button type="submit"
		                        id="submitTaApprovalMatrixButton"
		                        class="btn bg-1"
		                        title="Add Approval Matrix">
		                  Submit
		                </button>
		              </div>
		              <div class="row mt-3">
		                <div class="col-md-3">
		                  <div class="form-group">
		                    <label class="font-3" for="approverLevel1"><span class="mandatory">*</span>Approver Level 1</label>
		                  <select name="approverLevel1.mUserId" id="approverLevel1" class="form-control" required>
		                    <option value="">-- Select User --</option>
		                    <c:forEach items="${userList}" var="user">
		                      <option value="${user.mUserId}">${user.userFirstName} ${user.userLastName}</option>
		                    </c:forEach>
		                  </select>
		                  <span class="invalid-feedback"></span>

		                  <span class="error invalid-feedback" id="approverLevel1Error"></span>
		                </div>
		              </div>
		              <div class="col-md-3">
		                <div class="form-group">
		                  <label class="font-3" for="approverLevel2"><span class="mandatory">*</span>Approver Level 2</label>
		                  <select name="approverLevel2.mUserId" id="approverLevel2" class="form-control" required>
		                    <option value="">-- Select User --</option>
		                    <c:forEach items="${userList}" var="user">
		                      <option value="${user.mUserId}">${user.userFirstName} ${user.userLastName}</option>
		                    </c:forEach>
		                  </select>
		                  <span class="invalid-feedback"></span>

		                  <span class="error invalid-feedback" id="approverLevel2Error"></span>
		                </div>
		              </div>
		              <div class="col-md-3">
		                <div class="form-group">
		                  <label class="font-3" for="approverLevel3"><span class="mandatory">*</span>Approver Level 3</label>
		                  <select name="approverLevel3.mUserId" id="approverLevel3" class="form-control" required>
		                    <option value="">-- Select User --</option>
		                    <c:forEach items="${userList}" var="user">
		                      <option value="${user.mUserId}">${user.userFirstName} ${user.userLastName}</option>
		                    </c:forEach>
		                  </select>
		                  <span class="invalid-feedback"></span>

		                  <span class="error invalid-feedback" id="approverLevel3Error"></span>
		                </div>
		              </div>
		              <div class="col-md-3">
		                <div class="form-group">
		                  <label class="font-3" for="approverLevel4"><span class="mandatory">*</span>Approver Level 4</label>
		                  <select name="approverLevel4.mUserId" id="approverLevel4" class="form-control" required>
		                    <option value="">-- Select User --</option>
		                    <c:forEach items="${userList}" var="user">
		                      <option value="${user.mUserId}">${user.userFirstName} ${user.userLastName}</option>
		                    </c:forEach>
		                  </select>
		                  <span class="invalid-feedback"></span>

		                  <span class="error invalid-feedback" id="approverLevel4Error"></span>
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
		            <h5 class="card-title font-weight-bold">List of Approval Matrices</h5>
		          </div>
		          <div class="card-body">
		            <div class="row">
		              <div class="col-md-12 tableOverFlowDiv">
		                <table class="table table-bordered table-striped dataTable" id="approvalMatrixTable">
		                  <thead>
		                    <tr class="bg-table-head">
		                      <th>Action</th>
		                      <th>Entity</th>
		                      <th>Approver Level 1</th>
		                      <th>Approver Level 2</th>
		                      <th>Approver Level 3</th>
		                      <th>Approver Level 4</th>
		                      <th>Active/In-Active</th>
		                      <th>Created By</th>
		                      <th>Created On</th>
		                      <th>Updated By</th>
		                      <th>Updated On</th>
		                    </tr>
		                  </thead>
		                  <tbody>
		                    <c:forEach items="${approvalMatrixList }" var="taApprovalMatrix" varStatus="taApprovalMatrixLoop">
		                      <tr class="bg-table-row-${taApprovalMatrixLoop.index %2 }">
		                        <td>${taApprovalMatrix.actionForList }</td>
								<td>${taApprovalMatrix.mEntity.entityName }</td>
		                        <td>
		                          <c:if test="${taApprovalMatrix.approverLevel1 != null}">
  ${taApprovalMatrix.approverLevel1.userFirstName}
  ${taApprovalMatrix.approverLevel1.userLastName}
</c:if>

		                        </td>
		                        <td>
		                          <c:if test="${taApprovalMatrix.approverLevel2 != null}">
  									${taApprovalMatrix.approverLevel2.userFirstName}
  									${taApprovalMatrix.approverLevel2.userLastName}
									</c:if>

		                        </td>
		                        <td>
		                          <c:if test="${taApprovalMatrix.approverLevel3 != null}">
		                              ${taApprovalMatrix.approverLevel3.userFirstName}
  										${taApprovalMatrix.approverLevel3.userLastName}
		                          </c:if>
		                        </td>
		                        <td>
		                          <c:if test="${taApprovalMatrix.approverLevel4 != null}">
		                              ${taApprovalMatrix.approverLevel4.userFirstName}
  										${taApprovalMatrix.approverLevel4.userLastName}
		                          </c:if>
		                        </td>
		                        <td>
		                          <c:choose>
		                            <c:when test="${taApprovalMatrix.matrixActive eq 1 }"><span class="badge sequence-bg-5">Active</span></c:when>
		                            <c:otherwise><span class="badge sequence-bg-1">In-Active</span></c:otherwise>
		                          </c:choose>
		                        </td>
		                        <td>${taApprovalMatrix.createdBy.userFirstName } ${taApprovalMatrix.createdBy.userLastName }</td>
		                        <td><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${taApprovalMatrix.createdOn }" /></td>
		                        <td>${taApprovalMatrix.updatedBy.userFirstName } ${taApprovalMatrix.updatedBy.userLastName }</td>
		                        <td><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${taApprovalMatrix.updatedOn }" /></td>
		                      </tr>
		                    </c:forEach>
		                  </tbody>
		                  <tfoot>
		                    <tr class="bg-table-foot">
		                      <th>Action</th>
		                      <th>Entity</th>
		                      <th>Approver Level 1</th>
		                      <th>Approver Level 2</th>
		                      <th>Approver Level 3</th>
		                      <th>Approver Level 4</th>
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
		
		<div class="modal fade" id="editTaApprovalMatrixModal">
		  <div class="modal-dialog modal-lg">
		    <div class="modal-content">
		      <form modelAttribute="approvalMatrix" action="ta-approval-matrix" id="approvalMatrixEdit" method="post">
		      <input type="hidden" name="taApprovalMatrixId" id="mApprovalMatrixId" />
		      <div class="modal-header bg-3">
		        <h4 class="modal-title font-weight-bold">Edit Approval Matrix</h4>
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
		              <div class="row mt-3">
		                <div class="col-md-6">
		                  <div class="form-group">
		                    <label class="font-1" for="mEntityIdEdit"><span class="mandatory">*</span>Entity</label>
		                    <select name="mEntity.mEntityId" required class="form-control" id="mEntityIdEdit">
		                    	<option value="">-- Select Entity --</option>
		                    	<c:forEach items="${entities}" var="en">
		                    		<option value="${en.mEntityId}">${en.entityName}</option>
		                    	</c:forEach>
		                    </select>
		                    <span class="error invalid-feedback" id="mEntityIdErrorEdit"></span>
		                  </div>
		                </div>
		                <div class="col-md-6">
		                  <div class="form-check" id="isActiveEditDiv">
		                    <label class="font-2"><span class="mandatory">*</span>Approval Matrix Active/InActive</label>
		                    <div class="custom-control custom-radio">
		                      <input type="radio" name="matrixActive"
						       class="custom-control-input"
						       value="1"
						       id="matrixActiveEdit1" />
								<label for="matrixActiveEdit1"
						       class="custom-control-label sequence-font-5">Active</label>

		                    </div>
		                    <div class="custom-control custom-radio">
		                      <input type="radio" name="matrixActive"
						       class="custom-control-input"
						       value="0"
						       id="matrixActiveEdit2" />
								<label for="matrixActiveEdit2"
						       class="custom-control-label sequence-font-1">Inactive</label>

		                    </div>
		                    <span class="error invalid-feedback" id="isActiveEditError" style="display:block" ></span> 
		                    <span class="invalid-feedback d-block" id="matrixActiveEditError"></span>
		                  </div>
		                </div>
		              </div>
		              <div class="row mt-3">
		                <div class="col-md-3">
		                  <div class="form-group">
		                    <label class="font-1" for="approverLevel1Edit"><span class="mandatory">*</span>Approver Level 1</label>
		                    <select name="approverLevel1.mUserId" id="approverLevel1Edit" class="form-control" required>
		                      <option value="">-- Select User --</option>
		                      <c:forEach items="${userList}" var="user">
		                        <option value="${user.mUserId}">${user.userFirstName} ${user.userLastName}</option>
		                      </c:forEach>
		                    </select>
		                    <span class="invalid-feedback"></span>

		                    <span class="error invalid-feedback" id="approverLevel1ErrorEdit"></span>
		                  </div>
		                </div>
		                <div class="col-md-3">
		                  <div class="form-group">
		                    <label class="font-1" for="approverLevel2Edit"><span class="mandatory">*</span>Approver Level 2</label>
		                    <select name="approverLevel2.mUserId" id="approverLevel2Edit" class="form-control" required>
		                      <option value="">-- Select User --</option>
		                      <c:forEach items="${userList}" var="user">
		                        <option value="${user.mUserId}">${user.userFirstName} ${user.userLastName}</option>
		                      </c:forEach>
		                    </select>
		                    <span class="invalid-feedback"></span>

		                    <span class="error invalid-feedback" id="approverLevel2ErrorEdit"></span>
		                  </div>
		                </div>
		                <div class="col-md-3">
		                  <div class="form-group">
		                    <label class="font-1" for="approverLevel3Edit"><span class="mandatory">*</span>Approver Level 3</label>
		                   <select name="approverLevel3.mUserId" id="approverLevel3Edit" class="form-control" required>
		                     <option value="">-- Select User --</option>
		                     <c:forEach items="${userList}" var="user">
		                       <option value="${user.mUserId}">${user.userFirstName} ${user.userLastName}</option>
		                     </c:forEach>
		                   </select>
		                   <span class="invalid-feedback"></span>

		                    <span class="error invalid-feedback" id="approverLevel3ErrorEdit"></span>
		                  </div>
		                </div>
		                <div class="col-md-3">
		                  <div class="form-group">
		                    <label class="font-1" for="approverLevel4Edit"><span class="mandatory">*</span>Approver Level 4</label>
		                    <select name="approverLevel4.mUserId" id="approverLevel4Edit" class="form-control" required>
		                      <option value="">-- Select User --</option>
		                      <c:forEach items="${userList}" var="user">
		                        <option value="${user.mUserId}">${user.userFirstName} ${user.userLastName}</option>
		                      </c:forEach>
		                    </select>
		                    <span class="invalid-feedback"></span>

		                    <span class="error invalid-feedback" id="approverLevel4ErrorEdit"></span>
		                  </div>
		                </div>
		              </div>
		            </div>
		          </div>
		        </div>
		      </div>
		      <div class="modal-footer justify-content-between">
		        <button title="Close" id="closeEditTaApprovalMatrixModal" type="button" class="btn sequence-bg-1" data-dismiss="modal">Close</button>
		        <button type="submit" id="saveTaApprovalMatrixChanges" class="btn bg-1" title="Edit Approval Matrix Details">Edit Approval Matrix Details</button>
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
    <script src="usedStaticFiles/essentials/js/jsp_js_files/toolApproval/approvalMatrixMaster.js"></script>
  </body>
</html>

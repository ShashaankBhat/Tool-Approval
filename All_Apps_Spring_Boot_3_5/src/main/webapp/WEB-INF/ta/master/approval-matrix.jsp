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
    <title>APPROVAL MATRIX | TOOL APPROVAL<%@include file="../../includeJSP/company_name_title.jsp"%></title>
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
                <h5 class="font-3">APPROVAL MATRIX LIST</h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item"><a href="dashboard" title="Dashboard"><strong>Dashboard</strong></a></li>
                  <li class="breadcrumb-item"><a href="dashboard-tool-approval" title="TA Dashboard"><strong>TA Dashboard</strong></a></li>
                  <li class="breadcrumb-item"><a href="ta-masters-dashboard" title="TA Masters"><strong>TA Masters</strong></a></li>
                  <li class="breadcrumb-item active"><strong>Approval Matrix</strong></li>
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
		            <div class="row">
		              <div class="col-5">
		                <div class="form-group">
		                  <label class="font-1" for="tempBusinessUnit"><span class="mandatory">*</span>Business Unit</label>
		                  <input type="hidden" value="${approvalMatrix.tempBusinessUnit }" id="uiTempBusinessUnitId" />
		                  <select name="tempBusinessUnit" class="form-control select2" id="tempBusinessUnit">
		                  	<option value="-1">- Select Business Unit -</option>
		                  	<c:forEach items="${businessUnitList}" var="businessUnit" varStatus="businessUnitLoop">
		                  	  <option value="${businessUnit.taBusinessUnitId}">${businessUnit.taBusinessUnitName}</option>
		                  	</c:forEach>
		                  </select>
		                  <span class="error invalid-feedback" id="tempBusinessUnitError"></span>
		                </div>
		              </div>
		              <div class="col-5">
		                <div class="form-check" id="isActiveDiv">
		                  <label class="font-2"><span class="mandatory">*</span>Approval Matrix Active/InActive</label>
		                  <div class="custom-control custom-radio">
		                    <input type="radio" name="matrixActive" class="custom-control-input" value="1" id="matrixActive1" name="matrixActive" />
		                    <label for="matrixActive1" class="custom-control-label sequence-font-5">Active</label>
		                  </div>
		                  <div class="custom-control custom-radio">
		                    <input type="radio" name="matrixActive" class="custom-control-input" value="0" id="matrixActive2" name="matrixActive" />
		                    <label for="matrixActive2" class="custom-control-label sequence-font-1">Inactive</label>
		                  </div>
		                  <input type="hidden" id="activenessTemp" value="${approvalMatrix.matrixActive }" />
		                  <span class="error invalid-feedback" id="isActiveError" style="display:block" ></span> 
		                </div>
		              </div>
		              <div class="col-2">
		                <div class="form-check">
		                  <br>
		                  <button style="float: right;" title="Add Approval Matrix" type="submit" id="submitTaBusinessUnitButton" class="btn bg-1">Submit</button>
		                </div>
		              </div>
		              <div class="col-6">
		                <div class="form-group">
		                  <label class="font-3" for="tempLevelOneId"><span class="mandatory">*</span>Level 1</label>
		                  <input type="hidden" value="${approvalMatrix.tempLevelOneId }" id="uiTempLevelOneId" />
		                  <select name="tempLevelOneId" id="tempLevelOneId" class="form-control select2">
		                    <option value="-1">- Select User -</option>
		                    <c:forEach items="${userList}" var="user">
		                      <option value="${user.mUserId}">${user.userFirstName} ${user.userLastName} - ${user.userLoginId}</option>
		                    </c:forEach>
		                  </select>
		                  <span class="error invalid-feedback" id="tempLevelOneIdError"></span>
		                  <input type="text" value="${approvalMatrix.levelOnePosition }" class="form-control" id="levelOnePosition" placeholder="Enter Level One Position" name="levelOnePosition" />
		                  <span class="error invalid-feedback" id="levelOnePositionError"></span>
		                </div>
		              </div>
		              <div class="col-6">
		                <div class="form-group">
		                  <label class="font-3" for="tempLevelTwoId"><span class="mandatory">*</span>Level 2</label>
		                  <input type="hidden" value="${approvalMatrix.tempLevelTwoId }" id="uiTempLevelTwoId" />
		                  <select name="tempLevelTwoId" id="tempLevelTwoId" class="form-control select2">
		                    <option value="-1">- Select User -</option>
		                    <c:forEach items="${userList}" var="user">
		                      <option value="${user.mUserId}">${user.userFirstName} ${user.userLastName} - ${user.userLoginId}</option>
		                    </c:forEach>
		                  </select>
		                  <span class="error invalid-feedback" id="tempLevelTwoIdError"></span>
		                  <input type="text" value="${approvalMatrix.levelTwoPosition }" class="form-control" id="levelTwoPosition" placeholder="Enter Level One Position" name="levelTwoPosition" />
		                  <span class="error invalid-feedback" id="levelTwoPositionError"></span>
		                </div>
		              </div>
		              <div class="col-6">
		                <div class="form-group">
		                  <label class="font-3" for="tempLevelThreeId"><span class="mandatory">*</span>Level 3</label>
		                  <input type="hidden" value="${approvalMatrix.tempLevelThreeId }" id="uiTempLevelThreeId" />
		                  <select name="tempLevelThreeId" id="tempLevelThreeId" class="form-control select2">
		                    <option value="-1">- Select User -</option>
		                    <c:forEach items="${userList}" var="user">
		                      <option value="${user.mUserId}">${user.userFirstName} ${user.userLastName} - ${user.userLoginId}</option>
		                    </c:forEach>
		                  </select>
		                  <span class="error invalid-feedback" id="tempLevelThreeIdError"></span>
		                  <input type="text" value="${approvalMatrix.levelThreePosition }" class="form-control" id="levelThreePosition" placeholder="Enter Level One Position" name="levelThreePosition" />
		                  <span class="error invalid-feedback" id="levelThreePositionError"></span>
		                </div>
		              </div>
		              <div class="col-6">
		                <div class="form-group">
		                  <label class="font-3" for="tempLevelFourId"><span class="mandatory">*</span>Level 4</label>
		                  <input type="hidden" value="${approvalMatrix.tempLevelFourId }" id="uiTempLevelFourId" />
		                  <select name="tempLevelFourId" id="tempLevelFourId" class="form-control select2">
		                    <option value="-1">- Select User -</option>
		                    <c:forEach items="${userList}" var="user">
		                      <option value="${user.mUserId}">${user.userFirstName} ${user.userLastName} - ${user.userLoginId}</option>
		                    </c:forEach>
		                  </select>
		                  <span class="error invalid-feedback" id="tempLevelFourIdError"></span>
		                  <input type="text" value="${approvalMatrix.levelFourPosition }" class="form-control" id="levelFourPosition" placeholder="Enter Level One Position" name="levelFourPosition" />
		                  <span class="error invalid-feedback" id="levelFourPositionError"></span>
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
		                <table class="table table-bordered table-striped dataTable nowrap" id="approvalMatrixTable" style="width:100%">
		                  <thead>
		                    <tr class="bg-table-head">
		                      <th>Action</th>
		                      <th>Business Unit</th>
		                      <th>Level 1</th>
		                      <th>Level 2</th>
		                      <th>Level 3</th>
		                      <th>Level 4</th>
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
								<td>${taApprovalMatrix.taBusinessUnitId.taBusinessUnitName }</td>
		                        <td>
		                          ${taApprovalMatrix.levelOne.userFirstName} ${taApprovalMatrix.levelOne.userLastName}
		                          <br>${taApprovalMatrix.levelOnePosition }
		                        </td>
		                        <td>
		                          ${taApprovalMatrix.levelTwo.userFirstName} ${taApprovalMatrix.levelTwo.userLastName}
		                          <br>${taApprovalMatrix.levelTwoPosition }
		                        </td>
		                        <td>
		                          ${taApprovalMatrix.levelThree.userFirstName} ${taApprovalMatrix.levelThree.userLastName}
		                          <br>${taApprovalMatrix.levelThreePosition }
		                        </td>
		                        <td>
		                          ${taApprovalMatrix.levelFour.userFirstName} ${taApprovalMatrix.levelFour.userLastName}
		                          <br>${taApprovalMatrix.levelFourPosition }
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
		                      <th>Business Unit</th>
		                      <th>Level 1</th>
		                      <th>Level 2</th>
		                      <th>Level 3</th>
		                      <th>Level 4</th>
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
		  <div class="modal-dialog modal-xl">
		    <div class="modal-content">
		      <form modelAttribute="approvalMatrix" action="ta-approval-matrix" id="approvalMatrixEdit" method="post">
		      <input type="hidden" name="taApprovalMatrixId" id="taApprovalMatrixId" value="${approvalMatrix.taApprovalMatrixId }" />
		      <div class="modal-header bg-3">
		        <h4 class="modal-title font-weight-bold">Edit Approval Matrix</h4>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	              <span aria-hidden="true"><i class="text-white font-weight-bold fas fa-times"></i></span>
	            </button>
		      </div>
		      <div class="modal-body">
		        <div class="row">
		          <c:if test="${not empty regMsgEdit }">
		            <div class="col-12">
		              <div class="alert ${cssEdit } alert-dismissible">
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
		          <div class="col-12">
		            <div class="card-body">
		              <div class="row">
		                <div class="col-6">
		                  <div class="form-group">
		                    <label class="font-1" for="tempBusinessUnitEdit"><span class="mandatory">*</span>Business Unit</label>
		                    <select name="tempBusinessUnit" class="form-control select2" id="tempBusinessUnitEdit">
		                      <option value="-1">- Select Business Unit -</option>
		                      <c:forEach items="${businessUnitList}" var="businessUnit" varStatus="businessUnitLoop">
		                        <option value="${businessUnit.taBusinessUnitId}">${businessUnit.taBusinessUnitName}</option>
		                      </c:forEach>
		                    </select>
		                    <span class="error invalid-feedback" id="tempBusinessUnitErrorEdit"></span>
		                  </div>
		                </div>
		                <div class="col-6">
		                  <div class="form-check" id="isActiveEditDiv">
		                    <label class="font-2"><span class="mandatory">*</span>Approval Matrix Active/InActive</label>
		                    <div class="custom-control custom-radio">
		                      <input type="radio" name="matrixActive" class="custom-control-input" value="1" id="matrixActiveEdit1" />
		                      <label for="matrixActiveEdit1" class="custom-control-label sequence-font-5">Active</label>
		                    </div>
		                    <div class="custom-control custom-radio">
		                      <input type="radio" name="matrixActive" class="custom-control-input" value="0" id="matrixActiveEdit2" />
		                      <label for="matrixActiveEdit2" class="custom-control-label sequence-font-1">Inactive</label>
		                    </div>
		                    <span class="error invalid-feedback" id="isActiveEditError" style="display:block" ></span> 
		                  </div>
		                </div>
		                <div class="col-6">
		                  <div class="form-group">
		                    <label class="font-3" for="tempLevelOneIdEdit"><span class="mandatory">*</span>Level 1</label>
		                    <select name="tempLevelOneId" id="tempLevelOneIdEdit" class="form-control select2">
		                      <option value="-1">- Select User -</option>
		                      <c:forEach items="${userList}" var="user">
		                        <option value="${user.mUserId}">${user.userFirstName} ${user.userLastName} - ${user.userLoginId}</option>
		                      </c:forEach>
		                    </select>
		                    <span class="error invalid-feedback" id="tempLevelOneIdErrorEdit"></span>
		                    <input type="text" value="${approvalMatrix.levelOnePosition }" class="form-control" id="levelOnePositionEdit" placeholder="Enter Level One Position" name="levelOnePosition" />
		                    <span class="error invalid-feedback" id="levelOnePositionErrorEdit"></span>
		                  </div>
		                </div>
		                <div class="col-6">
		                  <div class="form-group">
		                    <label class="font-3" for="templevelTwoIdEdit"><span class="mandatory">*</span>Level 2</label>
		                    <select name="tempLevelTwoId" id="tempLevelTwoIdEdit" class="form-control select2">
		                      <option value="-1">- Select User -</option>
		                      <c:forEach items="${userList}" var="user">
		                        <option value="${user.mUserId}">${user.userFirstName} ${user.userLastName} - ${user.userLoginId}</option>
		                      </c:forEach>
		                    </select>
		                    <span class="error invalid-feedback" id="tempLevelTwoIdErrorEdit"></span>
		                    <input type="text" value="${approvalMatrix.levelTwoPosition }" class="form-control" id="levelTwoPositionEdit" placeholder="Enter Level One Position" name="levelTwoPosition" />
		                    <span class="error invalid-feedback" id="levelTwoPositionErrorEdit"></span>
		                  </div>
		                </div>
		                <div class="col-6">
		                  <div class="form-group">
		                    <label class="font-3" for="tempLevelThreeIdEdit"><span class="mandatory">*</span>Level 3</label>
		                    <select name="tempLevelThreeId" id="tempLevelThreeIdEdit" class="form-control select2">
		                      <option value="-1">- Select User -</option>
		                      <c:forEach items="${userList}" var="user">
		                        <option value="${user.mUserId}">${user.userFirstName} ${user.userLastName} - ${user.userLoginId}</option>
		                      </c:forEach>
		                    </select>
		                    <span class="error invalid-feedback" id="tempLevelThreeIdErrorEdit"></span>
		                    <input type="text" value="${approvalMatrix.levelThreePosition }" class="form-control" id="levelThreePositionEdit" placeholder="Enter Level One Position" name="levelThreePosition" />
		                    <span class="error invalid-feedback" id="levelThreePositionErrorEdit"></span>
		                  </div>
		                </div>
		                <div class="col-6">
		                  <div class="form-group">
		                    <label class="font-3" for="tempLevelFourIdEdit"><span class="mandatory">*</span>Level 4</label>
		                    <select name="tempLevelFourId" id="tempLevelFourIdEdit" class="form-control select2">
		                      <option value="-1">- Select User -</option>
		                      <c:forEach items="${userList}" var="user">
		                        <option value="${user.mUserId}">${user.userFirstName} ${user.userLastName} - ${user.userLoginId}</option>
		                      </c:forEach>
		                    </select>
		                    <span class="error invalid-feedback" id="tempLevelFourIdErrorEdit"></span>
		                    <input type="text" value="${approvalMatrix.levelFourPosition }" class="form-control" id="levelFourPositionEdit" placeholder="Enter Level One Position" name="levelFourPosition" />
		                    <span class="error invalid-feedback" id="levelFourPositionErrorEdit"></span>
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
      <%@include file="../../includeJSP/footer.jsp"%>
    </div>
    <%@include file="../../includeJSP/jsFiles.jsp"%>
    <%@include file="../../includeJSP/dataTablesImport.jsp"%>
    <script src="usedStaticFiles/essentials/js/jsp_js_files/ta/master/approval-matrix.js"></script>
  </body>
</html>

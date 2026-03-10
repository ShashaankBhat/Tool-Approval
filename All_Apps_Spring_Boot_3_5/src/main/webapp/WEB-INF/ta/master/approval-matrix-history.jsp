<!DOCTYPE html>
<html lang="en">
  <head>
    <title>APPROVAL MATRIX HISTORY | TOOL APPROVAL<%@include file="../../includeJSP/company_name_title.jsp"%></title>
    <%@include file="../../includeJSP/cssFiles.jsp"%>
  </head>
  <body class="sidebar-mini layout-navbar-fixed sidebar-collapse pace-primary">
    <div class="wrapper">
      <%@include file="../../includeJSP/header.jsp"%>
      <%@include file="../includeJSP/leftSideBar.jsp"%>
      <div class="content-wrapper">
        <section class="content-header">
          <div class="container-fluid">
            <div class="row mb-2">
              <div class="col-sm-4">
                <h5 class="font-3">APPROVAL MATRIX HISTORY</h5>
              </div>
              <div class="col-sm-8">
                <ol class="breadcrumb float-sm-right font-weight-bold">
                  <li class="breadcrumb-item"><a href="dashboard-tool-approval" title="TA Dashboard">TA Dashboard</a></li>
                  <li class="breadcrumb-item"><a href="ta-masters-dashboard" title="TA Masters">TA Masters</a></li>
                  <li class="breadcrumb-item"><a href="ta-approval-matrix" title="Approval Matrix">Approval Matrix</a></li>
                  <li class="breadcrumb-item active">Approval Matrix History</li>
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
                <div class="card card-secondary">
                  <div class="card-header bg-3">
                    <h5 class="card-title font-weight-bold">Approval Matrix History</h5>
                  </div>
                  <div class="card-body">
                    <div class="row">
                      <div class="col-md-12 tableOverFlowDiv">
                        <table class="table table-bordered table-striped dataTable nowrap" id="approvalMatrixTable" style="width:100%">
		                  <thead>
		                    <tr class="bg-table-head">
		                      <th>Business Unit</th>
		                      <th>Level 1</th>
		                      <th>Level 2</th>
		                      <th>Level 3</th>
		                      <th>Level 4</th>
		                      <th>Active/In-Active</th>
		                      <th>Created By</th>
		                      <th>Created On</th>
		                    </tr>
		                  </thead>
		                  <tbody>
		                    <c:forEach items="${approvalMatrixList }" var="taApprovalMatrix" varStatus="taApprovalMatrixLoop">
		                      <tr class="bg-table-row-${taApprovalMatrixLoop.index %2 }">
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
		                      </tr>
		                    </c:forEach>
		                  </tbody>
		                  <tfoot>
		                    <tr class="bg-table-foot">
		                      <th>Business Unit</th>
		                      <th>Level 1</th>
		                      <th>Level 2</th>
		                      <th>Level 3</th>
		                      <th>Level 4</th>
		                      <th>Active/In-Active</th>
		                      <th>Created By</th>
		                      <th>Created On</th>
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
    <%@include file="../../includeJSP/jsFiles.jsp"%>
    <%@include file="../../includeJSP/dataTablesImport.jsp"%>
    <script src="usedStaticFiles/essentials/js/jsp_js_files/ta/master/approval-matrix-history.js"></script>
  </body>
</html>
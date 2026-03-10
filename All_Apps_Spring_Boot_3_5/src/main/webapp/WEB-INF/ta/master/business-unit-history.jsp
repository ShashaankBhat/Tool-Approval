<!DOCTYPE html>
<html lang="en">
  <head>
    <title>BUSINESS UNIT HISTORY | TOOL APPROVAL<%@include file="../../includeJSP/company_name_title.jsp"%></title>
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
                <h5 class="font-3">BUSINESS UNIT HISTORY</h5>
              </div>
              <div class="col-sm-8">
                <ol class="breadcrumb float-sm-right font-weight-bold">
                  <li class="breadcrumb-item"><a href="dashboard-tool-approval" title="TA Dashboard">TA Dashboard</a></li>
                  <li class="breadcrumb-item"><a href="ta-masters-dashboard" title="TA Masters">TA Masters</a></li>
                  <li class="breadcrumb-item"><a href="ta-business-unit" title="Business Unit">Business Unit</a></li>
                  <li class="breadcrumb-item active">Business Unit History</li>
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
                    <h5 class="card-title font-weight-bold">Business Unit History</h5>
                  </div>
                  <div class="card-body">
                    <div class="row">
                      <div class="col-md-12 tableOverFlowDiv">
                        <table class="table table-bordered table-striped dataTable nowrap" id="taBusinessUnitHistoryTable" style="width:100%">
                          <thead>
                            <tr class="bg-table-head">
                              <th>Changed By</th>
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
                            <c:forEach items="${historyList}" var="hist" varStatus="loop">
                              <tr class="bg-table-row-${loop.index % 2}">
                                <td>
                                  <c:choose>
                                    <c:when test="${not empty hist.updatedBy}">
                                      ${hist.updatedBy.userFirstName} ${hist.updatedBy.userLastName}
                                    </c:when>
                                    <c:otherwise>
                                      ${hist.createdBy.userFirstName} ${hist.createdBy.userLastName}
                                    </c:otherwise>
                                  </c:choose>
                                </td>
                                <td>${hist.businessUnitName}</td>
                                <td>${hist.businessUnitDescription}</td>
                                <td>
                                  <c:choose>
                                    <c:when test="${hist.businessUnitActive eq 1}">
                                      <span class="badge sequence-bg-5">Active</span>
                                    </c:when>
                                    <c:otherwise>
                                      <span class="badge sequence-bg-1">In-Active</span>
                                    </c:otherwise>
                                  </c:choose>
                                </td>
                                <td>${hist.createdBy.userFirstName} ${hist.createdBy.userLastName}</td>
                                <td><fmt:formatDate pattern="dd-MMM-yyyy" value="${hist.createdOn}" /></td>
                                <td>${hist.updatedBy.userFirstName} ${hist.updatedBy.userLastName}</td>
                                <td><fmt:formatDate pattern="dd-MMM-yyyy" value="${hist.updatedOn}" /></td>
                              </tr>
                            </c:forEach>
                          </tbody>
                          <tfoot>
                            <tr class="bg-table-foot">
                              <th>Changed By</th>
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
    <%@include file="../../includeJSP/jsFiles.jsp"%>
    <%@include file="../../includeJSP/dataTablesImport.jsp"%>
    <script src="usedStaticFiles/essentials/js/jsp_js_files/ta/master/business-unit-history.js"></script>
  </body>
</html>
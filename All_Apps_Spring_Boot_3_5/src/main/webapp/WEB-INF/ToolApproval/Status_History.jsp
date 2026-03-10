<!DOCTYPE html>
<html lang="en">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
  <head>
    <title>STATUS HISTORY<%@include file="../includeJSP/company_name_title.jsp"%></title>
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
                <h5 class="font-3">STATUS HISTORY</h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item font-1"><a href="dashboard" title="Dashboard">Dashboard</a></li>
                  <li class="breadcrumb-item font-1"><a href="ta-masters-dashboard" title="TA Masters Dashboard">TA Masters</a></li>
                  <li class="breadcrumb-item font-1"><a href="ta-status" title="Status">Status</a></li>
                  <li class="breadcrumb-item font-3 active">History</li>
                </ol>
              </div>
            </div>
          </div>
        </section>

        <section class="content content-margin">
          <div class="container-fluid">

            <div class="row">
              <div class="col-md-12">
                <div class="card card-secondary">
                  <div class="card-header bg-3">
                    <h5 class="card-title font-weight-bold">Status History</h5>
                  </div>
                  <div class="card-body">
                    <div class="row">
                      <div class="col-md-12 tableOverFlowDiv">
                        <table class="table table-bordered table-striped dataTable" id="taStatusHistoryTable">
                          <thead>
                            <tr class="bg-table-head">
                              <th>Changed By</th>
                              <th>Status Name</th>
                              <th>Description</th>
                              <th>Active/In-Active</th>
                              <th>Created By</th>
                              <th>Created On</th>
                              <th>Updated By</th>
                              <th>Updated On</th>
                            </tr>
                          </thead>
                          <tbody>
                            <c:forEach items="${statusHistoryList}" var="hist" varStatus="histLoop">
                              <tr class="bg-table-row-${histLoop.index %2 }">
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
                                <td>${hist.taStatusName }</td>
                                <td>${hist.taStatusDescription }</td>
                                <td>
                                  <c:choose>
                                    <c:when test="${hist.taStatusActive eq 1 }"><span class="badge sequence-bg-5">Active</span></c:when>
                                    <c:otherwise><span class="badge sequence-bg-1">In-Active</span></c:otherwise>
                                  </c:choose>
                                </td>
                                <td>${hist.createdBy.userFirstName } ${hist.createdBy.userLastName }</td>
                                <td><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${hist.createdOn }" /></td>
                                <td>${hist.updatedBy.userFirstName } ${hist.updatedBy.userLastName }</td>
                                <td><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${hist.updatedOn }" /></td>
                              </tr>
                            </c:forEach>
                          </tbody>
                          <tfoot>
                            <tr class="bg-table-foot">
                              <th>Changed By</th>
                              <th>Status Name</th>
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
    <script src="usedStaticFiles/essentials/js/jsp_js_files/toolApproval/taStatusHistory.js"></script>
  </body>
</html>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>
        VIEW TOOL REQUESTS
        <%@include file="../includeJSP/company_name_title.jsp"%>
    </title>
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
                        <h5 class="font-3 font-weight-bold">
                            View Tool Approval Requests
                        </h5>
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
                                <h5 class="card-title font-weight-bold">
                                    List of Tool Approval Requests
                                </h5>
                            </div>

                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-12 tableOverFlowDiv">

                                        <table class="table table-bordered table-striped dataTable"
                                               id="toolApprovalTable">

                                            <thead>
                                            <tr class="bg-table-head">
                                                <th>Action</th>
                                                <th>Plant</th>
                                                <th>Customer</th>
                                                <th>Project</th>
                                                <th>Status</th>
                                                <th>Initiator</th>
                                                <th>Pending With</th>
                                                <th>Request No</th>
                                                <th>Created On</th>
                                            </tr>
                                            </thead>

                                            <tbody>

                                            <c:forEach items="${toolRequestList}"
                                                       var="tr"
                                                       varStatus="loop">

                                                <tr class="bg-table-row-${loop.index % 2}">

                                                    <!-- ACTION -->
                                                    <td>

                                                        <c:url var="viewUrl"
                                                               value="view-tool-approval-details">
                                                            <c:param name="reqId"
                                                                     value="${tr.taToolRequestId}"/>
                                                        </c:url>

                                                        <a href="${viewUrl}">
                                                            <i class="fas fa-eye"></i>
                                                        </a>

                                                        <c:if test="${tr.status.taStatusName=='Draft'
                                                                     || tr.status.taStatusName=='Tool Details Entered'
                                                                     || tr.status.taStatusName=='Cost Entered'}">

                                                            <c:url var="editUrl"
                                                                   value="edit-tool-approval-request">
                                                                <c:param name="reqId"
                                                                         value="${tr.taToolRequestId}"/>
                                                            </c:url>

                                                            &nbsp;
                                                            <a href="${editUrl}">
                                                                <i class="fas fa-edit"></i>
                                                            </a>

                                                        </c:if>

                                                    </td>

                                                    <!-- PLANT -->
                                                    <td>${tr.entity.entityName}</td>

                                                    <!-- CUSTOMER -->
                                                    <td>${tr.customerName}</td>

                                                    <!-- PROJECT -->
                                                    <td>${tr.projectName}</td>

                                                    <!-- STATUS -->
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${tr.status.taStatusName=='Approved'}">
                                                                <span class="badge sequence-bg-5">Approved</span>
                                                            </c:when>
                                                            <c:when test="${tr.status.taStatusName=='Rejected'}">
                                                                <span class="badge sequence-bg-1">Rejected</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge sequence-bg-3">
                                                                    ${tr.status.taStatusName}
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>

                                                    <!-- INITIATOR -->
                                                    <td>
                                                        ${tr.initiatedBy.userFirstName}
                                                        ${tr.initiatedBy.userLastName}
                                                    </td>

                                                    <!-- PENDING WITH -->
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${tr.currentApproverUser != null}">
                                                                ${tr.currentApproverUser.userFirstName}
                                                            </c:when>
                                                            <c:otherwise>N/A</c:otherwise>
                                                        </c:choose>
                                                    </td>

                                                    <!-- REQUEST NO -->
                                                    <td>${tr.requestNumber}</td>

                                                    <!-- CREATED ON -->
                                                    <td>
                                                        <fmt:formatDate value="${tr.createdOn}"
                                                                        pattern="dd-MMM-yyyy"/>
                                                    </td>

                                                </tr>

                                            </c:forEach>

                                            </tbody>

                                            <tfoot>
                                            <tr class="bg-table-foot">
                                                <th>Action</th>
                                                <th>Plant</th>
                                                <th>Customer</th>
                                                <th>Project</th>
                                                <th>Status</th>
                                                <th>Initiator</th>
                                                <th>Pending With</th>
                                                <th>Request No</th>
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

<%@include file="../includeJSP/jsFiles.jsp"%>
<%@include file="../includeJSP/dataTablesImport.jsp"%>

<script src="usedStaticFiles/essentials/js/jsp_js_files/toolApproval/toolApprovalList.js"></script>

</body>
</html>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>VIEW TOOL REQUEST DETAILS<%@include file="../includeJSP/company_name_title.jsp"%></title>
    <%@include file="../includeJSP/cssFiles.jsp"%>
</head>

<body class="sidebar-mini layout-navbar-fixed sidebar-collapse">
<div class="wrapper">

    <%@include file="includeJSP/header.jsp"%>
    <%@include file="includeJSP/leftSideBar.jsp"%>

    <div class="content-wrapper">

        <!-- HEADER -->
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h5 class="font-3 font-weight-bold">Tool Request Details</h5>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item">
                                <a href="view-tool-approval-request-list">View Requests</a>
                            </li>
                            <li class="breadcrumb-item active">Details</li>
                        </ol>
                    </div>
                </div>
            </div>
        </section>

        <!-- MAIN -->
        <section class="content content-margin">
            <div class="container-fluid">

                <!-- SUMMARY CARD -->
                <div class="card">
                    <div class="card-body">

                        <div class="row">
                            <div class="col-md-3">
                                <b>Request #:</b> ${toolRequest.requestNumber}
                            </div>

                            <div class="col-md-3">
                                <b>Status:</b>
                                <span class="badge badge-info">
                                    ${toolRequest.status.taStatusName}
                                </span>
                            </div>

                            <div class="col-md-3">
                                <b>Initiator:</b>
                                <c:if test="${not empty toolRequest.initiatedBy}">
                                    ${toolRequest.initiatedBy.userFirstName}
                                    ${toolRequest.initiatedBy.userLastName}
                                </c:if>
                            </div>

                            <div class="col-md-3">
                                <b>Initiated On:</b>
                                <fmt:formatDate value="${toolRequest.initiatedOn}" pattern="dd-MMM-yyyy"/>
                            </div>
                        </div>

                    </div>
                </div>

                <!-- PROJECT DETAILS -->
                <div class="card mt-3">
                    <div class="card-header bg-2 text-white">
                        Project & Location Details
                    </div>

                    <div class="card-body">

                        <div class="row mb-2">
                            <div class="col-md-3">
                                <b>Plant:</b>
                                ${toolRequest.entity.entityName}
                            </div>

                            <div class="col-md-3">
                                <b>Customer:</b>
                                ${toolRequest.customerName}
                            </div>

                            <div class="col-md-3">
                                <b>Project:</b>
                                ${toolRequest.projectName}
                            </div>

                            <div class="col-md-3">
                                <b>SOP:</b>
                                <fmt:formatDate value="${toolRequest.sopDate}" pattern="dd-MMM-yyyy"/>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-3">
                                <b>Peak Annual Volume:</b>
                                ${toolRequest.peakAnnualVolume}
                            </div>

                            <div class="col-md-3">
                                <b>Business Unit:</b>
                                ${toolRequest.businessUnit.taBusinessUnitName}
                            </div>

                            <div class="col-md-3">
                                <b>Commodity Manager:</b>
                                <c:if test="${not empty toolRequest.commodityManager}">
                                    ${toolRequest.commodityManager.userFirstName}
                                    ${toolRequest.commodityManager.userLastName}
                                </c:if>
                            </div>

                            <div class="col-md-3"></div>
                        </div>

                    </div>
                </div>

                <!-- COST DETAILS -->
                <div class="card mt-3">
                    <div class="card-header bg-2 text-white">
                        Cost Details
                    </div>

                    <div class="card-body table-responsive p-0">

                        <c:choose>
                            <c:when test="${not empty costDetails}">
                                <table class="table table-bordered mb-0">
                                    <thead class="bg-light">
                                        <tr>
                                            <th>Part No</th>
                                            <th>Description</th>
                                            <th>Currency</th>
                                            <th>Quoted</th>
                                            <th>Negotiated</th>
                                            <th>Upfront</th>
                                            <th>Amortization</th>
                                            <th>Supplier</th>
                                            <th>Lead Time</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <c:forEach var="cost" items="${costDetails}">
                                            <tr>
                                                <td>${cost.toolPartNumber}</td>
                                                <td>${cost.partDescription}</td>
                                                <td>${cost.currency}</td>
                                                <td>${cost.quotedCost}</td>
                                                <td>${cost.negotiatedCost}</td>
                                                <td>${cost.upfrontCost}</td>
                                                <td>${cost.amortizationCost}</td>
                                                <td>${cost.supplierName}</td>
                                                <td>${cost.developmentLeadTime}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>

                            <c:otherwise>
                                <div class="p-3 text-muted">
                                    No cost details available.
                                </div>
                            </c:otherwise>
                        </c:choose>

                    </div>
                </div>

                <!-- ATTACHMENTS -->
                <div class="card mt-3">
                    <div class="card-header bg-2 text-white">
                        Attachments
                    </div>

                    <div class="card-body">

                        <c:choose>
                            <c:when test="${not empty attachments}">
                                <ul class="list-group">
                                    <c:forEach var="att" items="${attachments}">
                                        <li class="list-group-item d-flex justify-content-between align-items-center">
                                            <a href="ta-attachment-download?attachmentId=${att.taAttachmentId}">
                                                ${att.fileName}
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </c:when>

                            <c:otherwise>
                                <div class="text-muted">
                                    No attachments available.
                                </div>
                            </c:otherwise>
                        </c:choose>

                    </div>
                </div>

                <!-- ACTION BUTTONS -->
                <div class="mt-3 text-right">

                    <c:if test="${toolRequest.status.taStatusName == 'Draft'
                                 || toolRequest.status.taStatusName == 'Rejected'
                                 || toolRequest.status.taStatusName == 'Tool Details Entered'
                                 || toolRequest.status.taStatusName == 'Cost Entered'}">

                        <a href="add-tool-approval-request?reqId=${toolRequest.taToolRequestId}"
                           class="btn btn-info">
                            Edit
                        </a>

                    </c:if>

                    <a href="view-tool-approval-request-list"
                       class="btn btn-secondary">
                        Back
                    </a>

                </div>

            </div>
        </section>

    </div>

    <%@include file="../includeJSP/footer.jsp"%>

</div>

<%@include file="../includeJSP/jsFiles.jsp"%>

</body>
</html>

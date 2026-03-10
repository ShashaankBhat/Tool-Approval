<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>EDIT TOOL APPROVAL REQUEST<%@include file="../includeJSP/company_name_title.jsp"%></title>
    <%@include file="../includeJSP/cssFiles.jsp"%>
</head>

<body class="sidebar-mini layout-navbar-fixed sidebar-collapse pace-primary">
<div class="wrapper">

    <%@include file="includeJSP/header.jsp"%>
    <%@include file="includeJSP/leftSideBar.jsp"%>

    <div class="content-wrapper">

        <!-- HEADER -->
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-8">
                        <h5 class="font-3 font-weight-bold">
                            EDIT TOOL APPROVAL REQUEST
                            <span class="badge badge-danger ml-2">Rejected</span>
                        </h5>
                    </div>
                    <div class="col-sm-4">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item">
                                <c:url var="viewUrl" value="view-tool-approval-request-list" />
                                <a href="${viewUrl}">View Requests</a>
                            </li>
                            <li class="breadcrumb-item active">Edit</li>
                        </ol>
                    </div>
                </div>
            </div>
        </section>

        <!-- CONTENT -->
        <section class="content content-margin">
            <div class="container-fluid">

                <form method="post" action="edit-tool-approval-cost-details">

                    <!-- Preserve request identity -->
                    <input type="hidden" name="reqId" value="${reqId}"/>

                    <!-- TOOL SUMMARY -->
                    <div class="card shadow-sm mb-3">
                        <div class="card-body bg-light">
                            <div class="row">
                                <div class="col-md-3">
                                    <b>Initiator:</b> ${initiatorName}
                                </div>
                                <div class="col-md-3">
                                    <b>Initiated On:</b> ${initiatedOn}
                                </div>
                                <div class="col-md-3">
                                    <b>Status:</b>
                                    <span class="badge badge-danger">Rejected</span>
                                </div>
                                <div class="col-md-3">
                                    <b>Business Unit:</b> ${businessUnit}
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- PROJECT & LOCATION DETAILS -->
                    <div class="card shadow-sm mb-3">
                        <div class="card-header bg-2 text-white font-weight-bold">
                            Project & Location Details
                        </div>
                        <div class="card-body">

                            <div class="row mb-2">
                                <div class="col-md-3">
                                    <label>Location</label>
                                    <input type="text" name="location"
                                           class="form-control"
                                           value="${location}">
                                </div>

                                <div class="col-md-3">
                                    <label>Customer Name</label>
                                    <input type="text" name="customerName"
                                           class="form-control"
                                           value="${toolRequest.customerName}">
                                </div>

                                <div class="col-md-3">
                                    <label>Project Name</label>
                                    <input type="text" name="projectName"
                                           class="form-control"
                                           value="${projectName}">
                                </div>

                                <div class="col-md-3">
                                    <label>SOP Date</label>
                                    <input type="date" name="sopDate"
                                           class="form-control"
                                           value="${sopDate}">
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-3">
                                    <label>Peak Annual Volume</label>
                                    <input type="number" name="peakVolume"
                                           class="form-control"
                                           value="${peakAnnualVolume}">
                                </div>

                                <div class="col-md-3">
                                    <label>Commodity</label>
                                    <input type="text" name="commodity"
                                           class="form-control"
                                           value="${commodity}">
                                </div>

                                <div class="col-md-3">
                                    <label>Plant Code</label>
                                    <input type="text" name="plantCode"
                                           class="form-control"
                                           value="${plantCode}">
                                </div>

                                <div class="col-md-3">
                                    <label>Recovery Type</label>
                                    <select name="recoveryType" class="form-control">
                                        <option ${recoveryType == 'Recoverable' ? 'selected' : ''}>Recoverable</option>
                                        <option ${recoveryType == 'Non-Recoverable' ? 'selected' : ''}>Non-Recoverable</option>
                                    </select>
                                </div>
                            </div>

                        </div>
                    </div>

                    <!-- BACKGROUND -->
                    <div class="card shadow-sm mb-3">
                        <div class="card-header bg-2 text-white font-weight-bold">
                            Background
                        </div>
                        <div class="card-body">
                            <textarea name="background"
                                      class="form-control"
                                      rows="3">${background}</textarea>
                        </div>
                    </div>

                    <!-- INITIATOR REMARK -->
                    <div class="card shadow-sm mb-3">
                        <div class="card-header bg-2 text-white font-weight-bold">
                            Initiator Remark
                        </div>
                        <div class="card-body">
                            <textarea name="initiatorRemark"
                                      class="form-control"
                                      rows="3">${initiatorRemark}</textarea>
                        </div>
                    </div>

                    <!-- ACTION -->
                    <div class="text-right mb-4">
                        <a href="dashboard-tool-approval" class="btn btn-secondary">
                            Cancel
                        </a>
                        <button type="submit" class="btn btn-warning">
                            Save & Continue
                        </button>
                    </div>

                </form>

            </div>
        </section>

    </div>

    <%@include file="../includeJSP/footer.jsp"%>
</div>

<%@include file="../includeJSP/jsFiles.jsp"%>
</body>
</html>

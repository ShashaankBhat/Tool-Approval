<!DOCTYPE html>
<html lang="en">
<head>
    <title>ADD TOOL APPROVAL REQUEST<%@include file="../includeJSP/company_name_title.jsp"%></title>

    <%@include file="../includeJSP/cssFiles.jsp"%>

    <style>
        .wizard-step {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }
        .wizard-box {
            padding: 10px 18px;
            border-radius: 6px;
            font-weight: bold;
            font-size: 14px;
            cursor: default;
        }
        .wizard-active {
            background-color: #17a2b8;
            color: #ffffff;
        }
        .wizard-disabled {
            background-color: #e9ecef;
            color: #6c757d;
        }
    </style>
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
                            ADD TOOL APPROVAL REQUEST
                            <span class="badge badge-info ml-2">In Progress</span>
                        </h5>
                    </div>
                    <div class="col-sm-4">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="dashboard">Dashboard</a></li>
                            <li class="breadcrumb-item"><a href="dashboard-tool-approval">Tool Approval</a></li>
                            <li class="breadcrumb-item">New Request</li>
                            <li class="breadcrumb-item active">Tool Details</li>
                        </ol>
                    </div>
                </div>
            </div>
        </section>

        <!-- ALERTS -->
        <c:if test="${not empty regMsg}">
            <section class="content content-margin">
                <div class="container-fluid">
                    <div class="alert ${css} alert-dismissible">
                        <button type="button" class="close" data-dismiss="alert">
                            <i class="fas fa-times"></i>
                        </button>
                        <h5>${regMsg}</h5>
                    </div>
                </div>
            </section>
        </c:if>

        <!-- MAIN -->
        <section class="content content-margin">
            <div class="container-fluid">

                <!-- WIZARD -->
                <div class="wizard-step">
                    <div class="wizard-box wizard-active">
                        Step 1 : Tool Details
                    </div>
                    <div class="wizard-box wizard-disabled">
                        Step 2 : Cost Details
                    </div>
                </div>

                <!-- FORM -->
                <div class="card shadow">
                    <div class="card-body">

                        <form method="post" action="add-tool-approval-request">

                            <!-- Hidden ID (used only in edit mode) -->
                            <input type="hidden"
                                   name="taToolRequestId"
                                   value="${taToolRequest != null ? taToolRequest.taToolRequestId : ''}" />
                            <input type="hidden" name="actionType" id="actionType"/>

                            <div class="row">
                                <div class="col-md-6">
                                    <label>Customer Name</label>
                                    <input type="text"
                                           name="customerName"
                                           class="form-control"
                                           required
                                           value="${taToolRequest.customerName}" />
                                </div>

                                <div class="col-md-6">
                                    <label>SOP Date</label>
                                    <input type="date"
                                           name="sopDate"
                                           class="form-control"
                                           required
                                           value="<fmt:formatDate value='${taToolRequest.sopDate}' pattern='yyyy-MM-dd'/>" />
                                </div>
                            </div>

                            <div class="row mt-3">
                                <div class="col-md-6">
                                    <label>Project</label>
                                    <input type="text"
                                           name="projectName"
                                           class="form-control"
                                           required
                                           value="${taToolRequest.projectName}" />
                                </div>

                                <div class="col-md-6">
                                    <label>Peak Annual Volume</label>
                                    <input type="number"
                                           name="peakAnnualVolume"
                                           class="form-control"
                                           required
                                           value="${taToolRequest.peakAnnualVolume}" />
                                </div>
                            </div>

                            <div class="row mt-3">
                                <div class="col-md-6">
                                    <label>Plant Code</label>
                                    <select class="form-control"
                                            name="entity.mEntityId"
                                            required>
                                        <option value="">Select Plant</option>
                                        <c:forEach var="ent" items="${entities}">
                                            <option value="${ent.mEntityId}"
                                                <c:if test="${taToolRequest != null 
                                                              and taToolRequest.entity != null 
                                                              and taToolRequest.entity.mEntityId == ent.mEntityId}">
                                                    selected
                                                </c:if>>
                                                ${ent.entityName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="col-md-6">
                                    <label>Applicable For</label>
                                    <select class="form-control"
                                            name="businessUnit.taBusinessUnitId"
                                            required>
                                        <option value="">Select Business Unit</option>
                                        <c:forEach var="bu" items="${businessUnits}">
                                            <option value="${bu.taBusinessUnitId}"
                                                <c:if test="${taToolRequest != null 
                                                              and taToolRequest.businessUnit != null 
                                                              and taToolRequest.businessUnit.taBusinessUnitId == bu.taBusinessUnitId}">
                                                    selected
                                                </c:if>>
                                                ${bu.taBusinessUnitName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="row mt-3">
                                <div class="col-md-6">
                                    <label>Commodity Manager</label>
                                    <select class="form-control"
                                            name="commodityManager.mUserId"
                                            required>
                                        <option value="">Select Commodity Manager</option>
                                        <c:forEach var="cm" items="${commodityManagers}">
                                            <option value="${cm.mUserId}"
                                                <c:if test="${taToolRequest != null 
                                                              and taToolRequest.commodityManager != null 
                                                              and taToolRequest.commodityManager.mUserId == cm.mUserId}">
                                                    selected
                                                </c:if>>
                                                ${cm.userFirstName} ${cm.userLastName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="row mt-3">
                                <div class="col-md-12">
                                    <label>Background</label>
                                    <textarea name="background"
                                              class="form-control"
                                              rows="4"
                                              >${toolRequest != null ? toolRequest.background : ''}</textarea>
                                    <c:choose>
                                        <c:when test="${not empty toolRequest and not empty toolRequest.taToolRequestId}">
                                            <c:if test="${not empty backgroundAttachments}">
                                                <ul class="list-group mt-2">
                                                    <c:forEach var="att" items="${backgroundAttachments}">
                                                        <li class="list-group-item d-flex justify-content-between align-items-center">
                                                            <a href="ta-attachment-download?attachmentId=${att.taAttachmentId}">
                                                                ${att.fileName}
                                                            </a>
                                                            <form method="post"
                                                                  action="ta-attachment-delete"
                                                                  style="display:inline;">
                                                                <input type="hidden" name="toolRequestId"
                                                                       value="${toolRequest.taToolRequestId}"/>
                                                                <input type="hidden" name="attachmentId"
                                                                       value="${att.taAttachmentId}"/>
                                                                <button type="submit"
                                                                        class="btn btn-sm btn-danger">
                                                                    Delete
                                                                </button>
                                                            </form>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </c:if>

                                            <form method="post"
                                                  action="ta-attachment-upload"
                                                  enctype="multipart/form-data"
                                                  class="mt-2">
                                                <input type="hidden"
                                                       name="toolRequestId"
                                                       value="${toolRequest.taToolRequestId}" />
                                                <input type="hidden"
                                                       name="section"
                                                       value="BACKGROUND" />
                                            <div class="input-group">
                                                <input type="file"
                                                       name="file"
                                                       class="form-control"/>
                                                <div class="input-group-append">
                                                    <button type="submit" class="btn btn-info">
                                                        Upload File
                                                    </button>
                                                </div>
                                            </div>
                                        </form>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="alert alert-info mt-2">
                                                Please click <b>Save as Draft</b> to enable attachment upload.
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <hr/>

                            <div class="row mt-3">
                                <div class="col-md-12">
                                    <label>Remark</label>
                                    <textarea name="remark"
                                              class="form-control"
                                              rows="3">${toolRequest != null ? toolRequest.remark : ''}</textarea>
                                    <c:choose>
                                        <c:when test="${not empty toolRequest and not empty toolRequest.taToolRequestId}">
                                            <c:if test="${not empty remarkAttachments}">
                                                <ul class="list-group mt-2">
                                                    <c:forEach var="att" items="${remarkAttachments}">
                                                        <li class="list-group-item d-flex justify-content-between align-items-center">
                                                            <a href="ta-attachment-download?attachmentId=${att.taAttachmentId}">
                                                                ${att.fileName}
                                                            </a>
                                                            <form method="post"
                                                                  action="ta-attachment-delete"
                                                                  style="display:inline;">
                                                                <input type="hidden" name="toolRequestId"
                                                                       value="${toolRequest.taToolRequestId}"/>
                                                                <input type="hidden" name="attachmentId"
                                                                       value="${att.taAttachmentId}"/>
                                                                <button type="submit"
                                                                        class="btn btn-sm btn-danger">
                                                                    Delete
                                                                </button>
                                                            </form>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </c:if>

                                            <form method="post"
                                                  action="ta-attachment-upload"
                                                  enctype="multipart/form-data"
                                                  class="mt-2">
                                                <input type="hidden"
                                                       name="toolRequestId"
                                                       value="${toolRequest.taToolRequestId}" />
                                                <input type="hidden"
                                                       name="section"
                                                       value="REMARK" />
                                            <div class="input-group">
                                                <input type="file"
                                                       name="file"
                                                       class="form-control"/>
                                                <div class="input-group-append">
                                                    <button type="submit" class="btn btn-info">
                                                        Upload File
                                                    </button>
                                                </div>
                                            </div>
                                        </form>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="alert alert-info mt-2">
                                                Please click <b>Save as Draft</b> to enable attachment upload.
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-md-12 text-right">
                                    <a href="dashboard-tool-approval"
                                       class="btn btn-secondary">
                                        Cancel
                                    </a>
                                    <button type="button"
                                            class="btn btn-secondary"
                                            onclick="submitFormAction('draft')">
                                        Save as Draft
                                    </button>
                                    <button type="button"
                                            class="btn btn-info"
                                            onclick="submitFormAction('next')">
                                        Next
                                    </button>
                                </div>
                            </div>

                        </form>

                    </div>
                </div>

            </div>
        </section>

    </div>

    <%@include file="../includeJSP/footer.jsp"%>
</div>

<%@include file="../includeJSP/jsFiles.jsp"%>
<script>
function submitFormAction(type) {
    document.getElementById("actionType").value = type;

    // enforce HTML validation
    if (!document.forms[0].checkValidity()) {
        document.forms[0].reportValidity();
        return;
    }

    document.forms[0].submit();
}
</script>
</body>
</html>

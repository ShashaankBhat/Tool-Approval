<!DOCTYPE html>
<html lang="en">
<head>
    <title>ADD TOOL APPROVAL - COST DETAILS
        <%@include file="../includeJSP/company_name_title.jsp"%>
    </title>

    <%@include file="../includeJSP/cssFiles.jsp"%>

    <style>
        .wizard-step { display: flex; gap: 15px; margin-bottom: 20px; }
        .wizard-box { padding: 10px 18px; border-radius: 6px; font-weight: bold; font-size: 14px; }
        .wizard-active { background-color: #28a745; color: #ffffff; }
        .wizard-disabled { background-color: #e9ecef; color: #6c757d; text-decoration: none; }
        table input,
        table select {
            min-width: 120px;
        }

        table textarea {
            min-width: 250px;
            min-height: 60px;
            resize: both;   /* allows horizontal + vertical expansion */
        }
        .table {
            table-layout: auto;
            width: 100%;
        }

        .table th,
        .table td {
            white-space: nowrap;
        }
        .table thead th { vertical-align: middle; text-align: center; }
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
                            <li class="breadcrumb-item font-weight-bold"><a href="dashboard">Dashboard</a></li>
                            <li class="breadcrumb-item font-weight-bold"><a href="dashboard-tool-approval">Tool Approval</a></li>
                            <li class="breadcrumb-item font-weight-bold">New Request</li>
                            <li class="breadcrumb-item active font-weight-bold">Cost Details</li>
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
                    <a href="add-tool-approval-request" class="wizard-box wizard-disabled">
                        Step 1 : Tool Details
                    </a>
                    <div class="wizard-box wizard-active">
                        Step 2 : Cost Details
                    </div>
                </div>

                <div class="card shadow">
                    <div class="card-body">
                        <div style="overflow-x:auto;">

                        <form method="post" action="ta-tool-cost-details" modelAttribute="costWrapper">

                            <!-- REQUIRED FK -->
                            <input type="hidden"
                                   name="toolRequest.taToolRequestId"
                                   value="${taToolRequestId}" />
                            <input type="hidden" id="actionType" name="actionType" />

                            <table class="table table-bordered table-hover">
                                <thead class="bg-2 text-white">
                                <tr>
                                    <th>Sr No</th>
                                    <th>Tool for Part No</th>
                                    <th>Tool Description</th>
                                    <th>Currency</th>
                                    <th>Quoted (Mn)</th>
                                    <th>Negotiated (Mn)</th>
                                    <th>Up Front (Mn)</th>
                                    <th>Amortization (Mn)</th>
                                    <th>Supplier</th>
                                    <th>Dev Lead Time (Weeks)</th>
                                    <th>Remark</th>
                                    <th>Action</th>
                                </tr>
                                </thead>

                                <tbody id="costTableBody">

<c:choose>
<c:when test="${not empty costDetailsList}">
<c:forEach var="row" items="${costDetailsList}" varStatus="status">

<tr>
<td class="text-center">${status.index + 1}</td>

<td><input type="text" name="costDetailsList[${status.index}].toolPartNumber"
           value="${row.toolPartNumber}" class="form-control" required/></td>

<td><input type="text" name="costDetailsList[${status.index}].partDescription"
           value="${row.partDescription}" class="form-control" required/></td>

<td>
<select name="costDetailsList[${status.index}].currency" class="form-control">
<option value="INR" ${row.currency=='INR'?'selected':''}>INR</option>
<option value="USD" ${row.currency=='USD'?'selected':''}>USD</option>
<option value="EUR" ${row.currency=='EUR'?'selected':''}>EUR</option>
<option value="YEN" ${row.currency=='YEN'?'selected':''}>YEN</option>
</select>
</td>

<td><input type="number" step="0.01"
           name="costDetailsList[${status.index}].quotedCost"
           value="${row.quotedCost}" class="form-control"/></td>

<td><input type="number" step="0.01"
           name="costDetailsList[${status.index}].negotiatedCost"
           value="${row.negotiatedCost}" class="form-control"/></td>

<td><input type="number" step="0.01"
           name="costDetailsList[${status.index}].upfrontCost"
           value="${row.upfrontCost}" class="form-control"/></td>

<td><input type="text"
           name="costDetailsList[${status.index}].amortizationCost"
           value="${row.amortizationCost}" class="form-control"/></td>

<td><input type="text"
           name="costDetailsList[${status.index}].supplierName"
           value="${row.supplierName}" class="form-control"/></td>

<td><input type="text"
           name="costDetailsList[${status.index}].developmentLeadTime"
           value="${row.developmentLeadTime}" class="form-control"/></td>

<td>
<textarea name="costDetailsList[${status.index}].remarks"
          class="form-control"
          style="min-width:200px; resize:both;">
${row.remarks}
</textarea>
</td>

<td class="text-center">
    <button type="button"
            class="btn btn-sm btn-danger"
            onclick="deleteRow(this)">
        Delete
    </button>
</td>

</tr>

</c:forEach>
</c:when>

<c:otherwise>

<tr>
<td class="text-center">1</td>

<td><input type="text" name="costDetailsList[0].toolPartNumber" class="form-control" required/></td>
<td><input type="text" name="costDetailsList[0].partDescription" class="form-control" required/></td>
<td>
<select name="costDetailsList[0].currency" class="form-control">
<option value="INR">INR</option>
<option value="USD">USD</option>
<option value="EUR">EUR</option>
<option value="YEN">YEN</option>
</select>
</td>

<td><input type="number" step="0.01" name="costDetailsList[0].quotedCost" class="form-control"/></td>
<td><input type="number" step="0.01" name="costDetailsList[0].negotiatedCost" class="form-control"/></td>
<td><input type="number" step="0.01" name="costDetailsList[0].upfrontCost" class="form-control"/></td>
<td><input type="text" name="costDetailsList[0].amortizationCost" class="form-control"/></td>
<td><input type="text" name="costDetailsList[0].supplierName" class="form-control"/></td>
<td><input type="text" name="costDetailsList[0].developmentLeadTime" class="form-control"/></td>
<td><textarea name="costDetailsList[0].remarks" class="form-control" style="resize:both;"></textarea></td>

<td class="text-center">
    <button type="button"
            class="btn btn-sm btn-danger"
            onclick="deleteRow(this)">
        Delete
    </button>
</td>

</tr>

</c:otherwise>
</c:choose>

</tbody>
                            </table>
                        </div>

                            <div class="row mt-4">
                                <div class="col-md-12 d-flex justify-content-between">

                                    <div>
                                        <button type="button"
                                                class="btn btn-primary"
                                                onclick="addRow()">
                                            + Add Row
                                        </button>
                                    </div>

                                    <div>

                                        <a href="add-tool-approval-request?reqId=${taToolRequestId}"
                                           class="btn btn-secondary">
                                            Back
                                        </a>

                                        <a href="dashboard-tool-approval"
                                           class="btn btn-danger">
                                            Cancel
                                        </a>

                                        <button type="button"
                                                class="btn btn-secondary"
                                                onclick="submitCostForm('draft')">
                                            Save as Draft
                                        </button>

                                        <button type="button"
                                                class="btn btn-success"
                                                onclick="submitCostForm('submit')">
                                            Submit for Approval
                                        </button>

                                    </div>

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

let rowIndex = document.querySelectorAll("#costTableBody tr").length;

function updateSerialNumbers() {
    const rows = document.querySelectorAll("#costTableBody tr");
    rows.forEach((row, index) => {
        row.cells[0].innerText = index + 1;
    });
}

function addRow() {

    const tableBody = document.getElementById("costTableBody");

    const newRow = document.createElement("tr");

    newRow.innerHTML = `
        <td class="text-center"></td>

        <td><input type="text" name="costDetailsList[${rowIndex}].toolPartNumber" class="form-control"/></td>

        <td><input type="text" name="costDetailsList[${rowIndex}].partDescription" class="form-control"/></td>

        <td>
            <select name="costDetailsList[${rowIndex}].currency" class="form-control">
                <option value="INR">INR</option>
                <option value="USD">USD</option>
                <option value="EUR">EUR</option>
                <option value="YEN">YEN</option>
            </select>
        </td>

        <td><input type="number" step="0.01" name="costDetailsList[${rowIndex}].quotedCost" class="form-control"/></td>
        <td><input type="number" step="0.01" name="costDetailsList[${rowIndex}].negotiatedCost" class="form-control"/></td>
        <td><input type="number" step="0.01" name="costDetailsList[${rowIndex}].upfrontCost" class="form-control"/></td>

        <td><input type="text" name="costDetailsList[${rowIndex}].amortizationCost" class="form-control"/></td>

        <td><input type="text" name="costDetailsList[${rowIndex}].supplierName" class="form-control"/></td>

        <td><input type="text" name="costDetailsList[${rowIndex}].developmentLeadTime" class="form-control"/></td>

        <td>
            <textarea name="costDetailsList[${rowIndex}].remarks"
                      class="form-control"
                      style="resize:both;"></textarea>
        </td>

        <td class="text-center">
            <button type="button"
                    class="btn btn-sm btn-danger"
                    onclick="deleteRow(this)">
                Delete
            </button>
        </td>
    `;

    tableBody.appendChild(newRow);

    rowIndex++;
    updateSerialNumbers();
}

function deleteRow(button) {

    const tableBody = document.getElementById("costTableBody");
    const rows = tableBody.querySelectorAll("tr");

    if (rows.length === 1) {
        alert("At least one row is required.");
        return;
    }

    const row = button.closest("tr");
    row.remove();

    updateSerialNumbers();
}

</script>
<script>
function submitCostForm(type) {

    const form = document.querySelector("form");

    if (!form.checkValidity()) {
        form.reportValidity();
        return;
    }

    document.getElementById("actionType").value = type;
    form.submit();
}
</script>
</body>
</html>




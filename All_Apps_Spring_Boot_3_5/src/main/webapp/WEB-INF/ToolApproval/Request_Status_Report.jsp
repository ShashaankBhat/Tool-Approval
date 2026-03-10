<!DOCTYPE html>
<html lang="en">
<head>
    <title>REQUEST STATUS REPORT<%@include file="../includeJSP/company_name_title.jsp"%></title>
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
                <h5 class="font-3 font-weight-bold">Request Status Report</h5>
            </div>
        </section>

        <!-- FILTER SECTION -->
        <section class="content content-margin">
            <div class="container-fluid">

                <!-- Search Form (GET-based, UI-safe) -->
                <form method="get" action="request-status-report">
                    <div class="card shadow-sm mb-3">
                        <div class="card-body">
                            <div class="row align-items-end">

                                <div class="col-md-3">
                                    <label>Plant</label>
                                    <select name="plant" class="form-control">
                                        <option value="">All</option>
                                        <option value="Hosur">Hosur</option>
                                        <option value="Ambad">Ambad</option>
                                        <option value="Chakan 4W">Chakan 4W</option>
                                        <option value="Dewas">Dewas</option>
                                    </select>
                                </div>

                                <div class="col-md-3">
                                    <label>From Date</label>
                                    <input type="date"
                                           name="fromDate"
                                           class="form-control"
                                           value="${param.fromDate}">
                                </div>

                                <div class="col-md-3">
                                    <label>To Date</label>
                                    <input type="date"
                                           name="toDate"
                                           class="form-control"
                                           value="${param.toDate}">
                                </div>

                                <div class="col-md-3 text-right">
                                    <button type="submit" class="btn btn-primary">
                                        Search
                                    </button>

                                    <!-- Export via GET flag -->
                                    <a href="request-status-report?export=true"
                                       class="btn btn-secondary">
                                        Export
                                    </a>
                                </div>

                            </div>
                        </div>
                    </div>
                </form>

                <!-- REPORT TABLE -->
                <div class="card shadow-sm">
                    <div class="card-body table-responsive p-0">
                        <table class="table table-bordered table-hover text-nowrap">
                            <thead class="bg-2 text-white">
                            <tr>
                                <th>No</th>
                                <th>Plant Code</th>
                                <th>Customer Name</th>
                                <th>SOP Date</th>
                                <th>Project Name</th>
                                <th>Status</th>
                                <th>Initiated On</th>
                                <th>Initiator</th>
                                <th>COO Status</th>
                                <th>COO Approved Date</th>
                                <th>Business Unit</th>
                                <th>Pending With</th>
                                <th>Tool Number</th>
                            </tr>
                            </thead>

                            <tbody>
                            <tr>
                                <td>507</td>
                                <td>Hosur</td>
                                <td>OLA</td>
                                <td>01-07-2025</td>
                                <td>M3 Roadster</td>
                                <td><span class="badge badge-success">Approved</span></td>
                                <td>2025-06-03</td>
                                <td>Manikandan S</td>
                                <td>Partial Recoverable</td>
                                <td>2025-09-30</td>
                                <td>TWBU</td>
                                <td>—</td>
                                <td>2025-26/1001/0007</td>
                            </tr>

                            <tr>
                                <td>511</td>
                                <td>Dewas</td>
                                <td>Mahindra</td>
                                <td>01-08-2025</td>
                                <td>MTBD Sleeper Cabin</td>
                                <td><span class="badge badge-warning">Pending</span></td>
                                <td>2025-06-17</td>
                                <td>Vinod Kinge</td>
                                <td>—</td>
                                <td>—</td>
                                <td>CVBU</td>
                                <td>Vasudevan R</td>
                                <td>2025-26/1003/0011</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="mt-2 text-muted font-12">
                    Displaying dummy data for UI validation
                </div>

            </div>
        </section>
    </div>

    <%@include file="../includeJSP/footer.jsp"%>
</div>
<%@include file="../includeJSP/jsFiles.jsp"%>
</body>
</html>

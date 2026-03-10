<!DOCTYPE html>
<html lang="en">
<head>
    <title>APPROVED REQUEST REPORT<%@include file="../includeJSP/company_name_title.jsp"%></title>
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
                <h5 class="font-3 font-weight-bold">Approved Request Report</h5>
            </div>
        </section>

        <!-- FILTER -->
        <section class="content content-margin">
            <div class="container-fluid">

                <!-- Search Form (GET-based, UI-safe) -->
                <form method="get" action="approved-request-report">
                    <div class="card shadow-sm mb-3">
                        <div class="card-body">
                            <div class="row align-items-end">

                                <div class="col-md-3">
                                    <label>Plant</label>
                                    <select name="plant" class="form-control">
                                        <option value="">All</option>
                                        <option value="Hosur">Hosur</option>
                                        <option value="Ambad">Ambad</option>
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
                                    <a href="approved-request-report?export=true"
                                       class="btn btn-secondary">
                                        Export
                                    </a>
                                </div>

                            </div>
                        </div>
                    </div>
                </form>

                <!-- TABLE -->
                <div class="card shadow-sm">
                    <div class="card-body table-responsive p-0">
                        <table class="table table-bordered table-hover text-nowrap">
                            <thead class="bg-2 text-white">
                            <tr>
                                <th>No</th>
                                <th>Tool Number</th>
                                <th>Business Unit</th>
                                <th>Plant</th>
                                <th>Customer</th>
                                <th>Project</th>
                                <th>SOP Date</th>
                                <th>Quote</th>
                                <th>Price Negotiated</th>
                                <th>Upfront</th>
                                <th>Amortization</th>
                                <th>Initiator</th>
                                <th>Initiated On</th>
                                <th>COO Status</th>
                                <th>COO Approved Date</th>
                                <th>Status</th>
                            </tr>
                            </thead>

                            <tbody>
                            <tr>
                                <td>514</td>
                                <td>2025-26/1002/0007</td>
                                <td>TWBU</td>
                                <td>Ambad</td>
                                <td>Kinetic Green Energy</td>
                                <td>K STAR</td>
                                <td>01-08-2025</td>
                                <td>0.02</td>
                                <td>0.018</td>
                                <td>0.018</td>
                                <td>0</td>
                                <td>Rahul Sonar</td>
                                <td>2025-07-09</td>
                                <td>Partial Recoverable</td>
                                <td>2025-09-30</td>
                                <td>
                                    <span class="badge badge-success">Approved</span>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="mt-2 text-muted font-12">
                    Sample approved data for UI verification
                </div>

            </div>
        </section>
    </div>

    <%@include file="../includeJSP/footer.jsp"%>
</div>
<%@include file="../includeJSP/jsFiles.jsp"%>
</body>
</html>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>EDIT TOOL COST DETAILS</title>
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
                    <div class="col-sm-8">
                        <h5 class="font-3 font-weight-bold">
                            EDIT TOOL APPROVAL REQUEST
                            <span class="badge badge-warning ml-2">Resubmitting</span>
                        </h5>
                    </div>
                    <div class="col-sm-4">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="dashboard">Dashboard</a></li>
                            <li class="breadcrumb-item"><a href="dashboard-tool-approval">Tool Approval</a></li>
                            <li class="breadcrumb-item active">Cost Details</li>
                        </ol>
                    </div>
                </div>
            </div>
        </section>

        <section class="content content-margin">
            <div class="container-fluid">

                <div class="card shadow">
                    <div class="card-body">

                        <form method="post" action="dashboard-tool-approval">

                            <div class="row">
                                <div class="col-md-6">
                                    <label>Tool Cost</label>
                                    <input type="number" class="form-control" value="1200000">
                                </div>
                                <div class="col-md-6">
                                    <label>Remarks</label>
                                    <textarea class="form-control">Updated as per feedback</textarea>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-md-12 text-right">
                                    <a href="dashboard-tool-approval" class="btn btn-secondary">Cancel</a>
                                    <button type="submit" class="btn btn-warning">Resubmit</button>
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
</body>
</html>

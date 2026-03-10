<!DOCTYPE html>
<html lang="en">
<head>
    <title>REJECTED TOOL REQUEST<%@include file="../includeJSP/company_name_title.jsp"%></title>
    <%@include file="../includeJSP/cssFiles.jsp"%>
</head>

<body class="sidebar-mini layout-navbar-fixed sidebar-collapse">
<div class="wrapper">

<%@include file="includeJSP/header.jsp"%>
<%@include file="includeJSP/leftSideBar.jsp"%>

<div class="content-wrapper">

<section class="content-header">
    <div class="container-fluid">
        <h5 class="font-3 font-weight-bold">Rejected Tool Request</h5>
    </div>
</section>

<section class="content content-margin">
<div class="container-fluid">

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
    <th>Initiator</th>
    <th>Rejected By</th>
    <th>Rejection Remark</th>
</tr>
</thead>

<tbody>
<tr>
    <td>482</td>
    <td>1002</td>
    <td>Bajaj Auto Ltd</td>
    <td>01-04-2025</td>
    <td>CHETAK</td>
    <td><span class="badge badge-danger">Rejected</span></td>
    <td>Rahul Sonar</td>
    <td>SBU Head</td>
    <td>Trial request only</td>
</tr>
</tbody>

</table>
</div>
</div>

<div class="mt-2 text-muted font-12">
    Dummy rejected data for UI validation
</div>

</div>
</section>

</div>

<%@include file="../includeJSP/footer.jsp"%>
</div>
<%@include file="../includeJSP/jsFiles.jsp"%>
</body>
</html>

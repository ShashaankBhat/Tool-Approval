<!DOCTYPE html>
<html lang="en">
<head>
    <title>APPROVED TOOL REQUEST<%@include file="../includeJSP/company_name_title.jsp"%></title>
    <%@include file="../includeJSP/cssFiles.jsp"%>
</head>

<body class="sidebar-mini layout-navbar-fixed sidebar-collapse">
<div class="wrapper">

<%@include file="includeJSP/header.jsp"%>
<%@include file="includeJSP/leftSideBar.jsp"%>

<div class="content-wrapper">

<section class="content-header">
    <div class="container-fluid">
        <h5 class="font-3 font-weight-bold">Approved Tool Request</h5>
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
    <th>Approver</th>
    <th>Tool Number</th>
    <th>Last Approver Remark</th>
</tr>
</thead>

<tbody>
<tr>
    <td>514</td>
    <td>1002</td>
    <td>Kinetic Green Energy</td>
    <td>01-08-2025</td>
    <td>K STAR</td>
    <td><span class="badge badge-success">Approved</span></td>
    <td>Rahul Sonar</td>
    <td>COO</td>
    <td>2025-26/1002/0007</td>
    <td>MD: OK</td>
</tr>
</tbody>

</table>
</div>
</div>

<div class="mt-2 text-muted font-12">
    Dummy approved data for UI validation
</div>

</div>
</section>

</div>

<%@include file="../includeJSP/footer.jsp"%>
</div>
<%@include file="../includeJSP/jsFiles.jsp"%>
</body>
</html>

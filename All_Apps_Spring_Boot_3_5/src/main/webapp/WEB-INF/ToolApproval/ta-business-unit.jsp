<!DOCTYPE html>
<html lang="en">
  <head>
    <title>BUSINESS UINT<%@include file="../includeJSP/company_name_title.jsp"%></title>
    <%@ include file="../includeJSP/cssFiles.jsp" %>
  </head>
  <body class="hold-transition sidebar-mini layout-fixed">
    <div class="wrapper">
      <%@ include file="includeJSP/header.jsp" %>
      <%@ include file="includeJSP/leftSideBar.jsp" %>
      <div class="content-wrapper">
        <section class="content-header">
          <div class="container-fluid">
            <div class="row mb-2">
              <div class="col-sm-6">
                <h5 class="font-3">ROLE LIST</h5>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="/dashboard">Dashboard</a></li>
                            <li class="breadcrumb-item">Masters</li>
                            <li class="breadcrumb-item active">Business Unit</li>
                        </ol>
                    </div>
                </div>
            </div>
        </section>

        <!-- CONTENT -->
        <section class="content">
            <div class="container-fluid">

                <!-- MESSAGE -->
                <c:if test="${not empty regMsg}">
                    <div class="alert alert-${css == 'sequence-bg-5' ? 'success' : 'danger'} alert-dismissible">
                        ${regMsg}
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                    </div>
                </c:if>

                <!-- FORM -->
                <div class="card card-primary">
                    <div class="card-header">
                        <h3 class="card-title">Add / Edit Business Unit</h3>
                    </div>

                    <div class="card-body">
                        <form method="post" action="ta-business-unit" id="businessUnitForm">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <input type="hidden" name="taBusinessUnitId" id="taBusinessUnitId"/>

                            <div class="form-group">
                                <label>Business Unit Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="buName" id="buName" required>
                            </div>

                            <div class="form-group">
                                <label>Description</label>
                                <textarea class="form-control" name="buDescription" id="buDescription"></textarea>
                            </div>

                            <div class="form-group">
                                <input type="checkbox" id="buActive" name="buActive">
                                <label for="buActive">Active</label>
                            </div>

                            <button type="submit" class="btn btn-primary">Save</button>
                            <button type="button" class="btn btn-secondary" onclick="resetForm()">Reset</button>
                        </form>
                    </div>
                </div>

                <!-- LIST -->
                <div class="card mt-3">
                    <div class="card-header">
                        <h3 class="card-title">Business Unit List</h3>
                    </div>

                    <div class="card-body">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Action</th>
                                    <th>Name</th>
                                    <th>Description</th>
                                    <th>Status</th>
                                    <th>Created On</th>
                                    <th>Updated On</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${businessUnitList}" var="bu">
                                    <tr>
                                        <td>
                                            <button class="btn btn-sm btn-info"
                                                onclick="editBusinessUnit(
                                                    ${bu.taBusinessUnitId},
                                                    '${bu.taBusinessUnitName}',
                                                    '${bu.taBusinessUnitDescription}',
                                                    ${bu.taBusinessUnitActive})">
                                                Edit
                                            </button>
                                        </td>
                                        <td>${bu.taBusinessUnitName}</td>
                                        <td>${bu.taBusinessUnitDescription}</td>
                                        <td>
                                            <span class="badge ${bu.taBusinessUnitActive == 1 ? 'badge-success' : 'badge-danger'}">
                                                ${bu.taBusinessUnitActive == 1 ? 'Active' : 'Inactive'}
                                            </span>
                                        </td>
                                        <td><fmt:formatDate value="${bu.createdOn}" pattern="dd-MMM-yyyy"/></td>
                                        <td><fmt:formatDate value="${bu.updatedOn}" pattern="dd-MMM-yyyy"/></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </section>

    </div>

    <%@ include file="../includeJSP/footer.jsp" %>
</div>

<%@ include file="../includeJSP/jsFiles.jsp" %>

<script>
function editBusinessUnit(id, name, desc, active) {
    document.getElementById('taBusinessUnitId').value = id;
    document.getElementById('buName').value = name;
    document.getElementById('buDescription').value = desc || '';
    document.getElementById('buActive').checked = (active == 1);
}

function resetForm() {
    document.getElementById('businessUnitForm').reset();
    document.getElementById('taBusinessUnitId').value = '';
}
</script>

</body>
</html>

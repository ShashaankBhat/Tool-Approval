<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>DASHBOARD | ACT <%= request.getAttribute("company_name_title") != null ? request.getAttribute("company_name_title") : "" %></title>
    <%@ include file="../includeJSP/cssFiles.jsp" %>

    <!-- ✅ Load jQuery FIRST (CDN to prevent 404 & dependency issues) -->
    </head>

    
<body class="sidebar-mini layout-navbar-fixed sidebar-collapse pace-primary">
<div class="wrapper">
    <%@ include file="includeJSP/header.jsp" %>
    <%@ include file="includeJSP/leftSideBar.jsp" %>

    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h5 class="font-1 font-weight-bold">ACT DASHBOARD</h5>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item">
                                <a href="dashboard" title="Dashboard"><strong>Dashboard</strong></a>
                            </li>
                            <li class="breadcrumb-item active"><strong>ACT Dashboard</strong></li>
                        </ol>
                    </div>
                </div>
            </div>
        </section>

        <c:if test="${ctAdmin eq 1 || itAdmin eq 1 }">
        <section class="content content-margin mt-1">
          <div class="container-fluid">
        <div class="row">
          <div class="col-md-12">
             <div class="card card-primary card-outline bg-card-primary-anand mb-3">
   <div class="card-header d-flex align-items-center justify-content-between">
  <h5 class="card-title mb-0">
    <i class="fas fa-filter font-color-anand-one"></i>&emsp;Filters
  </h5>

  <!-- plus button on far right -->
  <button type="button" class="btn btn-tool" id="toggleFiltersBtn" title="Show/Hide Filters">
    <i class="fas fa-plus font-color-anand-one"></i>
  </button>
</div>



          <!-- Collapsible filter section -->
          <div class="card-body p-3" id="filterCardBody" style="display: none;">
                <form action="emc-coaching-mis-report" id="dashboard_v2" method="get">
                  <!-- First Row - Batch, Company, Coach, Coachee -->
                  <div class="form-row align-items-end mb-3">
                    <!-- Batch Filter -->
                    <div class="col-12 col-md-3 mb-2">
                      <label class="mb-1 font-weight-bold">Batch</label>
                      <select name="batchId" id="batchSelect" class="form-control form-control-sm">
                        <option value="-1">All Batches</option>
                        <c:forEach items="${batchList}" var="batch">
                          <option value="${batch.actCoachingBatchId}" ${param.batchId == batch.actCoachingBatchId ? 'selected' : ''}>${batch.batchName}</option>
                        </c:forEach>
                      </select>
                    </div>
                    
                    <!-- Company Filter -->
                    <div class="col-12 col-md-3 mb-2">
                      <label class="mb-1 font-weight-bold">Company</label>
                      <select name="companyId" class="form-control form-control-sm">
                        <option value="-1">All Companies</option>
                        <c:forEach items="${entityList}" var="entity">
                          <option value="${entity.mEntityId}" ${param.companyId == entity.mEntityId ? 'selected' : ''}>${entity.entityName}</option>
                        </c:forEach>
                      </select>
                    </div>
                    
                    <!-- Coach Filter -->
                    <div class="col-12 col-md-3 mb-2">
                      <label class="mb-1 font-weight-bold">Coach</label>
                      <select name="coachId" id="coachSelect" class="form-control form-control-sm">
                        <option value="-1">All Coaches</option>
                        <c:if test="${not empty param.coachId && param.coachId ne '-1'}">
                          <c:forEach items="${coachList}" var="coach">
                            <c:if test="${coach.mUserId eq param.coachId}">
      <option value="${coach.mUserId}" selected>
        ${coach.userFirstName} ${coach.userLastName}
      </option>
    </c:if>
                          </c:forEach>
                        </c:if>
                      </select>
                    </div>
                    
                    <!-- Coachee Filter -->
                    <div class="col-12 col-md-3 mb-2">
                      <label class="mb-1 font-weight-bold">Coachee</label>
                      <select name="coacheeId" id="coacheeSelect" class="form-control form-control-sm">
                        <option value="-1">All Coachees</option>
                        <c:if test="${not empty param.coacheeId && param.coacheeId ne '-1'}">
                          <c:forEach items="${coacheeList}" var="coachee">
                             <c:if test="${coachee.mUserId eq param.coacheeId}">
      <option value="${coachee.mUserId}" selected>
        ${coachee.userFirstName} ${coachee.userLastName}
      </option>
    </c:if>
                          </c:forEach>
                        </c:if>
                      </select>
                    </div>
                  </div>
                  
                  <div class="form-row align-items-end">
                    <!-- Program Category -->
                    <div class="col-12 col-md-3 mb-2">
                      <label class="mb-1 font-weight-bold">Program Category</label>
                      <select name="programCategory" class="form-control form-control-sm">
                        <option value="-1">All Categories</option>
                        <option value="1" ${param.programCategory == '1' ? 'selected' : ''}>AM - ANAND Mentee</option>
                        <option value="2" ${param.programCategory == '2' ? 'selected' : ''}>AT - ANAND Talent</option>
                        <option value="3" ${param.programCategory == '3' ? 'selected' : ''}>AL - ANAND Leader</option>
                      </select>
                    </div>
                    
                    <!-- Date Range -->
                    <div class="col-12 col-md-3 mb-2">
                      <label class="mb-1 font-weight-bold">Report Date Range</label>
                      <div class="input-group input-group-sm">
                        <input type="date" name="startDate" class="form-control" value="${param.startDate}">
                        <div class="input-group-append">
                          <span class="input-group-text py-0">to</span>
                        </div>
                        <input type="date" name="endDate" class="form-control" value="${param.endDate}">
                      </div>
                    </div>
                  
                    <!-- Completion Percentage -->
                    <div class="col-12 col-md-3 mb-2">
                      <label class="mb-1 font-weight-bold">Completion Percentage</label>
                      
                      <select name="percentage" id="percentageDropdown" class="form-control form-control-sm">

                        <option value="-1">All Percentages</option>
                        <option value="30" ${percentage.percentage == '30' ? 'selected' : ''}>30%</option>
                        <option value="50" ${percentage.percentage == '50' ? 'selected' : ''}>50%</option>
                        <option value="75" ${percentage.percentage == '75' ? 'selected' : ''}>75%</option>
                        <option value="100" ${percentage.percentage == '100' ? 'selected' : ''}>100%</option>
                      </select>
                    </div>
                    
                    <!-- Buttons -->
                    <div class="col-md-3 mb-2 d-flex"> <button type="submit" class="btn bg-1 flex-fill mr-2">Search</button> 
                      <button type="submit" onclick="resetFilters()" class="btn bg-3 flex-fill">Clear</button> </div>
                    
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
      </section></c:if>
        <!-- ==================== REPORT TABLE ==================== -->
        <section class="content mt-3">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="card shadow-sm">
                            <div class="card-body">

                              <div class="table-responsive table-responsive-md" style="overflow-x: auto; max-width: 100%;">
                <table id="misReportTable" class="table table-bordered dataTable anand-table-font-size dtr-inline">

                                            <thead class="bg-1 text-white">
  <tr>
    <th>Program</th>
    <th>Employee Name</th>
    <th>Company</th>
    <c:forEach var="i" begin="0" end="${maxSessions - 1}">
      <th>Coaching Session - ${i + 1}</th>
    </c:forEach>
    <th>YTM</th>
    <th>% Completion</th>
  </tr>
</thead>

<tbody>
  <c:forEach var="coacheeName" items="${coacheeSessions.keySet()}">
    <tr>
      <td>${programMap[coacheeName]}</td>
      <td>${coacheeName}</td>
      <td>${companyMap[coacheeName]}</td>
      <c:forEach var="i" begin="0" end="${maxSessions - 1}">
        <td>
          <c:choose>
            <c:when test="${i < fn:length(coacheeSessions[coacheeName])}">
              ${coacheeSessions[coacheeName][i]}
            </c:when>
            <c:otherwise>-</c:otherwise>
          </c:choose>
        </td>
      </c:forEach>
      <td>${not empty actualMap[coacheeName] ? actualMap[coacheeName] : '-'}</td>
      <td>
        <c:choose>
          <c:when test="${not empty percentMap[coacheeName]}">
            <c:set var="percentage" value="${fn:substringBefore(percentMap[coacheeName], '.')}" />
            <c:choose>
              <c:when test="${percentage le 50}">
                <span class="badge bg-danger">${percentage}%</span>
              </c:when>
              <c:when test="${percentage gt 50 && percentage le 75}">
                <span class="badge bg-warning text-dark">${percentage}%</span>
              </c:when>
              <c:otherwise>
                <span class="badge bg-success">${percentage}%</span>
              </c:otherwise>
            </c:choose>
          </c:when>
          <c:otherwise>-</c:otherwise>
        </c:choose>
      </td>
    </tr>
  </c:forEach>
</tbody>
        
                                       
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>

<!-- ✅ Core libraries first -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- ✅ Then DataTables, DatePicker, Charts -->
<%@ include file="../includeJSP/dataTablesImport.jsp" %>
<%@ include file="../includeJSP/datePickerJs.jsp" %>
<%@include file="../includeJSP/footer.jsp" %>
<script src="usedStaticFiles/essentials/js/charts/Chart.min.js"></script>
<script src="usedStaticFiles/essentials/js/jquery-knob/jquery.knob.min.js"></script>

<!-- ✅ Finally your custom JS -->
<script src="usedStaticFiles/essentials/js/jsp_js_files/emc/mis-report.js"></script>

<script>
  const contextPath = '${pageContext.request.contextPath}';
</script>



</body>


</html>

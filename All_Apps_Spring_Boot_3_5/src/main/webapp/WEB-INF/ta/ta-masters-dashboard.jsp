<!DOCTYPE html>
<html lang="en">
  <head>
    <title>TA MASTERS DASHBOARD | TOOL APPROVAL<%@include file="../includeJSP/company_name_title.jsp"%></title>
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
              <div class="col-sm-6">
                <h5 class="font-1 font-weight-bold">TA MASTERS DASHBOARD</h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item"><a href="dashboard" title="Dashboard"><strong>Dashboard</strong></a></li>
                  <li class="breadcrumb-item"><a href="dashboard-tool-approval" title="TA Dashboard"><strong>TA Dashboard</strong></a></li>
                  <li class="breadcrumb-item active"><strong>TA Masters</strong></li>
                </ol>
              </div>
            </div>
          </div>
        </section>
        <c:if test="${not empty regMsg }">
          <section class="content content-margin">
            <div class="container-fluid">
              <div class="alert ${css } alert-dismissible">
                <button type="button" title="CLose Alert Box" class="close" data-dismiss="alert" aria-hidden="true"><i class="fas fa-times"></i></button>
                <c:if test="${css eq 'sequence-bg-1'}">
                  <h5><i class="icon fas fa-ban"></i>${regMsg }</h5>
                </c:if>
                <c:if test="${css ne 'sequence-bg-1'}">
                  <h5><i class="icon fas fa-check"></i>${regMsg }</h5>
                </c:if>
              </div>
            </div>
          </section>
        </c:if>
        <section class="content content-margin">
          <div class="container-fluid">
            <div class="row">
              <div class="col-sm-6 col-lg-4 col-md-3">
                <div class="card card-widget widget-user-2 shadow">
                  <div class="widget-user-header bg-1" title="Business Unit Master" onclick="location.href='ta-business-unit';" style="cursor: pointer;">
                    <h4 class="font-weight-bold"><i class="fas fa-sitemap"></i>&emsp;Business Unit</h4>
                  </div>
                  <div class="card-footer p-0">
                    <ul class="nav flex-column">
                      <li class="nav-item nav-link font-weight-bold font-1" title="Load All Recovery Type" style="cursor: pointer;" onclick="location.href='ta-business-unit?all=1';">
                        Total Business Units<span class="float-right">${buActive + buInactive}</span>
                      </li>
                      <li class="nav-item nav-link sequence-font-5 font-weight-bold">Active
                        <span class="float-right font-weight-bold">${buActive}</span>
                      </li>
                      <li class="nav-item nav-link sequence-font-1 font-weight-bold">In Active
                        <span class="float-right font-weight-bold">${buInactive}</span>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
              <div class="col-sm-6 col-lg-4 col-md-3">
                <div class="card card-widget widget-user-2 shadow">
                  <div class="widget-user-header bg-2" title="Recovery Type Master" onclick="location.href='ta-recovery-type';" style="cursor: pointer;">
                    <h4 class="font-weight-bold"><i class="fas fa-exchange-alt"></i>&emsp;Recovery Type</h4>
                  </div>
                  <div class="card-footer p-0">
                    <ul class="nav flex-column">
                      <li class="nav-item nav-link font-weight-bold font-1" title="Load All Recovery Type" style="cursor: pointer;" onclick="location.href='ta-recovery-type?all=1';">
                        Total Recovery Types<span class="float-right">${rtActive + rtInactive}</span>
                      </li>
                      <li class="nav-item nav-link sequence-font-5 font-weight-bold">Active
                        <span class="float-right font-weight-bold">${rtActive}</span>
                      </li>
                      <li class="nav-item nav-link sequence-font-1 font-weight-bold">In-Active
                        <span class="float-right font-weight-bold">${rtInactive}</span>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
              <div class="col-sm-6 col-lg-4 col-md-3">
                <div class="card card-widget widget-user-2 shadow">
                  <div class="widget-user-header bg-3" title="Status Master" onclick="location.href='ta-status';" style="cursor: pointer;">
                    <h4 class="font-weight-bold"><i class="fas fa-check-circle"></i>&emsp;Status</h4>
                  </div>
                  <div class="card-footer p-0">
                    <ul class="nav flex-column">
                      <li class="nav-item nav-link font-weight-bold font-1" title="Load All Status" style="cursor: pointer;" onclick="location.href='ta-status?all=1';">
                      Total Statuses<span class="float-right">${statusActive + statusInactive}</span>
                      </li>
                      <li class="nav-item nav-link sequence-font-5 font-weight-bold">Active
                        <span class="float-right font-weight-bold">${statusActive}</span>
                      </li>
                      <li class="nav-item nav-link sequence-font-1 font-weight-bold">In-Active
                        <span class="float-right font-weight-bold">${statusInactive}</span>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
              <div class="col-sm-6 col-lg-4 col-md-3">
                <div class="card card-widget widget-user-2 shadow">
                  <div class="widget-user-header bg-1" title="Approval Matrix" onclick="location.href='ta-approval-matrix';" style="cursor: pointer;">
                    <h4 class="font-weight-bold"><i class="fas fa-th-list"></i>&emsp;Approval Matrix</h4>
                  </div>
                  <div class="card-footer p-0">
                    <ul class="nav flex-column">
                      <li class="nav-item nav-link font-weight-bold font-1" title="Load All Status" style="cursor: pointer;" onclick="location.href='ta-approval-matrix?all=1';">
                        Total Approval Matrix<span class="float-right">${matrixActive + matrixInactive}</span>
                      </li>
                      <li class="nav-item nav-link sequence-font-5 font-weight-bold">Active
                        <span class="float-right font-weight-bold">${matrixActive}</span>
                      </li>
                      <li class="nav-item nav-link sequence-font-1 font-weight-bold">In-Active
                        <span class="float-right font-weight-bold">${matrixInactive}</span>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
      </div>
      <%@include file="includeJSP/footer.jsp"%>
    </div>
    <%@include file="../includeJSP/jsFiles.jsp"%>
  </body>
</html>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>DASHBOARD TOOL APPROVAL<%@include file="../includeJSP/company_name_title.jsp"%></title>
    <%@include file="../includeJSP/cssFiles.jsp"%>
  </head>
  <body class="sidebar-mini layout-navbar-fixed sidebar-collapse">
    <div class="wrapper">
      <%@include file="includeJSP/header.jsp"%>
      <%@include file="includeJSP/leftSideBar.jsp"%>
      <div class="content-wrapper">
        <section class="content-header">
          <div class="container-fluid">
            <div class="row mb-2">
              <div class="col-sm-6">
                <h5 class="font-1 font-weight-bold">DASHBOARD TOOL APPROVAL</h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item"><a href="dashboard" title="Dashboard"><strong>Dashboard</strong></a></li>
                  <li class="breadcrumb-item active"><strong>TA Dashboard</strong></li>
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
              <div class="col-md-12">
                <div class="card card-primary collapsed-card mb-3">
                  <div class="card-header bg-1" data-card-widget="collapse">
                    <h5 class="card-title font-weight-bold"><i class="fas fa-filter"></i>&ensp;Filters</h5>
                    <div class="card-tools">
                      <button type="button" class="btn btn-tool" data-card-widget="collapse">
                        <i class="fas fa-plus text-white font-weight-bold"></i>
                      </button>
                    </div>
                  </div>
                  <div class="card-body p-3">
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-md-3 col-sm-6 col-12">
                <div class="info-box">
                  <span class="info-box-icon bg-3"><i class="fas fa-list"></i></span>
                  <div class="info-box-content">
                    <span class="info-box-text">Total Requests</span>
                    <span class="info-box-number">1,410</span>
                  </div>
                </div>
              </div>
              <div class="col-md-3 col-sm-6 col-12">
                <div class="info-box">
                  <span class="info-box-icon sequence-bg-3"><i class="fas fa-spinner"></i></span>
                  <div class="info-box-content">
                    <span class="info-box-text">Pending Requests</span>
                    <span class="info-box-number">1,410</span>
                  </div>
                </div>
              </div>
              <div class="col-md-3 col-sm-6 col-12">
                <div class="info-box">
                  <span class="info-box-icon sequence-bg-1"><i class="fas fa-thumbs-down"></i></i></span>
                  <div class="info-box-content">
                    <span class="info-box-text">Rejected Requests</span>
                    <span class="info-box-number">1,410</span>
                  </div>
                </div>
              </div>
              <div class="col-md-3 col-sm-6 col-12">
                <div class="info-box">
                  <span class="info-box-icon sequence-bg-5"><i class="fas fa-thumbs-up"></i></span>
                  <div class="info-box-content">
                    <span class="info-box-text">Approved Requests</span>
                    <span class="info-box-number">1,410</span>
                  </div>
                </div>
              </div>
              <!-- <div class="col-sm-12 col-md-4 col-lg-3" title="">
                <div class="small-box bg-3">
                  <div class="inner">
                    <h4 class="font-weight-bold">Total Requests</h4>
                    <p class="" style="font-size:15px">1256</p>
                  </div>
                  <div class="icon text-white">
                    <i class="fas fa-list" style="font-size:50px"></i>
                  </div>
                </div>
              </div>
              <div class="col-sm-12 col-md-4 col-lg-3" title="">
                <div class="small-box sequence-bg-3">
                  <div class="inner">
                    <h4 class="font-weight-bold">Pending Requests</h4>
                    <p class="" style="font-size:15px">1256</p>
                  </div>
                  <div class="icon text-white">
                    <i class="fas fa-spinner" style="font-size:50px"></i>
                  </div>
                </div>
              </div>
              <div class="col-sm-12 col-md-4 col-lg-3" title="">
                <div class="small-box sequence-bg-1">
                  <div class="inner">
                    <h4 class="font-weight-bold">Rejected Requests</h4>
                    <p class="" style="font-size:15px">1256</p>
                  </div>
                  <div class="icon text-white">
                    <i class="fas fa-thumbs-down" style="font-size:50px"></i>
                  </div>
                </div>
              </div>
              <div class="col-sm-12 col-md-4 col-lg-3" title="">
                <div class="small-box sequence-bg-5">
                  <div class="inner">
                    <h4 class="font-weight-bold">Approved Requests</h4>
                    <p class="" style="font-size:15px">1256</p>
                  </div>
                  <div class="icon text-white">
                    <i class="fas fa-thumbs-up" style="font-size:50px"></i>
                  </div>
                </div>
              </div> -->
            </div>
            <div class="card">
              <div class="card-header bg-3">
                <h5 class="card-title font-weight-bold">Location Wise-Statistics</h5>
              </div>
              <div class="card-body">
                <div class="row">
                  <div class="col-md-12 tableOverFlowDiv">
                    <table class="table table-bordered table-striped dataTable" id="locationWiseStatistics">
                      <thead>
                        <tr class="bg-table-head">
                          <th>Location</th>
                          <th>Total Requests</th>
                          <th>Open Requests</th>
                          <th>Rejected Requests</th>
                          <th>Approved Requests</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td>Chakan - GIL Plant</td>
                          <td>2</td>
                          <td>3</td>
                          <td>2</td>
                          <td>5</td>
                        </tr>
                        <tr>
                          <td>Sanand - GIL Plant</td>
                          <td>2</td>
                          <td>3</td>
                          <td>2</td>
                          <td>5</td>
                        </tr>
                        <tr>
                          <td>Hosur - GIL Plant</td>
                          <td>2</td>
                          <td>3</td>
                          <td>2</td>
                          <td>5</td>
                        </tr>
                        <tr>
                          <td>Khandsa - GIL Plant</td>
                          <td>2</td>
                          <td>3</td>
                          <td>2</td>
                          <td>5</td>
                        </tr>
                        <tr>
                          <td>Dewas - GIL Plant</td>
                          <td>2</td>
                          <td>3</td>
                          <td>2</td>
                          <td>5</td>
                        </tr>
                        <tr>
                          <td>Parwanoo - GIL Plant</td>
                          <td>2</td>
                          <td>3</td>
                          <td>2</td>
                          <td>5</td>
                        </tr>
                      </tbody>
                      <tfoot>
                        <tr class="bg-table-foot">
                          <th>Location</th>
                          <th>Total Requests</th>
                          <th>Open Requests</th>
                          <th>Rejected Requests</th>
                          <th>Approved Requests</th>
                        </tr>
                      </tfoot>
                    </table>
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
    <%@include file="../includeJSP/dataTablesImport.jsp"%>
    <script src="usedStaticFiles/essentials/js/jsp_js_files/ta/dashboard-tool-approval.js"></script>
  </body>
</html>

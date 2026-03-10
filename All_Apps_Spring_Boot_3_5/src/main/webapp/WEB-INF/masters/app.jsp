<!-- ****************************************************************************************
# *******************************************************************************************
# Copyright © 2021 Anand Group India. All rights reserved.									*
# No part of this product may be reproduced in any form by any means without prior			*
# written authorization of Anand Automotive Private Limited and its licensors, if any.		*
# *******************************************************************************************
# Author - Sheshadhri Iyer																	*
# *************************************************************************************** -->
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>APP<%@include file="../includeJSP/company_name_title.jsp"%></title>
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
                <h5 class="font-3 font-weight-bold">APP LIST</h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item font-1"><a href="dashboard" title="Dashboard">Dashboard</a></li>
                  <li class="breadcrumb-item font-1"><a href="master" title="Masters Dashboard">Masters</a></li>
                  <li class="breadcrumb-item font-3 active">App</li>
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
		        <form modelAttribute="app" action="app" id="app" method="post">
		        <div class="card collapsed-card">
		          <div class="card-header bg-1" data-card-widget="collapse">
		            <h5 class="card-title font-weight-bold">Add App</h5>
		            <div class="card-tools">
		              <button type="button" class="btn btn-tool text-white" data-card-widget="collapse">
		                <i class="fas fa-plus"></i>
		              </button>
		              <input type="hidden" value="${openAddModal }" id="openAddModel" />
		              <input type="hidden" value="${openEditModel }" id="openEditModel" />
		            </div>
		          </div>
		          <div class="card-body" style="display: none;">
		            <div class="row">
		              <div class="col-md-4">
		                <div class="form-group">
		                  <label class="font-1" for="appName"><span class="mandatory">*</span>App Name</label>
		                  <input type="text" class="form-control" id="appName" placeholder="Enter App Name" name="appName" />
		                  <span class="error invalid-feedback" id="appNameError"></span>
		                </div>
		              </div>
		              <div class="col-md-2">
		                <div class="form-group">
		                  <label class="font-2" for="appLink"><span class="mandatory">*</span>App Link</label>
		                  <input type="text" class="form-control" id="appLink" placeholder="Enter App Link" name="appLink" />
		                  <span class="error invalid-feedback" id="appLinkError"></span>
		                </div>
		              </div>
		              <div class="col-md-6">
		                <div class="form-group">
		                  <label class="font-3" for="appDescription"><span class="mandatory">*</span>App Description</label>
		                  <input type="text" class="form-control" id="appDescription" placeholder="Enter App Description" name="appDescription" />
		                  <span class="error invalid-feedback" id="appDescriptionError"></span>
		                </div>
		              </div>
		              <div class="col-md-8">
		                <div class="form-group">
		                  <label class="font-1" for="appDescription2"><span class="mandatory">*</span>App Description2</label>
		                  <input type="text" class="form-control" id="appDescription2" placeholder="Enter App Description2" name="appDescription2" />
		                  <span class="error invalid-feedback" id="appDescription2Error"></span>
		                </div>
		              </div>
		              <div class="col-md-2">
		                <div class="form-check" id="isActiveDiv">
		                  <label class="font-2"><span class="mandatory">*</span>App Active/InActive</label>
		                  <div class="custom-control custom-radio">
		                    <input type="radio" name="appActive" class="custom-control-input" value="1" id="appActive1" name="appActive" />
		                    <label for="appActive1" class="custom-control-label sequence-font-5">Active</label>
		                  </div>
		                  <div class="custom-control custom-radio">
		                    <input type="radio" name="appActive" class="custom-control-input" value="0" id="appActive2" name="appActive" />
		                    <label for="appActive2" class="custom-control-label sequence-font-1">Inactive</label>
		                  </div>
		                  <span class="error invalid-feedback" id="isActiveError" style="display:block" ></span> 
		                </div>
		              </div>
		              <div class="col-md-2">
		                <div class="form-check">
		                  <br>
		                  <button style="float: left;" title="Add App" type="submit" id="submitAppButton" class="btn bg-1">Submit</button>
		                </div>
		              </div>
		            </div>
		          </div>
		        </div>
		        </form>
		      </div>
		    </div>
		    <div class="row">
		      <div class="col-md-12">
		        <div class="card card-secondary">
		          <div class="card-header bg-3">
		            <h5 class="card-title font-weight-bold">List of Apps</h5>
		          </div>
		          <div class="card-body">
		            <div class="row">
		              <div class="col-md-12 tableOverFlowDiv">
		                <table class="table table-bordered table-striped dataTable" id="appTable">
		                  <thead>
		                    <tr class="bg-table-head">
		                      <th>Action</th>
		                      <th>Name</th>
		                      <th>Description</th>
		                      <th>Description 2</th>
		                      <th>Active/In-Active</th>
		                      <th>Created By</th>
		                      <th>Created On</th>
		                      <th>Updated By</th>
		                      <th>Updated On</th>
		                    </tr>
		                  </thead>
		                  <tbody>
		                    <c:forEach items="${appList }" var="app" varStatus="appLoop">
		                      <tr class="bg-table-row-${appLoop.index %2 }">
		                        <td>${app.actionForList }</td>
		                        <td>${app.appName }</td>
		                        <td>${app.appDescription }</td>
		                        <td>${app.appDescription2 }</td>
		                        <td>
		                          <c:choose>
		                            <c:when test="${app.appActive eq 1 }"><span class="badge sequence-bg-5">Active</span></c:when>
		                            <c:otherwise><span class="badge sequence-bg-1">In-Active</span></c:otherwise>
		                          </c:choose>
		                        </td>
		                        <td>${app.appCreatedBy.userFirstName } ${app.appCreatedBy.userLastName }</td>
		                        <td><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${app.appCreatedOn }" /></td>
		                        <td>${app.appUpdatedBy.userFirstName } ${app.appUpdatedBy.userLastName }</td>
		                        <td><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${app.appUpdatedOn }" /></td>
		                      </tr>
		                    </c:forEach>
		                  </tbody>
		                  <tfoot>
		                    <tr class="bg-table-foot">
		                      <th>Action</th>
		                      <th>Name</th>
		                      <th>Description</th>
		                      <th>Description 2</th>
		                      <th>Active/In-Active</th>
		                      <th>Created By</th>
		                      <th>Created On</th>
		                      <th>Updated By</th>
		                      <th>Updated On</th>
		                    </tr>
		                  </tfoot>
		                </table>
		              </div>
		            </div>
		          </div>
		        </div>
		      </div>
		    </div>
		  </div>
		</section>
		<div class="modal fade" id="editAppModal">
		  <div class="modal-dialog modal-lg">
		    <div class="modal-content">
		      <form modelAttribute="app" action="app" id="appEdit" method="post">
		      <input type="hidden" name="mAppId" id="mAppId" />
		      <div class="modal-header bg-3">
		        <h4 class="modal-title font-weight-bold">Edit App</h4>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	              <span aria-hidden="true"><i class="text-white font-weight-bold fas fa-times"></i></span>
	            </button>
		      </div>
		      <div class="modal-body">
		        <div class="row">
		          <c:if test="${not empty regMsgEdit }">
		            <div class="col-md-12">
		              <div class="alert bg-${cssEdit } alert-dismissible">
		                <button type="button" title="CLose Alert Box" class="close" data-dismiss="alert" aria-hidden="true"><i class="fas fa-times"></i></button>
		                <c:if test="${css eq 'sequence-bg-1'}">
		                  <h5><i class="icon fas fa-ban"></i>${regMsgEdit }</h5>
		                </c:if>
		                <c:if test="${css ne 'sequence-bg-1'}">
		                  <h5><i class="icon fas fa-check"></i>${regMsgEdit }</h5>
		                </c:if>
		              </div>
		            </div>
		          </c:if>
		          <div class="col-md-12">
		            <div class="card-body">
		              <div class="row">
		                <div class="col-md-3">
		                  <div class="form-group">
		                    <label class="font-1" for="appNameEdit"><span class="mandatory">*</span>App Name</label>
		                    <input type="text" class="form-control" id="appNameEdit" placeholder="Enter App Name" name="appName" />
		                    <span class="error invalid-feedback" id="appNameErrorEdit"></span>
		                  </div>
		                </div>
		                <div class="col-md-3">
		                  <div class="form-group">
		                    <label class="font-2" for="appLinkEdit"><span class="mandatory">*</span>App Link</label>
		                    <input type="text" class="form-control" id="appLinkEdit" placeholder="Enter App Link" name="appLink" />
		                    <span class="error invalid-feedback" id="appLinkErrorEdit"></span>
		                  </div>
		                </div>
		                <div class="col-md-6">
		                  <div class="form-check" id="isActiveEditDiv">
		                    <label class="font-3"><span class="mandatory">*</span>App Active/InActive</label>
		                    <div class="custom-control custom-radio">
		                      <input type="radio" name="appActive" class="custom-control-input" value="1" id="appActiveEdit1" name="appActive" />
		                      <label for="appActiveEdit1" class="custom-control-label sequence-font-5">Active</label>
		                    </div>
		                    <div class="custom-control custom-radio">
		                      <input type="radio" name="appActive" class="custom-control-input" value="0" id="appActiveEdit2" name="appActive" />
		                      <label for="appActiveEdit2" class="custom-control-label sequence-font-1">Inactive</label>
		                    </div>
		                    <span class="error invalid-feedback" id="isActiveEditError" style="display:block" ></span> 
		                  </div>
		                </div>
		                <div class="col-md-6">
		                  <div class="form-group">
		                    <label class="font-1" for="appDescriptionEdit"><span class="mandatory">*</span>App Description 1</label>
		                    <%-- <textarea name="appDescription" id="appDescriptionEdit" class="form-control" rows="4" cols="200" /> --%>
		                    <input type="text" class="form-control" id="appDescriptionEdit" placeholder="Enter App Description" name="appDescription" />
		                    <span class="error invalid-feedback" id="appDescriptionErrorEdit"></span>
		                  </div>
		                </div>
		                <div class="col-md-6">
		                  <div class="form-group">
		                    <label class="font-3" for="appDescriptionEdit"><span class="mandatory">*</span>App Description 2</label>
		                    <%-- <textarea name="appDescription" id="appDescriptionEdit" class="form-control" rows="4" cols="200" /> --%>
		                    <input type="text" class="form-control" id="appDescription2Edit" placeholder="Enter App Description" name="appDescription2" />
		                    <span class="error invalid-feedback" id="appDescriptionError2Edit"></span>
		                  </div>
		                </div>
		              </div>
		            </div>
		          </div>
		        </div>
		      </div>
		      <div class="modal-footer justify-content-between">
		        <button title="Close" id="closeEditAppModal" type="button" class="btn sequence-bg-1" data-dismiss="modal">Close</button>
		        <button type="submit" id="saveAppChanges" class="btn bg-1" title="Edit App Details">Edit App Details</button>
		      </div>
		      </form>
		    </div>
		  </div>
		</div>
      </div>
      <%@include file="../includeJSP/footer.jsp"%>
    </div>
    <%@include file="../includeJSP/jsFiles.jsp"%>
    <%@include file="../includeJSP/dataTablesImport.jsp"%>
    <script src="usedStaticFiles/essentials/js/jsp_js_files/masters/app.js"></script>
  </body>
</html>
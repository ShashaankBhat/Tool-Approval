<!-- ****************************************************************************************
# *******************************************************************************************
# Copyright © 2021 Anand Group India. All rights reserved.									*
# No part of this product may be reproduced in any form by any means without prior			*
# written authorization of Anand Automotive Private Limited and its licensors, if any.		*
# *******************************************************************************************
# Author - Sheshadhri Iyer																	*
# *************************************************************************************** -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>COACHING BATCH DETAILS | ACT<%@include file="../../includeJSP/company_name_title.jsp"%></title>
    <%@include file="../../includeJSP/cssFiles.jsp"%>
    <%@include file="../../includeJSP/datePickerCss.jsp"%>
  </head>
  <body class="sidebar-mini layout-navbar-fixed sidebar-collapse pace-primary">
    <div class="wrapper">
      <%@include file="../includeJSP/header.jsp"%>
      <%@include file="../includeJSP/leftSideBar.jsp"%>
      <div class="content-wrapper">
        
        <section class="content-header">
          <div class="container-fluid">
            <div class="row mb-2">
              <div class="col-sm-6">
                <h5 class="font-3 font-weight-bold">COACHING BATCH DETAILS</h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item"><a href="dashboard-act" title="Dashboard"><strong>Dashboard</strong></a></li>
                  <li class="breadcrumb-item active"><strong>Coaching Batch Details</strong></li>
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
		        <div class="card card-secondary card-outline bg-card-primary-anand">
		          <div class="card-header bg-3">
		            <h5 class="card-title font-weight-bold">List of all Coaching Batches &amp; Details</h5>
		          </div>
		          <div class="card-body">
		            <div class="row">
		              <div class="col-md-12">
		                <table class="table table-bordered dataTable anand-table-font-size" id="batchTable">
		                  <thead>
		                    <tr class="bg-table-head">
		                      <th>Action</th>
		                      <th>Batch Name</th>
		                      <th>Batch Description</th>
		                      <th>Start Date</th>
		                      <th>End Date</th>
		                      <c:if test="${itAdmin eq 1 || ctAdmin eq 1 }">
		                        <th>Total Participants</th>
		                        <th>ANAND Leader</th>
		                        <th>ANAND Talent</th>
		                        <th>ANAND Mentee</th>
		                      </c:if>
		                    </tr>
		                  </thead>
		                  <tbody>
		                    <c:forEach items="${batchList }" var="batch" varStatus="batchLoop">
		                      <tr class="bg-table-row-${batchLoop.index %2 }">
		                        <td>${batch.actionForList }
									<!-- <a title="Download Report" href="javascript:void(0);"
   onclick="openDownloadModal('${batch.actCoachingBatchId}', '${coachCoacheeMap.coacheeUserId.mUserId}')">
   <i class="fas fa-download"></i>
</a> -->

<!-- 
<a title="Download Report"
   href="javascript:void(0);"
   onclick="downloadReport(${batch.actCoachingBatchId})">
   <i class="fas fa-download"></i>
</a> -->


								</td>
		                        <td>${batch.batchName }</td>
		                        <td>${batch.batchDescription }</td>
		                        <td><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${batch.batchStartDate }" /></td>
		                        <td><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${batch.batchEndDate }" /></td>
		                        <c:if test="${itAdmin eq 1 || ctAdmin eq 1 }">
		                          <td><span class="badge sequence-bg-5" style='font-size:18px'>${batch.totalParticipants }</span></td>
		                          <td><span class="badge bg-1" style='font-size:18px'>${batch.anandLeaderCount }</span></td>
		                          <td><span class="badge bg-2" style='font-size:18px'>${batch.anandTalentCount }</span></td>
		                          <td><span class="badge bg-3" style='font-size:18px'>${batch.anandMenteeCount }</span></td>
		                        </c:if>
		                      </tr>
		                    </c:forEach>
		                  </tbody>
		                  <tfoot>
		                    <tr class="bg-table-foot">
		                      <th>Action</th>
		                      <th>Batch Name</th>
		                      <th>Batch Description</th>
		                      <th>Start Date</th>
		                      <th>End Date</th>
		                      <c:if test="${itAdmin eq 1 }">
		                        <th>Total Participants</th>
		                        <th>ANAND Leader</th>
		                        <th>ANAND Talent</th>
		                        <th>ANAND Mentee</th>
		                      </c:if>
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
		
		<div class="modal fade" id="batchInfoModal">
		  <div class="modal-dialog modal-xl">
		    <div class="modal-content">
		      <div class="modal-header bg-secondary">
		        <h4 class="modal-title">ALDP Batch Information</h4>
		      </div>
		      <div class="modal-body">
		        <div class="row">
		          <div class="col-md-12">
		            <div class="card-body">
		              <div class="row">
		                <div class="col-md-4">
		                  <div class="form-group">
		                    <label for="batchNameInfo">Batch Name</label>
		                    <p id="batchNameInfo"></p>
		                  </div>
		                </div>
		                <div class="col-md-8">
		                  <div class="form-group">
		                    <label for="batchDescriptionInfo">Batch Description</label>
		                    <p id="batchDescriptionInfo"></p>
		                  </div>
		                </div>
		                <div class="col-md-4">
		                  <div class="form-group">
		                    <label for="batchStartDateInfo">Batch Start Date</label>
		                    <p id="batchStartDateInfo"></p>
		                  </div>
		                </div>
		                <div class="col-md-4">
		                  <div class="form-group">
		                    <label for="batchEndDateInfo">Batch End Date</label>
		                    <p id="batchEndDateInfo"></p>
		                  </div>
		                </div>
		                <div class="col-md-4">
		                  <div class="form-group">
		                    <label for="batchActiveInfo">Batch Active/In-Active</label>
		                    <p id="batchActiveInfo"></p>
		                  </div>
		                </div>
		                <div class="col-md-12">
		                  <table class="table table-striped anand-table-font-size" id="coachCoacheeTableInfo">
		                    <thead class="bg-table-head">
		                      <tr>
		                        <th>Coach</th>
		                        <th>Coachee</th>
		                        <th>ALDP Program</th>
		                        <th>Supervisor</th>
		                      </tr>
		                    </thead>
		                    <tbody>
		                    </tbody>
		                  </table>
		                </div>
		              </div>
		            </div>
		          </div>
		        </div>
		      </div>
		      <div class="modal-footer justify-content-between">
		        <button onclick="" id="closeEditRoleModal" type="button" class="btn sequence-bg-1" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		  </div>
		</div>
		
		
		
      </div>


	  
      <%@include file="../includeJSP/footer.jsp"%>
    </div>
    <%@include file="../../includeJSP/jsFiles.jsp"%>
    <%@include file="../../includeJSP/dataTablesImport.jsp"%>
    <%@include file="../../includeJSP/datePickerJs.jsp"%>
	<!-- <script> -->
// function downloadReport(batchId) {
// 	console.log("batchId"+batchId);
//     window.open('coaching-download-report?batchId=' + batchId, '_blank');
// }

<script>
function downloadReport(batchId) {
    window.open('coaching-download-report?batchId=' + batchId, '_blank');
}
</script>


</script>
    <script src="usedStaticFiles/essentials/js/jsp_js_files/aldp/coachingBatchDetails/coachingBatchDetails.js"></script>
  </body>
</html>
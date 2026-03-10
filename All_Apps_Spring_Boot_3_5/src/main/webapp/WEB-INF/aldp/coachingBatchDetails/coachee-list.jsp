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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>COACHEE LIST | ACT<%@include file="../../includeJSP/company_name_title.jsp"%></title>
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
                <h5 class="font-3 font-weight-bold">Coachee List for batch - ${batchList[0].batchName }</h5>
                <input type="hidden" value="${batchList[0].batchName }" id="jsBatchName" />
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right font-weight-bold">
                  <li class="breadcrumb-item"><a href="dashboard-act" title="Dashboard">Dashboard</a></li>
                  <c:if test="${ctCoach eq 1 || ctAdmin eq 1 || itAdmin eq 1 }">
                    <li class="breadcrumb-item"><a href="coaching-batch-details" title="Dashboard">Coaching Batch</a></li>
                  </c:if>
                  <li class="breadcrumb-item active">Coachee List</li>
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
		        <div class="card card-outline bg-card-primary-anand">
		          <div class="card-header bg-3">
		            <h5 class="card-title font-weight-bold">List of all Coachee List for batch - ${batchList[0].batchName }</h5>
		          </div>
		          <div class="card-body">
		            <div class="row">
		              <div class="col-md-12">
		                <table class="table table-bordered dataTable anand-table-font-size" id="batchTable">
		                  <thead>
		                    <tr class="bg-table-head">
		                      <th>Action</th>
		                      <th>Coachee</th>
		                      <th>ALDP Program</th>
		                      <th>Coach</th>
		                      <th>Supervisor</th>
		                      <th>Start Date</th>
		                      <th>End Date</th>
		                    </tr>
		                  </thead>
		                  <tbody>
		                    <c:forEach items="${batchList }" var="batch" varStatus="batchLoop">
		                      <c:forEach items="${batch.coachCoacheeMappingSet }" var="coachCoacheeMap" varStatus="coachCoacheeMapLoop">
		                        <c:if test="${(itAdmin eq 1 || ctAdmin eq 1) ||  (coachCoacheeMap.actCoachCoacheeMapActive eq 1 && sessionUserInfo.mUserId eq coachCoacheeMap.coachUserId.mUserId) }">
		                          <tr class="bg-table-row-${coachCoacheeMapLoop.index %2 }">
		                            <td>
		                              <!-- <c:choose>
		                                <c:when test="${fn:contains(batch.actionForList, 'ADD') }">
		                                  <a title='Add Goals' href='coaching-goals?batch-id=${batch.actCoachingBatchId }&coachee-id=${coachCoacheeMap.coacheeUserId.mUserId }'><i class='fas fa-bullseye'></i></a>
		                                  &emsp;<a title='Submit Report' href='coaching-report?batch-id=${batch.actCoachingBatchId }&coachee-id=${coachCoacheeMap.coacheeUserId.mUserId }'><i class='fas fa-list'></i></a>
		                                </c:when>
		                                <c:otherwise>
		                                  ${batch.actionForList }
		                                </c:otherwise>
		                              </c:choose> -->
		                            <c:choose>
<c:when test="${fn:contains(batch.actionForList, 'ADD') }">
<a title='Add Goals' href='coaching-goals?batch-id=${batch.actCoachingBatchId }&coachee-id=${coachCoacheeMap.coacheeUserId.mUserId }'><i class='fas fa-bullseye'></i></a>
&emsp;<a title='Submit Report' href='coaching-report?batch-id=${batch.actCoachingBatchId }&coachee-id=${coachCoacheeMap.coacheeUserId.mUserId }'><i class='fas fa-list'></i></a>
&emsp;
<a target="_blank" title='Download Report' href='act-report?coach-coachee-mapping=${coachCoacheeMap.actCoachCoacheeMapId }'><i class='fas fa-download'></i></a>
</c:when>
<c:otherwise>
		                                  ${batch.actionForList }
</c:otherwise>
</c:choose>
									</td>
		                            <td>${coachCoacheeMap.coacheeUserId.userFirstName } ${coachCoacheeMap.coacheeUserId.userLastName }</td>
		                            <td>
		                              <c:choose>
		                                <c:when test="${coachCoacheeMap.actCoacheeProgram eq 1 }">
		                                  ANAND Mentee
		                                </c:when>
		                                <c:when test="${coachCoacheeMap.actCoacheeProgram eq 2 }">
		                                  ANAND Talent
		                                </c:when>
		                                <c:when test="${coachCoacheeMap.actCoacheeProgram eq 3 }">
		                                  ANAND Leader
		                                </c:when>
		                              </c:choose>
		                            </td>
		                            <td>${coachCoacheeMap.coachUserId.userFirstName } ${coachCoacheeMap.coachUserId.userLastName }</td>
		                            <td>${coachCoacheeMap.supervisorUserId.userFirstName } ${coachCoacheeMap.supervisorUserId.userLastName }</td>
		                            <td><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${batch.batchStartDate }" /></td>
		                            <td><fmt:formatDate pattern = "dd-MMM-yyyy" value = "${batch.batchEndDate }" /></td>
		                          </tr>
		                        </c:if>
		                      </c:forEach>
		                    </c:forEach>
		                  </tbody>
		                  <tfoot>
		                    <tr class="bg-table-foot">
		                      <th>Action</th>
		                      <th>Coachee</th>
		                      <th>ALDP Program</th>
		                      <th>Coach</th>
		                      <th>Supervisor</th>
		                      <th>Start Date</th>
		                      <th>End Date</th>
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
		        <button onclick="" id="closeEditRoleModal" type="button" class="btn bg-info-anand-danger" data-dismiss="modal">Close</button>
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
    <script src="usedStaticFiles/essentials/js/jsp_js_files/aldp/coachingBatchDetails/coachee-list.js"></script>
  </body>
</html>
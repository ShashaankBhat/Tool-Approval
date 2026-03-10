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
    <title>MENTEE LIST | EMC<%@include file="../../includeJSP/company_name_title.jsp"%></title>
    <%@include file="../../includeJSP/cssFiles.jsp"%>
    <%@include file="../../includeJSP/datePickerCss.jsp"%>
    <meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">

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
                <h5 class="font-3 font-weight-bold">Mentee List for batch - ${batchList[0].batchName }</h5>
                <input type="hidden" value="${batchList[0].batchName }" id="jsBatchName" />
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right font-weight-bold">
                  <li class="breadcrumb-item"><a href="dashboard-act" title="Dashboard">Dashboard</a></li>
                  <c:if test="${ctCoach eq 1 || ctAdmin eq 1 || itAdmin eq 1 }">
                    <li class="breadcrumb-item"><a href="emc-coaching-batch-details" title="Dashboard">Mentoring Batch</a></li>
                  </c:if>
                  <li class="breadcrumb-item active">Mentee List</li>
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
		            <h5 class="card-title font-weight-bold">Submit Feedback</h5>
		          </div>
		          <div class="card-body">
		            <div class="row">
		              <div class="col-md-12">
		                <table class="table table-bordered dataTable anand-table-font-size" id="batchTable">
		                  <thead>
		                    <tr class="bg-table-head">
		                      <th>Action</th>
		                      <th>Mentee</th>
		                    
		                      <th>Mentor</th>
							            <th>Program Category</th>
		                      <th>Supervisor</th>
		                      <th>Start Date</th>
		                      <th>End Date</th>
		                    </tr>
		                  </thead>
		                  <tbody>
		                    <c:forEach items="${batchList }" var="batch" varStatus="batchLoop">
		                      <c:forEach items="${batch.coachCoacheeMappingSet }" var="coachCoacheeMap" varStatus="coachCoacheeMapLoop">
		                     		        <c:if test="${(itAdmin eq 1 || emcAdmin eq 1) ||   (coachCoacheeMap.actCoachCoacheeMapActive eq 1 && sessionUserInfo.mUserId eq coachCoacheeMap.coachUserId.mUserId || sessionUserInfo.mUserId eq coachCoacheeMap.coacheeUserId.mUserId) }"> 
   
							  <tr class="bg-table-row-${coachCoacheeMapLoop.index %2 }">
		                         <td>

    <c:if test="${(coachCoacheeMap.actCoachCoacheeMapActive eq 1 && sessionUserInfo.mUserId eq coachCoacheeMap.coachUserId.mUserId || sessionUserInfo.mUserId eq coachCoacheeMap.coacheeUserId.mUserId) }"> 

  <button type="button"
        class="btn btn-link p-0 open-feedbackQuestionList-btn"
        data-mapping-id="${coachCoacheeMap.actCoachCoacheeMapId}"
        title="Give Feedback">
    <i class="fa fa-comment-dots text-primary" style="font-size: 18px;"></i>
</button>
</c:if>

<!-- ftafs<c:out value ="${coachCoacheeMap.actCoachCoacheeMapId}" /> -->

<c:set var="responseList" value="${feedbackSubmittedResponseMap[row.reportId + 0]}" />


<c:if test="${not empty responseList}">
    <button type="button"
            class="btn btn-link p-0 view-feedback-btn"
            data-mapping-id="${coachCoacheeMap.actCoachCoacheeMapId}"
            title="View Feedback">
        <i class="fa fa-eye text-bg1" style="font-size: 18px;"></i>
    </button>
</c:if>




</td>



		                            <td>${coachCoacheeMap.coacheeUserId.userFirstName } ${coachCoacheeMap.coacheeUserId.userLastName }</td>
		                           
		                            <td>${coachCoacheeMap.coachUserId.userFirstName } ${coachCoacheeMap.coachUserId.userLastName }</td>
									 <td>
		                              <c:choose>
		                                <c:when test="${coachCoacheeMap.actCoacheeProgram eq 1 }">
		                                 Senior Executive Coaching
		                                </c:when>
		                                <c:when test="${coachCoacheeMap.actCoacheeProgram eq 2 }">
		                                  Top Executive Mentee
		                                </c:when>
		                              
		                              </c:choose>
		                            </td>
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
		                      <th>Mentee</th>
		                      <!-- <th>ALDP Program</th> -->
		                      <th>Mentor</th>
							  <th>Program Category</th>
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
	
  <!-- <div class="modal fade" id="feedbackQuestionListModal" tabindex="-1" role="dialog" aria-labelledby="feedbackQuestionListModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title" id="feedbackQuestionListModalLabel">Feedback Form</h5>
        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <c:if	test="${emcMentor eq '1' and fn:contains(programCategory, '1') || emcAdmin eq 1}">
      <div class="modal-body" id="feedbackQuestionListModalBody">
      
      </div>
      </c:if>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div> -->




	<div class="modal fade" id="feedbackQuestionListModal" tabindex="-1" role="dialog" aria-labelledby="feedbackQuestionListModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header bg-1 text-white">
        <h5 class="modal-title" id="feedbackQuestionListModalLabel">Feedback Form</h5>
        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="feedbackQuestionListModalBody">
        <!-- AJAX Content will be injected here -->
      </div>
      <!-- <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div> -->
    </div>
  </div>
</div>


<!-- View Feedback Modal -->
<div class="modal fade" id="viewFeedbackModal" tabindex="-1" role="dialog" aria-labelledby="viewFeedbackModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header bg-1 text-white">
        <h5 class="modal-title" id="viewFeedbackModalLabel">View Feedback</h5>
        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="viewFeedbackModalBody">
        <!-- Content will be loaded here via AJAX -->
      </div>
      <div class="modal-footer">
        <button type="button" class="btn bg-2" data-dismiss="modal">Close</button>
      </div>
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
    <script src="usedStaticFiles/essentials/js/jsp_js_files/emc/coachingBatchDetails/feedback-list.js"></script>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".open-feedback-btn").forEach(function (button) {
      button.addEventListener("click", function () {
        const mappingId = this.getAttribute("data-mapping-id");
        // Redirect to a page that displays feedback for that mapping
        window.location.href = "/emc-feedback-response?mappingId=" + mappingId;
      });
    });
  });
</script>
<script>
 

  document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".open-feedback-btn").forEach(function (button) {
      button.addEventListener("click", function () {
        const mappingId = this.getAttribute("data-mapping-id");
        const feedbackSection = document.querySelector(`#feedback-${mappingId}`);
        let modalBody = document.getElementById("modalFeedbackBody");

        if (feedbackSection && feedbackSection.innerHTML.trim() !== "") {
          modalBody.innerHTML = feedbackSection.innerHTML;
        } else {
          modalBody.innerHTML = "<p>No feedback found for this session.</p>";
        }
      });
    });
  });
</script>







  </body>
</html>
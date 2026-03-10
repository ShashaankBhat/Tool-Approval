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
          <title>MENTEE LIST | EMC<%@include file="../../includeJSP/company_name_title.jsp" %>
          </title>
          <%@include file="../../includeJSP/cssFiles.jsp" %>
            <%@include file="../../includeJSP/datePickerCss.jsp" %>
        </head>

        <body class="sidebar-mini layout-navbar-fixed sidebar-collapse pace-primary">
          <div class="wrapper">
            <%@include file="../includeJSP/header.jsp" %>
              <%@include file="../includeJSP/leftSideBar.jsp" %>
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
                              <li class="breadcrumb-item"><a href="emc-coaching-batch-details"
                                  title="Dashboard">Mentoring Batch</a></li>
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
                          <button type="button" title="CLose Alert Box" class="close" data-dismiss="alert"
                            aria-hidden="true"><i class="fas fa-times"></i></button>
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
                              <h5 class="card-title font-weight-bold">List of all Mentee List for batch -
                                ${batchList[0].batchName }</h5>
                            </div>
                            <div class="card-body">
                              <div class="row">
                                <div class="col-md-12">
                                  <table class="table table-bordered dataTable anand-table-font-size" id="batchTable">
                                    <thead>
                                      <tr class="bg-table-head">
                                        <th>Action</th>
                                        <th>Mentee</th>
                                        <!-- <th>ALDP Program</th> -->
                                        <th>Mentor</th>
                                        <th>Supervisor</th>
                                        <th>Start Date</th>
                                        <th>End Date</th>
                                      </tr>
                                    </thead>
                                    <tbody>
                                      <c:forEach items="${batchList }" var="batch" varStatus="batchLoop">
                                        <c:forEach items="${batch.coachCoacheeMappingSet }" var="coachCoacheeMap"
                                          varStatus="coachCoacheeMapLoop">
                                          <c:if
                                            test="${(itAdmin eq 1 || emcAdmin eq 1) ||  (coachCoacheeMap.actCoachCoacheeMapActive eq 1 && sessionUserInfo.mUserId eq coachCoacheeMap.coachUserId.mUserId) }">
                                            <tr class="bg-table-row-${coachCoacheeMapLoop.index %2 }">
                                              <td>
                                                <c:choose>
                                                  <c:when test="${fn:contains(batch.actionForList, 'ADD') }">
                                                    <a title='Add Goals'
                                                      href='emc-coaching-goals?batch-id=${batch.actCoachingBatchId }&coachee-id=${coachCoacheeMap.coacheeUserId.mUserId }'><i
                                                        class='fas fa-bullseye'></i>&emsp;</a>
                                                    &emsp;<a title='Submit Report'
                                                      href='emc-coaching-report?batch-id=${batch.actCoachingBatchId }&coachee-id=${coachCoacheeMap.coacheeUserId.mUserId }'><i
                                                        class='fas fa-list'></i>&emsp;</a>

                                                    <c:if test="${itAdmin eq 1 || emcAdmin eq 1}">

                                                      <a title="Upload Document" href="javascript:void(0);"
                                                        onclick="openUploadModal('${batch.actCoachingBatchId}', '${coachCoacheeMap.coacheeUserId.mUserId}')">
                                                        <i class="fas fa-upload"></i>&emsp;
                                                      </a>

                                                      <a title="Download Document" href="javascript:void(0);"
   onclick="openDownloadModal('${batch.actCoachingBatchId}', '${coachCoacheeMap.coacheeUserId.mUserId}')">
   <i class="fas fa-download"></i>&emsp;
</a>


                                     



                                                      <!-- <a target="_blank" title='Download Report' href='act-report?coach-coachee-mapping=${coachCoacheeMap.actCoachCoacheeMapId }'><i class='fas fa-download'></i></a> -->

                                                    </c:if>


                                                  </c:when>

                                                  <c:otherwise>
                                                    ${batch.actionForList }
                                                  </c:otherwise>
                                                </c:choose>
                                              </td>
                                              <td>${coachCoacheeMap.coacheeUserId.userFirstName }
                                                ${coachCoacheeMap.coacheeUserId.userLastName }</td>

                                              <td>${coachCoacheeMap.coachUserId.userFirstName }
                                                ${coachCoacheeMap.coachUserId.userLastName }</td>
                                              <td>${coachCoacheeMap.supervisorUserId.userFirstName }
                                                ${coachCoacheeMap.supervisorUserId.userLastName }</td>
                                              <td>
                                                <fmt:formatDate pattern="dd-MMM-yyyy"
                                                  value="${batch.batchStartDate }" />
                                              </td>
                                              <td>
                                                <fmt:formatDate pattern="dd-MMM-yyyy" value="${batch.batchEndDate }" />
                                              </td>
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
                          <h4 class="modal-title">EMC Batch Information</h4>
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
                                          <th>Mentor</th>
                                          <th>Mentee</th>
                                          <!-- <th>ALDP Program</th> -->
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
                          <button onclick="" id="closeEditRoleModal" type="button" class="btn bg-info-anand-danger"
                            data-dismiss="modal">Close</button>
                        </div>
                      </div>
                    </div>
                  </div>


                  <!-- Upload Documents Modal -->
                  <div class="modal fade" id="uploadDocumentsModal" tabindex="-1"
                    aria-labelledby="uploadDocumentsModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg modal-dialog-centered">
                      <div class="modal-content shadow">
                        <div class="modal-header bg-1">
                          <h5 class="modal-title" id="uploadDocumentsModalLabel">Upload Documents</h5>
 <button type="button" class="btn text-white fs-4 close" data-dismiss="modal" aria-label="Close">
    &times;
  </button>                          <!-- <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                            aria-label="Close"></button> -->
                              <!-- <button type="button" class="btn text-white fs-4" data-bs-dismiss="modal" aria-label="Close" style="line-height: 1;">&times;</button> -->

                        </div>
                        <div class="modal-body bg-light">
                          <form id="uploadForm" method="post" enctype="multipart/form-data" action="upload">
                            <input type="hidden" name="batchId" id="modalBatchId" />
                            <input type="hidden" name="coacheeId" id="modalCoacheeId" />

                            <div class="mb-3">
                              <label for="remark" class="form-label fw-bold">Remark</label>
                              <textarea id="remark" name="remark" class="form-control" rows="3" required></textarea>
                            </div>

                            <div class="mb-3">
                              <label class="form-label fw-bold">Select Files (Max 5MB each)</label>
                              <div id="fileInputs">
                                <input type="file" name="files" class="form-control mb-2"
                                  accept=".pdf,.doc,.docx,.png,.jpg" required />
                              </div>
                              <button type="button" class="btn btn-outline-primary btn-sm" onclick="addMoreFiles()">+
                                Upload More Document</button>
                            </div>

                            <div class="text-end mt-3">
                              <button id="submit-btn" class="btn bg-1" type="submit">Upload</button>
                            </div>
                          </form>
                        </div>
                      </div>
                    </div>
                  </div>


                  <!-- Download Documents Modal -->
<div class="modal fade" id="downloadModal" tabindex="-1" aria-labelledby="downloadModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content shadow">
      <div class="modal-header bg-1 text-white">
        <h5 class="modal-title" id="downloadModalLabel">Download Documents</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"
          style="line-height: 1;">&times;</button>
      </div>
      <div class="modal-body bg-light">
        <ul id="fileList" class="list-group"></ul>
      </div>
    </div>
  </div>
</div>




                </div>
                <%@include file="../includeJSP/footer.jsp" %>
          </div>
          <%@include file="../../includeJSP/jsFiles.jsp" %>
            <%@include file="../../includeJSP/dataTablesImport.jsp" %>
              <%@include file="../../includeJSP/datePickerJs.jsp" %>
                <script
                  src="usedStaticFiles/essentials/js/jsp_js_files/emc/coachingBatchDetails/coachee-list.js"></script>

                <script>
                  function addMoreFiles() {
                    let wrapper = document.getElementById("fileInputs");
                    const fileInput = document.createElement("input");
                    fileInput.type = "file";
                    fileInput.name = "files";
                    fileInput.accept = ".pdf,.doc,.docx,.png,.jpg";
                    fileInput.className = "form-control mb-2";
                    wrapper.appendChild(fileInput);
                  }

                  function openUploadModal(batchId, coacheeId) {
                    document.getElementById('modalBatchId').value = batchId;
                    document.getElementById('modalCoacheeId').value = coacheeId;
                    var uploadModal = new bootstrap.Modal(document.getElementById('uploadDocumentsModal'));
                    uploadModal.show();
                  }

                  // Validate file size
                  document.getElementById('uploadForm').onsubmit = function (e) {
                    const files = document.querySelectorAll('input[type="file"]');
                    for (let fileInput of files) {
                      if (fileInput.files.length > 0 && fileInput.files[0].size > 5 * 1024 * 1024) {
                        alert('Each file must be less than 5MB.');
                        e.preventDefault();
                        return false;
                      }
                    }
                  };
                </script>

                <!-- <script>
                  function openDownloadModal(batchId, coacheeId) {
                    const modal = new bootstrap.Modal(document.getElementById('downloadModal'));
                    const fileList = document.getElementById('fileList');
                    fileList.innerHTML = '<li class="list-group-item">Loading files...</li>';
                    console.log(batchId + "mkjkj");
                    console.log(coacheeId + "mkjkj");


                    fetch(`/coaching/get-documents?batchId=${batchId}&coacheeId=${coacheeId}`)
                      .then(response => {
                        if (!response.ok) throw new Error("Failed to fetch files");
                        return response.json();
                      })
                      .then(files => {
                        if (files.length === 0) {
                          fileList.innerHTML = '<li class="list-group-item text-danger">No files found.</li>';
                        } else {
                          fileList.innerHTML = '';
                          files.forEach(file => {
                            const li = document.createElement('li');
                            li.className = 'list-group-item d-flex justify-content-between align-items-center';
                            li.innerHTML = `
              <span>${file.fileName}</span>
              <a class="btn btn-sm btn-outline-primary" href="${file.url}" download>Download</a>
            `;
                            fileList.appendChild(li);
                          });
                        }
                        modal.show();
                      })
                      .catch(err => {
                        fileList.innerHTML = `<li class="list-group-item text-danger">Error loading files: ${err.message}</li>`;
                        modal.show();
                      });
                  }
                </script> -->




        </body>

        </html>
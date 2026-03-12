<!DOCTYPE html>
<html lang="en">
  <head>
    <title>TOOL APPROVAL REQUEST | TOOL APPROVAL<%@include file="../includeJSP/company_name_title.jsp"%></title>
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
                <h5 class="font-1 font-weight-bold">TOOL APPROVAL REQUEST</h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item"><a href="dashboard" title="Dashboard"><strong>Dashboard</strong></a></li>
                  <li class="breadcrumb-item"><a href="dashboard-tool-approval" title="TA Dashboard"><strong>TA Dashboard</strong></a></li>
                  <li class="breadcrumb-item active"><strong>Tool Approval Reqeust</strong></li>
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
              <div class="col-12">
                <form method="post"
                      action="ta-approval-reqeust"
                      modelAttribute="taToolRequest"
                      id="ta-approval-reqeust"
                      enctype="multipart/form-data">
                <input type="file" id="backgroundAttachmentHidden" name="backgroundAttachments" multiple style="display:none">
                <input type="file" id="remarkAttachmentHidden" name="remarkAttachments" multiple style="display:none">
                <input type="number" value="${taToolRequest.taToolRequestId }" id="taToolRequestId" name="taToolRequestId" />
                <div class="card card-primary card-tabs">
                  <div class="card-header p-0 pt-1 bg-3">
                    <ul class="nav nav-tabs" id="custom-tabs-one-tab" role="tablist">
                      <li class="nav-item">
                        <a class="nav-link active" id="tool-approval-details-tab" data-toggle="pill" href="#tool-approval-details" role="tab" aria-controls="tool-approval-details" aria-selected="true">Step 1: Tool Details</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link font-white" id="cost-details-tab" data-toggle="pill" href="#cost-details" role="tab" aria-controls="cost-details" aria-selected="false">Step 2: Cost Details</a>
                      </li>
                    </ul>
                  </div>
                  <div class="card-body">
                    <div class="tab-content" id="custom-tabs-one-tabContent">
                      <div class="tab-pane fade show active" id="tool-approval-details" role="tabpanel" aria-labelledby="tool-approval-details-tab">
                        <div class="row">
                          <div class="col-5">
                            <div class="form-group">
                              <label class="font-1" for="customerName"><span class="mandatory">*</span>Customer Name</label>
                              <input id="customerName" type="text" name="customerName" class="form-control" value="${taToolRequest.customerName}" />
                              <span class="invalid-feedback" id="customerNameError"></span>
                            </div>
                          </div>
                          <div class="col-5">
                            <div class="form-group">
                              <label class="font-2" for="projectName"><span class="mandatory">*</span>Project</label>
                              <input id="projectName" type="text" name="projectName" class="form-control" value="${taToolRequest.projectName}" />
                              <span class="invalid-feedback" id="projectNameError"></span>
                            </div>
                          </div>
                          <div class="col-2">
                            <div class="form-group">
                              <label class="font-3" for="tempSopDate"><span class="mandatory">*</span>SOP Date</label>
                              <input id="tempSopDate" type="date" name="tempSopDate" class="form-control" value="${taToolRequest.tempSopDate}" />
                              <span class="invalid-feedback" id="tempSopDateError"></span>
                            </div>
                          </div>
                          <div class="col-6">
                            <div class="form-group">
                              <label class="font-1" for="tempEntityId"><span class="mandatory">*</span>Plant Code</label>
                              <input id="tempEntityIdForJquery" type="hidden" value="${taToolRequest.entityId.mEntityId }" />
                              <select id="tempEntityId" class="form-control select2" name="tempEntityId">
                                <option value="">Select Plant</option>
                                <c:forEach var="ent" items="${plantCodeList}">
                                  <option value="${ent.mEntityId}">${ent.entityName} - ${ent.locationId.locationName }</option>
                                </c:forEach>
                              </select>
                              <span class="invalid-feedback d-block" id="tempEntityIdError"></span>
                            </div>
                          </div>
                          <div class="col-3">
                            <div class="form-group">
                              <label class="font-2" for="peakAnnualVolume"><span class="mandatory">*</span>Peak Annual Volume</label>
                              <input type="number" id="peakAnnualVolume" name="peakAnnualVolume" class="form-control" value="${taToolRequest.peakAnnualVolume}" />
                              <span class="invalid-feedback" id="peakAnnualVolumeError"></span>
                            </div>
                          </div>
                          <div class="col-3">
                            <div class="form-group">
                              <label class="font-3" for="unit"><span class="mandatory">*</span>Unit</label>
                              <input id="unitTempForJquery" type="hidden" value="${taToolRequest.unit }" />
                              <select class="form-control" name="unit" id="unit">
                                <option value="-1">- Select Unit -</option>
                                <option value="1">Numbers</option>
                                <option value="2">Vehicles</option>
                              </select>
                              <span class="invalid-feedback d-block" id="unitError"></span>
                            </div>
                          </div>
                          <div class="col-3">
                            <div class="form-group">
                              <label class="font-1" for="expenseType"><span class="mandatory">*</span>Expense Type</label>
                              <input id="expenseTypeTempForJquery" type="hidden" value="${taToolRequest.expenseType }" />
                              <select class="form-control" name="expenseType" id="expenseType">
                                <option value="">Select Expense Type</option>
                                <option value="1">Tool Cost</option>
                                <option value="2">Design and Development Cost</option>
                              </select>
                              <span class="invalid-feedback d-block" id="expenseTypeError"></span>
                            </div>
                          </div>
                          <div class="col-3">
                            <div class="form-group">
                              <label class="font-2" for="tempBusinessUnitId"><span class="mandatory">*</span>Applicable For</label>
                              <input id="tempBusinessUnitIdTempForJquery" type="hidden" value="${taToolRequest.taBusinessUnitId.taBusinessUnitId }" />
                              <select class="form-control select2" id="tempBusinessUnitId" name="tempBusinessUnitId">
                                <option value="">Select Business Unit</option>
                                <c:forEach var="bu" items="${businessUnitList}">
                                  <option value="${bu.taBusinessUnitId}">${bu.taBusinessUnitName}</option>
                                </c:forEach>
                              </select>
                              <span class="invalid-feedback d-block" id="tempBusinessUnitIdError"></span>
                            </div>
                          </div>
                          <div class="col-6">
                            <div class="form-group">
                              <label class="font-3" for="tempCommodityManagerId"><span class="mandatory">*</span>Commodity Manager</label>
                              <input id="tempCommodityManagerIdForJquery" type="hidden" value="${taToolRequest.commodityManagerUserId.mUserId }" />
                              <select class="form-control select2" name="tempCommodityManagerId" id="tempCommodityManagerId">
                                <option value="">Select Commodity Manager</option>
                                <c:forEach var="cm" items="${commodityManagerList}">
                                  <option value="${cm.mUserId}">${cm.userFirstName} ${cm.userLastName} - ${cm.userLoginId }</option>
                                </c:forEach>
                              </select>
                              <span class="invalid-feedback d-block" id="tempCommodityManagerIdError"></span>
                            </div>
                          </div>
                          <div class="col-6">
                            <div class="form-group">
                              <label class="font-1" for="background"><span class="mandatory">*</span>Background</label>
                              <textarea id="background" name="background" class="form-control" rows="3">${taToolRequest.background }</textarea>
                              <span class="invalid-feedback" id="backgroundError"></span>
                            </div>
                          </div>
                          <div class="col-6">
                            <div class="form-group">
                              <label class="font-2" for="remark"><span class="mandatory">*</span>Remark</label>
                              <textarea id="remark" name="remark" class="form-control" rows="3">${taToolRequest.remark }</textarea>
                              <span class="invalid-feedback" id="remarkError"></span>
                            </div>
                          </div>
                        </div>
                        <div class="row">
                          <div class="col-6">
                            <div class="form-group">
                              <label class="font-1">
                                Background Attachments
                                <small class="text-muted">Maximum 3 files allowed</small>
                              </label>
                              <button type="button"
                                      id="uploadBackgroundAttachmentBtn"
                                      class="btn bg-3 btn-sm mt-1"
                                      title="Upload Background Attachment">
                                <i class="fas fa-upload"></i>&ensp;Upload File
                              </button>
                              <div id="backgroundAttachmentList" class="mt-2"></div>
                              <input type="file"
                                     id="backgroundAttachmentFile"
                                     multiple
                                     style="display:none" />
                            </div>
                          </div>
                          <div class="col-6">
                            <div class="form-group">
                              <label class="font-2">
                                Remark Attachments
                                <small class="text-muted">Maximum 3 files allowed</small>
                              </label>
                              <button type="button"
                                      id="uploadRemarkAttachmentBtn"
                                      class="btn bg-3 btn-sm mt-1"
                                      title="Upload Remark Attachment">
                                <i class="fas fa-upload"></i>&ensp;Upload File
                              </button>
                              <div id="remarkAttachmentList" class="mt-2"></div>
                              <input type="file"
                                     id="remarkAttachmentFile"
                                     multiple
                                     style="display:none" />
                            </div>
                          </div>
                        </div>
                        <div class="row">
                          <div class="col-9"></div>
                          <div class="col-3 mt-2">
                            <button type="button" id="nextToolApprovalStep" class="btn sequence-bg-2" style="float:right" title="Go to Cost Details">
                              Next&ensp;<i class="fas fa-step-forward"></i>
                            </button>
                          </div>
                        </div>
                        
                      </div>
                      <c:set var="toolCostDetailsIndex" value="0" />
                      <div class="tab-pane fade" id="cost-details" role="tabpanel" aria-labelledby="cost-details-tab">
                        <div class="row">
                          <div class="col-md-12 tableOverFlowDiv text-sm">
                            <table class="table-bordered table-striped" id="approvalMatrixTable" style="width:100%">
                              <thead class="bg-table-head" style="text-align:center">
                                <tr>
                                  <th>Action</th>
                                  <th>Part No</th>
                                  <th>Description</th>
                                  <th>Currency</th>
                                  <th>Quoted (Mn)</th>
                                  <th>Negotiated (Mn)</th>
                                  <th>Up Front (Mn)</th>
                                  <th>Amortization (Mn)</th>
                                  <th>Supplier</th>
                                  <th>Dev Lead Time (Weeks)</th>
                                  <th>Remark</th>
                                </tr>
                              </thead>
                              <tbody>
                                <c:if test="${empty taToolRequest.toolReqeustCostDetail }">
                                <c:forEach var="i" begin="1" end="2">
                                <tr style="text-align:center" id="costDetailRow${toolCostDetailsIndex }">
                                  <td>
                                    <input style='width:10px' type="hidden" value="" id="taToolRequestCostDetailId${toolCostDetailsIndex }" name="tempToolRequestCostDetail[${toolCostDetailsIndex}].taToolRequestCostDetailId" />
                                    <input style='width:10px' type="hidden" value="1" id="costActive${toolCostDetailsIndex }" name="tempToolRequestCostDetail[${toolCostDetailsIndex}].costActive" />
                                    <a href="#" class="sequence-font-1 deleteCostRow" data-index="${toolCostDetailsIndex}" title="Delete Cost Entry"><i class="fas fa-times-circle"></i></a>
                                  </td>
                                  <td>
                                    <input style='width:140px' type="text" name="tempToolRequestCostDetail[${toolCostDetailsIndex}].toolPartNumber" id="toolPartNumber${toolCostDetailsIndex}" class="form-control input-group-sm" required/>
                                    <span class="invalid-feedback d-block" id="toolPartNumberError${toolCostDetailsIndex}"></span>
                                  </td>
                                  <td>
                                    <input style='width:150px' type="text" name="tempToolRequestCostDetail[${toolCostDetailsIndex}].partDescription" id="partDescription${toolCostDetailsIndex}" class="form-control input-group-sm" required/>
                                    <span class="invalid-feedback d-block" id="partDescriptionError${toolCostDetailsIndex}"></span>
                                  </td>
                                  <td>
                                    <select style='width:50px' name="tempToolRequestCostDetail[${toolCostDetailsIndex}].currency" id="currency${toolCostDetailsIndex}" class="input-group-sm">
                                      <option value="1">INR</option>
                                      <option value="2">USD</option>
                                      <option value="3">EUR</option>
                                      <option value="4">YEN</option>
                                    </select>
                                  </td>
                                  <td>
                                    <input style='width:70px' type="number" step="0.0001" min="0" name="tempToolRequestCostDetail[${toolCostDetailsIndex}].quotedCost" id="quotedCost${toolCostDetailsIndex}" class="form-control input-group-sm" required/>
                                    <span class="invalid-feedback d-block" id="quotedCostError${toolCostDetailsIndex}"></span>
                                  </td>
                                  <td>
                                    <input style='width:70px' type="number" step="0.0001" min="0" name="tempToolRequestCostDetail[${toolCostDetailsIndex}].negotiatedCost" id="negotiatedCost${toolCostDetailsIndex}" class="form-control input-group-sm" required/>
                                    <span class="invalid-feedback d-block" id="negotiatedCostError${toolCostDetailsIndex}"></span>
                                  </td>
                                  <td>
                                    <input style='width:70px' type="number" step="0.0001" min="0" name="tempToolRequestCostDetail[${toolCostDetailsIndex}].upfrontCost" id="upfrontCost${toolCostDetailsIndex}" class="form-control input-group-sm"/>
                                  </td>
                                  <td>
                                    <input style='width:80px' type="number" step="0.0001" min="0" name="tempToolRequestCostDetail[${toolCostDetailsIndex}].amortizationCost" id="amortizationCost${toolCostDetailsIndex}" class="form-control input-group-sm"/>
                                  </td>
                                  <td>
                                    <textarea id="supplierName${toolCostDetailsIndex}" rows="2" style='width:145px' name="tempToolRequestCostDetail[${toolCostDetailsIndex}].supplierName" class="form-control input-group-sm" required></textarea>
                                    <span class="invalid-feedback d-block" id="supplierNameError${toolCostDetailsIndex}"></span>
                                  </td>
                                  <td>
                                    <input style='width:100px' type="text" name="tempToolRequestCostDetail[${toolCostDetailsIndex}].developmentLeadTime" id="developmentLeadTime${toolCostDetailsIndex}" class="form-control input-group-sm" required />
                                    <span class="invalid-feedback d-block" id="developmentLeadTimeError${toolCostDetailsIndex}"></span>
                                  </td>
                                  <td>
                                    <textarea  id="costRemarks${toolCostDetailsIndex}" rows="2" style='width:145px' name="tempToolRequestCostDetail[${toolCostDetailsIndex}].remarks" class="form-control input-group-sm" required></textarea>
                                    <span class="invalid-feedback d-block" id="costRemarksError${toolCostDetailsIndex}"></span>
                                  </td>
                                </tr>
                                <c:set var="toolCostDetailsIndex" value="${toolCostDetailsIndex + 1 }" />
                                </c:forEach>
                                </c:if>
                                <c:if test="${not empty taToolRequest.toolReqeustCostDetail }">
                                <c:forEach var="costDetail" items="${taToolRequest.toolReqeustCostDetail }">
                                <tr style="text-align:center" id="costDetailRow${toolCostDetailsIndex }">
                                  <td>
                                    <input style='width:10px' type="hidden" value="${costDetail.taToolRequestCostDetailId }" id="taToolRequestCostDetailId${toolCostDetailsIndex }" name="tempToolRequestCostDetail[${toolCostDetailsIndex}].taToolRequestCostDetailId" />
                                    <input style='width:10px' type="hidden" value="${costDetail.costActive }" id="costActive${toolCostDetailsIndex }" name="tempToolRequestCostDetail[${toolCostDetailsIndex}].costActive" />
                                    <a href="#" class="sequence-font-1 deleteCostRow" data-index="${toolCostDetailsIndex}" title="Delete Cost Entry"><i class="fas fa-times-circle"></i></a>
                                  </td>
                                  <td>
                                    <input style='width:140px' type="text" name="tempToolRequestCostDetail[${toolCostDetailsIndex}].toolPartNumber" value="${costDetail.toolPartNumber }" id="toolPartNumber${toolCostDetailsIndex}" class="form-control input-group-sm" required/>
                                    <span class="invalid-feedback d-block" id="toolPartNumberError${toolCostDetailsIndex}"></span>
                                  </td>
                                  <td>
                                    <input style='width:150px' type="text" name="tempToolRequestCostDetail[${toolCostDetailsIndex}].partDescription" value="${costDetail.partDescription }" id="partDescription${toolCostDetailsIndex}" class="form-control input-group-sm" required/>
                                    <span class="invalid-feedback d-block" id="partDescriptionError${toolCostDetailsIndex}"></span>
                                  </td>
                                  <td>
                                    <input value="${costDetail.currency }" type="hidden" id="currencyTemp${toolCostDetailsIndex }" />
                                    <select style='width:50px' name="tempToolRequestCostDetail[${toolCostDetailsIndex}].currency" id="currency${toolCostDetailsIndex}" class="input-group-sm">
                                      <option value="1">INR</option>
                                      <option value="2">USD</option>
                                      <option value="3">EUR</option>
                                      <option value="4">YEN</option>
                                    </select>
                                  </td>
                                  <td>
                                    <input style='width:70px' type="number" step="0.0001" min="0" name="tempToolRequestCostDetail[${toolCostDetailsIndex}].quotedCost" value="${costDetail.quotedCost }" id="quotedCost${toolCostDetailsIndex}" class="form-control input-group-sm" required/>
                                    <span class="invalid-feedback d-block" id="quotedCostError${toolCostDetailsIndex}"></span>
                                  </td>
                                  <td>
                                    <input style='width:70px' type="number" step="0.0001" min="0" name="tempToolRequestCostDetail[${toolCostDetailsIndex}].negotiatedCost" value="${costDetail.negotiatedCost }" id="negotiatedCost${toolCostDetailsIndex}" class="form-control input-group-sm" required/>
                                    <span class="invalid-feedback d-block" id="negotiatedCostError${toolCostDetailsIndex}"></span>
                                  </td>
                                  <td>
                                    <input style='width:70px' type="number" step="0.0001" min="0" name="tempToolRequestCostDetail[${toolCostDetailsIndex}].upfrontCost" value="${costDetail.upfrontCost }" id="upfrontCost${toolCostDetailsIndex}" class="form-control input-group-sm"/>
                                  </td>
                                  <td>
                                    <input style='width:80px' type="number" step="0.0001" min="0" name="tempToolRequestCostDetail[${toolCostDetailsIndex}].amortizationCost" value="${costDetail.amortizationCost }" id="amortizationCost${toolCostDetailsIndex}" class="form-control input-group-sm"/>
                                  </td>
                                  <td>
                                    <textarea id="supplierName${toolCostDetailsIndex}" rows="2" style='width:145px' name="tempToolRequestCostDetail[${toolCostDetailsIndex}].supplierName" class="form-control input-group-sm" required>${costDetail.supplierName }</textarea>
                                    <span class="invalid-feedback d-block" id="supplierNameError${toolCostDetailsIndex}"></span>
                                  </td>
                                  <td>
                                    <input style='width:100px' type="text" name="tempToolRequestCostDetail[${toolCostDetailsIndex}].developmentLeadTime" value="${costDetail.developmentLeadTime }" id="developmentLeadTime${toolCostDetailsIndex}" class="form-control input-group-sm" required />
                                    <span class="invalid-feedback d-block" id="developmentLeadTimeError${toolCostDetailsIndex}"></span>
                                  </td>
                                  <td>
                                    <textarea  id="costRemarks${toolCostDetailsIndex}" rows="2" style='width:145px' name="tempToolRequestCostDetail[${toolCostDetailsIndex}].remarks" class="form-control input-group-sm" required>${costDetail.remarks }</textarea>
                                    <span class="invalid-feedback d-block" id="costRemarksError${toolCostDetailsIndex}"></span>
                                  </td>
                                </tr>
                                <c:set var="toolCostDetailsIndex" value="${toolCostDetailsIndex + 1 }" />
                                </c:forEach>
                                </c:if>
                                
                              <tfoot class="bg-table-foot">
                                <tr>
                                  <th>Action</th>
                                  <th>Part No</th>
                                  <th>Description</th>
                                  <th>Currency</th>
                                  <th>Quoted (Mn)</th>
                                  <th>Negotiated (Mn)</th>
                                  <th>Up Front (Mn)</th>
                                  <th>Amortization (Mn)</th>
                                  <th>Supplier</th>
                                  <th>Dev Lead Time (Weeks)</th>
                                  <th>Remark</th>
                                </tr>
                              </tfoot>
                            </table>
                            <template id="costRowTemplate">
                              <tr style="text-align:center" id="costDetailRow{index}">
                                <td>
                                  <input style="width:10px" type="hidden" value="" id="taToolRequestCostDetailId{index}" name="tempToolRequestCostDetail[{index}].taToolRequestCostDetailId" />
                                  <input style="width:10px" type="hidden" value="1" id="costActive{index}" name="tempToolRequestCostDetail[{index}].costActive" />
                                  <a href="#" class="sequence-font-1 deleteCostRow" data-index="{index}" title="Delete Cost Entry">
                                    <i class="fas fa-times-circle"></i>
                                  </a>
                                </td>

                                <td>
                                  <input style="width:140px" type="text"
                                    name="tempToolRequestCostDetail[{index}].toolPartNumber"
                                    id="toolPartNumber{index}"
                                    class="form-control input-group-sm"
                                    required/>
                                </td>

                                <td>
                                  <input style="width:150px" type="text"
                                    name="tempToolRequestCostDetail[{index}].partDescription"
                                    id="partDescription{index}"
                                    class="form-control input-group-sm"
                                    required/>
                                </td>

                                <td>
                                  <select style="width:50px"
                                    name="tempToolRequestCostDetail[{index}].currency"
                                    id="currency{index}"
                                    class="input-group-sm">
                                    <option value="1">INR</option>
                                    <option value="2">USD</option>
                                    <option value="3">EUR</option>
                                    <option value="4">YEN</option>
                                  </select>
                                </td>

                                <td>
                                  <input style="width:70px"
                                    type="number"
                                    step="0.0001"
                                    min="0"
                                    name="tempToolRequestCostDetail[{index}].quotedCost"
                                    id="quotedCost{index}"
                                    class="form-control input-group-sm"
                                    required/>
                                </td>

                                <td>
                                  <input style="width:70px"
                                    type="number"
                                    step="0.0001"
                                    min="0"
                                    name="tempToolRequestCostDetail[{index}].negotiatedCost"
                                    id="negotiatedCost{index}"
                                    class="form-control input-group-sm"
                                    required/>
                                </td>

                                <td>
                                  <input style="width:70px"
                                    type="number"
                                    step="0.0001"
                                    min="0"
                                    name="tempToolRequestCostDetail[{index}].upfrontCost"
                                    id="upfrontCost{index}"
                                    class="form-control input-group-sm"/>
                                </td>

                                <td>
                                  <input style="width:80px"
                                    type="number"
                                    step="0.0001"
                                    min="0"
                                    name="tempToolRequestCostDetail[{index}].amortizationCost"
                                    id="amortizationCost{index}"
                                    class="form-control input-group-sm"/>
                                </td>

                                <td>
                                  <textarea id="supplierName{index}"
                                    rows="2"
                                    style="width:145px"
                                    name="tempToolRequestCostDetail[{index}].supplierName"
                                    class="form-control input-group-sm"
                                    required></textarea>
                                </td>

                                <td>
                                  <input style="width:100px"
                                    type="text"
                                    name="tempToolRequestCostDetail[{index}].developmentLeadTime"
                                    id="developmentLeadTime{index}"
                                    class="form-control input-group-sm"
                                    required/>
                                </td>

                                <td>
                                  <textarea id="costRemarks{index}"
                                    rows="2"
                                    style="width:145px"
                                    name="tempToolRequestCostDetail[{index}].remarks"
                                    class="form-control input-group-sm"
                                    required></textarea>
                                </td>

                              </tr>
                            </template>
                          </div>
                        </div>
                        <div class="row">
                          <div class="col-9"></div>
                          <div class="col-3 mt-2">
                            <button type="button" id="addMorePartCost" class="btn bg-3" style="float:right" title="Add More Part Cost Details">
                              <i class="fas fa-plus"></i>&ensp;Add More Part Cost Details
                            </button>
                          </div>
                          <div class="col-6">
                            <div class="form-group">
                              <label class="font-2">Tooling Payment Remark</label>
                              <textarea id="toolingPaymentRemark" name="costDetailsList[0].toolingPaymentRemark" class="form-control" rows="2" required>${not empty costDetailsList ? costDetailsList[0].toolingPaymentRemark : ''}</textarea>
                              <span class="invalid-feedback" id="toolingPaymentRemarkError"></span>
                            </div>
                          </div>
                          <div class="col-6"></div>
                          <div class="col-3 mt-2">
                            <button type="button" id="backToToolDetails" class="btn bg-2" style="float:left" title="Go back to Tool Approval Details">
                              <i class="fas fa-step-backward"></i>&ensp;Back
                            </button>
                          </div>
                          <div class="col-6"></div>
                          <div class="col-3 mt-2">
                            <button type="button" id="saveDraftToolApproval" class="btn sequence-bg-4" title="Save Tool Details in Draft">
                              <i class="fas fa-tasks"></i>&ensp;Save as Draft
                            </button>
                            <button type="submit" id="submitToolApprovalRequest" class="btn sequence-bg-5" style="float:right" title="Submit Tool Details for Approval">
                              <i class="fas fa-save"></i>&ensp;Save
                            </button>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                </form>
                <input type="hidden" value="${toolCostDetailsIndex }" id="toolCostDetailsIndex" />
              </div>
            </div>
          </div>
        </section>
      </div>
      <%@include file="../includeJSP/footer.jsp"%>
    </div>
    <%@include file="../includeJSP/jsFiles.jsp"%>
    <script src="usedStaticFiles/essentials/js/jsp_js_files/ta/ta-approval-reqeust.js"></script>
  </body>
</html>

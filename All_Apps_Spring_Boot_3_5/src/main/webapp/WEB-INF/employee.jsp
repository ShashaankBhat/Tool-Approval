<!-- ****************************************************************************************
# *******************************************************************************************
# Copyright © 2021 Anand Group India. All rights reserved.									*
# No part of this product may be reproduced in any form by any means without prior			*
# written authorization of Anand Automotive Private Limited and its licensors, if any.		*
# *******************************************************************************************
# Author - Sheshadhri R Iyer																*
# *************************************************************************************** -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>EMPLOYEE | EMC | ANAND U</title>
		<%@include file="/WEB-INF/includeJSP/cssFiles.jsp"%>
	</head>
	<body class="sidebar-mini layout-navbar-fixed sidebar-collapse pace-primary">
		<div class="wrapper">
			<%@include file="/WEB-INF/includeJSP/header.jsp"%>
			
			<%@include file="/WEB-INF/includeJSP/leftSideBar.jsp"%>
			
			<div class="content-wrapper">
				
				<section class="content-header">
					<div class="container-fluid">
						<div class="row mb-2">
							<div class="col-sm-6">
								<h4>EMPLOYEE LIST</h4>
							</div>
							<div class="col-sm-6">
								<ol class="breadcrumb float-sm-right">
									<li class="breadcrumb-item"><a href="dashboard" title="Dashboard">Dashboard</a></li>
									<li class="breadcrumb-item active">Employee</li>
								</ol>
							</div>
						</div>
					</div>
				</section>

				<c:if test="${not empty regMsg }">
					<section class="content">
						<div class="container-fluid">
							<div class="alert bg-info-anand-${css } alert-dismissible">
								<button type="button" title="CLose Alert Box" class="close" data-dismiss="alert" aria-hidden="true"><i class="fas fa-times"></i></button>
								<c:if test="${css eq 'danger'}">
									<h5><i class="icon fas fa-ban"></i>${regMsg }</h5>
								</c:if>
								<c:if test="${css ne 'danger'}">
									<h5><i class="icon fas fa-check"></i>${regMsg }</h5>
								</c:if>
							</div>
						</div>
					</section>
				</c:if>
				
				<section class="content">
					<div class="container-fluid">
						<div class="row">
							<div class="col-md-12">
								<div class="card card-primary card-outline collapsed-card">
									<div class="card-header">
										<h5 class="card-title">Add Employee</h5>
										<div class="card-tools">
											<button type="button" class="btn btn-tool" data-card-widget="collapse">
											<i class="fas fa-plus"></i>
											</button>
										</div>
									</div>
									<div class="card-body" style="display: none;">
										<div class="row">
											<div class="col-md-12">
												<form:form modelAttribute="employee" action="employee" method="post" id="addEmployee">
													<form:hidden path="employeeId" id="employeeIdAdd" />
													<div class="card-body">
														<div class="row">
															<div class="col-md-4">
																<div class="form-group">
																	<label for="employeeFirstName"><span class="mandatory">*</span>First Name</label>																	<form:input type="text" class="form-control" id="employeeFirstName" placeholder="Enter First Name" path="employeeFirstName" />
																	<span class="error invalid-feedback" id="employeeFirstNameError"></span>
																</div>
															</div>
															<div class="col-md-4">
																<div class="form-group">
																	<label for="employeeMiddleName"><span class="mandatory"></span>Middle Name</label>
																	<form:input type="text" class="form-control" id="employeeMiddleName" placeholder="Enter Middle Name" path="employeeMiddleName" />
																	<span class="error invalid-feedback" id="employeeMiddleNameError"></span>
																</div>
															</div>
															<div class="col-md-4">
																<div class="form-group">
																	<label for="employeeLastName"><span class="mandatory">*</span>Last Name</label>
																	<form:input type="text" class="form-control" id="employeeLastName" placeholder="Enter Last Name" path="employeeLastName" />
																	<span class="error invalid-feedback" id="employeeLastNameError"></span>
																</div>
															</div>
															<div class="col-md-4">
																<div class="form-group">
																	<label for="selectCompanyLocation"><span class="mandatory">*</span>Company - Location</label>
																	<form:select class="form-control" path="selectCompanyLocation" id="selectCompanyLocation">
																		<form:option value="-1">Select Company-Location</form:option>
																		<c:forEach items="${companyLocationList }" var="comLoc">
																			<form:option value="${comLoc.companyLocation.companyId }-${comLoc.locationId.locationId }">${comLoc.companyLocation.companyAcronym }-${comLoc.locationId.locationName }</form:option>
																		</c:forEach>
																	</form:select>
																	<span class="error invalid-feedback" id="selectCompanyLocationError"></span>
																</div>
															</div>
															<div class="col-md-4">
																<div class="form-group">
																	<label for="selectMemeberDesignation"><span class="mandatory">*</span>Designation</label>
																	<form:select class="form-control" path="selectMemeberDesignation" id="selectMemeberDesignation">
																		<form:option value="-1">Select Designation</form:option>
																		<c:forEach items="${designationList }" var="designation">
																			<form:option value="${designation.designationId }">${designation.designationName }</form:option>
																		</c:forEach>
																	</form:select>
																	<span class="error invalid-feedback" id="selectMemeberDesignationError"></span>
																</div>
															</div>
															<div class="col-md-4">
																<div class="form-group">
																	<label for="selectMemeberType"><span class="mandatory">*</span>Type</label>
																	<form:select class="form-control" path="selectMemeberType" id="selectMemeberType">
																		<form:option value="-1">Select Type</form:option>
																		<c:forEach items="${memberTypeList }" var="memberType">
																			<form:option value="${memberType.memberTypeId }">${memberType.memberTypeName }</form:option>
																		</c:forEach>
																	</form:select>
																	<span class="error invalid-feedback" id="selectMemeberTypeError"></span>
																</div>
															</div>
															<div class="col-md-6">
																<div class="form-group">
																	<label for="employeeEmail"><span class="mandatory">*</span>Email ID</label>
																	<form:input type="text" class="form-control" id="employeeEmail" placeholder="Enter Email ID" path="employeeEmail" />
																	<span class="error invalid-feedback" id="employeeEmailError"></span>
																	<span class="error invalid-feedback formError" id="emailCheckLoader" style="display:none;color:black;">
																		Checking for email uniqueness&nbsp;<img src="usedStaticFiles/images/dotted_loader.gif" height="10px" />
																	</span>
																</div>
															</div>
															<div class="col-md-3">
																<div class="form-group">
																	<label for="selectMemeberLevel"><span class="mandatory">*</span>Level</label>
																	<form:select class="form-control" path="selectMemeberLevel" id="selectMemeberLevel">
																		<form:option value="-1">Select Level</form:option>
																		<c:forEach items="${memberLevelList }" var="level">
																			<form:option value="${level.memberLevelId }">${level.memberLevelName }</form:option>
																		</c:forEach>
																	</form:select>
																	<span class="error invalid-feedback" id="selectMemeberLevelError"></span>
																</div>
															</div>
															<div class="col-md-3">
																<div class="form-check" id="isActiveDiv">
																	<label><span class="mandatory">*</span>Active/InActive</label>
																	<div class="custom-control custom-radio">
																		<form:radiobutton path="employeeActive" class="custom-control-input" value="1" id="customRadio1" name="customRadio" />
																		<label for="customRadio1" class="custom-control-label text-green">Active</label>
																	</div>
																	<div class="custom-control custom-radio">
																		<form:radiobutton path="employeeActive" class="custom-control-input" value="0" id="customRadio2" name="customRadio" />
																		<label for="customRadio2" class="custom-control-label text-red">Inactive</label>
																	</div>
																	<span class="error invalid-feedback" id="isActiveError" style="display:block" ></span> 
																</div>
															</div>
															<div class="col-md-6">
																<div class="form-group">
																	<label for="selectRole"><span class="mandatory">*</span>Role</label>
																	<form:select class="form-control select2bs4" multiple="multiple" path="selectRole" id="selectRole">
																		<form:option value="-1"> Select Role</form:option>
																		<c:forEach items="${roleList }" var="role">
																			<form:option value="${role.roleId }">${role.roleName }</form:option>
																		</c:forEach>
																	</form:select>
																	<span class="error invalid-feedback" id="selectRoleError"></span>
																</div>
															</div>
															<div class="col-md-3">
																<div class="form-group">
																	<label for="employeePhoneNo"><span class="mandatory">*</span>Phone No</label>
																	<form:input type="text" class="form-control" id="employeePhoneNo" placeholder="Enter Phone No" path="employeePhoneNo" />
																	<span class="error invalid-feedback" id="employeePhoneNoError"></span>
																</div>
															</div>
															<div class="col-md-1" align="right">
																<div class="form-check">
																	<br>
																	<button style="float: right;" title="Add Employee" type="submit" id="submitEmployeeButton" class="btn bg-color-anand-two text-white">Submit</button>
																</div>
															</div>
														</div>
													</div>
												</form:form>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div class="card card-primary card-outline">
									<div class="card-header">
										<h5 class="card-title">List of Employees</h5>
									</div>
									<div class="card-body">
										<div class="row">
											<div class="col-md-12">
												<table class="table table-bordered table-hover dataTable" id="employeeTable">
													<thead>
														<tr class="bg-table-head">
															<th>Name</th>
															<th>Email ID</th>
															<th>Company-Location</th>
															<th>Designation</th>
															<th>Contact No</th>
															<th>Roles</th>
															<th>Action</th>
														</tr>
													</thead>
													<tbody>
														<c:forEach items="${employeeList}" var="employee" varStatus="loop">
															<tr class="bg-table-row-${loop.index % 2 }">
																<td>
																	<c:if test="${employee.employeeActive eq 1 }">
	                                                                	<i title="Active" class="fas fa-hand-point-up icon-anand-success"></i>
	                                                                </c:if>
	                                                                <c:if test="${employee.employeeActive eq 0 }">
	                                                                	<i title="In-Active" class="fas fa-hand-point-down icon-anand-danger"></i>
	                                                                </c:if>&nbsp;
																	${employee.employeeFirstName } ${employee.employeeMiddleName } ${employee.employeeLastName }
																</td>
	                                                           	<td>${employee.employeeEmail }</td>
	                                                           	<td>${employee.employeeCompany.companyAcronym } - ${employee.employeeLocation.locationName }</td>
	                                                           	<td>${employee.employeeDesignation.designationName }</td>
	                                                           	<td>${employee.employeePhoneNo }</td>
	                                                           	<td>
	                                                           		<c:set var="rolesNow" value="" />
	                                                           		<c:forEach items="${employee.employeeUserRoleMap}" var="empRole" varStatus="loop">
	                                                           			<c:if test="${empRole.userRoleMapActive eq 1 }">
	                                                           				<c:choose>
		                                                           				<c:when test="${empty rolesNow }">
		                                                           					<c:set var="rolesNow" value="${empRole.roleInfo.roleName }" />
		                                                           				</c:when>
		                                                           				<c:otherwise>
		                                                           					<c:set var="rolesNow" value="${rolesNow } , ${empRole.roleInfo.roleName }" />
		                                                           				</c:otherwise>
		                                                           			</c:choose>
	                                                           			</c:if>
	                                                           		</c:forEach>
	                                                           		<%-- <span class="badge bg-info-anand-warning">${empRole.roleInfo.roleName }</span> --%>
	                                                           		<span class="badge bg-info-anand-warning">${rolesNow }</span>
	                                                           	</td>
	                                                            <td>
	                                                                <a onclick="openEditModal(${employee.employeeId});" href="#" title="Edit Employee">
	                                                                	<i class="fas fa-edit"></i>&nbsp;Edit
	                                                                </a>
	                                                                <c:if test="${employee.employeeActive eq 1 }">
	                                                                	<i title="Active" class="fas fa-hand-point-up icon-anand-success"></i>
	                                                                </c:if>
	                                                                <c:if test="${employee.employeeActive eq 0 }">
	                                                                	<i title="In-Active" class="fas fa-hand-point-down icon-anand-danger"></i>
	                                                                </c:if>
	                                                        	</td>
	                                                    	</tr>
	                                                    </c:forEach>
													</tbody>
													<tr id="employeeListLoader" style="display:none">
														<th colspan="7">
															<img class="loaderClass" id="companyLoaderImage" src="usedStaticFiles/images/loader.gif" width="64" alt="">
															<p id="nothingMore" style="display:none;float:right">All companies are loaded.</p>
														</th>
													</tr>
													<tfoot>
														<tr class="bg-table-foot">
															<th>Name</th>
															<th>Email ID</th>
															<th>Company-Location</th>
															<th>Designation</th>
															<th>Contact No</th>
															<th>Roles</th>
															<th>Action</th>
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
			</div>
			<div class="modal fade" id="editEmployee">
				<div class="modal-dialog modal-xl">
					<div class="modal-content">
						<form:form modelAttribute="employee" action="employee" method="post" id="editEmployee">
							<div class="modal-header bg-secondary">
								<h4 class="modal-title">Edit Employee Information</h4>
							</div>
							<div class="modal-body">
								<div class="row">
									<div class="col-md-12">
										<form:hidden path="employeeId" id="employeeIdEdit" />
										<div class="card-body">
											<div class="row">
												<div class="col-md-4">
													<div class="form-group">
														<label for="employeeFirstNameEdit"><span class="mandatory">*</span>First Name</label>
														<form:input type="text" class="form-control" id="employeeFirstNameEdit" placeholder="Enter First Name" path="employeeFirstName" />
														<span class="error invalid-feedback" id="employeeFirstNameErrorEdit"></span>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group">
														<label for="employeeMiddleNameEdit"><span class="mandatory"></span>Middle Name</label>
														<form:input type="text" class="form-control" id="employeeMiddleNameEdit" placeholder="Enter Middle Name" path="employeeMiddleName" />
														<span class="error invalid-feedback" id="employeeMiddleNameErrorEdit"></span>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group">
														<label for="employeeLastNameEdit"><span class="mandatory">*</span>Last Name</label>
														<form:input type="text" class="form-control" id="employeeLastNameEdit" placeholder="Enter Last Name" path="employeeLastName" />
														<span class="error invalid-feedback" id="employeeLastNameErrorEdit"></span>
													</div>
												</div>
												<div class="col-md-6">
													<div class="form-group">
														<label for="employeeEmailEdit"><span class="mandatory">*</span>Email ID</label>
														<form:input type="text" class="form-control" id="employeeEmailEdit" placeholder="Enter Email ID" path="employeeEmail" />
														<span class="error invalid-feedback" id="employeeEmailErrorEdit"></span>
														<span class="error invalid-feedback formError" id="emailCheckLoaderEdit" style="display:none;color:black;">
															Checking for email uniqueness&nbsp;<img src="usedStaticFiles/images/dotted_loader.gif" height="10px" />
														</span>
													</div>
												</div>
												<div class="col-md-6">
													<div class="form-group">
														<label for="selectCompanyLocationEdit"><span class="mandatory">*</span>Company - Location</label>
														<form:select class="form-control" path="selectCompanyLocation" id="selectCompanyLocationEdit">
															<form:option value="-1">Select Company-Location</form:option>
															<c:forEach items="${companyLocationList }" var="comLoc">
																<form:option value="${comLoc.companyLocation.companyId }-${comLoc.locationId.locationId }">${comLoc.companyLocation.companyAcronym }-${comLoc.locationId.locationName }</form:option>
															</c:forEach>
														</form:select>
														<span class="error invalid-feedback" id="selectCompanyLocationErrorEdit"></span>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group">
														<label for="selectMemeberDesignationEdit"><span class="mandatory">*</span>Designation</label>
														<form:select class="form-control" path="selectMemeberDesignation" id="selectMemeberDesignationEdit">
															<form:option value="-1">Select Designation</form:option>
															<c:forEach items="${designationList }" var="designation">
																<form:option value="${designation.designationId }">${designation.designationName }</form:option>
															</c:forEach>
														</form:select>
														<span class="error invalid-feedback" id="selectMemeberDesignationErrorEdit"></span>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group">
														<label for="selectMemeberTypeEdit"><span class="mandatory">*</span>Type</label>
														<form:select class="form-control" path="selectMemeberType" id="selectMemeberTypeEdit">
															<form:option value="-1">Select Type</form:option>
															<c:forEach items="${memberTypeList }" var="memberType">
																<form:option value="${memberType.memberTypeId }">${memberType.memberTypeName }</form:option>
															</c:forEach>
														</form:select>
														<span class="error invalid-feedback" id="selectMemeberTypeErrorEdit"></span>
													</div>
												</div>
												<div class="col-md-4">
													<div class="form-group">
														<label for="selectMemeberLevelEdit"><span class="mandatory">*</span>Level</label>
														<form:select class="form-control" path="selectMemeberLevel" id="selectMemeberLevelEdit">
															<form:option value="-1">Select Level</form:option>
															<c:forEach items="${memberLevelList }" var="level">
																<form:option value="${level.memberLevelId }">${level.memberLevelName }</form:option>
															</c:forEach>
														</form:select>
														<span class="error invalid-feedback" id="selectMemeberLevelErrorEdit"></span>
													</div>
												</div>
												<div class="col-md-2">
													<div class="form-group">
														<label for="employeePhoneNoEdit"><span class="mandatory">*</span>Phone No</label>
														<form:input type="text" class="form-control" id="employeePhoneNoEdit" placeholder="Enter Phone No" path="employeePhoneNo" />
														<span class="error invalid-feedback" id="employeePhoneNoErrorEdit"></span>
													</div>
												</div>
												<div class="col-md-8">
													<div class="form-group">
														<label for="selectRoleEdit"><span class="mandatory">*</span>Role</label>
														<form:select class="form-control select2bs4" multiple="multiple" path="selectRole" id="selectRoleEdit">
															<form:option value="-1"> Select Role</form:option>
															<c:forEach items="${roleList }" var="role">
																<form:option value="${role.roleId }">${role.roleName }</form:option>
															</c:forEach>
														</form:select>
														<span class="error invalid-feedback" id="selectRoleErrorEdit"></span>
													</div>
												</div>
												<div class="col-md-2">
													<div class="form-check" id="isActiveDivEdit">
														<label><span class="mandatory">*</span>Active/InActive</label>
														<div class="custom-control custom-radio">
															<form:radiobutton path="employeeActive" class="custom-control-input" value="1" id="customRadio3" name="customRadio1" />
															<label for="customRadio3" class="custom-control-label text-green">Active</label>
														</div>
														<div class="custom-control custom-radio">
															<form:radiobutton path="employeeActive" class="custom-control-input" value="0" id="customRadio4" name="customRadio1" />
															<label for="customRadio4" class="custom-control-label text-red">Inactive</label>
														</div>
														<span class="error invalid-feedback" id="isActiveErrorEdit" style="display:block" ></span> 
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="modal-footer justify-content-between">
								<button type="button" class="btn bg-info-anand-danger" data-dismiss="modal">Close</button>
								<button type="submit" class="btn bg-color-anand-two text-white" title="Save Employee Changes" id="submitEditEmployee">Save Employee Changes</button>
							</div>
						</form:form>
					</div>
				</div>
			</div>
			<%@include file="/WEB-INF/includeJSP/footer.jsp"%>
		</div>
		<%@include file="/WEB-INF/includeJSP/rightSideBar.jsp"%>
		<%@include file="/WEB-INF/includeJSP/jsFiles.jsp"%>
		<script src="usedStaticFiles/js/jsp_js_files/employee.js"></script>
		<%@include file="/WEB-INF/includeJSP/dataTablesImport.jsp"%>
	</body>
</html>
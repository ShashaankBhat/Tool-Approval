var stringCheck = /^[a-zA-Z_ ]*$/;
var pagination = true;
var emailIdEditValidation = false;
$(function() {
	$(".select2").select2({
		theme: 'bootstrap4'
	});
	$("#tempEntityId").select2({
		theme: 'bootstrap4'
	});
	$("#tempDesignationId").select2({
		theme: 'bootstrap4'
	});
	$("#tempDepartmentId").select2({
		theme: 'bootstrap4'
	});
	$("#userReportingManager").select2({
		theme: 'bootstrap4'
	});
	$("#userRolesTemp").select2({
		theme: 'bootstrap4'
	});
	$("#userAppsTemp").select2({
		theme: 'bootstrap4'
	});
	$("#tempEntityIdEdit").select2({
		theme: 'bootstrap4'
	});
	$("#tempDesignationIdEdit").select2({
		theme: 'bootstrap4'
	});
	$("#tempDepartmentIdEdit").select2({
		theme: 'bootstrap4'
	});
	$("#userReportingManagerEdit").select2({
		theme: 'bootstrap4'
	});
	$("#userRolesTempEdit").select2({
		theme: 'bootstrap4'
	});
	$("#userAppsTempEdit").select2({
		theme: 'bootstrap4'
	});
	$("#userTable").DataTable({
		"ordering": false,
		"paging": true,
		"info": true,
		"lengthChange": true,
		"searching": true,
		"autoWidth": false,
		"responsive": false,
		"drawCallback": function(settings) {
			if (pagination) {
				$('#userTable_paginate').find(".pagination").append('<li class="paginate_button page-item"><a onclick="loadNextSetValues()" id="loadMore_userTable" class="fa fa-arrow-right page-link" href="#" title="Load More"></a></li>');
			}
		},
		"createdRow": function (row,data,index) {
	    	if(index % 2 == 0) {
	    		$(row).addClass("bg-table-row-0");
	    	} else {
	    		$(row).addClass("bg-table-row-1");
	    	}
	    },
		"buttons": ["csv", "excel", {
			extend: 'pdf',
			className:'buttons-pdf',
			text:'PDF',
			titleAttr: 'Download in PDF',
			title:"User List",
			orientation: 'landscape',
			customize: function (doc) {
				var now = new Date();
				var jsDate = now.getDate()+'-'+(now.getMonth()+1)+'-'+now.getFullYear();
				var logo = 'data:image/png;base64,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';
				doc['header']=(function() { return {
					columns: [{
						alignment: 'left',
						fontSize: 15,
						text: "User List",
					}, {
						alignment: 'right',
						image: logo,
						width: 100,
						height:20
					}],
					margin: 10
				}});
				doc['footer']=(function(page, pages) { return {
					columns: [{
						alignment: 'left',
						text: ['Created on: ', { text: jsDate.toString() }]
					}, {
						alignment: 'right',
						text: ['Page ', { text: page.toString() },	' of ',	{ text: pages.toString() }]
					}],
					margin: 20
				}});
			},
			pageSize: 'LEGAL',
			exportOptions: {
				columns: ':visible thead th:not(.noExport)'
			}
		}, "print", "colvis"]
	}).buttons().container().appendTo('#userTable_wrapper .col-md-6:eq(0)');

	var userTable = $("#userTable").DataTable();
	var loadAll = window.location.href.split("all").length;
	if(userTable.rows().count() < 20 || loadAll > 1) {
		$("#loadMore_userTable").hide();
		pagination = false;
	}

	if($("#openAddModel").val() != "") {
		$(".btn-tool").click();
	}
	if($("#openEditModel").val() != "") {
		$("#closeEditUserModal").attr("onclick", "location.href='user'");
		$("#userInfomationEditModal").modal({
		    backdrop: 'static',
		    keyboard: false
		});
	}
});
function loadNextSetValues() {
	var userTable = $("#userTable").DataTable();
	var offsetValue = userTable.rows().count();
	$('body').addClass('disableClickBody');
	$(".package-loader").show();
	$.ajax({
		url:'loadMoreUsers',
		type:'GET',
		data:{'offsetValue':offsetValue},
		dataType : 'json',
		success: function(result) {
			for(var i=0; i<result.length; i++) {
				console.log(result[i]["userActive"]);
				userTable.row.add([
					result[i]["userAction"],result[i]["userFirstName"]+" "+result[i]["userMiddleName"]+" "+result[i]["userLastName"],
					result[i]["userEmailId"],result[i]["userEntity"],result[i]["userLocation"],
					result[i]["userZone"],result[i]["userRoles"],result[i]["userActive"]
				]);
			}
			userTable.draw(false);
			var currentPage = userTable.page.info().page;
			var totalPages = userTable.page.info().pages;
			console.log(totalPages);
			if(totalPages > 1) {
				if(currentPage != (totalPages-1)) {
					userTable.page(currentPage+1).draw(false);
				}
			}
			$("#userTable_paginate").scroll();
			$('#userTable_paginate').show();
			if(result.length < 20) {
				pagination = false;
				$('#loadMore_userTable').hide();
			}
			$('body').removeClass('disableClickBody');
			$(".package-loader").hide();
		},
		error:function() {
			$('#userTable_paginate').show();
			$('body').removeClass('disableClickBody');
			$(".package-loader").hide();
			alert("Something went wrong, kindly try again after sometime.");
		}
	});
}
function getUserInfo(mUserId) {
	$('body').addClass('disableClickBody');
	$(".package-loader").show();
	$.ajax({
		url: 'getUserDetails',
		type: 'GET',
		data: { 'mUserId': mUserId },
		dataType: 'json',
		success: function(result) {
			$(".userFirstName").html(result["userFirstName"]);
			$(".userMiddleName").html(result["userMiddleName"]);
			$(".userLastName").html(result["userLastName"]);
			$(".userLoginId").html(result["userLoginId"]);
			$(".userPhoneNumber").html(result["userPhoneNumber"]);
			$(".tempEntityId").html(result["userEntityName"]);
			$(".tempLocationId").html(result["userEntityLocationName"]);
			$(".tempDesignationId").html(result["userDesignation"]);
			$(".tempDepartmentId").html(result["userDepartment"]);
			$(".userReportingManagerMail").html(result["userReportingManagerMailId"]);
			$(".userReportingManagerName").html(result["userReportingManagerName"]);
			$('body').removeClass('disableClickBody');
			$(".package-loader").hide();
			$("#userInformationModal").modal({
			    backdrop: 'static',
			    keyboard: false
			});
		},
		error: function() {
			alert("Something went wrong, try again later");
			$('body').removeClass('disableClickBody');
			$(".package-loader").hide();
		}
	});
}
function editUserInfo(mUserId) {
	$('body').addClass('disableClickBody');
	$(".package-loader").show();
	$('body').addClass('disableClickBody');
	$(".package-loader").show();
	$.ajax({
		url: 'getUserDetails',
		type: 'GET',
		data: { 'mUserId': mUserId },
		dataType: 'json',
		success: function(result) {
			clearEditFormValidation();
			$("#mUserId").val(mUserId);
			$("#userFirstNameEdit").val(result["userFirstName"]);
			$("#userMiddleNameEdit").val(result["userMiddleName"]);
			$("#userLastNameEdit").val(result["userLastName"]);
			$("#userLoginIdEdit").val(result["userLoginId"]);
			$("#userPhoneNumberEdit").val(result["userPhoneNumber"]);
			$("#tempEntityIdEdit").val(result["userEntityId"]).trigger("change");
			$("#tempDesignationIdEdit").val(result["userDesignationId"]).trigger("change");
			$("#tempDepartmentIdEdit").val(result["userDepartmentId"]).trigger("change");
			$("#userReportingManagerMailEdit").val(result["userReportingManagerMailId"]);
			$("#userReportingManagerNameEdit").val(result["userReportingManagerName"]);
			$("#userReportingManagerEdit").val(result["userReportingManager"]).trigger("change");
			
			var userRolesTemp = result["userRoles"].split(",");
			if(userRolesTemp != "") {
				$("#userRolesTempEdit").val(userRolesTemp).trigger("change");
			}
			
			var userAppsTemp = result["userApps"].split(",");
			if(userAppsTemp != "") {
				$("#userAppsTempEdit").val(userAppsTemp).trigger("change");
			}
			
			if(result["userActive"] == "1") {
				$("#userActive1").prop('checked', true);
				$("#userActive2").prop('checked', false);
			} else {
				$("#userActive1").prop('checked', false);
				$("#userActive2").prop('checked', true);
			}
			$('body').removeClass('disableClickBody');
			$(".package-loader").hide();
			$("#userInfomationEditModal").modal({
			    backdrop: 'static',
			    keyboard: false
			});
		},
		error: function() {
			alert("Something went wrong, try again later");
			$('body').removeClass('disableClickBody');
			$(".package-loader").hide();
		}
	});
}
function clearEditFormValidation() {
	$("#userFirstNameEditError").html("");
	$("#userFirstNameEdit").removeClass("is-valid");
	$("#userFirstNameEdit").removeClass("is-invalid");

	$("#userMiddleNameEditError").html("");
	$("#userMiddleNameEdit").removeClass("is-valid");
	$("#userMiddleNameEdit").removeClass("is-invalid");
	
	$("#userLastNameEditError").html("");
	$("#userLastNameEdit").removeClass("is-valid");
	$("#userLastNameEdit").removeClass("is-invalid");

	$("#userLoginIdEditError").html("");
	$("#userLoginIdEdit").removeClass("is-valid");
	$("#userLoginIdEdit").removeClass("is-invalid");

	$("#userPhoneNumberEditError").html("");
	$("#userPhoneNumberEdit").removeClass("is-valid");
	$("#userPhoneNumberEdit").removeClass("is-invalid");
	
	$("#tempEntityIdEditError").html("");
	$("#tempEntityIdEdit").removeClass("is-valid");
	$("#tempEntityIdEdit").removeClass("is-invalid");

	$("#tempLocationIdEditError").html("");
	$("#tempLocationIdEdit").removeClass("is-valid");
	$("#tempLocationIdEdit").removeClass("is-invalid");

	$("#tempDesignationIdEditError").html("");
	$("#tempDesignationIdEdit").removeClass("is-valid");
	$("#tempDesignationIdEdit").removeClass("is-invalid");

	$("#tempDepartmentIdEditError").html("");
	$("#tempDepartmentIdEdit").removeClass("is-valid");
	$("#tempDepartmentIdEdit").removeClass("is-invalid");
	
	$("#tempEntityIdEdit").val("").trigger("change");
	$("#tempDesignationIdEdit").val("").trigger("change");
	$("#tempDepartmentIdEdit").val("").trigger("change");
	$("#userReportingManagerEdit").val("").trigger("change");
}
$("#userEditForm").submit(function(){
	$("#saveUserChanges").addClass("disabledButton");
	$('body').addClass('disableClickBody');
	$(".package-loader").show();
	var submitOrNot = true;
	if(userFirstNameEditValidation() == false) {
		console.log("1");
		submitOrNot = false;
	}
	if(userMiddleNameEditValidation() == false) {
		console.log("2");
		submitOrNot = false;
	}
	if(userLastNameEditValidation() == false) {
		console.log("3");
		submitOrNot = false;
	}
	if(emailIdEditValidation == false) {
		console.log("4");
		submitOrNot = false;
	}
	if(tempEntityIdEditValidation() == false) {
		console.log("5");
		submitOrNot = false;
	}
	if(tempDepartmentIdEditValidation() == false) {
		console.log("6");
		submitOrNot = false;
	}
	if(tempDesignationIdEditValidation() == false) {
		console.log("7");
		submitOrNot = false;
	}
	if(userPhoneNumberEditValidation() == false) {
		console.log("8");
		submitOrNot = false;
	}
	if(userReportingManagerNameEditValidation() == false) {
		console.log("9");
		submitOrNot = false;
	}
	if(userReportingManagerMailEditValidation() == false) {
		console.log("10");
		submitOrNot = false;
	}
	if($("#userActive1").prop("checked") == false && $("#userActive2").prop("checked") == false) {
		$("#isActiveError").html("User state must be selected");
		submitOrNot = false;
	}
	if(submitOrNot) {
		return true;
	} else {
		$("#saveUserChanges").removeClass("disabledButton");
		$('body').removeClass('disableClickBody');
		$(".package-loader").hide();
		return false;
	}
});


$("#userFirstNameEdit").focusout(function() {
	userFirstNameEditValidation();
});
function userFirstNameEditValidation() {
	var userFirstNameEdit = $("#userFirstNameEdit").val().replace(/\s+/g, " ");
	$("#userFirstNameErrorEdit").html("");
	$("#userFirstNameEdit").removeClass("is-valid");
	$("#userFirstNameEdit").removeClass("is-invalid");
	if(userFirstNameEdit != "") {
		if(stringCheck.test(userFirstNameEdit) == false) {
			$("#userFirstNameEdit").addClass("is-invalid");
			$("#userFirstNameErrorEdit").html("First Name can only contain alphabets.");
			return false;
		} else {
			$("#userFirstNameEdit").addClass("is-valid");
			return true;
		}
	} else {
		$("#userFirstNameEdit").addClass("is-invalid");
		$("#userFirstNameErrorEdit").html("First Name cannot be empty.");
		return false;
	}
}
$("#userMiddleNameEdit").focusout(function() {
	userMiddleNameEditValidation();
});
function userMiddleNameEditValidation() {
	var userMiddleNameEdit = $("#userMiddleNameEdit").val().replace(/\s+/g, " ");
	$("#userMiddleNameErrorEdit").html("");
	$("#userMiddleNameEdit").removeClass("is-valid");
	$("#userMiddleNameEdit").removeClass("is-invalid");
	if(userMiddleNameEdit != "") {
		if(stringCheck.test(userMiddleNameEdit) == false) {
			$("#userMiddleNameEdit").addClass("is-invalid");
			$("#userMiddleNameErrorEdit").html("Middle Name can only contain alphabets.");
			return false;
		} else {
			$("#userMiddleNameEdit").addClass("is-valid");
			return true;
		}
	} else {
		return true;
	}
}
$("#userLastNameEdit").focusout(function() {
	userLastNameEditValidation();
});
function userLastNameEditValidation() {
	var userLastNameEdit = $("#userLastNameEdit").val().replace(/\s+/g, " ");
	$("#userLastNameErrorEdit").html("");
	$("#userLastNameEdit").removeClass("is-valid");
	$("#userLastNameEdit").removeClass("is-invalid");
	if(userLastNameEdit != "") {
		if(stringCheck.test(userLastNameEdit) == false) {
			$("#userLastNameEdit").addClass("is-invalid");
			$("#userLastNameErrorEdit").html("Last Name can only contain alphabets.");
			return false;
		} else {
			$("#userLastNameEdit").addClass("is-valid");
			return true;
		}
	} else {
		$("#userLastNameEdit").addClass("is-invalid");
		$("#userLastNameErrorEdit").html("Last Name cannot be empty.");
		return false;
	}
}
$("#userLoginIdEdit").focusout(function() {
	userLoginIdEditValidation();
});
var validMailIdFormat = /^[A-Z0-9._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
function userLoginIdEditValidation() {
	$("#userLoginIdErrorEdit").html("");
	$("#userLoginIdEdit").removeClass("is-valid");
	$("#userLoginIdEdit").removeClass("is-invalid");
	var userLoginIdEdit = $("#userLoginIdEdit").val().replace(/\s+/g, " ");
	if(userLoginIdEdit != "") {
		if(validMailIdFormat.test(userLoginIdEdit) == false) {
			$("#userLoginIdEdit").addClass("is-invalid");
			$("#userLoginIdErrorEdit").html("Enter valid email address.");
			return false;
		} else {
			$("#emailCheckLoader").show();
			emailIdEditValidation = false;
			$.ajax({
				url:'checkUserExists',
				type:'GET',
				data:{'userLoginId':userLoginIdEdit, 'mUserId' : $("#mUserId").val()},
				success: function(result) {
					if(result == "proceed") {
						emailIdEditValidation = true;
						$("#userLoginIdEdit").addClass("is-valid");
					} else if(result == "exists") {
						$("#userLoginIdEdit").addClass("is-invalid");
						$("#userLoginIdErrorEdit").html("Email Address Already Exists.");
					}
					$("#emailCheckLoader").hide();
				},
				error:function() {
					$("#emailCheckLoader").hide();
					$("#userLoginIdErrorEdit").html("Some Exception occures, try again after some time.");
				}
			});
			return true;
		}
	} else {
		$("#userLoginIdEdit").addClass("is-invalid");
		$("#userLoginIdErrorEdit").html("Email Address cannot be empty.");
		return false;
	}
}
$("#tempEntityIdEdit").change(function() {
	tempEntityIdEditValidation();
});
function tempEntityIdEditValidation() {
	$("#tempEntityIdEditError").html("");
	$("#tempEntityIdEdit").removeClass("is-valid");
	$("#tempEntityIdEdit").removeClass("is-invalid");
	var tempEntityIdEdit = $("#tempEntityIdEdit").val();
	if(tempEntityIdEdit == -1) {
		$("#tempEntityIdEdit").addClass("is-invalid");
		$("#tempEntityIdEditError").html("Select your company/entity.");
		return false;
	} else {
		$("#tempEntityIdEdit").addClass("is-valid");
		return true;
	}
}
$("#tempDepartmentIdEdit").change(function() {
	tempDepartmentIdEditValidation();
});
function tempDepartmentIdEditValidation() {
	$("#tempDepartmentIdEditError").html("");
	$("#tempDepartmentIdEdit").removeClass("is-valid");
	$("#tempDepartmentIdEdit").removeClass("is-invalid");
	var tempDepartmentIdEdit = $("#tempDepartmentIdEdit").val();
	if(tempDepartmentIdEdit == -1) {
		$("#tempDepartmentIdEdit").addClass("is-invalid");
		$("#tempDepartmentIdEditError").html("Select your designation.");
		return false;
	} else {
		$("#tempDepartmentIdEdit").addClass("is-valid");
		return true;
	}
}
$("#tempDesignationIdEdit").change(function() {
	tempDesignationIdEditValidation();
});
function tempDesignationIdEditValidation() {
	$("#tempDesignationIdEditError").html("");
	$("#tempDesignationIdEdit").removeClass("is-valid");
	$("#tempDesignationIdEdit").removeClass("is-invalid");
	var tempDesignationIdEdit = $("#tempDesignationIdEdit").val();
	if(tempDesignationIdEdit == -1) {
		$("#tempDesignationIdEdit").addClass("is-invalid");
		$("#tempDesignationIdEditError").html("Select your department.");
		return false;
	} else {
		$("#tempDesignationIdEdit").addClass("is-valid");
		return true;
	}
}
$("#userPhoneNumberEdit").focusout(function() {
	userPhoneNumberEditValidation();
});
var allAreNumbers = /^[0-9]+$/;
function userPhoneNumberEditValidation() {
	var userPhoneNumberEdit = $("#userPhoneNumberEdit").val().replace(/\s+/g, " ");
	$("#userPhoneNumberEditError").html("");
	$("#userPhoneNumberEdit").removeClass("is-valid");
	$("#userPhoneNumberEdit").removeClass("is-invalid");
	if(userPhoneNumberEdit != "") {
		if(allAreNumbers.test(userPhoneNumberEdit) == false) {
			$("#userPhoneNumberEdit").addClass("is-invalid");
			$("#userPhoneNumberEditError").html("You can only enter numeric value here.");
			return false;
		} else if(userPhoneNumberEdit.length != 10) {
			$("#userPhoneNumberEdit").addClass("is-invalid");
			$("#userPhoneNumberEditError").html("Enter 10 digit valid mobile number.");
			return false;
		} else {
			$("#userPhoneNumberEdit").addClass("is-valid");
			return true;
		}
	} else {
		$("#userPhoneNumberEdit").addClass("is-invalid");
		$("#userPhoneNumberEditError").html("Enter your phone number.");
		return false;
	}
}
$("#userReportingManagerNameEdit").focusout(function() {
	userReportingManagerNameEditValidation();
});
function userReportingManagerNameEditValidation() {
	var userReportingManagerNameEdit = $("#userReportingManagerNameEdit").val().replace(/\s+/g, " ");
	$("#userReportingManagerNameEditError").html("");
	$("#userReportingManagerNameEdit").removeClass("is-valid");
	$("#userReportingManagerNameEdit").removeClass("is-invalid");
	if(userReportingManagerNameEdit != "") {
		if(stringCheck.test(userReportingManagerNameEdit) == false) {
			$("#userReportingManagerNameEdit").addClass("is-invalid");
			$("#userReportingManagerNameEditError").html("Manager Name can only contain alphabets.");
			return false;
		} else {
			$("#userReportingManagerNameEdit").addClass("is-valid");
			return true;
		}
	} else {
		$("#userReportingManagerNameEdit").addClass("is-invalid");
		$("#userReportingManagerNameEditError").html("Manager Name cannot be empty.");
		return false;
	}
}
$("#userReportingManagerMailEdit").focusout(function() {
	userReportingManagerMailEditValidation();
});
function userReportingManagerMailEditValidation() {
	$("#userReportingManagerMailErrorEdit").html("");
	$("#userReportingManagerMailEdit").removeClass("is-valid");
	$("#userReportingManagerMailEdit").removeClass("is-invalid");
	var userReportingManagerMailEdit = $("#userReportingManagerMailEdit").val().replace(/\s+/g, " ");
	if(userReportingManagerMailEdit != "") {
		if(validMailIdFormat.test(userReportingManagerMailEdit) == false) {
			$("#userReportingManagerMailEdit").addClass("is-invalid");
			$("#userReportingManagerMailErrorEdit").html("Enter valid email address.");
			return false;
		} else {
			$("#userReportingManagerMailEdit").addClass("is-valid");
			return true;
		}
	} else {
		$("#userReportingManagerMailEdit").addClass("is-invalid");
		$("#userReportingManagerMailErrorEdit").html("Email Address cannot be empty.");
		return false;
	}
};
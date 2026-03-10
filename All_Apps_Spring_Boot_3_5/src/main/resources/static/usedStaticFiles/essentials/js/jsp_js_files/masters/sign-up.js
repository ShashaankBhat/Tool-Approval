var emailIdValidation = false;
$(function() {
	$('.select2').select2({
		theme: 'bootstrap4'
	});
});
$("#signUpForm").submit(function(e){
/*function submitNow() {*/
	var submitOrNot = true;
	if(userFirstNameValidation() == false) {
		console.log("1");
		submitOrNot = false;
	}
	if(userMiddleNameValidation() == false) {
		console.log("2");
		submitOrNot = false;
	}
	if(userLastNameValidation() == false) {
		console.log("3");
		submitOrNot = false;
	}
	if(emailIdValidation == false) {
		console.log("4");
		submitOrNot = false;
	}
	if(tempEntityIdValidation() == false) {
		console.log("5");
		submitOrNot = false;
	}
	if(tempDepartmentIdValidation() == false) {
		console.log("6");
		submitOrNot = false;
	}
	if(tempDesignationIdValidation() == false) {
		console.log("7");
		submitOrNot = false;
	}
	/*if(userPhoneNumberValidation() == false) {
		console.log("8");
		submitOrNot = false;
	}*/
	/*if(reportingManagerValidation() == false) {
		console.log("9");
		submitOrNot = false;
	}*/
	if(userPasswordValidation() == false) {
		console.log("10");
		submitOrNot = false;
	}
	if(userPasswordTwoValidation() == false) {
		console.log("11");
		submitOrNot = false;
	}
	console.log("submitOrNot : "+submitOrNot);
	if(submitOrNot) {
		return true;
		/*$("#signUpForm").submit();*/
	} else {
		return false;
	}
/*}*/
});
var stringCheck = /^[a-zA-Z_ ]*$/;
$("#userFirstName").focusout(function() {
	userFirstNameValidation();
});
function userFirstNameValidation() {
	var userFirstName = $("#userFirstName").val().replace(/\s+/g, " ");
	$("#userFirstNameError").html("");
	$("#userFirstName").removeClass("is-valid");
	$("#userFirstName").removeClass("is-invalid");
	if(userFirstName != "") {
		if(stringCheck.test(userFirstName) == false) {
			$("#userFirstName").addClass("is-invalid");
			$("#userFirstNameError").html("First Name can only contain alphabets.");
			return false;
		} else {
			$("#userFirstName").addClass("is-valid");
			return true;
		}
	} else {
		$("#userFirstName").addClass("is-invalid");
		$("#userFirstNameError").html("First Name cannot be empty.");
		return false;
	}
}
$("#userMiddleName").focusout(function() {
	userMiddleNameValidation();
});
function userMiddleNameValidation() {
	var userMiddleName = $("#userMiddleName").val().replace(/\s+/g, " ");
	$("#userMiddleNameError").html("");
	$("#userMiddleName").removeClass("is-valid");
	$("#userMiddleName").removeClass("is-invalid");
	if(userMiddleName != "") {
		if(stringCheck.test(userMiddleName) == false) {
			$("#userMiddleName").addClass("is-invalid");
			$("#userMiddleNameError").html("Middle Name can only contain alphabets.");
			return false;
		} else {
			$("#userMiddleName").addClass("is-valid");
			return true;
		}
	} else {
		return true;
	}
}
$("#userLastName").focusout(function() {
	userLastNameValidation();
});
function userLastNameValidation() {
	var userLastName = $("#userLastName").val().replace(/\s+/g, " ");
	$("#userLastNameError").html("");
	$("#userLastName").removeClass("is-valid");
	$("#userLastName").removeClass("is-invalid");
	if(userLastName != "") {
		if(stringCheck.test(userLastName) == false) {
			$("#userLastName").addClass("is-invalid");
			$("#userLastNameError").html("Last Name can only contain alphabets.");
			return false;
		} else {
			$("#userLastName").addClass("is-valid");
			return true;
		}
	} else {
		$("#userLastName").addClass("is-invalid");
		$("#userLastNameError").html("Last Name cannot be empty.");
		return false;
	}
}
$("#userLoginId").focusout(function() {
	userLoginIdValidation();
});
var validMailIdFormat = /^[A-Z0-9._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
function userLoginIdValidation() {
	$("#userLoginIdError").html("");
	$("#userLoginId").removeClass("is-valid");
	$("#userLoginId").removeClass("is-invalid");
	var userLoginId = $("#userLoginId").val().replace(/\s+/g, " ");
	if(userLoginId != "") {
		if(validMailIdFormat.test(userLoginId) == false) {
			$("#userLoginId").addClass("is-invalid");
			$("#userLoginIdError").html("Enter valid email address.");
			return false;
		} else {
			$("#emailCheckLoader").show();
			emailIdValidation = false;
			$.ajax({
				url:'checkUserExists',
				type:'GET',
				data:{'userLoginId':userLoginId, 'register' : 1},
				success: function(result) {
					if(result == "proceed") {
						emailIdValidation = true;
						$("#userLoginId").addClass("is-valid");
					} else if(result == "exists") {
						$("#userLoginId").addClass("is-invalid");
						$("#userLoginIdError").html("Email Address Already Exists.");
					}
					$("#emailCheckLoader").hide();
				},
				error:function() {
					$("#emailCheckLoader").hide();
					$("#userLoginIdError").html("Some Exception occures, try again after some time.");
				}
			});
			return true;
		}
	} else {
		$("#userLoginId").addClass("is-invalid");
		$("#userLoginIdError").html("Email Address cannot be empty.");
		return false;
	}
}
$("#tempEntityId").change(function() {
	tempEntityIdValidation();
});
function tempEntityIdValidation() {
	$("#tempEntityIdError").html("");
	$("#tempEntityId").removeClass("is-valid");
	$("#tempEntityId").removeClass("is-invalid");
	var tempEntityId = $("#tempEntityId").val();
	if(tempEntityId == -1) {
		$("#tempEntityId").addClass("is-invalid");
		$("#tempEntityIdError").html("Select your company/entity.");
		return false;
	} else {
		$("#tempEntityId").addClass("is-valid");
		return true;
	}
}
$("#tempDepartmentId").change(function() {
	tempDepartmentIdValidation();
});
function tempDepartmentIdValidation() {
	$("#tempDepartmentIdError").html("");
	$("#tempDepartmentId").removeClass("is-valid");
	$("#tempDepartmentId").removeClass("is-invalid");
	var tempDepartmentId = $("#tempDepartmentId").val();
	if(tempDepartmentId == -1) {
		$("#tempDepartmentId").addClass("is-invalid");
		$("#tempDepartmentIdError").html("Select your designation.");
		return false;
	} else {
		$("#tempDepartmentId").addClass("is-valid");
		return true;
	}
}
$("#userManagerId").change(function() {
	reportingManagerValidation();
});
function reportingManagerValidation() {
	$("#userManagerIdError").html("");
	$("#userManagerId").removeClass("is-valid");
	$("#userManagerId").removeClass("is-invalid");
	var userManagerId = $("#userManagerId").val();
	if(userManagerId == -1) {
		$("#userManagerId").addClass("is-invalid");
		$("#userManagerIdError").html("Select your reporting manager.");
		return false;
	} else {
		$("#userManagerId").addClass("is-valid");
		return true;
	}
}

$("#tempDesignationId").change(function() {
	tempDesignationIdValidation();
});
function tempDesignationIdValidation() {
	$("#tempDesignationIdError").html("");
	$("#tempDesignationId").removeClass("is-valid");
	$("#tempDesignationId").removeClass("is-invalid");
	var tempDesignationId = $("#tempDesignationId").val();
	if(tempDesignationId == -1) {
		$("#tempDesignationId").addClass("is-invalid");
		$("#tempDesignationIdError").html("Select your department.");
		return false;
	} else {
		$("#tempDesignationId").addClass("is-valid");
		return true;
	}
}

$("#userPhoneNumber").focusout(function() {
	userPhoneNumberValidation();
});
var allAreNumbers = /^[0-9]+$/;
function userPhoneNumberValidation() {
	var userPhoneNumber = $("#userPhoneNumber").val().replace(/\s+/g, " ");
	$("#userPhoneNumberError").html("");
	$("#userPhoneNumber").removeClass("is-valid");
	$("#userPhoneNumber").removeClass("is-invalid");
	if(userPhoneNumber != "") {
		if(allAreNumbers.test(userPhoneNumber) == false) {
			$("#userPhoneNumber").addClass("is-invalid");
			$("#userPhoneNumberError").html("You can only enter numeric value here.");
			return false;
		} else if(userPhoneNumber.length != 10) {
			$("#userPhoneNumber").addClass("is-invalid");
			$("#userPhoneNumberError").html("Enter 10 digit valid mobile number.");
			return false;
		} else {
			$("#userPhoneNumber").addClass("is-valid");
			return true;
		}
	} else {
		$("#userPhoneNumber").addClass("is-invalid");
		$("#userPhoneNumberError").html("Enter your phone number.");
		return false;
	}
}
var passwordCheck = /^[a-zA-Z0-9_ ]*$/;
/*6-20 one upper-case, one lower-case and one numeric*/
var passwordCheck_v1 = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,20}$/;
/*7 to 15 characters which contain at least one numeric digit and a special character*/
var passwordCheck_v2 = /^(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{7,15}$/;
/*8 to 15 characters which contain at least one lowercase letter, one uppercase letter, one numeric digit, and one special character*/
var passwordCheck_v3 = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{6,15}$/;

$("#userPassword").focusout(function() {
	userPasswordValidation();
});
function userPasswordValidation() {
	$("#userPasswordError").html("");
	$("#userPassword").removeClass("is-valid");
	$("#userPassword").removeClass("is-invalid");
	var userPassword = $("#userPassword").val().replace(/\s+/g, " ");
	if(userPassword != "") {
		if(userPassword.match(passwordCheck_v3)) {
			$("#userPassword").addClass("is-valid");
			return true;
		} else {
			$("#userPassword").addClass("is-invalid");
			$("#userPasswordError").html("Password must contain 6 to 15 characters, one lowercase letter, one uppercase letter, one numeric digit, and one special character");
			return false;
		}
	} else {
		$("#userPassword").addClass("is-invalid");
		$("#userPasswordError").html("Type your password.");
		return false;
	}
}
$("#userPasswordTwo").focusout(function() {
	userPasswordTwoValidation();
});
function userPasswordTwoValidation() {
	var userPasswordTwo = $("#userPasswordTwo").val().replace(/\s+/g, " ");
	var userPassword = $("#userPassword").val().replace(/\s+/g, " ");
	$("#userPasswordTwoError").html("");
	$("#userPasswordTwo").removeClass("is-valid");
	$("#userPasswordTwo").removeClass("is-invalid");
	if(userPasswordTwo != "") {
		if(userPasswordTwo.match(passwordCheck_v3)) {
			if(userPassword != userPasswordTwo) {
				$("#userPasswordTwo").addClass("is-invalid");
				$("#userPasswordTwoError").html("Password does not match.");
				return false;
			} else {
				$("#userPasswordTwo").addClass("is-valid");
				return true;
			}
		} else {
			$("#userPasswordTwo").addClass("is-invalid");
			$("#userPasswordTwoError").html("Password must contain 6 to 15 characters, one lowercase letter, one uppercase letter, one numeric digit, and one special character");
			return false;
		}
	} else {
		$("#userPasswordTwo").addClass("is-invalid");
		$("#userPasswordTwoError").html("Re-Type your password.");
		return false;
	}
}
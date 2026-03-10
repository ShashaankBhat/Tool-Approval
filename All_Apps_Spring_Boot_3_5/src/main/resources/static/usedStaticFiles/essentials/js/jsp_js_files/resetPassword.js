/**
 * ******************************************************************************************
 * Copyright © 2021-2022 ANAND Automotive Private Limited. All rights reserved.				*
 * No part of this product may be reproduced in any form by any means without prior			*
 * written authorization of ANAND Automotive Private Limited and its licensors, if any.		*
 * ******************************************************************************************
 * Author - ANAND Automotive Private Limited - Corporate IT - R S Iyer						*
 * ******************************************************************************************
 */
var emailIdValidation = false;
$(function() {
	/*write code here for onload of login_page.jsp*/
});
var stringCheck = /^[a-zA-Z_ ]*$/;
$("#resetPasswordForm").submit(function() {

	$("#submitReSetPassword").addClass("disabledButton");
	$('body').addClass('disableClickBody');
	$(".anand-loader").show();

	var submitOrNot = true;

	$("#currentPasswordError").html("");
	$("#currentPassword").removeClass("is-valid");
	$("#currentPassword").removeClass("is-invalid");
	if($("#currentPassword").val() == "") {
		$("#currentPassword").addClass("is-invalid");
		$("#currentPasswordError").html("Current password cannot be empty");
		submitOrNot = false;
	} else {
		$("#currentPassword").addClass("is-valid");
	}
	
	if(passwordValidation() == false) {
		submitOrNot = false;
	}

	if(retypePasswordValidation() == false) {
		submitOrNot = false;
	}

	console.log("submitOrNot : "+submitOrNot);
	if(submitOrNot) {
		return true;
	} else {
		$("#submitReSetPassword").removeClass("disabledButton");
		$('body').removeClass('disableClickBody');
		$(".anand-loader").hide();
		return false;
	}
});
$("#newPassword").focusout(function() {
	passwordValidation();
});
$("#confirmNewPassword").focusout(function() {
	retypePasswordValidation();
});

var passwordCheck_v3 = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{6,15}$/;

function passwordValidation() {
	$("#newPasswordError").html("");
	$("#newPassword").removeClass("is-valid");
	$("#newPassword").removeClass("is-invalid");
	var password = $("#newPassword").val().replace(/\s+/g, " ");
	if(password != "") {
		if(password.match(passwordCheck_v3)) {
			$("#newPassword").addClass("is-valid");
			return true;
		} else {
			$("#newPassword").addClass("is-invalid");
			$("#newPasswordError").html("Password must contain 6 to 15 characters, one lowercase letter, one uppercase letter, one numeric digit, and one special character");
			return false;
		}
	} else {
		$("#newPassword").addClass("is-invalid");
		$("#newPasswordError").html("Type your password.");
		return false;
	}
}
function retypePasswordValidation() {
	var retypePassword = $("#confirmNewPassword").val().replace(/\s+/g, " ");
	var password = $("#newPassword").val().replace(/\s+/g, " ");
	$("#confirmNewPasswordError").html("");
	$("#confirmNewPassword").removeClass("is-valid");
	$("#confirmNewPassword").removeClass("is-invalid");
	if(retypePassword != "") {
		if(retypePassword.match(passwordCheck_v3)) {
			if(password != retypePassword) {
				$("#confirmNewPassword").addClass("is-invalid");
				$("#confirmNewPasswordError").html("Password does not match.");
				return false;
			} else {
				$("#confirmNewPassword").addClass("is-valid");
				return true;
			}
		} else {
			$("#confirmNewPassword").addClass("is-invalid");
			$("#confirmNewPasswordError").html("Password must contain 6 to 15 characters, one lowercase letter, one uppercase letter, one numeric digit, and one special character");
			return false;
		}
	} else {
		$("#confirmNewPassword").addClass("is-invalid");
		$("#confirmNewPasswordError").html("Re-Type your password.");
		return false;
	}
}
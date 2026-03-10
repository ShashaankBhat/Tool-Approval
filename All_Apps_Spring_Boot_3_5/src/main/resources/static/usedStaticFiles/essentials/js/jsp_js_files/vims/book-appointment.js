var pagination = true;
$(function() {
	$('.select2').select2({
		theme: 'bootstrap4'
	});
	if($("#visitorId").val() == "") {
		$('#meetingStartDateTemp').datetimepicker({ 
			icons: { time: 'fas fa-clock' },
			format: 'DD/MM/YYYY',
			date: new Date(),
			minDate: new Date()
		});
		$('#meetingEndDateTemp').datetimepicker({ 
			icons: { time: 'fas fa-clock' },
			format: 'DD/MM/YYYY',
			date: new Date(),
			minDate: new Date()
		});
	} else {
		var dateToSet = $("#meetingStartDateTempId").val();
		dateToSet = dateToSet.split("/");
		dateToSet = new Date(dateToSet[2]+"-"+dateToSet[1]+"-"+dateToSet[0]);
		$('#meetingStartDateTemp').datetimepicker({ 
			icons: { time: 'fas fa-clock' },
			format: 'DD/MM/YYYY',
			date: dateToSet,
			minDate: dateToSet
		});
		dateToSet = $("#meetingEndDateTempId").val();
		dateToSet = dateToSet.split("/");
		dateToSet = new Date(dateToSet[2]+"-"+dateToSet[1]+"-"+dateToSet[0]);
		$('#meetingEndDateTemp').datetimepicker({ 
			icons: { time: 'fas fa-clock' },
			format: 'DD/MM/YYYY',
			date: dateToSet,
			minDate: dateToSet
		});
	}
	$('#meetingStartTimeTemp').datetimepicker({ 
		icons: { time: 'fas fa-clock' },
		format: 'hh:mm A'
	});
	$('#meetingEndTimeTemp').datetimepicker({ 
		icons: { time: 'fas fa-clock' },
		format: 'hh:mm A'
	});
});

$('#visitingLocationTemp').on('change', function() {
	var selectedId = $(this).val();
	updateUserOptions(selectedId);
});
function updateUserOptions(mEntityId) {
	$.ajax({
		url: 'getUserbyEntity',
		type: 'GET',
		data: {'mEntityId': mEntityId},
		dataType: 'json',
		success: function (result) {
			$('#hostNameTemp').empty();
			var option = document.createElement("option");
            option.value = -1;
            option.textContent = "Select Host";
            hostNameTemp.appendChild(option);
			for (var i = 0; i < result.length; i++) {
                option = document.createElement("option");
                option.value = result[i]["userId"];
                option.textContent = result[i]["userName"];
                hostNameTemp.appendChild(option);
            }
        }
    })
}
$("#visitor").submit(function() {
	$("#submitVisitorPurposeButton").addClass("disabledButton");
	$('body').addClass('disableClickBody');
	$(".package-loader").show();
	var submitOrNot = true;
	if(visitorNameValidation("") == false) {
		submitOrNot = false;
	}
	if(visitorEmailValidation("") == false) {
		submitOrNot = false;
	}
	if(visitorTypeTempValidation() == false) {
		submitOrNot = false;
	}
	if(visitorPurposeTempValidation() == false) {
		submitOrNot = false;
	}
	if(visitingLocationTempValidation() == false) {
		submitOrNot = false;
	}
	if(totalVisitorValidation("") == false) {
		submitOrNot = false;
	}
	if(visitorCompanyNameValidation("") == false) {
		submitOrNot = false;
	}
	if(visitorCompanyAddressValidation("") == false) {
		submitOrNot = false;
	}
	$("#visitorPermissionChecboxDivError").html("");
	if($("#visitorCanteenAccess").prop("checked") == false && $("#visitorLaptopAllowed").prop("checked") == false
			 && $("#visitorCellPhoneAllowed").prop("checked") == false  && $("#visitorEscortRequired").prop("checked") == false) {
		$("#visitorPermissionChecboxDivError").html("Select permission.");
		submitOrNot = false;
	}
	if(visitorRemarksValidation("") == false) {
		submitOrNot = false;
	}
	if(hostNameTempValidation() == false) {
		submitOrNot = false;
	}
	if(meetingStartDateTempIdValidation("") == false) {
		submitOrNot = false;
	}
	if(meetingStartTimeTempIdValidation("") == false) {
		submitOrNot = false;
	}
	if(meetingEndTimeTempIdValidation("") == false) {
		submitOrNot = false;
	}
	if(meetingEndDateTempIdValidation("") == false) {
		submitOrNot = false;
	}
	if(submitOrNot) {
		return true;
	} else {
		$("#submitVisitorPurposeButton").removeClass("disabledButton");
		$('body').removeClass('disableClickBody');
		$(".package-loader").hide();
		return false;
	}
});
$("#visitorName").focusout(function() {
	visitorNameValidation("");
});
function visitorNameValidation(idAppend) {
	var id = "visitorName"+idAppend;
	var error = "visitorNameError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var visitorName = $("#"+id).val().replace(/\s+/g, " ");
	if(visitorName != "") {
		if(centralAlphaNumericCheck.test(visitorName) == false) {
			$("#"+error).html("Visitor Name cannot contain special characters.");
			$("#"+id).addClass("is-invalid");
			return false;
		} else {
			$("#"+id).addClass("is-valid");
			return true;
		}
	} else {
		$("#"+error).html("Visitor Name cannot be empty.");
		$("#"+id).addClass("is-invalid");
		return false;
	}
}
$("#visitorEmail").focusout(function() {
	visitorEmailValidation("");
});
function visitorEmailValidation(idAppend) {
	var id = "visitorEmail"+idAppend;
	var error = "visitorEmailError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var visitorEmail = $("#"+id).val().replace(/\s+/g, " ");
	if(visitorEmail != "") {
		if(centralEmailFormat.test(visitorEmail) == false) {
			$("#"+error).html("Visitor Email cannot contain special characters.");
			$("#"+id).addClass("is-invalid");
			return false;
		} else {
			$("#"+id).addClass("is-valid");
			return true;
		}
	} else {
		$("#"+error).html("Visitor Email cannot be empty.");
		$("#"+id).addClass("is-invalid");
		return false;
	}
}
$("#visitorTypeTemp").change(function() {
	visitorTypeTempValidation();
});
function visitorTypeTempValidation() {
	$("#visitorTypeTempError").html("");
	$("#visitorTypeTemp").removeClass("is-valid");
	$("#visitorTypeTemp").removeClass("is-invalid");
	var visitorTypeTemp = $("#visitorTypeTemp").val();
	if(visitorTypeTemp == -1) {
		$("#visitorTypeTemp").addClass("is-invalid");
		$("#visitorTypeTempError").html("Select your visitor type.");
		return false;
	} else {
		$("#visitorTypeTemp").addClass("is-valid");
		return true;
	}
}
$("#visitorPurposeTemp").change(function() {
	visitorPurposeTempValidation();
});
function visitorPurposeTempValidation() {
	$("#visitorPurposeTempError").html("");
	$("#visitorPurposeTemp").removeClass("is-valid");
	$("#visitorPurposeTemp").removeClass("is-invalid");
	var visitorPurposeTemp = $("#visitorPurposeTemp").val();
	if(visitorPurposeTemp == -1) {
		$("#visitorPurposeTemp").addClass("is-invalid");
		$("#visitorPurposeTempError").html("Select Purpose.");
		return false;
	} else {
		$("#visitorPurposeTemp").addClass("is-valid");
		return true;
	}
}
$("#visitingLocationTemp").change(function() {
	visitingLocationTempValidation();
});
function visitingLocationTempValidation() {
	$("#visitingLocationTempError").html("");
	$("#visitingLocationTemp").removeClass("is-valid");
	$("#visitingLocationTemp").removeClass("is-invalid");
	var visitingLocationTemp = $("#visitingLocationTemp").val();
	if(visitingLocationTemp == -1) {
		$("#visitingLocationTemp").addClass("is-invalid");
		$("#visitingLocationTempError").html("Select Purpose.");
		return false;
	} else {
		$("#visitingLocationTemp").addClass("is-valid");
		return true;
	}
}
$("#totalVisitor").focusout(function() {
	totalVisitorValidation("");
});
function totalVisitorValidation(idAppend) {
	var id = "totalVisitor"+idAppend;
	var error = "totalVisitorError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var totalVisitor = $("#"+id).val().replace(/\s+/g, " ");
	if(totalVisitor != "") {
		if(centralNumericOnly.test(totalVisitor) == false) {
			$("#"+error).html("Only Numeric input is allowed.");
			$("#"+id).addClass("is-invalid");
			return false;
		} else {
			$("#"+id).addClass("is-valid");
			return true;
		}
	} else {
		$("#"+error).html("Total Visitor cannot be empty.");
		$("#"+id).addClass("is-invalid");
		return false;
	}
}
$("#visitorCompanyName").focusout(function() {
	visitorCompanyNameValidation("");
});
function visitorCompanyNameValidation(idAppend) {
	var id = "visitorCompanyName"+idAppend;
	var error = "visitorCompanyNameError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var visitorCompanyName = $("#"+id).val().replace(/\s+/g, " ");
	if(visitorCompanyName != "") {
		if(centralAlphaNumericCheck.test(visitorCompanyName) == false) {
			$("#"+error).html("Visitor Company Name cannot contain special characters.");
			$("#"+id).addClass("is-invalid");
			return false;
		} else {
			$("#"+id).addClass("is-valid");
			return true;
		}
	} else {
		$("#"+error).html("Visitor Company Name cannot be empty.");
		$("#"+id).addClass("is-invalid");
		return false;
	}
}
$("#visitorCompanyAddress").focusout(function() {
	visitorCompanyAddressValidation("");
});
function visitorCompanyAddressValidation(idAppend) {
	var id = "visitorCompanyAddress"+idAppend;
	var error = "visitorCompanyAddressError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var visitorCompanyAddress = $("#"+id).val().replace(/\s+/g, " ");
	if(visitorCompanyAddress != "") {
		if(centralAlphaNumericDescriptionCheck.test(visitorCompanyAddress) == false) {
			$("#"+error).html("Visitor Company Address cannot contain special characters.");
			$("#"+id).addClass("is-invalid");
			return false;
		} else {
			$("#"+id).addClass("is-valid");
			return true;
		}
	} else {
		$("#"+error).html("Visitor Company Address cannot be empty.");
		$("#"+id).addClass("is-invalid");
		return false;
	}
}
$('#visitorPermissionChecboxDiv input[type="checkbox"]').click(function() {
	$("#visitorPermissionChecboxDivError").html("");
});
$("#visitorRemarks").focusout(function() {
	visitorRemarksValidation("");
});
function visitorRemarksValidation(idAppend) {
	var id = "visitorRemarks"+idAppend;
	var error = "visitorRemarksError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var visitorRemarks = $("#"+id).val().replace(/\s+/g, " ");
	if(visitorRemarks != "") {
		if(centralAlphaNumericDescriptionCheck.test(visitorRemarks) == false) {
			$("#"+error).html("Remarks cannot contain special characters.");
			$("#"+id).addClass("is-invalid");
			return false;
		} else {
			$("#"+id).addClass("is-valid");
			return true;
		}
	} else {
		$("#"+error).html("Remarks cannot be empty.");
		$("#"+id).addClass("is-invalid");
		return false;
	}
}
$("#hostNameTemp").change(function() {
	hostNameTempValidation();
});
function hostNameTempValidation() {
	$("#hostNameTempError").html("");
	$("#hostNameTemp").removeClass("is-valid");
	$("#hostNameTemp").removeClass("is-invalid");
	var hostNameTemp = $("#hostNameTemp").val();
	if(hostNameTemp === null) {
		$("#hostNameTemp").addClass("is-invalid");
		$("#hostNameTempError").html("Select Host.");
		return false;
	} else {
		$("#hostNameTemp").addClass("is-valid");
		return true;
	}
}
$("#meetingStartDateTempId").focusout(function() {
	meetingStartDateTempIdValidation("");
});
function meetingStartDateTempIdValidation(idAppend) {
	var id = "meetingStartDateTempId"+idAppend;
	var error = "meetingStartDateTempIdError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var meetingStartDateTempId = $("#"+id).val();
	if(meetingStartDateTempId != "") {
		$("#"+id).addClass("is-valid");
		return true;
	} else {
		$("#"+error).html("Start Date cannot be empty.");
		$("#"+id).addClass("is-invalid");
		return false;
	}
}
$("#meetingStartTimeTempId").focusout(function() {
	meetingStartTimeTempIdValidation("");
});
function meetingStartTimeTempIdValidation(idAppend) {
	var id = "meetingStartTimeTempId"+idAppend;
	var error = "meetingStartTimeTempIdError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var meetingStartTimeTempId = $("#"+id).val();
	if(meetingStartTimeTempId != "") {
		$("#"+id).addClass("is-valid");
		return true;
	} else {
		$("#"+error).html("Start Time cannot be empty.");
		$("#"+id).addClass("is-invalid");
		return false;
	}
}
$("#meetingEndTimeTempId").focusout(function() {
	meetingEndTimeTempIdValidation("");
});
function meetingEndTimeTempIdValidation(idAppend) {
	var id = "meetingEndTimeTempId"+idAppend;
	var error = "meetingEndTimeTempIdError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var meetingEndTimeTempId = $("#"+id).val();
	if(meetingEndTimeTempId != "") {
		$("#"+id).addClass("is-valid");
		return true;
	} else {
		$("#"+error).html("End Time cannot be empty.");
		$("#"+id).addClass("is-invalid");
		return false;
	}
}
$("#meetingEndDateTempId").focusout(function() {
	meetingEndDateTempIdValidation("");
});
function meetingEndDateTempIdValidation(idAppend) {
	var id = "meetingEndDateTempId"+idAppend;
	var error = "meetingEndDateTempIdError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	$("#startEndDateDiff").html("");
	var meetingEndDateTempId = $("#"+id).val();
	if(meetingEndDateTempId != "") {
		var startDate = $("#meetingStartDateTempId").val();
		var startTime = $("#meetingStartTimeTempId").val();
		var endDate = $("#meetingEndDateTempId").val();
		var endTime = $("#meetingEndTimeTempId").val();
		startDate = startDate.split("/");
		endDate = endDate.split("/");
		startDate = startDate[2]+"-"+startDate[1]+"-"+startDate[0]+" "+startTime;
		endDate = endDate[2]+"-"+endDate[1]+"-"+endDate[0]+" "+endTime;
		startDate = new Date(startDate);
		endDate = new Date(endDate);
		/*console.log(startDate);
		console.log(endDate);
		console.log(startDate.getTime() > endDate.getTime());
		console.log(startDate.getTime() < endDate.getTime());*/
		$("#"+id).addClass("is-valid");
		if(startDate.getTime() > endDate.getTime()) {
			$("#startEndDateDiff").html("Meeting Start Date & Time is after Meeting End Date Time.<br>" + $("#meetingStartDateTempId").val() + " " + $("#meetingStartTimeTempId").val() +
				" - "+$("#meetingEndDateTempId").val() + " "+$("#meetingEndTimeTempId").val());
			return false;
		} else {
			$("#"+id).addClass("is-valid");
			return true;
		}
	} else {
		$("#"+error).html("End Date cannot be empty.");
		$("#"+id).addClass("is-invalid");
		return false;
	}
}
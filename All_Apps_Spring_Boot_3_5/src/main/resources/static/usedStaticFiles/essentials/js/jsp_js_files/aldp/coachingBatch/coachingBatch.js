var pagination = true;
var addBatchCoachCoacheeMapIndex = 0;
var editBatchCoachCoacheeMapIndex = 0;
var coachFinalList = "";
var coacheeFinalList = "";
var supervisorFinalList = "";

$(function() {
	
	var coachList = $("#coachStringForJs").val().trim();
	var coachListSplit = coachList.split("||");
	for(var i = 0; i < coachListSplit.length; i++) {
		coachFinalList += "<option value='"+coachListSplit[i].split("!!")[0]+"'>"+coachListSplit[i].split("!!")[1]+"</option>";
	}
	
	var coacheeList = $("#coacheeStringForJs").val().trim();
	var coacheeListSplit = coacheeList.split("||");
	for(var i = 0; i < coacheeListSplit.length; i++) {
		coacheeFinalList += "<option value='"+coacheeListSplit[i].split("!!")[0]+"'>"+coacheeListSplit[i].split("!!")[1]+"</option>";
	}
	
	var supervisorList = $("#supervisorStringForJs").val().trim();
	var supervisorListSplit = supervisorList.split("||");
	for(var i = 0; i < supervisorListSplit.length; i++) {
		supervisorFinalList += "<option value='"+supervisorListSplit[i].split("!!")[0]+"'>"+supervisorListSplit[i].split("!!")[1]+"</option>";
	}
	
	$('#startDateTemp').datetimepicker({
		icons: { time: 'fas fa-clock' },
        format: 'DD/MM/YYYY',
        /*date: new Date(),*/
        minDate: new Date()
    });
	$('#endDateTemp').datetimepicker({
		icons: { time: 'fas fa-clock' },
        format: 'DD/MM/YYYY',
        /*date: new Date(),*/
        minDate: new Date()
    });
	$('#startDateTempEdit').datetimepicker({
		icons: { time: 'fas fa-clock' },
        format: 'DD/MM/YYYY',
    });
	$('#endDateTempEdit').datetimepicker({
		icons: { time: 'fas fa-clock' },
        format: 'DD/MM/YYYY',
    });
	/*$('#endDateTempEdit').datetimepicker({
		icons: { time: 'fas fa-clock' },
        format: 'DD/MM/YYYY',
        date: new Date(),
        minDate: new Date()
    });*/
	
	$(".editCoachingBatch").hide();
	/*$('#startDateTemp').datepicker({ 
		dateFormat: 'dd/mm/yy',
		//minDate: new Date(),
		beforeShowDay: DisableDates
	});*/
	/*$('#endDateTemp').datepicker({ 
		dateFormat: 'dd/mm/yy',
		//minDate: new Date(''+$("#startDateTemp").val()),
		beforeShowDay: DisableDates
	});*/
	
	/*$('#startDateTempEdit').datepicker({ 
		dateFormat: 'dd/mm/yy',
		//minDate: new Date(''+$("#startDateTemp").val()),
		beforeShowDay: DisableDates
	});
	$('#endDateTempEdit').datepicker({ 
		dateFormat: 'dd/mm/yy',
		//minDate: new Date(''+$("#startDateTemp").val()),
		beforeShowDay: DisableDates
	});*/
	
	$("#batchTable").DataTable({
		"ordering": false,
		"paging": true,
		"info": true,
		"lengthChange": true,
		"searching": true,
		"autoWidth": false,
		"responsive": true,
		"drawCallback": function(settings) {
			if (pagination) {
				$('#batchTable_paginate').find(".pagination").append('<li class="paginate_button page-item"><a onclick="loadNextSetValues()" id="loadMore_batchTable" class="fa fa-arrow-right page-link" href="#" title="Load More"></a></li>');
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
			title:"Coaching Batch List",
			orientation: 'landscape',
			customize: function (doc) {
				var now = new Date();
				var jsDate = now.getDate()+'-'+(now.getMonth()+1)+'-'+now.getFullYear();
				var logo = 'data:image/png;base64,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';
				doc['header']=(function() { return {
					columns: [{
						alignment: 'left',
						fontSize: 15,
						text: "ACT - ANAND Coaching Tracker",
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
						text: ['page ', { text: page.toString() },	' of ',	{ text: pages.toString() }]
					}],
					margin: 20
				}});
			},
			pageSize: 'LEGAL',
			exportOptions: {
				columns: ':visible thead th:not(.noExport)'
			}
		}, "print", "colvis"]
	}).buttons().container().appendTo('#batchTable_wrapper .col-md-6:eq(0)');

	var batchTable = $("#batchTable").DataTable();
	var loadAll = window.location.href.split("all").length;
	if(batchTable.rows().count() < 20 || loadAll > 1) {
		$("#loadMore_batchTable").hide();
		pagination = false;
	}

	if($("#openEditModel").val() != "") {
		$(".editCoachingBatch").show();
		$('html, body').animate({
	        scrollTop: $(".editCoachingBatch").offset().top
	    }, 800);
	}
});
function loadNextSetValues() {
	var batchTable = $("#batchTable").DataTable();
	var offsetValue = batchTable.rows().count();
	$('body').addClass('disableClickBody');
	$(".package-loader").hide();
	$.ajax({
		url:'loadMoreBatch',
		type:'GET',
		data:{'offsetValue':offsetValue},
		dataType : 'json',
		success: function(result) {
			for(var i=0; i<result.length; i++) {
				batchTable.row.add([
					result[i]["batchAction"],result[i]["batchName"],
					result[i]["batchDescription"],result[i]["batchActive"],
					result[i]["batchCreatedBy"],result[i]["batchCreatedOn"],
					result[i]["batchUpdatedBy"],result[i]["batchUpdatedOn"]
				]);
			}
			batchTable.draw(false);
			var currentPage = batchTable.page.info().page;
			var totalPages = batchTable.page.info().pages;
			console.log(totalPages);
			if(totalPages > 1) {
				if(currentPage != (totalPages-1)) {
					batchTable.page(currentPage+1).draw(false);
				}
			}
			$("#batchTable_paginate").scroll();
			$('#batchTable_paginate').show();
			if(result.length < 20) {
				pagination = false;
				$('#loadMore_batchTable').hide();
			}
			$('body').removeClass('disableClickBody');
			$(".anand-loader").hide();
		},
		error:function() {
			$('#batchTable_paginate').show();
			$('body').removeClass('disableClickBody');
			$(".anand-loader").hide();
			alert("Something went wrong, kindly try again after sometime.");
		}
	});
}
function editBatch(actCoachingBatchId) {
	$('body').addClass('disableClickBody');
	$(".package-loader").hide();
	$(".editCoachingBatch").hide();
	$.ajax({
		url: 'getBatchDetails',
		type: 'GET',
		data: { 'actCoachingBatchId': actCoachingBatchId },
		dataType: 'json',
		success: function(result) {
			clearEditFormValidation();
			$("#actCoachingBatchId").val(actCoachingBatchId);
			$("#batchNameEdit").val(result["batchName"]);
			$("#batchDescriptionEdit").val(result["batchDescription"]);
			$("#startDateTempInEdit").val(result["batchStartDate"]);
			$("#endDateTempInEdit").val(result["batchEndDate"]);
			
			$("#batchDurationEdit").val(result["batchDuration"]);
			$("#daysBetweenTwoSessionEdit").val(result["daysBetweenTwoSession"]);
			if(result["batchActive"] == "1") {
				$("#batchActiveEdit1").prop('checked', true);
			} else if(result["batchActive"] == "0")  {
				$("#batchActiveEdit2").prop('checked', true);
			}
			else  {
				$("#batchActiveEdit3").prop('checked', true);
			}
			$('body').removeClass('disableClickBody');
			$(".anand-loader").hide();
			$(".editCoachingBatch").show();
			editBatchCoachCoacheeMapIndex = parseInt(result["coachCoacheeIndex"]);
			for(var i = 0; i < parseInt(result["coachCoacheeIndex"]); i++) {
				var newCoachCoacheeMapping = "<tr class='coacheCoacheeMapTrEdit"+i+"'>"+
					"<td>"+
						"<input type='hidden' name='coachCoacheeMappingList["+i+"].actCoachCoacheeMapActive' id='actCoachCoacheeMapActiveEdit"+i+"' value='1' />"+
						"<input type='hidden' name='coachCoacheeMappingList["+i+"].actCoachCoacheeMapId' id='actCoachCoacheeMapId"+i+"' value='' />"+
						"<a href='#' title='Remove Coach-Coachee' onclick='removeCoachCoacheeMappingEdit("+i+")'><i class='fas fa-times'></i></a>"+
					"</td>"+
					"<td>"+
						"<select onchange='coachIdTempValidation(\"-\","+i+")' class='form-control' name='coachCoacheeMappingList["+i+"].coachIdTemp' id='coachIdTempEdit"+i+"'>"+
							"<option value='-1'>Select  Coach</option>"+
							coachFinalList+
						"</select>"+
						"<span class='error invalid-feedback' id='coachIdTempEditError"+i+"'></span>"+
					"</td>"+
					"<td>"+
						"<select onchange='coacheeIdTempValidation(\"-\","+i+")' class='form-control' name='coachCoacheeMappingList["+i+"].coacheeIdTemp' id='coacheeIdTempEdit"+i+"'>"+
							"<option value='-1'>Select  Coachee</option>"+
							coacheeFinalList+
						"</select>"+
						"<span class='error invalid-feedback' id='coacheeIdTempEditError"+i+"'></span>"+
					"</td>"+
					"<td>"+
						"<select onchange='actCoacheeProgramValidation(\"-\","+i+")' class='form-control' name='coachCoacheeMappingList["+i+"].actCoacheeProgram' id='actCoacheeProgramEdit"+i+"'>"+
							"<option value='-1'>Select ALDP Program</option>"+
							"<option value='1'>AM - ANAND Mentee</option>"+
							"<option value='2'>AT - ANAND Talent</option>"+
							"<option value='3'>AL - ANAND Leader</option>"+
						"</select>"+
						"<span class='error invalid-feedback' id=actCoacheeProgramEditError"+i+"'></span>"+
					"</td>"+
					"<td>"+
						"<select onchange='supervisorIdTempValidation(\"-\","+i+")' class='form-control' name='coachCoacheeMappingList["+i+"].supervisorIdTemp' id='supervisorIdTempEdit"+i+"'>"+
							"<option value='-1'>Select Supervisor</option>"+
							supervisorFinalList+
						"</select>"+
						"<span class='error invalid-feedback' id='supervisorIdTempEditError"+i+"'></span>"+
					"</td>"+
				"</tr>";
				if(i == 0) {
					$('#coachCoacheeTableEdit tbody').append(newCoachCoacheeMapping);
				} else {
					$('#coachCoacheeTableEdit tbody tr:last').after(newCoachCoacheeMapping);
				}
				var id = "coachIdTempEdit"+i;
				var resultId = "coach"+i;
				$("#"+id).val(result[resultId]);
				
				id = "actCoachCoacheeMapId"+i;
				resultId = "actCoachCoacheeMapId"+i;
				$("#"+id).val(result[resultId]);
				
				id = "coacheeIdTempEdit"+i;
				resultId = "coachee"+i;
				$("#"+id).val(result[resultId]);
				
				id = "actCoacheeProgramEdit"+i;
				resultId = "programType"+i;
				$("#"+id).val(result[resultId]);
				
				id = "supervisorIdTempEdit"+i;
				resultId = "supervisor"+i;
				$("#"+id).val(result[resultId]);
				
			}
			$('html, body').animate({
		        scrollTop: $(".editCoachingBatch").offset().top
		    }, 800);
		},
		error: function() {
			alert("Something went wrong, try again later");
		}
	});
}

function openBatchInfo(actCoachingBatchId) {
	$('body').addClass('disableClickBody');
	$(".package-loader").hide();
	$(".editCoachingBatch").hide();
	console.log("1");
	$.ajax({
		url: 'getBatchDetails',
		type: 'GET',
		data: { 'actCoachingBatchId': actCoachingBatchId },
		dataType: 'json',
		success: function(result) {
			$("#batchNameInfo").html(result["batchName"]);
			$("#batchDescriptionInfo").html(result["batchDescription"]);
			$("#batchStartDateInfo").html(result["batchStartDateInfo"]);
			$("#batchEndDateInfo").html(result["batchEndDateInfo"]);
			if(result["batchActive"] == "1") {
				$("#batchActiveInfo").html("<span class='badge sequence-bg-5'>Active</span>");
			} else if(result["batchActive"] == "0") {
				$("#batchActiveInfo").html("<span class='badge sequence-bg-1'>In-Active</span>");
			} else  {
				$("#batchActiveInfo").html("<span class='badge sequence-bg-3 '>Closed</span>");
			}
			$('#coachCoacheeTableInfo tbody').empty();
			for(var i = 0; i < parseInt(result["coachCoacheeIndex"]); i++) {
				var coach = "coachName"+i;
				var coachee = "coacheeName"+i;
				var programType = "programTypeName"+i;
				var supervisor = "supervisorName"+i;
				var newCoachCoacheeMapping = "<tr>"+
					"<td>"+
						""+result[coach]+
					"</td>"+
					"<td>"+
						""+result[coachee]+
					"</td>"+
					"<td>"+
						""+result[programType]+
					"</td>"+
					"<td>"+
						""+result[supervisor]+
					"</td>"+
				"</tr>";
				if(i == 0) {
					$('#coachCoacheeTableInfo tbody').append(newCoachCoacheeMapping);
				} else {
					$('#coachCoacheeTableInfo tbody tr:last').after(newCoachCoacheeMapping);
				}
			}
			
			$("#batchInfoModal").modal({
			    backdrop: 'static',
			    keyboard: false
			});
			$('body').removeClass('disableClickBody');
			$(".anand-loader").hide();
		},
		error: function() {
			alert("Something went wrong, try again later");
		}
	});
}

function clearEditFormValidation() {
	$("#batchNameEdit").html("");
	$("#batchNameEdit").removeClass("is-valid");
	$("#batchNameEdit").removeClass("is-invalid");
	
	$("#isActiveEditError").html("");
	$("#isActiveEditError").removeClass("is-invalid");
	$("#isActiveEditError").removeClass("is-valid");
}
$("#actCoachingBatch").submit(function(){
	$("#submitBatchButton").addClass("disabledButton");
	$('body').addClass('disableClickBody');
	$(".package-loader").hide();
	var submitOrNot = true;
	if(batchNameValidation("") == false) {
		submitOrNot = false;
	}
	if(batchDescriptionValidation("") == false) {
		submitOrNot = false;
	}
	if(startDateTempValidation("") == false) {
		submitOrNot = false;
	}
	if(endDateTempValidation("") == false) {
		submitOrNot = false;
	}
	if($("#batchActive1").prop("checked") == false && $("#batchActive2").prop("checked") == false &&  $("#batchActive3").prop("checked") == false){
		$("#isActiveError").html("Batch state must be selected");
		submitOrNot = false;
	}
	var activeFlag = 0;
	for(var coachCoacheeIndex = 0; coachCoacheeIndex <= addBatchCoachCoacheeMapIndex; coachCoacheeIndex++) {
		var id = "actCoachCoacheeMapActive"+coachCoacheeIndex;
		if($("#"+id).val() == 1) {
			activeFlag++;
			if(checkDropDown("coachIdTemp", coachCoacheeIndex, "Coach") == false) {
				submitOrNot = false;
			}
			if(checkDropDown("coacheeIdTemp", coachCoacheeIndex, "Coachee") == false) {
				submitOrNot = false;
			}
			if(checkDropDown("actCoacheeProgram", coachCoacheeIndex, "Program Type") == false) {
				submitOrNot = false;
			}
			if(checkDropDown("supervisorIdTemp", coachCoacheeIndex, "Supervisor") == false) {
				submitOrNot = false;
			}
				
		}
	}
	if(submitOrNot) {
		//return false;
		return true;
	} else {
		$("#submitBatchButton").removeClass("disabledButton");
		$('body').removeClass('disableClickBody');
		$(".anand-loader").hide();
		return false;
	}
});
$("#actCoachingBatchEdit").submit(function(){
	$("#saveBatchChanges").addClass("disabledButton");
	$('body').addClass('disableClickBody');
	$(".package-loader").hide();
	var submitOrNot = true;
	if(batchNameValidation("Edit") == false) {
		submitOrNot = false;
	}
	if(batchDescriptionValidation("Edit") == false) {
		submitOrNot = false;
	}
	if(startDateTempValidation("Edit") == false) {
		submitOrNot = false;
	}
	if(endDateTempValidation("Edit") == false) {
		submitOrNot = false;
	}
	if($("#batchActiveEdit1").prop("checked") == false && $("#batchActiveEdit2").prop("checked") == false && $("#batchActiveEdit3").prop("checked") == false) {
		$("#isActiveError").html("Batch state must be selected");
		submitOrNot = false;
	}
	var activeFlag = 0;
	for(var coachCoacheeIndex = 0; coachCoacheeIndex < editBatchCoachCoacheeMapIndex; coachCoacheeIndex++) {
		var id = "actCoachCoacheeMapActiveEdit"+coachCoacheeIndex;
		if($("#"+id).val() == 1) {
			activeFlag++;
			if(checkDropDown("coachIdTempEdit", coachCoacheeIndex, "Coach") == false) {
				submitOrNot = false;
			}
			if(checkDropDown("coacheeIdTempEdit", coachCoacheeIndex, "Coachee") == false) {
				submitOrNot = false;
			}
			if(checkDropDown("actCoacheeProgramEdit", coachCoacheeIndex, "Program Type") == false) {
				submitOrNot = false;
			}
			if(checkDropDown("supervisorIdTempEdit", coachCoacheeIndex, "Supervisor") == false) {
				submitOrNot = false;
			}
		}
	}
	if(submitOrNot) {
		return true;
	} else {
		$("#saveBatchChanges").removeClass("disabledButton");
		$('body').removeClass('disableClickBody');
		$(".anand-loader").hide();
		return false;
	}
});
$("#batchName").focusout(function() {
	batchNameValidation("");
});
$("#batchNameEdit").focusout(function() {
	batchNameValidation("Edit");
});
var batchNameCheck = /^[ A-Za-z0-9-Á& ]*$/;
function batchNameValidation(idAppend) {
	var id = "batchName"+idAppend;
	var error = "batchNameError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var batchName = $("#"+id).val().replace(/\s+/g, " ");
	if(batchName != "") {
		if(batchNameCheck.test(batchName) == false) {
			$("#"+error).html("Batch Name cannot contain special characters.");
			$("#"+id).addClass("is-invalid");
			return false;
		} else {
			$("#"+id).addClass("is-valid");
			return true;
		}
	} else {
		$("#"+error).html("Batch Name cannot be empty.");
		$("#"+id).addClass("is-invalid");
		return false;
	}
}
$("#batchDescription").focusout(function() {
	batchDescriptionValidation("");
});
$("#batchDescriptionEdit").focusout(function() {
	batchDescriptionValidation("Edit");
});
var batchDescriptionCheck = /^[ A-Za-z0-9-Á& ]*$/;
function batchDescriptionValidation(idAppend) {
	var id = "batchDescription"+idAppend;
	var error = "batchDescriptionError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var batchDescription = $("#"+id).val().replace(/\s+/g, " ");
	if(batchDescription != "") {
		if(batchDescriptionCheck.test(batchDescription) == false) {
			$("#"+error).html("Batch Description cannot contain special characters.");
			$("#"+id).addClass("is-invalid");
			return false;
		} else {
			$("#"+id).addClass("is-valid");
			return true;
		}
	} else {
		$("#"+error).html("Batch Description cannot be empty.");
		$("#"+id).addClass("is-invalid");
		return false;
	}
}
$("#startDateTemp").focusout(function() {
	startDateTempValidation("");
});
$("#startDateTempEdit").focusout(function() {
	startDateTempValidation("Edit");
});
function startDateTempValidation(idAppend) {
	var id = "startDateTempIn"+idAppend;
	var error = "startDateTempError"+idAppend;
	console.log("start here");
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	console.log(id);
	console.log($("#"+id).val());
	if($("#"+id).val() != "") {
		$("#"+id).addClass("is-valid");
		console.log("start here1");
		return true;
	} else {
		$("#"+error).html("Batch Start Date cannot be empty.");
		$("#"+id).addClass("is-invalid");
		console.log("start here2");
		return false;
	}
}
$("#endDateTemp").focusout(function() {
	endDateTempValidation("");
});
$("#endDateTempEdit").focusout(function() {
	endDateTempValidation("Edit");
});
function endDateTempValidation(idAppend) {
	var id = "endDateTempIn"+idAppend;
	var error = "endDateTempError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	if($("#"+id).val() != "") {
		$("#"+id).addClass("is-valid");
		return true;
	} else {
		$("#"+error).html("Batch End Date cannot be empty.");
		$("#"+id).addClass("is-invalid");
		return false;
	}
}
$('#isActiveDiv input[type="radio"]').click(function() {
	$("#isActiveError").html("");
});
$('#isActiveEditDiv input[type="radio"]').click(function() {
	$("#isActiveEditError").html("");
});
function checkDropDown(id, index, type) {
	if($("#"+id+index).val() == -1) {
		$("#"+id+"Error"+index).html(type+" cannot be empty.");
		$("#"+id+"Error"+index).show();
		$("#"+id).addClass("is-invalid");
		return false;
	} else {
		$("#"+id+index).addClass("is-valid");
		$("#"+id+"Error"+index).hide();
		return true;
	}
}
$("#addMoreCoachCoachee").click(function(){
	$('body').addClass('disableClickBody');
	$(".package-loader").hide();
	
	var counter = addBatchCoachCoacheeMapIndex;
	counter++;
	var newCoachCoacheeMapping = "<tr class='coacheCoacheeMapTr"+counter+"'>"+
	    "<td>"+
	    	"<input type='hidden' name='coachCoacheeMappingList["+counter+"].actCoachCoacheeMapActive' id='actCoachCoacheeMapActive"+counter+"' value='1' />"+
	    	"<a href='#' title='Remove Coach-Coachee' onclick='removeCoachCoacheeMapping("+counter+")'><i class='fas fa-times'></i></a>"+
	    "</td>"+
	    "<td>"+
	    	"<select onchange='coachIdTempValidation(\"-\","+counter+")' class='form-control' name='coachCoacheeMappingList["+counter+"].coachIdTemp' id='coachIdTemp"+counter+"'>"+
	    		"<option value='-1'>Select  Coach</option>"+
	    		coachFinalList+
	    	"</select>"+
	    	"<span class='error invalid-feedback' id='coachIdTempError"+counter+"'></span>"+
	    "</td>"+
	    "<td>"+
    		"<select onchange='coacheeIdTempValidation(\"-\","+counter+")' class='form-control' name='coachCoacheeMappingList["+counter+"].coacheeIdTemp' id='coacheeIdTemp"+counter+"'>"+
    			"<option value='-1'>Select  Coachee</option>"+
    			coacheeFinalList+
    		"</select>"+
    		"<span class='error invalid-feedback' id='coacheeIdTempError"+counter+"'></span>"+
    	"</td>"+
    	"<td>"+
    		"<select onchange='actCoacheeProgramValidation(\"-\","+counter+")' class='form-control' name='coachCoacheeMappingList["+counter+"].actCoacheeProgram' id='actCoacheeProgram"+counter+"'>"+
    			"<option value='-1'>Select ALDP Program</option>"+
    			"<option value='1'>AM - ANAND Mentee</option>"+
    			"<option value='2'>AT - ANAND Talent</option>"+
    			"<option value='3'>AL - ANAND Leader</option>"+
    		"</select>"+
    		"<span class='error invalid-feedback' id=actCoacheeProgramError"+counter+"'></span>"+
    	"</td>"+
    	"<td>"+
			"<select onchange='supervisorIdTempValidation(\"-\","+counter+")' class='form-control' name='coachCoacheeMappingList["+counter+"].supervisorIdTemp' id='supervisorIdTemp"+counter+"'>"+
				"<option value='-1'>Select  Supervisor</option>"+
				supervisorFinalList+
			"</select>"+
			"<span class='error invalid-feedback' id='supervisorIdTempError"+counter+"'></span>"+
		"</td>"+
	"</tr>";
	$('#coachCoacheeTable tbody tr:last').after(newCoachCoacheeMapping);

	addBatchCoachCoacheeMapIndex = counter;

	$('body').removeClass('disableClickBody');
	$(".anand-loader").hide();
});
function removeCoachCoacheeMapping(index) {
	var activeFlag = 0;
	for(var coachCoacheeIndex = 0; coachCoacheeIndex <= addBatchCoachCoacheeMapIndex; coachCoacheeIndex++) {
		var activeId = "actCoachCoacheeMapActive"+coachCoacheeIndex;
		if($("#"+activeId).val() == 1) {
			activeFlag++;
		}
	}
	if(activeFlag < 2) {
		alert("Batch should contain atleast 1 Coach-Coachee-Supervisor");
	} else {
		var id = "actCoachCoacheeMapActive"+index;
		$("#"+id).val(0);
		id = "coacheCoacheeMapTr"+index
		$("."+id).hide();
	}
	$('html, body').animate({
        scrollTop: $(".addCoachingBatch").offset().top
    }, 800);
}
function removeCoachCoacheeMappingEdit(index) {
	var activeFlag = 0;
	for(var coachCoacheeIndex = 0; coachCoacheeIndex <= editBatchCoachCoacheeMapIndex; coachCoacheeIndex++) {
		var activeId = "actCoachCoacheeMapActiveEdit"+coachCoacheeIndex;
		if($("#"+activeId).val() == 1) {
			activeFlag++;
		}
	}
	if(activeFlag < 2) {
		alert("Batch should contain atleast 1 Coach-Coachee-Supervisor");
	} else {
		var id = "actCoachCoacheeMapActiveEdit"+index;
		$("#"+id).val(0);
		id = "coacheCoacheeMapTrEdit"+index
		$("."+id).hide();
	}
	$('html, body').animate({
        scrollTop: $(".editCoachingBatch").offset().top
    }, 800);
}
$("#editMoreCoachCoachee").click(function(){
	$('body').addClass('disableClickBody');
	$(".package-loader").hide();
	
	var counter = editBatchCoachCoacheeMapIndex;
	var newCoachCoacheeMapping = "<tr class='coacheCoacheeMapTrEdit"+counter+"'>"+
	    "<td>"+
	    	"<input type='hidden' name='coachCoacheeMappingList["+counter+"].actCoachCoacheeMapActive' id='actCoachCoacheeMapActiveEdit"+counter+"' value='1' />"+
	    	"<a href='#' title='Remove Coach-Coachee' onclick='removeCoachCoacheeMappingEdit("+counter+")'><i class='fas fa-times'></i></a>"+
	    "</td>"+
	    "<td>"+
	    	"<select onchange='coachIdTempValidation(\"-\","+counter+")' class='form-control' name='coachCoacheeMappingList["+counter+"].coachIdTemp' id='coachIdTempEdit"+counter+"'>"+
	    		"<option value='-1'>Select  Coach</option>"+
	    		coachFinalList+
	    	"</select>"+
	    	"<span class='error invalid-feedback' id='coachIdTempEditError"+counter+"'></span>"+
	    "</td>"+
	    "<td>"+
    		"<select onchange='coacheeIdTempValidation(\"-\","+counter+")' class='form-control' name='coachCoacheeMappingList["+counter+"].coacheeIdTemp' id='coacheeIdTempEdit"+counter+"'>"+
    			"<option value='-1'>Select  Coachee</option>"+
    			coacheeFinalList+
    		"</select>"+
    		"<span class='error invalid-feedback' id='coacheeIdTempEditError"+counter+"'></span>"+
    	"</td>"+
    	"<td>"+
    		"<select onchange='actCoacheeProgramValidation(\"-\","+counter+")' class='form-control' name='coachCoacheeMappingList["+counter+"].actCoacheeProgram' id='actCoacheeProgramEdit"+counter+"'>"+
    			"<option value='-1'>Select ALDP Program</option>"+
    			"<option value='1'>AM - ANAND Mentee</option>"+
    			"<option value='2'>AT - ANAND Talent</option>"+
    			"<option value='3'>AL - ANAND Leader</option>"+
    		"</select>"+
    		"<span class='error invalid-feedback' id='actCoacheeProgramEditError"+counter+"'></span>"+
    	"</td>"+
    	"<td>"+
			"<select onchange='supervisorIdTempValidation(\"-\","+counter+")' class='form-control' name='coachCoacheeMappingList["+counter+"].supervisorIdTemp' id='supervisorIdTempEdit"+counter+"'>"+
				"<option value='-1'>Select  Supervisor</option>"+
				supervisorFinalList+
			"</select>"+
			"<span class='error invalid-feedback' id='supervisorIdTempEditError"+counter+"'></span>"+
		"</td>"+
	"</tr>";
	$('#coachCoacheeTableEdit tbody tr:last').after(newCoachCoacheeMapping);

	editBatchCoachCoacheeMapIndex++;

	$('body').removeClass('disableClickBody');
	$(".anand-loader").hide();
});

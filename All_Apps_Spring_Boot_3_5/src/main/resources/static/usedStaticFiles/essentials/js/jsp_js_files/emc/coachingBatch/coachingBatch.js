var pagination = true;
var addBatchCoachCoacheeMapIndex = 0;
var editBatchCoachCoacheeMapIndex = 0;
var coachFinalList = "";
var coacheeFinalList = "";
var supervisorFinalList = "";
var programCategory = "";
var submitOrNot = true;
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
	
	var programCategoryList = $("#programCategoryStringForJs").val().trim();
	var programCategoryListSplit = programCategoryList.split("||");
	for(var i = 0; i < programCategoryListSplit.length; i++) {
		programCategory += "<option value='"+programCategoryListSplit[i].split("!!")[0]+"'>"+programCategoryListSplit[i].split("!!")[1]+"</option>";
	}
	$(".editCoachingBatch").hide();
	$('#startDateTemp').datepicker({ 
		dateFormat: 'dd/mm/yy',
		//minDate: new Date(),
		beforeShowDay: DisableDates
	});
	$('#endDateTemp').datepicker({ 
		dateFormat: 'dd/mm/yy',
		//minDate: new Date(''+$("#startDateTemp").val()),
		beforeShowDay: DisableDates
	});
	
	$('#startDateTempEdit').datepicker({ 
		dateFormat: 'dd/mm/yy',
		//minDate: new Date(''+$("#startDateTemp").val()),
		beforeShowDay: DisableDates
	});
	$('#endDateTempEdit').datepicker({ 
		dateFormat: 'dd/mm/yy',
		//minDate: new Date(''+$("#startDateTemp").val()),
		beforeShowDay: DisableDates
	});
	
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
			// alert("Something went wrong, kindly try again after sometime.");
		}
	});
}



function editBatch(actCoachingBatchId) {
    $('body').addClass('disableClickBody');
    $(".package-loader").hide();
    $(".editCoachingBatch").hide();

    $.ajax({
        
		url: 'emc-getBatchDetails',
        type: 'GET',
        data: { 'actCoachingBatchId': actCoachingBatchId },
        dataType: 'json',
        success: function(result) {
            clearEditFormValidation();
            $("#actCoachingBatchId").val(actCoachingBatchId);
            $("#batchNameEdit").val(result["batchName"]);
            $("#batchDescriptionEdit").val(result["batchDescription"]);
            $("#startDateTempEdit").val(result["batchStartDate"]);
            $("#endDateTempEdit").val(result["batchEndDate"]);
            $("#batchDurationEdit").val(result["batchDuration"]);
            $("#daysBetweenTwoSessionEdit").val(result["daysBetweenTwoSession"]);
			$("#daysBetweenTwoSessionTopExeEdit").val(result["daysBetweenTwoSessionTopExe"]);

            if(result["batchActive"] == "1") {
                $("#batchActiveEdit1").prop('checked', true);
            } else {
                $("#batchActiveEdit2").prop('checked', true);
            }

            $('body').removeClass('disableClickBody');
            $(".anand-loader").hide();
            $(".editCoachingBatch").show();

            editBatchCoachCoacheeMapIndex = parseInt(result["coachCoacheeIndex"]);

           var programCategory = $("#programCategoryStringForJs").val().trim();
            var parts = programCategory.split("||");
            var programCategoryOptions = "<option value='-1'>Select Program Category</option>";
            var programCategoryMap = {};
            
            parts.forEach(function(p) {
                var bits = p.split("!!");
                var value = bits[0];
                var text = bits[1];
                programCategoryOptions += "<option value='"+value+"'>"+text+"</option>";
                programCategoryMap[value] = text;
                programCategoryMap[text] = value;});


            for (var i = 0; i < parseInt(result["coachCoacheeIndex"]); i++) {
                var newCoachCoacheeMapping = "<tr class='coacheCoacheeMapTrEdit" + i + "'>" +
                    "<td>" +
                        "<input type='hidden' name='coachCoacheeMappingList[" + i + "].actCoachCoacheeMapActive' id='actCoachCoacheeMapActiveEdit" + i + "' value='1' />" +
                        "<input type='hidden' name='coachCoacheeMappingList[" + i + "].actCoachCoacheeMapId' id='actCoachCoacheeMapId" + i + "' value='' />" +
                        "<a href='#' title='Remove Coach-Coachee' onclick='removeCoachCoacheeMappingEdit(" + i + ")'><i class='fas fa-times'></i></a>" +
                    "</td>" +
                    "<td>" +
                        "<select onchange='coachIdTempValidation(\"-\"," + i + ")' class='form-control' name='coachCoacheeMappingList[" + i + "].coachIdTemp' id='coachIdTempEdit" + i + "'>" +
                            "<option value='-1'>Select Mentor/Coach</option>" +
                            coachFinalList +
                        "</select>" +
                        "<span class='error invalid-feedback' id='coachIdTempEditError" + i + "'></span>" +
                    "</td>" +
                    "<td>" +
                        "<select onchange='coacheeIdTempValidation(\"-\"," + i + ")' class='form-control' name='coachCoacheeMappingList[" + i + "].coacheeIdTemp' id='coacheeIdTempEdit" + i + "'>" +
                            "<option value='-1'>Select Mentee/Coachee</option>" +
                            coacheeFinalList +
                        "</select>" +
                        "<span class='error invalid-feedback' id='coacheeIdTempEditError" + i + "'></span>" +
                    "</td>" +
					"<td>" +
  "<select onchange='actCoacheeProgramValidation(\"-\", " + i + ")' " +
  "class='form-control' " +
  "name='coachCoacheeMappingList[" + i + "].actCoacheeProgram' " +
  "id='actCoacheeProgramTempEdit" + i + "'>" +
    programCategoryOptions +
  "</select>" +
  "<span class='error invalid-feedback' id='supervisorIdTempEditError" + i + "'></span>" +
"</td>"+

                    "<td>" +
                        "<select onchange='supervisorIdTempValidation(\"-\"," + i + ")' class='form-control' name='coachCoacheeMappingList[" + i + "].supervisorIdTemp' id='supervisorIdTempEdit" + i + "'>" +
                            "<option value='-1'>Select Supversior</option>" +
                            supervisorFinalList +
                        "</select>" +
                        "<span class='error invalid-feedback' id='supervisorIdTempEditError" + i + "'></span>" +
                    "</td>" +
                "</tr>";

                if (i == 0) {
                    $('#coachCoacheeTableEdit tbody').append(newCoachCoacheeMapping);
                } else {
                    $('#coachCoacheeTableEdit tbody tr:last').after(newCoachCoacheeMapping);
                }

				console.log("programCategoryOptions"+programCategoryOptions);
                $("#coachIdTempEdit" + i).val(result["coach" + i]);
                $("#actCoachCoacheeMapId" + i).val(result["actCoachCoacheeMapId" + i]);
                $("#coacheeIdTempEdit" + i).val(result["coachee" + i]);
                $("#supervisorIdTempEdit" + i).val(result["supervisor" + i]);
				 
            //     var serverCategoryValue = result["programCategory" + i];
			// var dropdownValue = programCategoryMap[serverCategoryValue] || serverCategoryValue;
			var serverCategoryValue = result["programCategory" + i];  // Expecting ID like "1"
$("#actCoacheeProgramTempEdit" + i).val(serverCategoryValue);  // Directly set value


// console.log("dropdownValue"+dropdownValue);
				//  $("#actCoacheeProgramTempEdit" + i).val(dropdownValue || "-1");
            }
			// loadFeedbackQuestions(actCoachingBatchId);

            $('html, body').animate({
                scrollTop: $(".editCoachingBatch").offset().top
            }, 800);

            // Fetch questions for the first coach-coachee pair
            const batchId = $("#actCoachingBatchId").val();
            const coachId = $("#coachIdTempEdit0").val();
            const coacheeId = $("#coacheeIdTempEdit0").val();
			//  loadFeedbackQuestions(actCoachingBatchId);

			 loadFeedbackQuestionsInformation(batchId)

            console.log("Batch ID: ", batchId);
            console.log("Coach ID: ", coachId);
            console.log("Coachee ID: ", coacheeId);
			console.log()
			

            // if (!batchId || !coachId || !coacheeId || coachId === '-1' || coacheeId === '-1') {
            //     console.warn("Missing values for batchId, coachId, or coacheeId");
            //     return;
            // }

			$.ajax({
				url: `questionTexts?batchId=${batchId}`,
				method: 'GET',
				success: function (questionTexts) {
					let tableBody = $("#questionTableEdit tbody");
					tableBody.empty();
					console.log("Received questions:", questionTexts);
			
					// Check if questions is an array
					if (Array.isArray(questionTexts)) {
						questionTexts.forEach((q, index) => {
							let row = `
<tr id="questionRow-${index}">
<td>
  <button type="button" onclick="removeQuestionRows('${index}', \`${q.question}\`)" style="border: none; background: none; color: #007bff; padding: 0;">
    <i class="fas fa-times"></i>
  </button>
</td>

	
	<td>
		<input type="text"  class="form-control" name="questionTexts[${index}].questionText" value="${q.question}"  />
	</td>
</tr>`;

							tableBody.append(row);
						});
					} else {
						console.warn("Expected an array of questions but received:", questionTexts);
					}
				},
				error: function () {
					alert("Failed to load questions.");
				}
			});
			
			//  loadFeedbackQuestions(actCoachingBatchId);
        },
        error: function() {
            alert("Something went wrong, try again later");
        }
    });
}


function removeQuestionRows(index, questionText) {
    console.log("removeQuestionRow called with:", index, questionText);

// if (confirm("Are you sure? You want to delete the Question")) {
    $('#questionRow-' + index).remove();

    // Skip DB call if questionText is empty or marked as new
    if (questionText && questionText !== 'new') {
        $.ajax({
            url: 'deleteQuestion',
            method: 'POST',
            data: {
                questionText: questionText
            },
            success: function(response) {
                // alert("Question deleted successfully!");
            },
            error: function(xhr, status, error) {
                alert("Failed to delete question. Please try again.");
                console.error("Delete error:", error);
            }
        });
    }
}
// }


function loadQuestions(batchId) {
    $.ajax({
        url: `questionTexts?batchId=${batchId}`,
        method: 'GET',
        success: function (questionTexts) {
            let tableBody = $("#questionTableEdit tbody");
            tableBody.empty(); // Clear any existing rows

            if (Array.isArray(questionTexts) && questionTexts.length > 0) {
                questionTexts.forEach((q, index) => {
                    let row = `
                        <tr>
                            <td>${q.question}</td>
                        </tr>
                    `;
                    tableBody.append(row);
                });
            } else {
                tableBody.append(`
                    <tr>
                        <td colspan="1">No questions found</td>
                    </tr>
                `);
            }
        },
        error: function (xhr, status, error) {
            console.error("AJAX Error:", error);
            alert("Failed to load questions.");
        }
    });
}





function openBatchInfo(actCoachingBatchId) {
	$('body').addClass('disableClickBody');
	$(".package-loader").hide();
	$(".editCoachingBatch").hide();
	$.ajax({
	
			url: 'emc-getBatchDetails',
		type: 'GET',
		data: { 'actCoachingBatchId': actCoachingBatchId },
		dataType: 'json',
		success: function(result) {
			$("#batchNameInfo").html(result["batchName"]);
			$("#batchDescriptionInfo").html(result["batchDescription"]);
			$("#batchStartDateInfo").html(result["batchStartDateInfo"]);
			$("#batchEndDateInfo").html(result["batchEndDateInfo"]);
			if(result["batchActive"] == "1") {
				$("#batchActiveInfo").html("<span class='badge bg-color-anand-success-one'>Active</span>");
			} else {
				$("#batchActiveInfo").html("<span class='badge bg-color-anand-danger-one'>In-Active</span>");
			}
			$('#coachCoacheeTableInfo tbody').empty();
			for(var i = 0; i < parseInt(result["coachCoacheeIndex"]); i++) {
				var coach = "coachName"+i;
				var coachee = "coacheeName"+i;
				 var programType = "programCategory" + i;
var supervisor = "supervisorName" + i;

var programValue = result[programType];
var programLabel = "";

if (programValue == 1) {
    programLabel = "Senior Executive Coaching";
} else if (programValue == 2) {
    programLabel = "Top Executive Mentoring";
} else {
    programLabel = programValue; // fallback to original value
}
				var supervisor = "supervisorName"+i;
				var newCoachCoacheeMapping = "<tr>"+
					"<td>"+
						""+result[coach]+
					"</td>"+
					"<td>"+
						""+result[coachee]+
					"</td>"+
					 "<td>" + programLabel + "</td>" + 
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
			 loadQuestions(actCoachingBatchId);	
			$("#batchInfoModal").modal({
			    backdrop: 'static',
			    keyboard: false
			});

$("#batchInfoModal").off("shown.bs.modal").on("shown.bs.modal", function () {
    loadFeedbackQuestionsInformation_1(actCoachingBatchId);
});
			setTimeout(function () {
}, 300)
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
	if($("#batchActive1").prop("checked") == false && $("#batchActive2").prop("checked") == false) {
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

	prepareEditFeedbackQuestionsForSubmit();
	$("#saveBatchChanges").addClass("disabledButton"); // Enables the button
    $('body').removeClass('disableClickBody'); // Enables clicks on the body
    $(".package-loader").hide();
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
	if($("#batchActiveEdit1").prop("checked") == false && $("#batchActiveEdit2").prop("checked") == false) {
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
			if(checkDropDown("actCoacheeProgramEdit", coachCoacheeIndex, "programCategory") == false) {
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
	var id = "startDateTemp"+idAppend;
	var error = "startDateTempError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	if($("#"+id).val() != "") {
		$("#"+id).addClass("is-valid");
		return true;
	} else {
		$("#"+error).html("Batch Start Date cannot be empty.");
		$("#"+id).addClass("is-invalid");
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
	var id = "endDateTemp"+idAppend;
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
	// alert("hi");
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
	    		"<option value='-1'>Select Mentor/Coach</option>"+
	    		coachFinalList+
	    	"</select>"+
	    	"<span class='error invalid-feedback' id='coachIdTempError"+counter+"'></span>"+
	    "</td>"+
	    "<td>"+
    		"<select onchange='coacheeIdTempValidation(\"-\","+counter+")' class='form-control' name='coachCoacheeMappingList["+counter+"].coacheeIdTemp' id='coacheeIdTemp"+counter+"'>"+
    			"<option value='-1'>Select Mentee/Coachee</option>"+
    			coacheeFinalList+
    		"</select>"+
    		"<span class='error invalid-feedback' id='coacheeIdTempError"+counter+"'></span>"+
    	"</td>"+
    	"<td>"+
    		"<select onchange='actCoacheeProgramValidation(\"-\","+counter+")' class='form-control' name='coachCoacheeMappingList["+counter+"].actCoacheeProgram' id='actCoacheeProgram"+counter+"'>"+
    			"<option value='-1'>Select EMC Program</option>"+
    			"<option value='1'>Senior Executive Coaching	</option>"+
    			"<option value='2'>Top Executive Mentoring</option>"+
    			// "<option value='3'>AL - ANAND Leader</option>"+
    		"</select>"+
    		"<span class='error invalid-feedback' id=actCoacheeProgramError"+counter+"'></span>"+
    	"</td>"+
    	"<td>"+
			"<select onchange='supervisorIdTempValidation(\"-\","+counter+")' class='form-control' name='coachCoacheeMappingList["+counter+"].supervisorIdTemp' id='supervisorIdTemp"+counter+"'>"+
				"<option value='-1'>Select Supervisor</option>"+
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
	    		"<option value='-1'>Select Mentor/Coach</option>"+
	    		coachFinalList+
	    	"</select>"+
	    	"<span class='error invalid-feedback' id='coachIdTempEditError"+counter+"'></span>"+
	    "</td>"+
	    "<td>"+
    		"<select onchange='coacheeIdTempValidation(\"-\","+counter+")' class='form-control' name='coachCoacheeMappingList["+counter+"].coacheeIdTemp' id='coacheeIdTempEdit"+counter+"'>"+
    			"<option value='-1'>Select Mentee/Coachee</option>"+
    			coacheeFinalList+
    		"</select>"+
    		"<span class='error invalid-feedback' id='coacheeIdTempEditError"+counter+"'></span>"+
    	"</td>"+
    	"<td>"+
    		"<select onchange='actCoacheeProgramValidation(\"-\","+counter+")' class='form-control' name='coachCoacheeMappingList["+counter+"].actCoacheeProgram' id='actCoacheeProgramEdit"+counter+"'>"+
    			
    			"<option value='-1'>Select EMC Program</option>"+
    			"<option value='1'>Senior Executive Coaching	</option>"+
    			"<option value='2'>Top Executive Mentoring</option>"+
    		"</select>"+
    		"<span class='error invalid-feedback' id='actCoacheeProgramEditError"+counter+"'></span>"+
    	"</td>"+
    	"<td>"+
			"<select onchange='supervisorIdTempValidation(\"-\","+counter+")' class='form-control' name='coachCoacheeMappingList["+counter+"].supervisorIdTemp' id='supervisorIdTempEdit"+counter+"'>"+
				"<option value='-1'>Select Supervisor</option>"+
				supervisorFinalList+
			"</select>"+
			"<span class='error invalid-feedback' id='supervisorIdTempEditError"+counter+"'></span>"+
		"</td>"+
	"</tr>";
	$('#coachCoacheeTableEdit tbody').append(newCoachCoacheeMapping);

	editBatchCoachCoacheeMapIndex++;

	$('body').removeClass('disableClickBody');
	$(".anand-loader").hide();
});

function addQuestionRow() {
	const tableBody = document.getElementById("questionTableBody");
	const row = document.createElement("tr");

	row.innerHTML = `
		<td><a href="#" onclick="removeQuestionRow(this);"><i class="fas fa-times"></i></a></td>
		<td>
			<input 
				type="text" 
				name="questionTexts" 
				class="form-control question-text" 
				oninput="validateQuestionInput(this)" 
				placeholder="Enter question"
			/>
			<small class="text-danger validation-error" style="display: none;">Enter valid questions</small>
		</td>
	`;

	tableBody.appendChild(row);
}




function prepareFeedbackQuestions() {
	const rows = document.querySelectorAll("#feedbackQuestionTableBody tr");
	const result = [];

	rows.forEach(row => {
		const questionInput = row.querySelector(".question-text");
		const selectedProgram = row.querySelector("input.program-category:checked");

		if (questionInput && selectedProgram) {
			const questionText = questionInput.value.trim();
			const programCategory = selectedProgram.value;

			if (questionText !== "") {
				result.push({
					question: questionText,
					programCategory: programCategory
				});
			}
		}
	});

	document.getElementById("feedbackQuestionsField").value = JSON.stringify(result);
}


function validateQuestionInput(input) {
	const regex = /^[A-Za-z\s%?]*$/;
	const errorMsg = input.nextElementSibling; // the <small> tag

	if (!regex.test(input.value)) {
		errorMsg.style.display = "inline";
	} else {
		errorMsg.style.display = "none";
	}
	
	// Remove invalid characters as user types
	input.value = input.value.replace(/[^A-Za-z\s%?]/g, '');
}

  
  function removeQuestionRow(link) {
	const row = link.closest("tr");
	{row.remove();}
  }
  




function addQuestionRows() {
    $('#questionTableEdit tbody').append(`
        <tr>
            <td>
                <button type="button" onclick="$(this).closest('tr').remove()" style="border: none; background: none; color: #007bff; padding: 0;">
                    <i class="fas fa-times"></i>
                </button>
            </td>
            <td>
                <input type="text" class="form-control" name="questionTexts"/>
            </td>
        </tr>
    `);
}



let questionTextIndex = 0; // Already globally defined
$(document).ready(function () {
    questionTextIndex = document.querySelectorAll("input[name^='questionTexts']").length;
});
// function loadFeedbackQuestions(batchId) {
//     $.ajax({
//         url: `feedbackQuestion?batchId=${batchId}`,
//         method: 'GET',
//         success: function(response) {
//             $("#editfeedbackQuestionTableBody").empty();
//             $("#editfeedbackCoacheeQuestionTableBody").empty();
//             $("#editfeedbackMentorQuestionTableBody").empty();
//             $("#editfeedbackMenteeQuestionTableBody").empty();

//             if (Array.isArray(response) && response.length > 0) {
//                 response.forEach((q) => {
//                     const flag = q.mentorMenteeFlag;
//                     const questionText = q.question || "";
//                     let inputClass = "";

//                     switch (flag) {
//                         case 1: inputClass = "coach-input"; break;
//                         case 2: inputClass = "coachee-input"; break;
//                         case 3: inputClass = "mentor-input"; break;
//                         case 4: inputClass = "mentee-input"; break;
//                         default:
//                             console.warn("Unknown mentorMenteeFlag:", flag);
//                             return;
//                     }

//                     const row = `
//                         <tr>
//                             <td>
//                                 <button type="button" onclick="removeQuestionRow(this)" style="border: none; background: none; color: #dc3545;">
//                                     <i class="fas fa-times"></i>
//                                 </button>
//                             </td>
//                             <td>
//                                 <input type="text" class="form-control ${inputClass}" 
//                                        name="questionTexts[${questionTextIndex}].questionText" 
//                                        value="${questionText}" required />
//                                 <input type="hidden" name="questionTexts[${questionTextIndex}].mentorMenteeFlag" value="${flag}" />
//                             </td>
//                         </tr>
//                     `;

//                     switch (flag) {
//                         case 1: $("#editfeedbackQuestionTableBody").append(row); break;
//                         case 2: $("#editfeedbackCoacheeQuestionTableBody").append(row); break;
//                         case 3: $("#editfeedbackMentorQuestionTableBody").append(row); break;
//                         case 4: $("#editfeedbackMenteeQuestionTableBody").append(row); break;
//                     }

                    
//                 });
//             } else {
//                 console.warn("No feedback questions found for batch ID:", batchId);
//             }
//         },
//         error: function(xhr, status, error) {
//             console.error("AJAX Error:", error);
//             // alert("Failed to load feedback questions.");
//         }
//     });
// }


function addfeedbackQuestionRow() {
	const tableBody = document.getElementById("feedbackQuestionTableBody");
	const row = document.createElement("tr");

	row.innerHTML = `
		<td>
			<a href="#" onclick="removeQuestionRow(this);">
				<i class="fas fa-times text-danger"></i>
			</a>
		</td>
		<td>
			<input 
				type="text" 
				class="form-control question-text coach-input" 
				oninput="validateQuestionInput(this)" 
				placeholder="Enter question"
				required
			/>
			<small class="text-danger validation-error" style="display: none;">Enter a valid question</small>
		</td>
	`;

	tableBody.appendChild(row);
}
function addfeedbackCoacheeQuestionRow() {
	const tableBody = document.getElementById("feedbackCoacheeQuestionTableBody");
	const row = document.createElement("tr");

	row.innerHTML = `
		<td>
			<a href="#" onclick="removeQuestionRow(this);">
				<i class="fas fa-times text-danger"></i>
			</a>
		</td>
		<td>
			<input 
				type="text" 
				class="form-control question-text coachee-input" 
				oninput="validateQuestionInput(this)" 
				placeholder="Enter question"
				required
			/>
			<small class="text-danger validation-error" style="display: none;">Enter a valid question</small>
		</td>
	`;

	tableBody.appendChild(row);
}

function addfeedbackMentorQuestionRow() {
	const tableBody = document.getElementById("feedbackMentorQuestionTableBody");
	const row = document.createElement("tr");

	row.innerHTML = `
		<td>
			<a href="#" onclick="removeQuestionRow(this);">
				<i class="fas fa-times text-danger"></i>
			</a>
		</td>
		<td>
			<input 
				type="text" 
				class="form-control question-text mentor-input" 
				oninput="validateQuestionInput(this)" 
				placeholder="Enter question"
				required
			/>
			<small class="text-danger validation-error" style="display: none;">Enter a valid question</small>
		</td>
	`;

	tableBody.appendChild(row);
}

function addfeedbackMenteeQuestionRow() {
	const tableBody = document.getElementById("feedbackMenteeQuestionTableBody");
	const row = document.createElement("tr");

	row.innerHTML = `
		<td>
			<a href="#" onclick="removeQuestionRow(this);">
				<i class="fas fa-times text-danger"></i>
			</a>
		</td>
		<td>
			<input 
				type="text" 
				class="form-control question-text mentee-input" 
				oninput="validateQuestionInput(this)" 
				placeholder="Enter question"
				required
			/>
			<small class="text-danger validation-error" style="display: none;">Enter a valid question</small>
		</td>
	`;

	tableBody.appendChild(row);
}



function prepareFeedbackQuestionsForSubmit() {
	// Coach Questions
	const coachQuestions = [...document.querySelectorAll(".coach-input")]
		.map(input => input.value.trim())
		.filter(val => val !== "");
	document.getElementById("feedbackTextField").value = coachQuestions.join("~");

	// Coachee Questions
	const coacheeQuestions = [...document.querySelectorAll(".coachee-input")]
		.map(input => input.value.trim())
		.filter(val => val !== "");
	document.getElementById("feedbackCoacheeTextField").value = coacheeQuestions.join("~");

	// Mentor Questions
	const mentorQuestions = [...document.querySelectorAll(".mentor-input")]
		.map(input => input.value.trim())
		.filter(val => val !== "");
	document.getElementById("feedbackMentorTextField").value = mentorQuestions.join("~");

	// Mentee Questions
	const menteeQuestions = [...document.querySelectorAll(".mentee-input")]
		.map(input => input.value.trim())
		.filter(val => val !== "");
	document.getElementById("feedbackMenteeTextField").value = menteeQuestions.join("~");

	return true; // allow form submission
}





function addEditfeedbackQuestionRow() {
	const tableBody = document.getElementById("editfeedbackQuestionTableBody");

	const row = document.createElement("tr");
	row.innerHTML = `
		<td>
			<button type="button" onclick="removeQuestionRow(this)" style="border: none; background: none; color: #dc3545;">
				<i class="fas fa-times"></i>
			</button>
		</td>
		<td>

                <input type="text" class="form-control" name="feedbackText"/>
       
			<input type="hidden" name="feedbackText[${questionTextIndex}].mentorMenteeFlag" value="1" />
		</td>
	`;
	tableBody.appendChild(row);
	questionTextIndex++;
}







function addEditfeedbackCoacheeQuestionRow() {
    const tableBody = document.getElementById("editfeedbackCoacheeQuestionTableBody");

    const row = document.createElement("tr");
    row.id = `questionRow-new-${questionTextIndex}`;

    row.innerHTML = `
        <td>
            <button type="button"
                onclick="removeFeedbackQuestionRows('new-${questionTextIndex}', 'new')"
                style="border: none; background: none; color: #dc3545;">
                <i class="fas fa-times"></i>
            </button>
        </td>
        <td>
            <input type="text" class="form-control"
                   name="feedbackcoacheeText[${questionTextIndex}].text" />
            <input type="hidden"
                   name="feedbackcoacheeText[${questionTextIndex}].mentorMenteeFlag"
                   value="2" />
        </td>
    `;

    tableBody.appendChild(row);
    questionTextIndex++;
}



function addEditfeedbackMentorQuestionRow() {
	const tableBody = document.getElementById("editfeedbackMentorQuestionTableBody");

	const row = document.createElement("tr");
	row.innerHTML = `
		<td>
			<button type="button" onclick="removeQuestionRow(this)" style="border: none; background: none; color: #dc3545;">
				<i class="fas fa-times"></i>
			</button>
		</td>
		<td>
		 <input type="text" class="form-control" name="feedbackMentorText"/>
			<input type="hidden" name="feedbackMentorText[${questionTextIndex}].mentorMenteeFlag" value="3" />
		</td>
	`;
	tableBody.appendChild(row);
	questionTextIndex++;
}


function addEditfeedbackMenteeQuestionRow() {
	const tableBody = document.getElementById("editfeedbackMenteeQuestionTableBody");

	const row = document.createElement("tr");
	row.innerHTML = `
		<td>
			<button type="button" onclick="removeQuestionRow(this)" style="border: none; background: none; color: #dc3545;">
				<i class="fas fa-times"></i>
			</button>
		</td>
		<td>
				 <input type="text" class="form-control" name="feedbackMenteeText"/>

			<input type="hidden" name="feedbackMenteeText[${questionTextIndex}].mentorMenteeFlag" value="4" />
		</td>
	`;
	tableBody.appendChild(row);
	questionTextIndex++;
}
// Add this before your return true
console.log("Coach Table Rows:", $('#editfeedbackQuestionTableBody tr').length);
console.log("Coachee Table Rows:", $('#editfeedbackCoacheeQuestionTableBody tr').length);
console.log("Mentor Table Rows:", $('#editfeedbackMentorQuestionTableBody tr').length);
console.log("Mentee Table Rows:", $('#editfeedbackMenteeQuestionTableBody tr').length);

$('#editfeedbackQuestionTableBody tr').each(function(i) {
    console.log(`Coach Q${i}:`, $(this).find('input[type="text"]').val());
});



function prepareEditFeedbackQuestionsForSubmit() {
    const coachQuestions = [];
    const coacheeQuestions = [];
    const mentorQuestions = [];
    const menteeQuestions = [];

    $('#editfeedbackQuestionTableBody tr').each(function() {
        const val = $(this).find('input[type="text"]').val()?.trim();
        if (val) coachQuestions.push(val);
    });

    $('#editfeedbackCoacheeQuestionTableBody tr').each(function() {
        const val = $(this).find('input[type="text"]').val()?.trim();
        if (val) coacheeQuestions.push(val);
    });

    $('#editfeedbackMentorQuestionTableBody tr').each(function() {
        const val = $(this).find('input[type="text"]').val()?.trim();
        if (val) mentorQuestions.push(val);
    });

    $('#editfeedbackMenteeQuestionTableBody tr').each(function() {
        const val = $(this).find('input[type="text"]').val()?.trim();
        if (val) menteeQuestions.push(val);
    });

    $('#feedbackTextField').val(coachQuestions.join('~'));
    $('#feedbackCoacheeTextField').val(coacheeQuestions.join('~'));
    $('#feedbackMentorTextField').val(mentorQuestions.join('~'));
    $('#feedbackMenteeTextField').val(menteeQuestions.join('~'));

    return true;
}


function removeQuestionRow(anchor) {
	const row = anchor.closest("tr");
	if (row) row.remove();
}

function validateQuestionInput(input) {
	const value = input.value.trim();
	const errorMsg = input.nextElementSibling;
	if (value === "" || value.length < 5) {
		errorMsg.style.display = "block";
		input.classList.add("is-invalid");
	} else {
		errorMsg.style.display = "none";
		input.classList.remove("is-invalid");
	}
}







function loadFeedbackQuestionsInformation(batchId) {
    console.log("▶️ Starting loadFeedbackQuestionsInformation for batch:", batchId);

    $.ajax({
        url: `/coaching/feedbackQuestion?batchId=${batchId}`,
        method: 'GET',
        success: function(response) {
            console.log("✅ Feedback questions received for batch:", batchId);

            $("#editfeedbackQuestionTableBody").empty();
            $("#editfeedbackCoacheeQuestionTableBody").empty();
            $("#editfeedbackMentorQuestionTableBody").empty();
            $("#editfeedbackMenteeQuestionTableBody").empty();

            if (Array.isArray(response) && response.length > 0) {
                response.forEach((q, i) => {
                    const questionText = q.question || "";
                    const flag = q.mentorMenteeFlag;

                    const row = `<tr><td>${questionText}</td></tr>`;

                    if (flag == 1) {
                        $("#editfeedbackQuestionTableBody").append(row);
                    } else if (flag == 2) {
                        $("#editfeedbackCoacheeQuestionTableBody").append(row);
                    } else if (flag == 3) {
                        $("#editfeedbackMentorQuestionTableBody").append(row);
                    } else if (flag == 4) {
                        $("#editfeedbackMenteeQuestionTableBody").append(row);
                    } else {
                        console.warn("⚠️ Unknown flag:", flag);
                    }
                });
            }
        },
        error: function(xhr, status, error) {
            console.error("❌ AJAX Error:", error);
            alert("Failed to load feedback questions.");
        }
    });
}


function loadFeedbackQuestionsInformation(batchId) {
    console.log("▶️ Starting loadFeedbackQuestionsInformation for batch:", batchId);

    $.ajax({
        url: `feedbackQuestion?batchId=${batchId}`,
        method: 'GET',
        success: function(response) {
            console.log("✅ Feedback questions received for batch:", batchId, response);

            // Clear all tables first
            $("#editfeedbackQuestionTableBody").empty();
            $("#editfeedbackCoacheeQuestionTableBody").empty();
            $("#editfeedbackMentorQuestionTableBody").empty();
            $("#editfeedbackMenteeQuestionTableBody").empty();

            if (Array.isArray(response) && response.length > 0) {
                response.forEach((q, i) => {
                    const questionText = q.question || "";
                    const questionId = q.id || `new-${i}`;
                    const flag = q.mentorMenteeFlag || 1; // Default to Coach if not specified

                    // Create a proper row with delete functionality
                    const row = `
                        <tr id="feedbackRow-${flag}-${questionId}">
                            <td>
                                <button type="button" 
                                    onclick="removeFeedbackQuestion('${flag}', '${questionId}', '${questionText.replace(/'/g, "\\'")}')"
                                    style="border: none; background: none; color: #dc3545;">
                                    <i class="fas fa-times"></i>
                                </button>
                            </td>
                            <td>
                                <input type="text" class="form-control" 
                                    name="${getQuestionFieldName(flag)}[${i}].question" 
                                    value="${questionText}" />
                                <input type="hidden" 
                                    name="${getQuestionFieldName(flag)}[${i}].id" 
                                    value="${questionId}" />
                                <input type="hidden" 
                                    name="${getQuestionFieldName(flag)}[${i}].mentorMenteeFlag" 
                                    value="${flag}" />
                            </td>
                        </tr>`;

                    // Append to the appropriate table based on flag
                    switch(flag) {
                        case 1: // Coach
                            $("#editfeedbackQuestionTableBody").append(row);
                            break;
                        case 2: // Coachee
                            $("#editfeedbackCoacheeQuestionTableBody").append(row);
                            break;
                        case 3: // Mentor
                            $("#editfeedbackMentorQuestionTableBody").append(row);
                            break;
                        case 4: // Mentee
                            $("#editfeedbackMenteeQuestionTableBody").append(row);
                            break;
                        default:
                            console.warn("⚠️ Unknown flag:", flag);
                            $("#editfeedbackQuestionTableBody").append(row);
                    }
                });
            } else {
                console.log("ℹ️ No feedback questions found for batch:", batchId);
            }
        },
        error: function(xhr, status, error) {
            console.error("❌ AJAX Error:", error);
           
        }
    });
}

// Helper function to get the correct field name based on question type
function getQuestionFieldName(flag) {
    switch(flag) {
        case 1: return 'feedbackText';
        case 2: return 'feedbackcoacheeText';
        case 3: return 'feedbackMentorText';
        case 4: return 'feedbackMenteeText';
        default: return 'feedbackText';
    }
}


function removeFeedbackQuestion(type, id, questionText) {
    console.log("Attempting to delete question:", {type, id, questionText});
    
    if (confirm("Are you sure you want to delete this question?")) {
        // Remove the row from UI immediately
        $(`#feedbackRow-${type}-${id}`).remove();
        
		 if (questionText && questionText !== 'new') {
        // // Only call API if this is not a new question (has a proper ID)
        // if (!id.startsWith('new-')) {
            $.ajax({
                url: 'deleteFeedbackQuestion',
                method: 'POST',
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                data: { 
                    questionText: questionText,
                    questionType: type  // Include type if needed for backend
                },
                success: function(response) {
                    console.log("Delete successful:", response);
                    // You can show a success message if needed
                },
                error: function(xhr, status, error) {
                    console.error("Delete failed:", error);
                    // Show error message and optionally re-add the row
                    // alert("Failed to delete question. Please try again.");
                }
            });
        }
    }
}


function loadFeedbackQuestionsInformation_1(batchId) {
    console.log("▶️ Starting loadFeedbackQuestionsInformation for batch:", batchId);

    $.ajax({
        url: `feedbackQuestion?batchId=${batchId}`,
        method: 'GET',
        success: function(response) {
            console.log("✅ Feedback questions received12:", response);

            // Clear tables
            $("#editfeedbackQuestionTableBody").empty();
            $("#editfeedbackCoacheeQuestionTableBody").empty();
            $("#editfeedbackMentorQuestionTableBody").empty();
            $("#editfeedbackMenteeQuestionTableBody").empty();

            if (Array.isArray(response) && response.length > 0) {

                response.forEach((q) => {

                    const questionText = q.question || "";
                    const flag = parseInt(q.mentorMenteeFlag);   // ⭐ FIX HERE

                    console.log("Flag value:", flag);

                    const row = `<tr><td>${questionText}</td></tr>`;
                  if (flag == 1) {
                      $("#info_feedbackQuestionTableBody").append(row);
                           }
                   else if (flag == 2) {
                     $("#info_feedbackCoacheeQuestionTableBody").append(row);
                    }
                          else if (flag == 3) {
                       $("#info_feedbackMentorQuestionTableBody").append(row);
                   }
                       else if (flag == 4) {
                 $("#info_feedbackMenteeQuestionTableBody").append(row);
                 } 

                    else {
                        console.warn("Unknown flag:", flag);
                    }
                });
            }
        },
        error: function(xhr, status, error) {
            console.error("❌ AJAX Error:", error);
        }
    });
}

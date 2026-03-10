var pagination = true;
$(function() {
	$("#appTable").DataTable({
		"ordering": false,
		"paging": true,
		"info": true,
		"lengthChange": true,
		"searching": true,
		"autoWidth": false,
		"responsive": true,
		"drawCallback": function(settings) {
			if (pagination) {
				$('#appTable_paginate').find(".pagination").append('<li class="paginate_button page-item"><a onclick="loadNextSetValues()" id="loadMore_appTable" class="fa fa-arrow-right page-link" href="#" title="Load More"></a></li>');
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
			title:"App-Dump List",
			orientation: 'portrait',
			customize: function (doc) {
				var now = new Date();
				var jsDate = now.getDate()+'-'+(now.getMonth()+1)+'-'+now.getFullYear();
				var logo = 'data:image/png;base64,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';
				doc['header']=(function() { return {
					columns: [{
						alignment: 'left',
						fontSize: 15,
						text: "Application Hub",
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
	}).buttons().container().appendTo('#appTable_wrapper .col-md-6:eq(0)');

	var appTable = $("#appTable").DataTable();
	var loadAll = window.location.href.split("all").length;
	if(appTable.rows().count() < 20 || loadAll > 1) {
		$("#loadMore_appTable").hide();
		pagination = false;
	}

	if($("#openAddModel").val() != "") {
		$(".btn-tool").click();
	}
	if($("#openEditModel").val() != "") {
		$("#closeEditAppModal").attr("onclick", "location.href='app-dump'");
		$("#editAppModal").modal({
		    backdrop: 'static',
		    keyboard: false
		});
	}
});
function loadNextSetValues() {
	var appTable = $("#appTable").DataTable();
	var offsetValue = appTable.rows().count();
	$('body').addClass('disableClickBody');
	$(".package-loader").show();
	$.ajax({
		url:'loadMoreApp',
		type:'GET',
		data:{'offsetValue':offsetValue},
		dataType : 'json',
		success: function(result) {
			for(var i=0; i<result.length; i++) {
				appTable.row.add([
					result[i]["appAction"],result[i]["appDumpName"],
					result[i]["appDumpDescription"],result[i]["appActive"],
					result[i]["appCreatedBy"],result[i]["appCreatedOn"],
					result[i]["appUpdatedBy"],result[i]["appUpdatedOn"]
				]);
			}
			appTable.draw(false);
			var currentPage = appTable.page.info().page;
			var totalPages = appTable.page.info().pages;
			console.log(totalPages);
			if(totalPages > 1) {
				if(currentPage != (totalPages-1)) {
					appTable.page(currentPage+1).draw(false);
				}
			}
			$("#appTable_paginate").scroll();
			$('#appTable_paginate').show();
			if(result.length < 20) {
				pagination = false;
				$('#loadMore_appTable').hide();
			}
			$('body').removeClass('disableClickBody');
			$(".package-loader").hide();
		},
		error:function() {
			$('#appTable_paginate').show();
			$('body').removeClass('disableClickBody');
			$(".package-loader").hide();
			alert("Something went wrong, kindly try again after sometime.");
		}
	});
}
function editApp(mAppDumpId) {
	$('body').addClass('disableClickBody');
	$(".package-loader").show();
	$.ajax({
		url: 'getAppDumpDetails',
		type: 'GET',
		data: { 'mAppDumpId': mAppDumpId },
		dataType: 'json',
		success: function(result) {
			clearEditFormValidation();
			$("#mAppDumpId").val(mAppDumpId);
			$("#appDumpNameEdit").val(result["appDumpName"]);
			$("#appDumpLinkEdit").val(result["appDumpLink"]);
			$("#appDumpDescriptionEdit").val(result["appDumpDescription"]);
			$("#appDumpDescription2Edit").val(result["appDumpDescription2"]);
			if(result["appDumpActive"] == "1") {
				$("#appDumpActiveEdit1").prop('checked', true);
			} else {
				$("#appDumpActiveEdit2").prop('checked', true);
			}
			$("#tempEntityIdEdit").val(-1);
			if(result["appDumpEntityId"] != "") {
				$("#tempEntityIdEdit").val(parseInt(result["appDumpEntityId"])).change();
			}
			$("#tempDepartmentIdEdit").val(-1);
			if(result["appDumpDepartmentId"] != "") {
				$("#tempDepartmentIdEdit").val(parseInt(result["appDumpDepartmentId"])).change();
			}
			$('body').removeClass('disableClickBody');
			$(".package-loader").hide();
			$("#editAppModal").modal({
			    backdrop: 'static',
			    keyboard: false
			});
		},
		error: function() {
			alert("Something went wrong, try again later");
		}
	});
}
function clearEditFormValidation() {
	$("#appDumpNameEdit").html("");
	$("#appDumpNameEdit").removeClass("is-valid");
	$("#appDumpNameEdit").removeClass("is-invalid");
	
	$("#isActiveEditError").html("");
	$("#isActiveEditError").removeClass("is-invalid");
	$("#isActiveEditError").removeClass("is-valid");
}
$("#app").submit(function() {
	$("#submitAppButton").addClass("disabledButton");
	$('body').addClass('disableClickBody');
	$(".package-loader").show();
	var submitOrNot = true;
	if(appDumpNameValidation("") == false) {
		submitOrNot = false;
	}
	if(appDumpLinkValidation("") == false) {
		submitOrNot = false;
	}
	if(appDumpDescriptionValidation("") == false) {
		submitOrNot = false;
	}
	if(appDumpDescription2Validation("") == false) {
		submitOrNot = false;
	}
	if($("#appDumpActive1").prop("checked") == false && $("#appDumpActive2").prop("checked") == false) {
		$("#isActiveError").html("App state must be selected");
		submitOrNot = false;
	}
	if(submitOrNot) {
		return true;
	} else {
		$("#submitAppButton").removeClass("disabledButton");
		$('body').removeClass('disableClickBody');
		$(".package-loader").hide();
		return false;
	}
});
$("#appEdit").submit(function(){
	$("#saveAppChanges").addClass("disabledButton");
	$('body').addClass('disableClickBody');
	$(".package-loader").show();
	var submitOrNot = true;
	if(appDumpNameValidation("Edit") == false) {
		submitOrNot = false;
	}
	if(appDumpDescriptionValidation("Edit") == false) {
		submitOrNot = false;
	}
	if($("#appActiveEdit1").prop("checked") == false && $("#appActiveEdit2").prop("checked") == false) {
		$("#isActiveError").html("App state must be selected");
		submitOrNot = false;
	}
	if(submitOrNot) {
		return true;
	} else {
		$("#saveAppChanges").removeClass("disabledButton");
		$('body').removeClass('disableClickBody');
		$(".package-loader").hide();
		return false;
	}
});
$("#appDumpName").focusout(function() {
	appDumpNameValidation("");
});
$("#appDumpNameEdit").focusout(function() {
	appDumpNameValidation("Edit");
});
var appDumpNameCheck = /^[ A-Za-z0-9-Á& ]*$/;
function appDumpNameValidation(idAppend) {
	var id = "appDumpName"+idAppend;
	var error = "appDumpNameError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var appDumpName = $("#"+id).val().replace(/\s+/g, " ");
	if(appDumpName != "") {
		if(centralAlphaNumericCheck.test(appDumpName) == false) {
			$("#"+error).html("App Dump Name cannot contain special characters.");
			$("#"+id).addClass("is-invalid");
			return false;
		} else {
			$("#"+id).addClass("is-valid");
			return true;
		}
	} else {
		$("#"+error).html("App Name cannot be empty.");
		$("#"+id).addClass("is-invalid");
		return false;
	}
}

$("#appDumpLink").focusout(function() {
	appDumpLinkValidation("");
});
$("#appDumpLinkEdit").focusout(function() {
	appDumpLinkValidation("Edit");
});
var appDumpLinkCheck = /^[ A-Za-z0-9-Á& ]*$/;
function appDumpLinkValidation(idAppend) {
	var id = "appDumpLink"+idAppend;
	var error = "appDumpLinkError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var appDumpLink = $("#"+id).val().replace(/\s+/g, " ");
	if(appDumpLink != "") {
		/*if(urlCheck.test(appDumpLink) == false) {
			$("#"+error).html("App Dump Link cannot contain special characters.");
			$("#"+id).addClass("is-invalid");
			return false;
		} else {
			$("#"+id).addClass("is-valid");
			return true;
		}*/
		$("#"+id).addClass("is-valid");
		return true;
	} else {
		$("#"+error).html("App Dump Link cannot be empty.");
		$("#"+id).addClass("is-invalid");
		return false;
	}
}

$("#appDumpDescription").focusout(function() {
	appDumpDescriptionValidation("");
});
$("#appDumpDescriptionEdit").focusout(function() {
	appDumpDescriptionValidation("Edit");
});
function appDumpDescriptionValidation(idAppend) {
	var id = "appDumpDescription"+idAppend;
	var error = "appDumpDescriptionError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var appDumpDescription = $("#"+id).val().replace(/\s+/g, " ");
	if(appDumpDescription != "") {
		if(centralTextCheck.test(appDumpDescription) == false) {
			$("#"+error).html("App Dump Description cannot contain special characters.");
			$("#"+id).addClass("is-invalid");
			return false;
		} else {
			$("#"+id).addClass("is-valid");
			return true;
		}
	} else {
		$("#"+error).html("App Dump Description cannot be empty.");
		$("#"+id).addClass("is-invalid");
		return false;
	}
}


$("#appDumpDescription2").focusout(function() {
	appDumpDescription2Validation("");
});
$("#appDumpDescription2Edit").focusout(function() {
	appDumpDescription2Validation("Edit");
});
function appDumpDescription2Validation(idAppend) {
	var id = "appDumpDescription2"+idAppend;
	var error = "appDumpDescription2Error"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var appDumpDescription2 = $("#"+id).val().replace(/\s+/g, " ");
	if(appDumpDescription2 != "") {
		if(centralTextCheck.test(appDumpDescription2) == false) {
			$("#"+error).html("App Dump Description 2 cannot contain special characters.");
			$("#"+id).addClass("is-invalid");
			return false;
		} else {
			$("#"+id).addClass("is-valid");
			return true;
		}
	} else {
		$("#"+error).html("App Dump Description 2 cannot be empty.");
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
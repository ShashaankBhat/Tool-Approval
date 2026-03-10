var pagination = true;
$(function() {
	$('.select2').select2({
		theme: 'bootstrap4'
	});
	var parentEntityFilterValue = $("#parentEntityFilterValue").val();
	if(parentEntityFilterValue != "") {
		$("#parentEntityFilter").val(parentEntityFilterValue);
	}
	var locationFilterValue = $("#locationFilterValue").val();
	if(locationFilterValue != "") {
		$("#locationFilter").val(locationFilterValue);
	}
	
	$("#entityTable").DataTable({
		"ordering": false,
		"paging": true,
		"info": true,
		"scrollX": true,
		"lengthChange": true,
		"searching": true,
		"autoWidth": false,
		"responsive": false,
		"drawCallback": function(settings) {
			if (pagination) {
				$('#entityTable_paginate').find(".pagination").append('<li class="paginate_button page-item"><a onclick="loadNextSetValues()" id="loadMore_entityTable" class="fa fa-arrow-right page-link" href="#" title="Load More"></a></li>');
			}
		},
		"createdRow": function (row,data,index) {
			$(row).removeClass("even");
			$(row).removeClass("odd");
	    	if(index % 2 == 0) {
	    		$(row).addClass("even");
	    	} else {
	    		$(row).addClass("odd");
	    	}
	    },
		"buttons": ["csv", "excel", {
			extend: 'pdf',
			className:'buttons-pdf',
			text:'PDF',
			titleAttr: 'Download in PDF',
			title:"Entity List",
			orientation: 'landscape',
			customize: function (doc) {
				var now = new Date();
				var jsDate = now.getDate()+'-'+(now.getMonth()+1)+'-'+now.getFullYear();
				/*var logo = 'data:image/png;base64,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';*/
				var logo = '';
				doc['header']=(function() { return {
					columns: [{
						alignment: 'left',
						fontSize: 15,
						text: "COMPANY-NAME Central",
					}, /*{
						alignment: 'right',
						image: logo,
						width: 100,
						height:20
					}*/],
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
	}).buttons().container().appendTo('#entityTable_wrapper .col-md-6:eq(0)');

	var entityTable = $("#entityTable").DataTable();
	var loadAll = window.location.href.split("all").length;
	if(entityTable.rows().count() < 10 || loadAll > 1) {
		$("#loadMore_entityTable").hide();
		pagination = false;
	}

	if($("#openAddModel").val() != "") {
		$(".btn-tool").click();
	}
	if($("#openEditModel").val() != "") {
		$("#closeEditEntityModal").attr("onclick", "location.href='entity'");
		$("#editEntityModal").modal({
		    backdrop: 'static',
		    keyboard: false
		});
	}
});
function loadNextSetValues() {
	var entityTable = $("#entityTable").DataTable();
	var offsetValue = entityTable.rows().count();
	$('body').addClass('disableClickBody');
	$(".package-loader").show();
	$.ajax({
		url:'loadMoreEntity',
		type:'GET',
		data:{'offsetValue':offsetValue},
		dataType : 'json',
		success: function(result) {
			for(var i=0; i<result.length; i++) {
				entityTable.row.add([
					result[i]["entityAction"],result[i]["entityName"],
					result[i]["entityShortName"],"<img src='usedStaticFiles/essentials/images/company_images/"+result[i]["entitySource"]+".png' style='height:25px;width:200px' alt='Company Logo' class='brand-image'>"
					,result[i]["entitySource"],result[i]["entityLocation"],result[i]["entityZone"],
					result[i]["entityAcronym"],result[i]["entityActive"],
					result[i]["entityCreatedBy"],result[i]["entityCreatedOn"],
					result[i]["entityUpdatedBy"],result[i]["entityUpdatedOn"]
				]);
			}
			entityTable.draw(false);
			var currentPage = entityTable.page.info().page;
			var totalPages = entityTable.page.info().pages;
			console.log(totalPages);
			if(totalPages > 1) {
				if(currentPage != (totalPages-1)) {
					entityTable.page(currentPage+1).draw(false);
				}
			}
			$("#entityTable_paginate").scroll();
			$('#entityTable_paginate').show();
			if(result.length < 20) {
				pagination = false;
				$('#loadMore_entityTable').hide();
			}
			$('body').removeClass('disableClickBody');
			$(".package-loader").hide();
		},
		error:function() {
			$('#entityTable_paginate').show();
			$('body').removeClass('disableClickBody');
			$(".package-loader").hide();
			alert("Something went wrong, kindly try again after sometime.");
		}
	});
}
function editEntity(mEntityId) {
	$('body').addClass('disableClickBody');
	$(".package-loader").show();
	$.ajax({
		url: 'getEntityDetails',
		type: 'GET',
		data: { 'mEntityId': mEntityId },
		dataType: 'json',
		success: function(result) {
			clearEditFormValidation();
			$("#mEntityId").val(mEntityId);
			$("#entityNameEdit").val(result["entityName"]);
			$("#entityShortNameEdit").val(result["entityShortName"]);
			$("#entityAcronymEdit").val(result["entityAcronym"]);
			$("#parentEntityIdEdit").val(result["parentEntityId"]);
			if(result["loationIdTemp"] == "-1") {
				$(".locationEdit").hide();
			} else {
				$("#loationIdTempEdit").val(result["loationIdTemp"]);
			}
			if(result["entityActive"] == "1") {
				$("#entityActiveEdit1").prop('checked', true);
			} else {
				$("#entityActiveEdit2").prop('checked', true);
			}
			$('body').removeClass('disableClickBody');
			$(".package-loader").hide();
			$("#editEntityModal").modal({
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
	/*$("#entityNameEdit").html("");
	$("#entityNameEdit").removeClass("is-valid");
	$("#entityNameEdit").removeClass("is-invalid");
	
	$("#isActiveEditError").html("");
	$("#isActiveEditError").removeClass("is-invalid");
	$("#isActiveEditError").removeClass("is-valid");*/
}
$("#entity").submit(function(){
	$("#submitEntityButton").addClass("disabledButton");
	$('body').addClass('disableClickBody');
	$(".package-loader").show();
	var submitOrNot = true;
	if(entityNameValidation("") == false) {
		submitOrNot = false;
	}
	console.log("came here");
	if($("#parentEntityId").val() != -1) {
		if(entityAcronymValidation("") == false) {
			submitOrNot = false;
		}
		console.log("came here1");
		if(entityShortNameValidation("") == false) {
			submitOrNot = false;
		}
		console.log("came here2");
		if($("#parentEntityId").val() != 0) {
			if($("#loationIdTemp").val() == -1) {
				submitOrNot = false;
			}
		}
	} else {
		if(parentEntityIdValidation("") == false) {
			submitOrNot = false;
		}
	}
	if($("#entityActive1").prop("checked") == false && $("#entityActive2").prop("checked") == false) {
		$("#isActiveError").html("Entity state must be selected");
		submitOrNot = false;
	}
	if(submitOrNot) {
		$("#entityShortName").attr("disabled", false);
		$("#entityAcronym").attr("disabled", false);
		return true;
	} else {
		$("#submitEntityButton").removeClass("disabledButton");
		$('body').removeClass('disableClickBody');
		$(".package-loader").hide();
		return false;
	}
});
$("#entityEdit").submit(function(){
	$("#saveEntityChanges").addClass("disabledButton");
	$('body').addClass('disableClickBody');
	$(".package-loader").show();
	var submitOrNot = true;
	if(entityNameValidation("Edit") == false) {
		submitOrNot = false;
	}
	if(entityShortNameValidation("Edit") == false) {
		submitOrNot = false;
	}
	if($("#entityActiveEdit1").prop("checked") == false && $("#entityActiveEdit2").prop("checked") == false) {
		$("#isActiveError").html("Entity state must be selected");
		submitOrNot = false;
	}
	if(submitOrNot) {
		return true;
	} else {
		$("#saveEntityChanges").removeClass("disabledButton");
		$('body').removeClass('disableClickBody');
		$(".package-loader").hide();
		return false;
	}
});
$("#entityName").focusout(function() {
	entityNameValidation("");
});
$("#entityNameEdit").focusout(function() {
	entityNameValidation("Edit");
});
function entityNameValidation(idAppend) {
	var id = "entityName"+idAppend;
	var error = "entityNameError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var entityName = $("#"+id).val().replace(/\s+/g, " ");
	if(entityName != "") {
		if(centralAlphaNumericCheck.test(entityName) == false) {
			$("#"+error).html("Entity Name cannot contain special characters.");
			$("#"+id).addClass("is-invalid");
			return false;
		} else {
			$("#"+id).addClass("is-valid");
			return true;
		}
	} else {
		$("#"+error).html("Entity Name cannot be empty.");
		$("#"+id).addClass("is-invalid");
		return false;
	}
}
$("#entityShortName").focusout(function() {
	entityShortNameValidation("");
});
$("#entityShortNameEdit").focusout(function() {
	entityShortNameValidation("Edit");
});
function entityShortNameValidation(idAppend) {
	var id = "entityShortName"+idAppend;
	var error = "entityShortNameError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var entityShortName = $("#"+id).val().replace(/\s+/g, " ");
	if(entityShortName != "") {
		if(centralAlphaNumericCheck.test(entityShortName) == false) {
			$("#"+error).html("Entity Short Name cannot contain special characters.");
			$("#"+id).addClass("is-invalid");
			return false;
		} else {
			$("#"+id).addClass("is-valid");
			return true;
		}
	} else {
		$("#"+error).html("Entity Short Name cannot be empty.");
		$("#"+id).addClass("is-invalid");
		return false;
	}
}
$("#entityAcronym").focusout(function() {
	entityAcronymValidation("");
});
$("#entityAcronymEdit").focusout(function() {
	entityAcronymValidation("Edit");
});
function entityAcronymValidation(idAppend) {
	var id = "entityAcronym"+idAppend;
	var error = "entityAcronymError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var entityAcronym = $("#"+id).val().replace(/\s+/g, " ");
	if(entityAcronym != "") {
		if(centralAlphaNumericCheck.test(entityAcronym) == false) {
			$("#"+error).html("Entity Acronym cannot contain special characters.");
			$("#"+id).addClass("is-invalid");
			return true;
		} else {
			$("#"+id).addClass("is-valid");
			return true;
		}
	} else {
		$("#"+error).html("Entity Acronym cannot be empty.");
		$("#"+id).addClass("is-invalid");
		return false;
	}
}

$("#parentEntityId").change(function() {
	parentEntityIdValidation("");
});
$("#parentEntityIdEdit").change(function() {
	parentEntityIdValidation("Edit");
});
var parentEntityIdCheck = /^[ A-Za-z0-9-Á& ]*$/;
function parentEntityIdValidation(idAppend) {
	var id = "parentEntityId"+idAppend;
	var error = "parentEntityIdError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var parentEntityId = $("#"+id).val();
	if(parentEntityId != "-1") {
		$('body').addClass('disableClickBody');
		$(".package-loader").show();
		if(parentEntityId == "0") {
			if(idAppend == "") {
				$("#loationIdTemp").val(-1);
				$(".location").hide();
				$("#entityShortName").val("");
				$("#entityAcronym").val("");
				
				$("#entityShortName").attr("disabled", false);
				$("#entityAcronym").attr("disabled", false);
			} else {
				$("#loationIdTempEdit").val(-1);
				$(".locationEdit").hide();
				/*$("#entityShortNameEdit").val("");
				$("#entityAcronymEdit").val("");*/
				
				$("#entityShortNameEdit").attr("disabled", false);
				$("#entityAcronymEdit").attr("disabled", false);
			}
			
			$('body').removeClass('disableClickBody');
			$(".package-loader").hide();
		} else {
			if(idAppend == "") {
				$(".location").show();
				$.ajax({
					url: 'getEntityDetails',
					type: 'GET',
					data: { 'mEntityId': parentEntityId },
					dataType: 'json',
					success: function(result) {
						$("#entityShortName").val(result["entityShortName"]);
						$("#entityAcronym").val(result["entityAcronym"]);
						
						$("#entityShortName").attr("disabled", true);
						$("#entityAcronym").attr("disabled", true);
						
						$('body').removeClass('disableClickBody');
						$(".package-loader").hide();
					},
					error: function() {
						alert("Something went wrong, try again later");
					}
				});
			} else {
				$(".locationEdit").show();
				$('body').removeClass('disableClickBody');
				$(".package-loader").hide();
			}
		}
		$("#"+id).addClass("is-valid");
		return true;
	} else {
		$("#"+error).html("Entity Short Name cannot be empty.");
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
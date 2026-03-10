var pagination = true;
$(function () {
	$('.select2').select2({
		theme: 'bootstrap4'
	});
	$("#approvalMatrixTable").DataTable({
		"ordering": false,
		"paging": true,
		"info": true,
		"lengthChange": true,
		"searching": true,
		"autoWidth": false,
		"responsive": false,
		"drawCallback": function(settings) {
			if (pagination) {
				$('#approvalMatrixTable_paginate').find(".pagination").append('<li class="paginate_button page-item"><a onclick="loadNextSetValues()" id="loadMore_approvalMatrixTable" class="fa fa-arrow-right page-link" href="#" title="Load More"></a></li>');
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
			title:"Approval Matrix List",
			orientation: 'landscape',
			customize: function (doc) {
				var now = new Date();
				var jsDate = now.getDate()+'-'+(now.getMonth()+1)+'-'+now.getFullYear();
				var logo = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOAAAAAhCAMAAAD3R1fCAAAB8lBMVEVHcEwANUkALj8AkcgASmYAb5kApuQAKzsARV4ANUgAre0Aot4Are0AO1EAKDYAWnwApuQAKTgAru8Aq+oAdaAAWXoAre4AsvUAPFIAjMAAe6gApOIAl9EAqekAot8Ag7UAsPEAo98AbJQAot8Am9UATmsAW30AsvQAn9oAfKoAT20Aq+sASmUAS2cAe6gAo+AAqegAkccAPVMAp+YAg7QAMEIAgrIAgbEAjsQAi78ARV8ARmAAibwAbpcAapIAls4AtPcArO0AndcAqOYAcZoAYoYAmtMAMkYAiLwAgLAAkcYAYYUAntkAkcgAd6IAg7MAYocAVHQAX4MAYocAd6MAlc0AkMUARF0Ad6QAhrkAqegAp+YAru8Aq+oAsPIAWXsAcJoAUnEAn9sAXoEAWXkARmEAir0ASmYAGyUAdaAAr/AAM0YAiLsAg7MApOEAnNYAa5MAj8UAfKsAfKoAnNYAb5kATGgApeIAYIQAXH8AksgAfa0Ah7oAsfMAgrMAcZsAot4AsvUAmNEAWXoAm9UAl88AZowAkskAkccAtvoAdqMAjcEAeqcAh7oApuQAhrkAlMsAru8AsPIAr/AAtfkAtPcAsfQAr/EAsPEAs/YAtfgArvAAsvUAtvoAt/sAsvQAru8Auf4At/wAs/UAuP0AvP+lRbl5AAAAkXRSTlMAJgjPAg7kAQUL+d/7LxZe6A/u8xxn/fs1s5nw1PHbPfvXbtPaPEX32Ckw+CcbkOX1vRTfoxmLllmlQSKqeV+//fbO7IJoyB1XOW830spoqz01TkqGyrQWfrfj1eno/RNWSt4rUjeeRiB58ytQnujVZVGJdLF0K91WY8E9kfOzl8jp0CTCuHOro/E1vk+/9GjIA5ZG/gAAB5lJREFUGBnlwHlXE+cCBvAHGk2CIEZbEdpQSgW4rKIgl4Igm9wWryuK112tWq3WfT3dF+1++8w7M5mZZCbHgN/zJu87M0mmes79s5z+8Pf3l7Ln4juB7tb3O5AYPdna2rqh7OTpb6ZSWLtS+1ZzPlOzz/RhodXTKgnSm0hg7Vo+ZTNkv7cRNWdWGPFiFGtYw2yOIX0qiQ+6TEa82IM17GqTxpD7PIZGJ8NqovAEr1VbU/IP3zmUJRoaGrb5kvD9/GHRu0U/x6Bcelc69IG0E2V9d27cuPEv6dc4lJFG6a235rdhubGx8clboQMflZy/hIjbBcGQtxuYKzBCa7qK10gO1fX27uitU5quoGxyr6BPH4CyeFZkS2gMxSFduG5li6gZdtGLSYRixxwtoD+G0vJSV15OYuClXimnmUW5+u/Po9qSk2Ug610DrniMMK9vw6uNFSxN0yyh2PviCNR22yLjM+v7ID23mZWMx5AaNueYLaHk7Eao084ykOtOoKSmTqOU216bHDT5CiKfu/8mqkzoDGXsx0g8dRlh71rAq9z1WCmT7kfgqM0yfRglDW0ZSvlbCZQsPLJZyX6KULPBMnceJS0eFe8B5nW+htNag0q13xsMaV2d2NhtMMKZSeHP2gtZVsl3IjBksEy09aDoS5eKcw0lqX0Oq2izO+G71CZYlm9NAqipsyhp6X7M5OjLFTzPsY0cA8b+JCqNbLAZyp9+iE/P5BjhHa9F1OO9Fqs57fD1tAlWMI4DONwmKFnpfhQlml1WE6IHvhadldw9AFo8KvowOvJZKrljX3311ejnn0/lM/R5e1ClZ7PJkPFoBFe7NEas3kRER5dJRctQMa7AN+GwktA6gQmdijOBkpYClWw+S8VphNK/RWMl87OdWNiiURJaB4Z1KqLtIZQDWwWVle0JVDnSlGFI35fCE08wojCHKn0nc1Ty7w9alHLvxCCNT1ussncKPW0ZSuLsYRSd8LKUhPm8N0tJb4FyQme1whxaPCr291hIa1SMXxC46VCxdvSj2gFHMOQdT2DuBSNEYR4Vdr7nULEfLY8ZlKzecUh3dfpMQck+elOnYvyBokY9QynrLMUumpRy38ZQUrshT0XkKGmzF97WqOhPsOTR5xxF4JAmKImtPYjY7bJsdRQYLjDCarqAUHLIpZKfvYRrOhXjCEpSgyYVrXs6yxLtsy2CijMJ4GqXRqUwDDQblLR0P0puO1REb7NGSewQVMzBZG2rSWXlVgyBN6cFpUzvOCLiwwbLCifitUM5RuS/6EBgzKOiXT8EHLGpuM9Q8qxAJVPXN2ZQ0gQVbdM5oGFzjorXHAMGXEpZaxFFsf05Kk5zcoNJyaLPHcBjnT69HaGerYKStn4dopJnLIYyL7ahpivDCGcGvrseFdF1BMDCtEXJOYii2lsrVJwxXD4rWMW5CyzssqmYUwkARwwqxgEUXbCzlMTZDjzQWcWaHseQQUVLLyPUrlOxh/AnS00sWx2tTTSvMEL74hCUdk9QsedGPvnkk5ruPCXzYi2Aj3UqVm8fcNBlpUz9d0h9bVCx0kcOLy4unq8XlIwxFDU7VPRmIHnRZCWnGYfzgoo+gFDsmE3FnURUuyMYsn+MY3SVEWbXVSiP91oMvP37jh07fq/PUsrUfQfEfzGo6AMALp8VrGA0I9GsM1C/VWSFYCA/EwcOt2UoWXUPATxwWck+ilGdimjrQ+iZQyU/mELE0SaLIe9+As88wWpa23koHV0mQ5ZWwkC+EzhkU9HS/Sj60mUF5yhGCywTEn3a7DlgWKeiX0FRcjDPslx3Ymdao+IcRCD5UZOg4jUiomezyZDzNImPXYvVxMt5KH0nV/hazglgzKDizqHkcluGoZVvcc2lks2EBBVhdmA8rVGypsdRcs9gmd6Odp0+7Z0v/yP99lurKajoBxEx8shmaOXUTmy7brKaMPZA2XjLoZI3tYCpUbF/wHidRcnctAzpoMuQ1/ixnqEkzK1KXV3dVkFFf4ATLhV9AFJyvcmAll5ObM8xYOo+R6PP/jqFaskphyGjdQELu2xGuLuhJKd0KvbMP5U7d+7c2G9SMgdjSzqVQjuk+IdNDGgbJq9rlLLetQalpqamI21R0g8m15uUrPQIlHs2A3oLOm2+nmnfX4eIH12G8psuIbXPYYRxE0psYjVjlWRWWvtRNuoKSavvnLVNybmYhO8HR7OU3MwmO2OVaO4SAnGg281J3rcPCpqyegK+1GeGaUiOfhlDnqaYRoRtr6y/F0fEnMuQ+dNlxCcKjDDux6EsGfV1Uv2uh6hw+4stSrr5bV/6NgKLg5tCs5vWSyc/R6WB1u3Ksafv+fYtI3Dg1P43lGEsz7zv2/9G6N/SseP/PYeoSVcwoE13AncLjHCmkvBta/i0RjmHSrVvhjYGUJZKrfsTVInV+pLJhC+GskQsrgCJRCwQD+G1OrssBqy954F5V7Ba/ut1+P/F8ZfSdybPQMabBy7stVjNPtWPNWvjfoMBYd8DPt1sslp+8DusWYkfXIZe3AVGug1WM79ZxJoVu+IypLcAqT9cWplK+elDWLsO/LTZd/r0N89jiO3+6fSZ9aFdJb/ib+V/NUXzv6YMwMQAAAAASUVORK5CYII=';
				doc['header']=(function() { return {
					columns: [{
						alignment: 'left',
						fontSize: 15,
						text: "Tool Approval",
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
	}).buttons().container().appendTo('#approvalMatrixTable_wrapper .col-md-6:eq(0)');
	$('select[name="approvalMatrixTable_length"]').val(25).trigger('change');
	var approvalMatrixTable = $("#approvalMatrixTable").DataTable();
	var loadAll = window.location.href.split("all").length;
	if(approvalMatrixTable.rows().count() < 25 || loadAll > 1) {
		$("#loadMore_approvalMatrixTable").hide();
		pagination = false;
	}
	if($("#openAddModel").val() != "") {
		$(".btn-tool").click();
		$("#tempBusinessUnit").val($("#uiTempBusinessUnitId").val()).trigger("change");
		$("#tempLevelOneId").val($("#uiTempLevelOneId").val()).trigger("change");
		$("#tempLevelTwoId").val($("#uiTempLevelTwoId").val()).trigger("change");
		$("#tempLevelThreeId").val($("#uiTempLevelThreeId").val()).trigger("change");
		$("#tempLevelFourId").val($("#uiTempLevelFourId").val()).trigger("change");
		if ($("#activenessTemp").val() == 1) {
			$("#matrixActive2").prop("checked", true);
		} else {
			$("#matrixActive1").prop("checked", true);
		}
	}
	if($("#openEditModel").val() != "") {
		$("#closeEditTaApprovalMatrixModal").attr("onclick", "location.href='ta-approval-matrix'");
		$("#tempBusinessUnitEdit").val($("#uiTempBusinessUnitId").val()).trigger("change");
		$("#tempLevelOneIdEdit").val($("#uiTempLevelOneId").val()).trigger("change");
		$("#tempLevelTwoIdEdit").val($("#uiTempLevelTwoId").val()).trigger("change");
		$("#tempLevelThreeIdEdit").val($("#uiTempLevelThreeId").val()).trigger("change");
		$("#tempLevelFourIdEdit").val($("#uiTempLevelFourId").val()).trigger("change");
		if ($("#activenessTemp").val == 1) {
			$("#matrixActiveEdit1").prop("checked", true);
		} else {
			$("#matrixActiveEdit2").prop("checked", true);
		}
		$("#editTaApprovalMatrixModal").modal({
			backdrop: 'static',
			keyboard: false
		});
	}
});
$("#approvalMatrix").submit(function(){
	$("#submitTaBusinessUnitButton").addClass("disabledButton");
	$('body').addClass('disableClickBody');
	$(".package-loader").show();
	var submitOrNot = true;
	if(tempEntityIdValidation("") == false) {
		submitOrNot = false;
	}
	if(tempLevelOneIdValidation("") == false) {
		submitOrNot = false;
	}
	if(levelOnePositionValidation("") == false) {
		submitOrNot = false;
	}
	if(tempLevelTwoIdValidation("") == false) {
		submitOrNot = false;
	}
	if(levelTwoPositionValidation("") == false) {
		submitOrNot = false;
	}
	if(tempLevelThreeIdValidation("") == false) {
		submitOrNot = false;
	}
	if(levelThreePositionValidation("") == false) {
		submitOrNot = false;
	}
	if(tempLevelFourIdValidation("") == false) {
		submitOrNot = false;
	}
	if(levelFourPositionValidation("") == false) {
		submitOrNot = false;
	}
	if($("#matrixActive1").prop("checked") == false && $("#matrixActive2").prop("checked") == false) {
		$("#isActiveError").html("Approval Matrix state must be selected");
		submitOrNot = false;
	}
	if(submitOrNot) {
		return true;
	} else {
		$("#submitTaBusinessUnitButton").removeClass("disabledButton");
		$('body').removeClass('disableClickBody');
		$(".package-loader").hide();
		return false;
	}
});
$("#approvalMatrixEdit").submit(function(){
	$("#saveTaApprovalMatrixChanges").addClass("disabledButton");
	$('body').addClass('disableClickBody');
	$(".package-loader").show();
	var submitOrNot = true;
	if(tempEntityIdValidation("Edit") == false) {
		submitOrNot = false;
	}
	if(tempLevelOneIdValidation("Edit") == false) {
		submitOrNot = false;
	}
	if(levelOnePositionValidation("Edit") == false) {
		submitOrNot = false;
	}
	if(tempLevelTwoIdValidation("Edit") == false) {
		submitOrNot = false;
	}
	if(levelTwoPositionValidation("Edit") == false) {
		submitOrNot = false;
	}
	if(tempLevelThreeIdValidation("Edit") == false) {
		submitOrNot = false;
	}
	if(levelThreePositionValidation("Edit") == false) {
		submitOrNot = false;
	}
	if(tempLevelFourIdValidation("Edit") == false) {
		submitOrNot = false;
	}
	if(levelFourPositionValidation("Edit") == false) {
		submitOrNot = false;
	}
	if($("#matrixActiveEdit1").prop("checked") == false && $("#matrixActiveEdit2").prop("checked") == false) {
		$("#isActiveEditError").html("Approval Matrix state must be selected");
		submitOrNot = false;
	}
	if(submitOrNot) {
		return true;
	} else {
		$("#saveTaApprovalMatrixChanges").removeClass("disabledButton");
		$('body').removeClass('disableClickBody');
		$(".package-loader").hide();
		return false;
	}
});
$("#tempBusinessUnit").change(function() {
	tempEntityIdValidation("");
});
$("#tempBusinessUnitEdit").change(function() {
	tempEntityIdValidation("Edit");
});
function tempEntityIdValidation(idAppend) {
	var id = "tempBusinessUnit"+idAppend;
	var error = "tempBusinessUnitError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var tempBusinessUnit = $("#"+id).val();
	if(tempBusinessUnit == -1) {
		$("#"+id).addClass("is-invalid");
		$("#"+error).html("Select Business Unit.");
		return false;
	} else {
		$("#"+id).addClass("is-valid");
		return true;
	}
}
$("#tempLevelOneId").change(function() {
	tempLevelOneIdValidation("");
});
$("#tempLevelOneIdEdit").change(function() {
	tempLevelOneIdValidation("Edit");
});
function tempLevelOneIdValidation(idAppend) {
	var id = "tempLevelOneId"+idAppend;
	var error = "tempLevelOneIdError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var tempLevelOneId = $("#"+id).val();
	if(tempLevelOneId == -1) {
		$("#"+id).addClass("is-invalid");
		$("#"+error).html("Select Approver Level One.");
		return false;
	} else {
		$("#"+id).addClass("is-valid");
		return true;
	}
}
$("#tempLevelTwoId").change(function() {
	tempLevelTwoIdValidation("");
});
$("#tempLevelTwoIdEdit").change(function() {
	tempLevelTwoIdValidation("Edit");
});
function tempLevelTwoIdValidation(idAppend) {
	var id = "tempLevelTwoId"+idAppend;
	var error = "tempLevelTwoIdError"+idAppend;
	console.log(id);
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var tempLevelTwoId = $("#"+id).val();
	console.log(tempLevelTwoId+"-"+$("#"+id).val());
	if(tempLevelTwoId == -1) {
		$("#"+id).addClass("is-invalid");
		$("#"+error).html("Select Approver Level Two.");
		return false;
	} else {
		$("#"+id).addClass("is-valid");
		return true;
	}
}
$("#tempLevelThreeId").change(function() {
	tempLevelThreeIdValidation("");
});
$("#tempLevelThreeIdEdit").change(function() {
	tempLevelThreeIdValidation("Edit");
});
function tempLevelThreeIdValidation(idAppend) {
	var id = "tempLevelThreeId"+idAppend;
	var error = "tempLevelThreeIdError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var tempLevelThreeId = $("#"+id).val();
	if(tempLevelThreeId == -1) {
		$("#"+id).addClass("is-invalid");
		$("#"+error).html("Select Approver Level Three.");
		return false;
	} else {
		$("#"+id).addClass("is-valid");
		return true;
	}
}
$("#tempLevelFourId").change(function() {
	tempLevelFourIdValidation("");
});
$("#tempLevelFourIdEdit").change(function() {
	tempLevelFourIdValidation("Edit");
});
function tempLevelFourIdValidation(idAppend) {
	var id = "tempLevelFourId"+idAppend;
	var error = "tempLevelFourIdError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var tempLevelFourId = $("#"+id).val();
	if(tempLevelFourId == -1) {
		$("#"+id).addClass("is-invalid");
		$("#"+error).html("Select Approver Level Four.");
		return false;
	} else {
		$("#"+id).addClass("is-valid");
		return true;
	}
}
$("#levelOnePosition").focusout(function() {
	levelOnePositionValidation("");
});
$("#levelOnePositionEdit").focusout(function() {
	levelOnePositionValidation("Edit");
});
function levelOnePositionValidation(idAppend) {
	var id = "levelOnePosition"+idAppend;
	var error = "levelOnePositionError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var levelOnePosition = $("#"+id).val().replace(/\s+/g, " ");
	if(levelOnePosition != "") {
		if(centralAlphaNumericCheck.test(levelOnePosition) == false) {
			$("#"+error).html("Level One Position cannot contain special characters.");
			$("#"+id).addClass("is-invalid");
			return false;
		} else {
			$("#"+id).addClass("is-valid");
			return true;
		}
	} else {
		$("#"+error).html("Level One Position cannot be empty.");
		$("#"+id).addClass("is-invalid");
		return false;
	}
}
$("#levelTwoPosition").focusout(function() {
	levelTwoPositionValidation("");
});
$("#levelTwoPositionEdit").focusout(function() {
	levelTwoPositionValidation("Edit");
});
function levelTwoPositionValidation(idAppend) {
	var id = "levelTwoPosition"+idAppend;
	var error = "levelTwoPositionError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var levelTwoPosition = $("#"+id).val().replace(/\s+/g, " ");
	if(levelTwoPosition != "") {
		if(centralAlphaNumericCheck.test(levelTwoPosition) == false) {
			$("#"+error).html("Level Two Position cannot contain special characters.");
			$("#"+id).addClass("is-invalid");
			return false;
		} else {
			$("#"+id).addClass("is-valid");
			return true;
		}
	} else {
		$("#"+error).html("Status Name cannot be empty.");
		$("#"+id).addClass("is-invalid");
		return false;
	}
}
$("#levelThreePosition").focusout(function() {
	levelThreePositionValidation("");
});
$("#levelThreePositionEdit").focusout(function() {
	levelThreePositionValidation("Edit");
});
function levelThreePositionValidation(idAppend) {
	var id = "levelThreePosition"+idAppend;
	var error = "levelThreePositionError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var levelThreePosition = $("#"+id).val().replace(/\s+/g, " ");
	if(levelThreePosition != "") {
		if(centralAlphaNumericCheck.test(levelThreePosition) == false) {
			$("#"+error).html("Status Name cannot contain special characters.");
			$("#"+id).addClass("is-invalid");
			return false;
		} else {
			$("#"+id).addClass("is-valid");
			return true;
		}
	} else {
		$("#"+error).html("Level Three Position cannot be empty.");
		$("#"+id).addClass("is-invalid");
		return false;
	}
}
$("#levelFourPosition").focusout(function() {
	levelFourPositionValidation("");
});
$("#levelFourPositionEdit").focusout(function() {
	levelFourPositionValidation("Edit");
});
function levelFourPositionValidation(idAppend) {
	var id = "levelFourPosition"+idAppend;
	var error = "levelFourPositionError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var levelFourPosition = $("#"+id).val().replace(/\s+/g, " ");
	if(levelFourPosition != "") {
		if(centralAlphaNumericCheck.test(levelFourPosition) == false) {
			$("#"+error).html("Status Name cannot contain special characters.");
			$("#"+id).addClass("is-invalid");
			return false;
		} else {
			$("#"+id).addClass("is-valid");
			return true;
		}
	} else {
		$("#"+error).html("Level Four Position cannot be empty.");
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
function loadNextSetValues() {
	var approvalMatrixTable = $("#approvalMatrixTable").DataTable();
	var offsetValue = approvalMatrixTable.rows().count();
	$('body').addClass('disableClickBody');
	$(".package-loader").show();
	$.ajax({
		url:'loadMoreApprovalMatrix',
		type:'GET',
		data:{'offsetValue':offsetValue},
		dataType : 'json',
		success: function(result) {
			for(var i=0; i<result.length; i++) {
				approvalMatrixTable.row.add([
					result[i]["approvalMatrixAction"],result[i]["approvalMatrixBusinessUnit"],result[i]["approvalMatrixLevelOne"],
					result[i]["approvalMatrixLevelTwo"],result[i]["approvalMatrixLevelThree"],result[i]["approvalMatrixLevelFour"],
					result[i]["approvalMatrixActive"],result[i]["approvalMatrixCreatedBy"],result[i]["approvalMatrixCreatedOn"],result[i]["approvalMatrixUpdatedBy"],result[i]["approvalMatrixUpdatedOn"]
				]);
			}
			approvalMatrixTable.draw(false);
			var currentPage = approvalMatrixTable.page.info().page;
			var totalPages = approvalMatrixTable.page.info().pages;
			if(totalPages > 1) {
				if(currentPage != (totalPages-1)) {
					approvalMatrixTable.page(currentPage+1).draw(false);
				}
			}
			$("#approvalMatrixTable_paginate").scroll();
			$('#approvalMatrixTable_paginate').show();
			if(result.length < 25) {
				pagination = false;
				$('#loadMore_approvalMatrixTable').hide();
			}
			$('body').removeClass('disableClickBody');
			$(".package-loader").hide();
		},
		error:function() {
			$('#approvalMatrixTable_paginate').show();
			$('body').removeClass('disableClickBody');
			$(".package-loader").hide();
			alert("Something went wrong, kindly try again after sometime.");
		}
	});
}
function editApprovalMatrix(taApprovalMatrixId) {
    $.ajax({
        url: 'getApprovalMatrixDetails',
        type: 'GET',
        data: { taApprovalMatrixId: taApprovalMatrixId },
        dataType: 'json',
        success: function (result) {
            $("#taApprovalMatrixId").val(taApprovalMatrixId);
			$("#tempBusinessUnitEdit").val(result.businessUnit).trigger("change");
			$("#tempLevelOneIdEdit").val(result.levelOne).trigger("change");
			$("#tempLevelTwoIdEdit").val(result.levelTwo).trigger("change");
			$("#tempLevelThreeIdEdit").val(result.levelThree).trigger("change");
			$("#tempLevelFourIdEdit").val(result.levelFour).trigger("change");
			$("#levelOnePositionEdit").val(result.levelOnePosition);
			$("#levelTwoPositionEdit").val(result.levelTwoPosition);
			$("#levelThreePositionEdit").val(result.levelThreePosition);
			$("#levelFourPositionEdit").val(result.levelFourPosition);
            if (result.matrixActive == "1") {
				$("#matrixActiveEdit1").prop("checked", true);
			} else {
				$("#matrixActiveEdit2").prop("checked", true);
			}
            $("#editTaApprovalMatrixModal").modal({ 
				backdrop:'static', 
				keyboard:false
			});
        }
    });
}
$(function () {
    $("#taBusinessUnitTable").DataTable({
        "ordering": false,
        "paging": true,
        "info": true,
        "lengthChange": true,
        "searching": true,
        "autoWidth": false,
        "responsive": true,
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
            orientation: 'portrait',
            customize: function (doc) {
                var now = new Date();
                var jsDate = now.getDate()+'-'+(now.getMonth()+1)+'-'+now.getFullYear();
                var logo = 'data:image/png;base64,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';
                doc['header']=(function() { return {
                    columns: [{
                        alignment: 'left',
                        fontSize: 15,
                        text: "ANAND Projects",
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
    }).buttons().container().appendTo('#taBusinessUnitTable_wrapper .col-md-6:eq(0)');
	if($("#openAddModel").val() != "") {
		$(".btn-tool").click();
		if ($("#activenessTemp").val == 1) {
			$("#taBusinessUnitActive2").prop("checked", true);
		} else {
			$("#taBusinessUnitActive1").prop("checked", true);
		}
	}
	if($("#openEditModel").val() != "") {
		$("#closeEditTaBusinessUnitModal").attr("onclick", "location.href='ta-business-unit'");
		if ($("#activenessTemp").val == 1) {
			$("#taBusinessUnitActiveEdit1").prop("checked", true);
		} else {
			$("#taBusinessUnitActiveEdit2").prop("checked", true);
		}
		$("#editTaBusinessUnitModal").modal({
			backdrop: 'static',
			keyboard: false
		});
	}
});
function editBusinessUnit(id) {
    $.ajax({
        url: 'getBusinessUnitDetails',
        type: 'GET',
        data: { 'taBusinessUnitId': id },
        dataType: 'json',
        success: function (result) {
            $("#taBusinessUnitId").val(id);
            $("#taBusinessUnitNameEdit").val(result.taBusinessUnitName);
            $("#taBusinessUnitDescriptionEdit").val(result.taBusinessUnitDescription);
            if (result.taBusinessUnitActive == "1") {
                $("#taBusinessUnitActiveEdit1").prop("checked", true);
            } else {
                $("#taBusinessUnitActiveEdit2").prop("checked", true);
            }
            $("#editTaBusinessUnitModal").modal({
                backdrop: 'static',
                keyboard: false
            });
        },
        error: function () {
            alert("Unable to fetch details.");
        }
    });
}
$("#taBusinessUnit").submit(function () {
    var isValid = true;
    var name = $("#taBusinessUnitName");
    name.removeClass("is-invalid");
    $("#taBusinessUnitNameError").text("");
    if (!name.val()) {
        name.addClass("is-invalid");
        $("#taBusinessUnitNameError").text("Business Unit Name is mandatory.");
        isValid = false;
    }
    var description = $("#taBusinessUnitDescription");
    description.removeClass("is-invalid");
    $("#taBusinessUnitDescriptionError").text("");
    if (!description.val()) {
        description.addClass("is-invalid");
        $("#taBusinessUnitDescriptionError").text("Business Unit Description is mandatory.");
        isValid = false;
    }
    if ($("input[name='taBusinessUnitActive']:checked").length === 0) {
        $("#isActiveError").text("Please select Active/Inactive status.");
        isValid = false;
    } else {
        $("#isActiveError").text("");
    }
    return isValid;
});
$("#taBusinessUnitEdit").submit(function () {
    var isValid = true;
    var name = $("#taBusinessUnitNameEdit");
    name.removeClass("is-invalid");
    $("#taBusinessUnitNameErrorEdit").text("");
    if (!name.val()) {
        name.addClass("is-invalid");
        $("#taBusinessUnitNameErrorEdit").text("Business Unit Name is mandatory.");
        isValid = false;
    }
    var description = $("#taBusinessUnitDescriptionEdit");
    description.removeClass("is-invalid");
    $("#taBusinessUnitDescriptionErrorEdit").text("");
    if (!description.val()) {
        description.addClass("is-invalid");
        $("#taBusinessUnitDescriptionErrorEdit").text("Business Unit Description is mandatory.");
        isValid = false;
    }
    if ($("#taBusinessUnitActiveEdit1:checked, #taBusinessUnitActiveEdit2:checked").length === 0) {
        $("#isActiveEditError").text("Please select Active/Inactive status.");
        isValid = false;
    } else {
        $("#isActiveEditError").text("");
    }
    return isValid;
});
$("#taBusinessUnit input, #taBusinessUnit textarea, #taBusinessUnit select").on("input change", function () {
    $(this).removeClass("is-invalid");
    $("#taBusinessUnitNameError").text("");
    $("#taBusinessUnitDescriptionError").text("");
    $("#isActiveError").text("");
});
$("#taBusinessUnitEdit input, #taBusinessUnitEdit textarea, #taBusinessUnitEdit select").on("input change", function () {
    $(this).removeClass("is-invalid");
    $("#taBusinessUnitNameErrorEdit").text("");
    $("#taBusinessUnitDescriptionErrorEdit").text("");
    $("#isActiveEditError").text("");
});
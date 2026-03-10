$(function () {

    $("#taStatusTable").DataTable({
        "ordering": false,
        "paging": true,
        "info": true,
        "lengthChange": true,
        "searching": true,
        "autoWidth": false,
        "responsive": true,
        "columnDefs": [
            { "width": "90px", "targets": 0 }
        ],
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
            title:"Status List",
            orientation: 'portrait',
            pageSize: 'LEGAL',
            exportOptions: {
                columns: ':visible thead th:not(.noExport)'
            }
        }, "print", "colvis"]
    }).buttons().container().appendTo('#taStatusTable_wrapper .col-md-6:eq(0)');

});

// Edit AJAX
function editStatus(id) {
    $.ajax({
        url: 'getStatusDetails',
        type: 'GET',
        data: { taStatusId: id },
        dataType: 'json',
        success: function (result) {
            $("#taStatusId").val(id);
            $("#taStatusNameEdit").val(result.taStatusName);
            $("#taStatusDescriptionEdit").val(result.taStatusDescription);
            if (result.taStatusActive == "1") $("#taStatusActiveEdit1").prop("checked", true);
            else $("#taStatusActiveEdit2").prop("checked", true);

            $("#editTaStatusModal").modal({ backdrop:'static', keyboard:false });
        }
    });
}

// Validation
$("#taStatus").submit(function () {
    var isValid = true;
    $(".invalid-feedback").text("");

    if (!$("#taStatusName").val()) {
        isValid = false;
        $("#taStatusName").addClass("is-invalid").next(".invalid-feedback").text("Name is mandatory.");
    }
    if (!$("#taStatusDescription").val()) {
        isValid = false;
        $("#taStatusDescription").addClass("is-invalid").next(".invalid-feedback").text("Description is mandatory.");
    }
    if ($("input[name='taStatusActive']:checked").length === 0) {
        isValid = false;
        $("#matrixActiveError").text("Please select Active/Inactive.");
    }
    return isValid;
});

$("#taStatusEdit").submit(function () {
    var isValid = true;
    $(".invalid-feedback").text("");

    if (!$("#taStatusNameEdit").val()) {
        isValid = false;
        $("#taStatusNameEdit").addClass("is-invalid").next(".invalid-feedback").text("Name is mandatory.");
    }
    if (!$("#taStatusDescriptionEdit").val()) {
        isValid = false;
        $("#taStatusDescriptionEdit").addClass("is-invalid").next(".invalid-feedback").text("Description is mandatory.");
    }
    if ($("#isActiveEditDiv input[name='taStatusActive']:checked").length === 0) {
        isValid = false;
        $("#matrixActiveEditError").text("Please select Active/Inactive.");
    }
    return isValid;
});

$("select, input[type='text']").change(function () {
    $(this).removeClass("is-invalid");
    $(".invalid-feedback").text("");
});

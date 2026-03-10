$(function () {

    $("#taRecoveryTypeTable").DataTable({
        ordering: false,
        paging: true,
        info: true,
        searching: true,
        responsive: true,
        autoWidth: false,
        columnDefs: [{ width: "90px", targets: 0 }],
        createdRow: function (row,data,index) {
            if(index % 2 == 0)
                $(row).addClass("bg-table-row-0");
            else
                $(row).addClass("bg-table-row-1");
        },
        buttons: ["csv","excel","pdf","print","colvis"]
    }).buttons().container()
      .appendTo('#taRecoveryTypeTable_wrapper .col-md-6:eq(0)');
});

function editRecoveryType(id) {
    $.ajax({
        url: 'getRecoveryTypeDetails',
        type: 'GET',
        data: { taRecoveryTypeId: id },
        dataType: 'json',
        success: function (result) {
            $("#taRecoveryTypeId").val(id);
            $("#taRecoveryTypeNameEdit").val(result.taRecoveryTypeName);
            $("#taRecoveryTypeDescriptionEdit").val(result.taRecoveryTypeDescription);

            if (result.taRecoveryTypeActive == "1")
                $("#taRecoveryTypeActiveEdit1").prop("checked", true);
            else
                $("#taRecoveryTypeActiveEdit2").prop("checked", true);

            $("#editTaRecoveryTypeModal").modal({ backdrop:'static', keyboard:false });
        }
    });
}

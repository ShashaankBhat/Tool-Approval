$(function () {

    $("#taRecoveryTypeHistoryTable").DataTable({
        ordering: false,
        paging: true,
        info: true,
        searching: true,
        responsive: true,
        autoWidth: false,
        createdRow: function (row,data,index) {
            if(index % 2 == 0)
                $(row).addClass("bg-table-row-0");
            else
                $(row).addClass("bg-table-row-1");
        },
        buttons: ["csv","excel","pdf","print","colvis"]
    }).buttons().container()
      .appendTo('#taRecoveryTypeHistoryTable_wrapper .col-md-6:eq(0)');

});
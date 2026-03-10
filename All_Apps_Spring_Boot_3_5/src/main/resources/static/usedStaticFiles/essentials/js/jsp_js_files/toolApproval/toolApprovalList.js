$(function () {

    var table = $("#toolApprovalTable").DataTable({
        "ordering": true,
        "paging": true,
        "info": true,
        "lengthChange": true,
        "searching": true,
        "autoWidth": false,
        "responsive": true,
        "pageLength": 10,
        "lengthMenu": [[10, 25, 50, 100], [10, 25, 50, 100]],
        "createdRow": function (row, data, index) {
            if (index % 2 === 0) {
                $(row).addClass("bg-table-row-0");
            } else {
                $(row).addClass("bg-table-row-1");
            }
        }
    });

    /* ================= STATUS FILTER ================= */

    var statusFilter = `
        <select id="statusFilter" class="form-control form-control-sm ml-2" style="width:auto; display:inline-block;">
            <option value="">All Status</option>
            <option value="Draft">Draft</option>
            <option value="Tool Details Entered">Tool Details Entered</option>
            <option value="Cost Entered">Cost Entered</option>
            <option value="Pending Approval">Pending Approval</option>
            <option value="Approved">Approved</option>
            <option value="Rejected">Rejected</option>
        </select>
    `;

    /* ================= SORT FILTER ================= */

    var sortFilter = `
        <select id="sortFilter" class="form-control form-control-sm ml-2" style="width:auto; display:inline-block;">
            <option value="">Sort By</option>
            <option value="latest">Latest First</option>
            <option value="oldest">Oldest First</option>
            <option value="status">Status</option>
        </select>
    `;


    $("#toolApprovalTable_length").append(statusFilter);
    $("#toolApprovalTable_length").append(sortFilter);

    /* ================= STATUS FILTER LOGIC ================= */

    $("#statusFilter").on("change", function () {
        var selected = $(this).val();

        if (selected === "") {
            table.column(4).search("").draw();   // Status column index
        } else {
            table.column(4).search(selected).draw();
        }
    });

    /* ================= SORT LOGIC ================= */

    $("#sortFilter").on("change", function () {

        var value = $(this).val();

        if (value === "latest") {
            table.order([8, 'desc']).draw();   // Created On column index
        }
        else if (value === "oldest") {
            table.order([8, 'asc']).draw();
        }
        else if (value === "status") {
            table.order([4, 'asc']).draw();
        }
        else {
            table.order([]).draw();
        }
    });

});

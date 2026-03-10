
$(window).on('load', function () {
    console.log("✅ Page fully loaded. Initializing DataTable...");

    // 🧩 FIX: Always hide loader at page load
    $(".package-loader").hide();
    $('body').removeClass('disableClickBody');




    let pagination = true;
    let isInitialDraw = true;

    // Destroy existing DataTable instance if already initialized
    if ($.fn.DataTable.isDataTable("#misReportTable")) {
        $("#misReportTable").DataTable().clear().destroy();
    }

    // Initialize DataTable
    const misTable = $("#misReportTable").DataTable({
        ordering: false,
    paging: true,
    info: true,
    lengthChange: true,
    searching: true,
    autoWidth: false,
    responsive: false, // ❌ disable 'responsive' when using fixed columns
    scrollX: true,
    scrollCollapse: true,
    pageLength: 20,
    fixedColumns: {
        left: 3,  // Fix first 3 columns (Program, Employee Name, Company)
        right: 2  // Fix last 2 columns (YTM, % Completion)
    },

        buttons: [
            "csv",
            "excel",
            {
                
               
                title: "EMC Coaching MIS Report",
                orientation: 'landscape',
                pageSize: 'LEGAL',
                customize: function (doc) {
                    const now = new Date();
                    const jsDate = now.getDate() + '-' + (now.getMonth() + 1) + '-' + now.getFullYear();
                    doc['footer'] = function (page, pages) {
                        return {
                            columns: [
                                { alignment: 'left', text: ['Created on: ', { text: jsDate }] },
                                { alignment: 'right', text: ['Page ', { text: page.toString() }, ' of ', { text: pages.toString() }] }
                            ],
                            margin: 20
                        };
                    };
                },
                exportOptions: { columns: ':visible thead th:not(.noExport)' }
            },
            // "print",
            "colvis"
        ],

        createdRow: function (row, data, index) {
            $(row).addClass(index % 2 === 0 ? "bg-light" : "bg-white");
        },

        drawCallback: function () {
            // Skip first draw (prevents spinner/overlay issue)
            if (isInitialDraw) {
                isInitialDraw = false;
                return;
            }

            if (pagination) {
                // Prevent duplicate buttons
                if (!$('#loadMore_misReportTable').length) {
                    $('#misReportTable_paginate').find(".pagination").append(
                        '<li class="paginate_button page-item">' +
                        '<a onclick="loadNextSetValues()" id="loadMore_misReportTable" class="fa fa-arrow-right page-link" href="#" title="Load More"></a></li>'
                    );
                }
            }
        }
    });

    // Attach DataTable buttons
    misTable.buttons().container().appendTo('#misReportTable_wrapper .col-md-6:eq(0)');

    // Disable pagination button if not needed
    if (misTable.rows().count() < 20) {
        pagination = false;
    }

    console.log("✅ DataTable init completed.");
});

// ✅ Load More handler
function loadNextSetValues() {
    const misTable = $("#misReportTable").DataTable();
    const offsetValue = misTable.rows().count();

    console.log("Loading more MIS data starting from offset:", offsetValue);

    $('body').addClass('disableClickBody');
    $(".package-loader").show();

    $.ajax({
        url: 'loadMoreMISData',
        type: 'GET',
        data: { offsetValue: offsetValue },
        dataType: 'json'
    })
    .done(function (result) {
        console.log("✅ AJAX result:", result);

        if (result && result.length > 0) {
            for (let i = 0; i < result.length; i++) {
                misTable.row.add([
                    result[i]["program"],
                    result[i]["employeeName"],
                    result[i]["companyName"],
                    result[i]["sessionDates"],
                    result[i]["ytm"],
                    result[i]["completionPercent"]
                ]);
            }
            misTable.draw(false);

            if (result.length < 20) {
                pagination = false;
                $('#loadMore_misReportTable').hide();
            }
        } else {
            pagination = false;
            $('#loadMore_misReportTable').hide();
        }
    })
    .fail(function (xhr, status, error) {
        console.error("❌ LoadMore AJAX failed:", error);
        alert("Error loading additional data. Please try again later.");
    })
    .always(function () {
        $('body').removeClass('disableClickBody');
        $(".package-loader").hide();
    });
}




$(document).ready(function () {
    if ($.fn.select2) {
        $('.select2').select2();
    }

    $('#batchSelect').change(function () {
        var batchId = $(this).val();

        if (batchId && batchId !== "-1") {
            $('#coachSelect').prop('disabled', true).html('<option>Loading coaches...</option>');
            
            $.get(contextPath + '/get-coaches-by-batch', { batchId: batchId })
                .done(function (data) {
                    var coachSelect = $('#coachSelect');
                    coachSelect.empty().append('<option value="-1">All Coaches</option>');

                    if (Array.isArray(data)) {
                        data.forEach(function (coach) {
                            coachSelect.append($('<option>', {
                                value: coach.id,
                                text: coach.name
                            }));
                        });
                    }

                    // Reset coachee
                    $('#coacheeSelect').empty().append('<option value="-1">All Coachees</option>');
                    coachSelect.prop('disabled', false);
                    coachSelect.trigger('change.select2');
                })
                .fail(function () {
                    $('#coachSelect').empty().append('<option>Error loading coaches</option>');
                    $('#coachSelect').prop('disabled', false);
                });
        } else {
            $('#coachSelect').empty().append('<option value="-1">All Coaches</option>');
            $('#coacheeSelect').empty().append('<option value="-1">All Coachees</option>');
        }
    });

    $('#coachSelect').change(function () {
        var coachId = $(this).val();
        var batchId = $('#batchSelect').val();

        if (coachId && coachId !== "-1" && batchId && batchId !== "-1") {
            $('#coacheeSelect').prop('disabled', true).html('<option>Loading coachees...</option>');

            $.get(contextPath + '/get-coachees-by-coach', { coachId: coachId, batchId: batchId })
                .done(function (data) {
                    var coacheeSelect = $('#coacheeSelect');
                    coacheeSelect.empty().append('<option value="-1">All Coachees</option>');

                    if (Array.isArray(data)) {
                        data.forEach(function (coachee) {
                            coacheeSelect.append($('<option>', {
                                value: coachee.id,
                                text: coachee.name
                            }));
                        });
                    }

                    coacheeSelect.prop('disabled', false);
                    coacheeSelect.trigger('change.select2');
                })
                .fail(function () {
                    $('#coacheeSelect').empty().append('<option>Error loading coachees</option>');
                    $('#coacheeSelect').prop('disabled', false);
                });
        } else {
            $('#coacheeSelect').empty().append('<option value="-1">All Coachees</option>');
        }
    });
});

  document.addEventListener('DOMContentLoaded', function () {
    const options = document.querySelectorAll('#percentageDropdown option');
    options.forEach(option => {
      const val = parseInt(option.value);
      if (val <= 50 && val >= 0) {
      } else if (val > 50 && val <= 75) {
      } else if (val > 75) {
      }
    });
  });

 
   window.resetFilters = function() {
      $('#dashboard_v2')[0].reset();
      $('.select2').val('-1').trigger('change');
      $('#coachSelect').empty().append('<option value="-1">All Coaches</option>');
      $('#coacheeSelect').empty().append('<option value="-1">All Coachees</option>');
      $('#dashboard_v2').submit();
    };


    
//   $(document).ready(function() {
//     const $filterBody = $("#filterCardBody");
//     const $toggleBtn = $("#toggleFiltersBtn");
//     const $icon = $toggleBtn.find("i");

//     // Closed by default
//     $filterBody.hide();

//     // Toggle on click
//     $toggleBtn.on("click", function() {
//       $filterBody.slideToggle(250); // smooth expand/collapse
//       $icon.toggleClass("fa-plus fa-minus"); // toggle icon
//     });
//   });

$(document).ready(function () {
  const $filterBody = $("#filterCardBody");
  const $toggleBtn = $("#toggleFiltersBtn");
  const $icon = $toggleBtn.find("i");
  const $cardHeader = $(".card-header"); // ✅ The entire header

  // ✅ Apply positioning dynamically via jQuery
  $toggleBtn.css({
    position: "absolute",
    top: "8px",
    right: "12px",
    "z-index": 10
  });

  // Hide filters by default
  $filterBody.hide();

  // ✅ Make entire card-header clickable (not just + button)
  $cardHeader.css("cursor", "pointer");

  // ✅ Handle click anywhere in header
  $cardHeader.on("click", function (e) {
    // Prevent double-trigger if clicking the button icon
    if (!$(e.target).is("#toggleFiltersBtn, #toggleFiltersBtn i")) {
      $toggleBtn.trigger("click");
    }
  });

  // ✅ Toggle expand/collapse with icon change
  $toggleBtn.on("click", function () {
    $filterBody.slideToggle(250);
    $icon.toggleClass("fa-plus fa-minus");
  });
});


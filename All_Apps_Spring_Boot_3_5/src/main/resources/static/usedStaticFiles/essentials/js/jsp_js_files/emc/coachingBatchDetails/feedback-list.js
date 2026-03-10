var pagination = true;
var jsBatchName = "";
$(function() {
	jsBatchName = $("#jsBatchName").val();
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
			title:"Coachee List - Batch: "+jsBatchName,
			orientation: 'portrait',
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
			alert("Something went wrong, kindly try again after sometime.");
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
				var programType = "programTypeName"+i;
				var supervisor = "supervisorName"+i;
				var newCoachCoacheeMapping = "<tr>"+
					"<td>"+
						""+result[coach]+
					"</td>"+
					"<td>"+
						""+result[coachee]+
					"</td>"+
					"<td>"+
						""+result[programType]+
					"</td>"+
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
			
			$("#batchInfoModal").modal({
			    backdrop: 'static',
			    keyboard: false
			});
			$('body').removeClass('disableClickBody');
			$(".anand-loader").hide();
		},
		error: function() {
			alert("Something went wrong, try again later");
		}
	});
}


$(document).ready(function () {

    var token = $('meta[name="_csrf"]').attr('content');
    var header = $('meta[name="_csrf_header"]').attr('content');

    console.log("CSRF:", header, token);

    $(document).ajaxSend(function (e, xhr, options) {
        xhr.setRequestHeader(header, token);
    });

});




$(document).ready(function () {

     var token = $('meta[name="_csrf"]').attr('content');
    var header = $('meta[name="_csrf_header"]').attr('content');

     $(document).ajaxSend(function (e, xhr, options) {
        xhr.setRequestHeader(header, token);
    });
   

    $(document).on('click', '.open-feedbackQuestionList-btn', function (e) {
        e.preventDefault();
        const mappingId = $(this).data('mapping-id');
        loadFeedbackQuestionListForm(mappingId);
    });

    $('#feedbackQuestionListModal').on('hidden.bs.modal', function () {
        $('#feedbackQuestionListModalBody').html('');
    });


    $(document).on('submit', '#feedbackForm', function (e) {
        e.preventDefault();
        const formData = $(this).serialize();
        $.ajax({
            url: 'submitFeedback',
            type: 'POST',
            data: formData,
            success: function (response) {
                alert('Feedback submitted successfully!');
                $('#feedbackQuestionListModal').modal('hide');
            },
            error: function (xhr) {
                alert('Submission failed!');
            }
        });
    });

    function loadFeedbackQuestionListForm(mappingId) {
        console.log("Mapping ID: ", mappingId);
        $.ajax({
            url: 'loadFeedbackForm',
            type: 'GET',
            data: { mappingId: mappingId },
            success: function (data) {
                if (data.status === 'success') {
                    const html = buildFeedbackFormHTML(data);
                    $('#feedbackQuestionListModalBody').html(html);
                    $('#feedbackQuestionListModal').modal('show');
                } else {
                    alert(data.message || 'Failed to load feedback form.');
                }
            },
            error: function (xhr) {
                alert('Error loading feedback form.');
            }
        });
    }

    function buildFeedbackFormHTML(data) {
        console.log("jjj",data);
        const {
            mappingId,
            programCategory,
            questions,
            coacheeQuestions,
            mentorQuestions,
            menteeQuestions,
            emcMentor = 0,
            emcMentee = 0,
            emcAdmin = 0
        } = data;

        let html = `
            <div class="card border-0 shadow-lg rounded-4 mt-5 mb-4 position-relative">
                <div class="card-body px-5 py-4">
                    <form id="feedbackForm" method="post">
                        <input type="hidden" name="mappingId" value="${mappingId}" />`;

        if (programCategory == 1) {
            console.log(programCategory);
            console.log("jjj",data);
       

if ((emcMentor == 1) && questions?.length > 0) {
    console.log("🧩 emcMentor Questions:", questions);
    html += `<h5 class="mb-4 text-primary"><i class="bi bi-person-workspace me-2"></i>Coach Questions</h5>`;
    questions.forEach((q, index) => {
        html += generateQuestionHTML(q, index);
    });
}

if (emcMentee == 1 && coacheeQuestions?.length > 0) {
    console.log("🧩 emcMentee Questions:", coacheeQuestions);
    html += `<h5 class="mb-4 text-success"><i class="bi bi-person-badge me-2"></i>Coachee Questions</h5>`;
    coacheeQuestions.forEach((q, index) => {
        html += generateQuestionHTML(q, index);
    });
}

        }

       
        if (programCategory == 2) {
            // Mentor questions
            if (emcMentor == 1 && mentorQuestions?.length > 0) {
                html += `<h5 class="mb-4 text-primary"><i class="bi bi-person-video2 me-2"></i>Mentor Questions</h5>`;
                mentorQuestions.forEach((q, index) => {
                    html += generateQuestionHTML(q, index);
                });
            }
            
            if (emcMentee == 1 && menteeQuestions?.length > 0) {
                html += `<h5 class="mb-4 text-success"><i class="bi bi-person-circle me-2"></i>Mentee Questions</h5>`;
                menteeQuestions.forEach((q, index) => {
                    html += generateQuestionHTML(q, index);
                });
            }
        }

        html += `
                        <div class="d-flex justify-content-end mt-5 gap-3">
                            <button type="submit" class="btn bg-1 ">
                                <i class="bi bi-send-fill me-1"></i> Submit Feedback
                            </button>
                        </div>
                    </form>
                </div>
            </div>`;

        return html;
    }

   
    function generateQuestionHTML(question, index) {
        return `
            <div class="mb-4">
                <label class="form-label fw-semibold">${index + 1}. ${question.question}</label>
                <textarea class="form-control shadow-sm rounded-3 feedback-textarea"
                          name="question_${question.questionId}" rows="3"
                          placeholder="Type your response here..." required></textarea>
            </div>`;
    }
});




$(document).ready(function () {
   
    $('#viewFeedbackModal').modal({
        show: false,
        backdrop: 'static'
    });

   
    $(document).on('click', '.view-feedback-btn', function (e) {
        e.preventDefault();
        const mappingId = $(this).data('mapping-id');
        loadViewFeedbackForm(mappingId);
    });

    
    $('#viewFeedbackModal').on('hidden.bs.modal', function () {
        $('#viewFeedbackModalBody').html('');
    });
});

function loadViewFeedbackForm(mappingId) {
    const modalBody = $('#viewFeedbackModalBody');
    modalBody.html(`
        <div class="text-center py-4">
            <div class="spinner-border text-primary" role="status">
                <span class="sr-only">Loading...</span>
            </div>
            <p class="mt-2">Loading feedback...</p>
        </div>
    `);
    
    $('#viewFeedbackModal').modal('show');

    $.ajax({
        url: 'emc-feedback-response',
        type: 'GET',
        data: { mappingId: mappingId },
        dataType: 'json',
        success: function(response) {
            if(response.status === 'success') {
                console.log("------------->"+response);
                renderViewFeedbackForm(response);
            } else {
                showViewFeedbackError(response.message || 'Failed to load feedback');
            }
        },
        error: function(xhr) {
            showViewFeedbackError(xhr.responseJSON?.message || xhr.statusText || 'Error loading feedback');
        }
    });
}




function showViewFeedbackError(message) {
    $('#viewFeedbackModalBody').html(`
        <div class="alert alert-danger">
            ${message}
        </div>
        <div class="text-center mt-3">
            <button class="btn btn-primary" onclick="$('#viewFeedbackModal').modal('hide')">Close</button>
        </div>
    `);
}


function renderFeedbackResponseItem(response, index) {
    return `
        <div class="mb-3 p-3 border rounded">
            <p><strong>Question${index + 1}:</strong> ${response.question}</p>
            <p><strong>Answer:</strong> ${response.answer}</p>
        </div>
    `;
}




// function renderViewFeedbackForm(data) {
//     console.log("🟢 FULL DATA RECEIVED -->", JSON.stringify(data, null, 2));

//     let html = `
//         <div class="card shadow border-0 rounded-4 mt-5">
//             <div class="card-body px-4 py-3">
//     `;

//     if (!data) {
//         $('#viewFeedbackModalBody').html(`<div class="alert alert-danger">No data found.</div>`);
//         return;
//     }

//   const programCategory = Number(data.programCategory);
// const emcMentor = Number(data.emcMentor);
// const emcMentee = Number(data.emcMentee);
// const emcAdmin = Number(data.emcAdmin);
// const responses = data.responses || [];   


//     console.log("🔍 Roles parsed:", { programCategory, emcMentor, emcMentee, emcAdmin });
//     console.log("📋 Responses count:", responses.length);

//     if (emcAdmin === 1) {
//         if (responses.length > 0) {
//             html += `
//                 <h5 class="mb-4 text-primary">
//                     <i class="bi bi-person-lines-fill me-2"></i>Admin View
//                 </h5>
//             `;
//             responses.forEach((response, index) => {
//                 html += renderFeedbackResponseItem(response, index);
//             });
//         } else {
//             html += `
//                 <div class="alert alert-warning">
//                     <i class="bi bi-info-circle me-2"></i>
//                     No feedback responses have been submitted yet.
//                 </div>
//             `;
//         }
//     }

   
//     else if (responses.length > 0) {
//         if (programCategory === 1) {
       
//             if (emcMentor === 1) {
//     console.log("emcMentor", emcMentor);

//     const coachResponses = responses.filter(r => 
//         r.mentorMenteeFlag == 1
//     );

//     console.log("Filtered coachResponses:", coachResponses);

//     if (coachResponses.length > 0) {
//         html += `
//             <h5 class="mb-4 text-primary">
//                 <i class="bi bi-person-workspace me-2"></i>Coach Responses
//             </h5>
//         `;
//         coachResponses.forEach((response, index) => {
//             html += renderFeedbackResponseItem(response, index);
//         });
//     }
// }


//             if (emcMentee === 1) {
        
//                const coacheeResponses = data.responses.filter(r => {
//     const q = (r.question || "").toLowerCase();
//     return r.mentorMenteeFlag == 2 || 
//           (r.mentorMenteeFlag != 1 && (q.includes("coachee") || q.includes("mentee")));
// });


//                 if (coacheeResponses.length > 0) {
//                     html += `
//                         <h5 class="mb-4 text-success">
//                             <i class="bi bi-person-badge me-2"></i>Coachee Responses
//                         </h5>
//                     `;
//                     coacheeResponses.forEach((response, index) => {
//                         html += renderFeedbackResponseItem(response, index);
//                     });
//                 }
//             }
//         }

//         if (programCategory === 2) {
//             // 🧩 Mentoring
//             if (emcMentor === 1) {
//                 const mentorResponses = responses.filter(r =>
//                     r.mentorMenteeFlag == 3 &&
//                     (r.question || "").toLowerCase().includes("coach") ||
//     (r.question || "").toLowerCase().includes("mentor")
                
//                 );
//                 if (mentorResponses.length > 0) {
//                     html += `
//                         <h5 class="mb-4 text-primary">
//                             <i class="bi bi-person-video2 me-2"></i>Mentor Responses
//                         </h5>
//                     `;
//                     mentorResponses.forEach((response, index) => {
//                         html += renderFeedbackResponseItem(response, index);
//                     });
//                 }
//             }

//             if (emcMentee === 1) {
              
//  const menteeResponses = data.responses.filter(r => 
//     r.mentorMenteeFlag == 4 ||
//     (r.question || "").toLowerCase().includes("coachee") ||
//     (r.question || "").toLowerCase().includes("mentee")
// );
//  console.log("menteeResponses"+menteeResponses);

//                 if (menteeResponses.length > 0) {
//                     html += `
//                         <h5 class="mb-4 text-success">
//                             <i class="bi bi-person-badge me-2"></i>Mentee Responses
//                         </h5>
//                     `;
//                     menteeResponses.forEach((response, index) => {
//                         html += renderFeedbackResponseItem(response, index);
//                     });
//                 }
//             }
//         }
//     }

//     // ✅ If no responses at all (non-admin)
//     else if (responses.length === 0 && emcAdmin !== 1) {
//         html += `
//             <div class="alert alert-info">
//                 <i class="bi bi-info-circle me-2"></i>No feedback responses found.
//             </div>
//         `;
//     }

//     html += `
//             </div>
//         </div>
//     `;

//     $('#viewFeedbackModalBody').html(html);
// }





function renderViewFeedbackForm(data) {
    console.log("🟢 FULL DATA RECEIVED -->", JSON.stringify(data, null, 2));

    let html = `
        <div class="card shadow border-0 rounded-4 mt-5">
            <div class="card-body px-4 py-3">
    `;

    if (!data) {
        $('#viewFeedbackModalBody').html(`<div class="alert alert-danger">No data found.</div>`);
        return;
    }

  const programCategory = Number(data.programCategory);
const emcMentor = Number(data.emcMentor);
const emcMentee = Number(data.emcMentee);
const emcAdmin = Number(data.emcAdmin);


let responses = data.responses || [];

// 🔥 Remove duplicates only for non-admin
if (Number(data.emcAdmin) !== 1) {
    responses = responses.filter(
        (item, index, self) =>
            index === self.findIndex(
                (t) =>
                    t.mentorMenteeFlag === item.mentorMenteeFlag &&
                    (t.question || "").trim().toLowerCase() === (item.question || "").trim().toLowerCase() &&
                    (t.answer || "").trim().toLowerCase() === (item.answer || "").trim().toLowerCase()
            )
    );
}

console.log("🧹 Unique responses count:", responses.length);
console.log("🧹 Unique responses:", responses);



    console.log("🔍 Roles parsed:", { programCategory, emcMentor, emcMentee, emcAdmin });
    console.log("📋 Responses count:", responses.length);

    if (emcAdmin === 1) {
        if (responses.length > 0) {
            html += `
                <h5 class="mb-4 text-primary">
                    <i class="bi bi-person-lines-fill me-2"></i>Admin View
                </h5>
            `;
            responses.forEach((response, index) => {
                html += renderFeedbackResponseItem(response, index);
            });
        } else {
            html += `
                <div class="alert alert-warning">
                    <i class="bi bi-info-circle me-2"></i>
                    No feedback responses have been submitted yet.
                </div>
            `;
        }
    }

   
    else if (responses.length > 0) {
        if (programCategory === 1) {
       
            if (emcMentor === 1) {
    console.log("emcMentor", emcMentor);

    const coachResponses = responses.filter(r => 
        r.mentorMenteeFlag == 1
    );

    console.log("Filtered coachResponses:", coachResponses);

    if (coachResponses.length > 0) {
        html += `
            <h5 class="mb-4 text-primary">
                <i class="bi bi-person-workspace me-2"></i>Coach Responses
            </h5>
        `;
        coachResponses.forEach((response, index) => {
            html += renderFeedbackResponseItem(response, index);
        });
    }
}


            if (emcMentee === 1) {
        
               const coacheeResponses = responses.filter(r => {
    const q = (r.question || "").toLowerCase();
    return r.mentorMenteeFlag == 2 || 
          (r.mentorMenteeFlag != 1 && (q.includes("coachee") || q.includes("mentee")));
});


                if (coacheeResponses.length > 0) {
                    html += `
                        <h5 class="mb-4 text-success">
                            <i class="bi bi-person-badge me-2"></i>Coachee Responses
                        </h5>
                    `;
                    coacheeResponses.forEach((response, index) => {
                        html += renderFeedbackResponseItem(response, index);
                    });
                }
            }
        }

        if (programCategory === 2) {
            // 🧩 Mentoring
            if (emcMentor === 1) {
                const mentorResponses = responses.filter(r =>
                    r.mentorMenteeFlag == 3 &&
                    (r.question || "").toLowerCase().includes("coach") ||
    (r.question || "").toLowerCase().includes("mentor")
                
                );
                if (mentorResponses.length > 0) {
                    html += `
                        <h5 class="mb-4 text-primary">
                            <i class="bi bi-person-video2 me-2"></i>Mentor Responses
                        </h5>
                    `;
                    mentorResponses.forEach((response, index) => {
                        html += renderFeedbackResponseItem(response, index);
                    });
                }
            }

            if (emcMentee === 1) {
              
 const menteeResponses = responses.filter(r => 
    r.mentorMenteeFlag == 4 ||
    (r.question || "").toLowerCase().includes("coachee") ||
    (r.question || "").toLowerCase().includes("mentee")
);
 console.log("menteeResponses"+menteeResponses);

                if (menteeResponses.length > 0) {
                    html += `
                        <h5 class="mb-4 text-success">
                            <i class="bi bi-person-badge me-2"></i>Mentee Responses
                        </h5>
                    `;
                    menteeResponses.forEach((response, index) => {
                        html += renderFeedbackResponseItem(response, index);
                    });
                }
            }
        }
    }

    // ✅ If no responses at all (non-admin)
    else if (responses.length === 0 && emcAdmin !== 1) {
        html += `
            <div class="alert alert-info">
                <i class="bi bi-info-circle me-2"></i>No feedback responses found.
            </div>
        `;
    }

    html += `
            </div>
        </div>
    `;

    $('#viewFeedbackModalBody').html(html);
}

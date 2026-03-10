$(document).ready(function () {
    // Handle click on feedback button
    $(document).on('click', '.open-feedback-btn', function () {
        const mappingId = $(this).data('mapping-id');
        const $modal = $('#feedbackModal');

        $modal.modal({ backdrop: 'static', keyboard: false });

        $modal.find('.modal-title').html('Provide Feedback');
        $modal.find('#feedbackModalBody').html(`
            <div class="d-flex justify-content-center align-items-center py-5">
                <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>
        `);

        // Load feedback form via AJAX
        $.ajax({
            url: 'loadFeedbackForm',
            type: 'GET',
            data: { mappingId: mappingId },
            success: function (response) {
                $modal.find('#feedbackModalBody').html(response);
                initFormValidation(); // bind events after form is loaded
            },
            error: function (xhr) {
                $modal.find('#feedbackModalBody').html(`
                    <div class="alert alert-danger alert-dismissible fade show m-3">
                        <h5 class="alert-heading">Error Loading Form</h5>
                        <p>Unable to load feedback questions. Please try again.</p>
                        <hr>
                        <button class="btn btn-outline-danger open-feedback-btn" data-mapping-id="${mappingId}">
                            <i class="fas fa-redo mr-2"></i> Try Again
                        </button>
                    </div>
                `);
            }
        });
    });

    // Bind validation and submit
    function initFormValidation() {
        const $form = $('#feedbackForm');

        if ($form.length === 0) return;

        $form.on('submit', function (e) {
            e.preventDefault();

            if (!this.checkValidity()) {
                e.stopPropagation();
                $(this).addClass('was-validated');

                // Scroll to first invalid field
                const $invalidField = $(this).find(':invalid').first();
                if ($invalidField.length) {
                    $('html, body').animate({
                        scrollTop: $invalidField.offset().top - 100
                    }, 500);
                }

                return;
            }

            window.submitFeedback($form);
        });
    }

    var token = $('meta[name="_csrf"]').attr('content');
var header = $('meta[name="_csrf_header"]').attr('content');

    // Global AJAX feedback submission function
    window.submitFeedback = function ($form) {
        const $modal = $('#feedbackModal');
        const $submitBtn = $form.find('[type="submit"]');
        const originalBtnText = $submitBtn.html();

        $submitBtn.prop('disabled', true).html(`
            <span class="spinner-border spinner-border-sm mr-2" role="status" aria-hidden="true"></span> Submitting...
        `);

        $.ajax({
            url: 'submitFeedback',
            type: 'POST',
            beforeSend: function(xhr) {
        xhr.setRequestHeader(header, token);
    },
            data: $form.serialize(),
            success: function () {
                $modal.find('#feedbackModalBody').html(`
                    <div class="text-center p-5">
                        <div class="mb-4">
                            <i class="fas fa-check-circle text-success" style="font-size: 5rem;"></i>
                        </div>
                        <h3 class="text-success mb-3">Thank You!</h3>
                        <p class="lead">Your feedback has been submitted successfully.</p>
                        <button class="btn btn-outline-secondary mt-3" data-dismiss="modal">Close</button>
                    </div>
                `);
            },
            error: function (xhr) {
                $submitBtn.prop('disabled', false).html(originalBtnText);

                let errorMsg = "An error occurred while submitting. Please try again.";
                if (xhr.responseJSON && xhr.responseJSON.message) {
                    errorMsg = xhr.responseJSON.message;
                }

                $('body').append(`
                    <div class="toast bg-danger text-white" style="position: fixed; top: 20px; right: 20px; z-index: 1100;" role="alert" aria-live="assertive" aria-atomic="true" data-delay="5000">
                        <div class="toast-header bg-danger text-white">
                            <strong class="mr-auto">Submission Error</strong>
                            <button type="button" class="ml-2 mb-1 close text-white" data-dismiss="toast" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="toast-body">
                            ${errorMsg}
                        </div>
                    </div>
                `);

                $('.toast').toast('show');
            }
        });
    };
});

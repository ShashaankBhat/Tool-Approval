<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../includeJSP/cssFiles.jsp" %>
		<%@include file="../../includeJSP/datePickerCss.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Upload Documents</title>
    <!-- ✅ Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .upload-box {
            max-width: 700px;
            margin: auto;
            margin-top: 40px;
        }
        .upload-box h2 {
            text-align: center;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>

<div class="container upload-box shadow p-4 rounded border border-secondary bg-light">
    <h2>Upload Documents</h2>

    <!-- Upload Form -->
   <form id="uploadForm" method="post" enctype="multipart/form-data" action="upload">
    <!-- Hidden fields -->
    <input type="hidden" name="batchId" value="${batchId}" />
    <input type="hidden" name="coacheeId" value="${coacheeId}" />
    
    <!-- Remark -->
    <div class="mb-3">
        <label for="remark" class="form-label fw-bold">Remark</label>
        <textarea id="remark" name="remark" class="form-control" rows="3" required></textarea>
    </div>

    <!-- File Inputs -->
    <div class="mb-3">
        <label class="form-label fw-bold">Select Files (Max 5MB each)</label>
        <div id="fileInputs">
            <input type="file" name="files" class="form-control mb-2" accept=".pdf,.doc,.docx,.png,.jpg" required />
        </div>
        <button type="button" class="btn btn-outline-primary btn-sm" onclick="addMoreFiles()">+ Upload More Document</button>
    </div>

    <!-- Submit -->
    <div class="text-end mt-3">
        <button id="submit-btn" class="btn btn-success" type="submit">Upload</button>
    </div>
</form>

</div>

<!-- ✅ JS Section -->
<script>
    function addMoreFiles() {
        let wrapper = document.getElementById("fileInputs");

        const fileInput = document.createElement("input");
        fileInput.type = "file";
        fileInput.name = "files";
        fileInput.accept = ".pdf,.doc,.docx,.png,.jpg";
        fileInput.className = "form-control mb-2";

        wrapper.appendChild(fileInput);
    }

    // File size validation (<= 5MB)
    document.getElementById('uploadForm').onsubmit = function (e) {
        const files = document.querySelectorAll('input[type="file"]');
        for (let fileInput of files) {
            if (fileInput.files.length > 0 && fileInput.files[0].size > 5 * 1024 * 1024) {
                alert('Each file must be less than 5MB.');
                e.preventDefault();
                return false;
            }
        }
    };
</script>

<!-- ✅ Bootstrap Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<%@include file="../includeJSP/footer.jsp" %>
						</div>
						<%@include file="../../includeJSP/jsFiles.jsp" %>
							<%@include file="../../includeJSP/dataTablesImport.jsp" %>
								<%@include file="../../includeJSP/datePickerJs.jsp" %>
</body>
</html>

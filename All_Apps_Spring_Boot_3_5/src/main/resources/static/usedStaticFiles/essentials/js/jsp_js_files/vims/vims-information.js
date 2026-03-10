var visitorInfoCount = $("#visitorInfoCount").val();
if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
	var video = $("#webcamVideoVisitor")[0];
	navigator.mediaDevices.getUserMedia({ video : true }).then(function(stream) {
		video.srcObject = stream
	}).catch(function(err) {
		console.error("Error accessing webcam: ", err);
		alert("Could not access the webcam. Please check permissions.");
	});
} else {
	alert("getUserMedia not supported in this browser.");
}
for(var i=0; i< visitorInfoCount; i++){
	var stream;
	const fps = 0;
	var video = $("#webcamVideoVisitor")[0];
	if (video.captureStream) {
		stream = video.captureStream(fps);
	} else if (video.mozCaptureStream) {
		stream = video.mozCaptureStream(fps);
	} else {
		console.error('Stream capture is not supported');
		stream = null;
	}
	$("#webcamVideoVisitor"+i)[0].srcObject = stream;
	$("#webcamVideoVisitor"+i)[0].play().catch(error => {
		console.error("Playback failed:", error);
	});
}
function runVideo(){
	var stream;
	const fps = 0;
	var video = $("#webcamVideoVisitor")[0];
	if (video.captureStream) {
		stream = video.captureStream(fps);
	} else if (video.mozCaptureStream) {
		stream = video.mozCaptureStream(fps);
	} else {
		console.error('Stream capture is not supported');
		stream = null;
	}
	$("#webcamVideoVisitor"+i)[0].srcObject = stream;
	$("#webcamVideoVisitor"+i)[0].play().catch(error => {
		console.error("Playback failed:", error);
	});
}
function getImage(index) {
	var video = $("#webcamVideoVisitor"+index)[0];
	var canvas = $("#photoCanvasVisitor"+index)[0];
	var context = canvas.getContext('2d');
	context.drawImage(video, 0, 0, canvas.width, canvas.height);
	canvas.style.display = 'block';// show captured photo
	// Optional: get image data URL (base64)
	const imageDataUrl = canvas.toDataURL('image/png');
	$('#img'+index).attr('src', imageDataUrl);
	$("#visitorImageText"+index).val(imageDataUrl);
	console.log("Captured image data URL:", imageDataUrl);
}
var option = "";
for(var i = 0; i< $("#govtIndex").val(); i++) {
	option += "<option value='"+$("#govtId"+i).val()+"'>"+$("#govtIdName"+i).val()+"</option>"
}
console.log(option);
function addMoreVisitor() {
	var index = $("#visitorInfoCount").val();
	console.log(option);
	var appendBody = "<div class='card visitorInfo"+index+"'>"+
		"<div class='card-header bg-1'>"+
          "<h5 class='card-title font-weight-bold'>Visitor Information "+parseInt(parseInt(index) + 1)+"</h5>"+
          "<input type='hidden' name='visitorInformationList["+index+"].visitorInformationId' id='visitorInformationId"+index+"' />"+
          "<input type='hidden' name='visitorInformationList["+index+"].visitorActive' id='visitorActive"+index+"' value='1'/>"+
          "<input type='hidden' name='visitorInformationList["+index+"].parentVisitorId' id='parentVisitorId"+index+"' value='"+$("#visitorId").val()+"' />"+
          "<div class='card-tools'>"+
		    "<button type='button' class='btn btn-tool' onclick='removeUser("+index+")'>"+
		      "<i class='fas fa-user-slash text-white font-weight-bold'></i>"+
		    "</button>"+
		  "</div>"+
          
        "</div>"+
        "<div class='card-body'>"+
          "<div class='row'>"+
            "<div class='col-md-3'>"+
              "<div class='form-group'>"+
                "<label class='font-3' for='visitorName"+index+"'><span class='mandatory'>*</span>Visitor Name</label>"+
                "<input type='text' name='visitorInformationList["+index+"].visitorName' id='visitorName"+index+"' class='form-control' />"+
                "<span class='error invalid-feedback' id='visitorNameError"+index+"'></span>"+
              "</div>"+
            "</div>"+
            "<div class='col-md-3'>"+
              "<div class='form-group'>"+
                "<label class='font-3' for='visitorEmail'><span class='mandatory'>*</span>Visitor Email</label>"+
                "<input type='text' name='visitorInformationList["+index+"].visitorEmail' id='visitorEmail"+index+"' class='form-control' />"+
                "<span class='error invalid-feedback' id='visitorEmailError"+index+"'></span>"+
              "</div>"+
            "</div>"+
            "<div class='col-md-3'>"+
              "<div class='form-group'>"+
                "<label class='font-3' for='visitorGovtIdTemp'><span class='mandatory'>*</span>Govt ID Type</label>"+
                "<select value='${visitorInfo.visitorGovtIdTemp }' class='form-control' name='visitorInformationList["+index+"].visitorGovtIdTemp' id='visitorGovtIdTemp"+index+"'>"+
                  "<option value='-1'>Select Govt ID Type</option>"+
                  option+
                  /*"<c:forEach items='${govtIdTypes }' var='govtIdType' varStatus='govtIdTypeStatus'>"+
                    "<option value='${govtIdType.MVisitorTypeId }'>${govtIdType.visitorTypeName }</option>"+
                  "</c:forEach>"+*/
                "</select>"+
                "<span class='error invalid-feedback' id='visitorGovtIdTempError"+index+"'></span>"+
              "</div>"+
            "</div>"+
            "<div class='col-md-3'>"+
              "<div class='form-group'>"+
                "<label class='font-3' for='visitorGovtIdNumber"+index+"'><span class='mandatory'>*</span>Govt ID Referecne</label>"+
                "<input type='text' name='visitorInformationList["+index+"].visitorGovtIdNumber' id='visitorGovtIdNumber"+index+"' class='form-control' />"+
                "<span class='error invalid-feedback' id='visitorGovtIdNumberError"+index+"'></span>"+
              "</div>"+
            "</div>"+
            "<div class='col-md-4'>"+
              "<div class='form-group'>"+
                "<label class='font-3' for='liveFeed"+index+"'>Live Feed</label><br>"+
                "<video id='webcamVideoVisitor"+index+"' autoplay playsinline width='100%' height='240'></video>"+
              "</div>"+
            "</div>"+
            "<div class='col-md-4'>"+
              "<div class='form-group'>"+
                "<label class='font-3' for='visitorBatch'>Picture Taken</label><br>"+
                "<canvas style='display:none' id='photoCanvasVisitor"+index+"' width='320' height='240'></canvas>"+
                "<img src='' id='vendorImage"+index+"' class='' />"+
                "<input type='hidden' name='visitorInformationList["+index+"].visitorImage' id='visitorImageText"+index+"' class='form-control' />"+
                "<br><button class='btn bg-2' onclick='getImage("+index+")' style='float: right' type='button' id='takePhotoBtnVisitor"+index+"' >Take Photo</button>"+
                "<span styl'display:block' class='error invalid-feedback' id='visitorImageTextError"+index+"'></span>"+
              "</div>"+
            "</div>"+
            "<div class='col-md-4'>"+
              "<div class='form-group'>"+
                "<label class='font-3' for='visitorBatch"+index+"'><span class='mandatory'>*</span>Badge Number</label>"+
                "<input value='' type='text' name='visitorInformationList["+index+"].visitorBatch' id='visitorBatch"+index+"' class='form-control' />"+
                "<span style='display:block' class='error invalid-feedback' id='visitorBatchError"+index+"'></span>"+
              "</div>"+
            "</div>"+
          "</div>"+
        "</div>"+
    "</div>";
	
	$(".visitorBodyDiv").append(appendBody);
	var stream;
	const fps = 0;
	var video = $("#webcamVideoVisitor")[0];
	if (video.captureStream) {
		stream = video.captureStream(fps);
	} else if (video.mozCaptureStream) {
		stream = video.mozCaptureStream(fps);
	} else {
		console.error('Stream capture is not supported');
		stream = null;
	}
	$("#webcamVideoVisitor"+index)[0].srcObject = stream;
	$("#webcamVideoVisitor"+index)[0].play();
	$("#webcamVideoVisitor"+index).show();
	index = parseInt(index) + 1;
	$("#visitorInfoCount").val(index);
}
$("#visitor").submit(function() {
	var visitorInfoCount = $("#visitorInfoCount").val();
	$("#submitVisitorInformation").addClass("disabledButton");
	$('body').addClass('disableClickBody');
	$(".package-loader").show();
	var submitOrNot = true;
	for(var i=0; i<visitorInfoCount; i++) {
		if($("#visitorActive"+i).val() == 1) {
			if(visitorNameValidation(i) == false) {
				console.log("name error "+i);
				submitOrNot = false;
			}
			if(visitorEmailValidation(i) == false) {
				console.log("email error "+i);
				submitOrNot = false;
			}
			if(visitorGovtIdTempValidation(i) == false) {
				console.log("govt id type error "+i);
				submitOrNot = false;
			}
			if(visitorGovtIdNumberValidation(i) == false) {
				console.log("govt id number error "+i);
				submitOrNot = false;
			}
			if(visitorImageValidation(i) == false) {
				console.log("image error "+i);
				submitOrNot = false;
			}
			if(visitorBatchValidation(i) == false) {
				console.log("badge error "+i);
				submitOrNot = false;
			}
		}
	}
	if(submitOrNot) {
		return true;
	} else {
		$("#submitVisitorInformation").removeClass("disabledButton");
		$('body').removeClass('disableClickBody');
		$(".package-loader").hide();
		return false;
	}
});
function visitorNameValidation(idAppend) {
	var id = "visitorName"+idAppend;
	var error = "visitorNameError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var visitorName = $("#"+id).val().replace(/\s+/g, " ");
	if(visitorName != "") {
		if(centralAlphaNumericCheck.test(visitorName) == false) {
			$("#"+error).html("Visitor Name cannot contain special characters.");
			$("#"+id).addClass("is-invalid");
			return false;
		} else {
			$("#"+id).addClass("is-valid");
			return true;
		}
	} else {
		$("#"+error).html("Visitor Name cannot be empty.");
		$("#"+id).addClass("is-invalid");
		return false;
	}
}
function visitorEmailValidation(idAppend) {
	var id = "visitorEmail"+idAppend;
	var error = "visitorEmailError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var visitorEmail = $("#"+id).val().replace(/\s+/g, " ");
	if(visitorEmail != "") {
		if(centralEmailFormat.test(visitorEmail) == false) {
			$("#"+error).html("Visitor Email cannot contain special characters.");
			$("#"+id).addClass("is-invalid");
			return false;
		} else {
			$("#"+id).addClass("is-valid");
			return true;
		}
	} else {
		$("#"+error).html("Visitor Email cannot be empty.");
		$("#"+id).addClass("is-invalid");
		return false;
	}
}
function visitorGovtIdTempValidation(idAppend) {
	var id = "visitorGovtIdTemp"+idAppend;
	var error = "visitorGovtIdTempError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var visitorGovtIdTemp = $("#"+id).val();
	if(visitorGovtIdTemp == -1) {
		$("#"+id).addClass("is-invalid");
		$("#"+error).html("Select Govt ID.");
		return false;
	} else {
		$("#"+id).addClass("is-valid");
		return true;
	}
}
function visitorGovtIdNumberValidation(idAppend) {
	var id = "visitorGovtIdNumber"+idAppend;
	var error = "visitorGovtIdNumberError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var visitorGovtIdNumber = $("#"+id).val().replace(/\s+/g, " ");
	if(visitorGovtIdNumber != "") {
		if(centralAlphaNumericCheckWithHifen.test(visitorGovtIdNumber) == false) {
			$("#"+error).html("Govt ID Reference cannot contain special characters.");
			$("#"+id).addClass("is-invalid");
			return false;
		} else {
			$("#"+id).addClass("is-valid");
			return true;
		}
	} else {
		$("#"+error).html("Govt ID Reference cannot be empty.");
		$("#"+id).addClass("is-invalid");
		return false;
	}
}
function visitorImageValidation(idAppend) {
	var id = "visitorImageText"+idAppend;
	var error = "visitorImageTextError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	$("#"+error).show();
	var visitorImage = $("#"+id).val();
	if(visitorImage == "") {
		$("#"+id).addClass("is-invalid");
		$("#"+error).html("Take Photo of the visitor.");
		return false;
	} else {
		$("#"+id).addClass("is-valid");
		return true;
	}
}
function visitorBatchValidation(idAppend) {
	var id = "visitorBatch"+idAppend;
	var error = "visitorBatchError"+idAppend;
	$("#"+id).removeClass("is-valid");
	$("#"+id).removeClass("is-invalid");
	$("#"+error).html("");
	var visitorBatch = $("#"+id).val().replace(/\s+/g, " ");
	if(visitorBatch != "") {
		if(centralNumericOnly.test(visitorBatch) == false) {
			$("#"+error).html("Visitor Badge cannot contain special characters.");
			$("#"+id).addClass("is-invalid");
			return false;
		} else {
			$("#"+id).addClass("is-valid");
			return true;
		}
	} else {
		$("#"+error).html("Visitor Badge cannot be empty.");
		$("#"+id).addClass("is-invalid");
		return false;
	}
}
function removeUser(index) {
	$(".visitorInfo"+index).hide();
	$("#visitorActive"+index).val(0);
}
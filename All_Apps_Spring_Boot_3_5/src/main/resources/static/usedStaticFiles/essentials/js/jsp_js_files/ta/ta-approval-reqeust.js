$(function() {
	$('.select2').select2({
		theme: 'bootstrap4'
	});
	var toolCostDetailsIndex = $("#toolCostDetailsIndex").val();
	if($("#taToolRequestId").val() != "") {
		$("#tempEntityId").val($("#tempEntityIdForJquery").val()).trigger("change");
		$("#unit").val($("#unitTempForJquery").val());
		$("#expenseType").val($("#expenseTypeTempForJquery").val());
		$("#tempBusinessUnitId").val($("#tempBusinessUnitIdTempForJquery").val()).trigger("change");
		$("#tempCommodityManagerId").val($("#tempCommodityManagerIdForJquery").val()).trigger("change");
		for(var i=0; i<$("#toolCostDetailsIndex").val(); i++) {
			$("#currency"+i).val($("#currencyTemp"+i).val());
		}
	} else {
		$("#background").val("");
		$("#remark").val("");
		for(var i=0; i< toolCostDetailsIndex; i++) {
			var id = "supplierName"+i;
			$("#"+id).val("");
			id = "costRemarks"+i;
			$("#"+id).val("");
			$("#toolingPaymentRemark").val("");
		}
	}

	loadAttachments(ATTACHMENT_SECTION_BACKGROUND);
	loadAttachments(ATTACHMENT_SECTION_REMARK);
});
const ATTACHMENT_SECTION_BACKGROUND = 1;
const ATTACHMENT_SECTION_REMARK = 2;
const ATTACHMENT_LIMIT = 3;
let tempAttachments = {
	1: [],   // background
	2: []    // remark
};
$("#ta-approval-reqeust").submit(function(){

	var submitOrNot = true;

	if(validateStepOne() == false){
		submitOrNot = false;
	}

	var toolCostDetailsIndex = $("#toolCostDetailsIndex").val();
	var activeCostRowExists = false;

	var maxIndex = $("#toolCostDetailsIndex").val();

	for(var j = 0; j < maxIndex; j++){

		if($("#costActive"+j).val() == "1"){
			activeCostRowExists = true;
			break;
		}

	}

	if(activeCostRowExists == false){
		var firstField = $("#toolPartNumber0")[0];

		firstField.setCustomValidity("One cost row is required");
		firstField.reportValidity();

		setTimeout(function(){
			firstField.setCustomValidity("");
			firstField.blur();
		},100);

		submitOrNot = false;
	}


	if(!validateField(
		"toolingPaymentRemark",
		"toolingPaymentRemarkError",
		"Tooling Payment Remark cannot be empty."
	)){
		submitOrNot = false;
	}

	if(tempAttachments[ATTACHMENT_SECTION_BACKGROUND].length > 0){

		const dataTransferBackground = new DataTransfer();

		tempAttachments[ATTACHMENT_SECTION_BACKGROUND].forEach(function(file){
			dataTransferBackground.items.add(file);
		});

		$("#backgroundAttachmentHidden")[0].files = dataTransferBackground.files;

	}

	if(tempAttachments[ATTACHMENT_SECTION_REMARK].length > 0){

		const dataTransferRemark = new DataTransfer();

		tempAttachments[ATTACHMENT_SECTION_REMARK].forEach(function(file){
			dataTransferRemark.items.add(file);
		});

		$("#remarkAttachmentHidden")[0].files = dataTransferRemark.files;

	}

	if(submitOrNot) {
		return true;
	} else {
		return false;
	}

});
function removeCostDetail(event, toolCostDetailsIndex){
	event.preventDefault();
	event.stopPropagation();

	var activeRowCount = 0;

	var maxIndex = $("#toolCostDetailsIndex").val();

	for(var j=0; j<maxIndex; j++) {

		if($("#costActive"+j).val() == "1") {
			activeRowCount++;
		}

	}

	if(activeRowCount <= 1){
		return;
	}

	$("#costActive"+toolCostDetailsIndex).val(0);
	$("#costDetailRow"+toolCostDetailsIndex)
		.find("input, textarea, select")
		.removeClass("is-valid is-invalid");
	$("#costDetailRow"+toolCostDetailsIndex).hide();

}
function goToCostDetails() {
	$("#cost-details-tab").trigger("click");
}
function goToToolApprovalDetails() {
	$("#tool-approval-details-tab").trigger("click");
}
function addMoreToolCostDetail() {
	var index = $("#toolCostDetailsIndex").val();

	var template = $("#costRowTemplate").html();

	template = template.replaceAll("{index}", index);

	$("#approvalMatrixTable tbody").append(template);

	index++;

	$("#toolCostDetailsIndex").val(index);
}
function el(id){
	return $("#"+id);
}
function validateField(id,errorId,message,options){

	var field = el(id);
	var error = el(errorId);

	field.removeClass("is-valid is-invalid");
	error.html("");

	var value = field.val();

	if(!value || value.trim()===""){
		error.html(message);
		field.addClass("is-invalid");
		return false;
	}

	if(options && options.type==="alphanumeric"){

		value = value.replace(/\s+/g," ");

		if(centralAlphaNumericCheck.test(value)===false){
			error.html("Customer Name cannot contain special characters.");
			field.addClass("is-invalid");
			return false;
		}

	}

	field.addClass("is-valid");
	return true;

}

function loadAttachments(section){
	var toolRequestId = $("#taToolRequestId").val();

	if(!toolRequestId){
		return;
	}

	$.get("getAttachmentList",{
		toolRequestId:toolRequestId,
		section:section
	},function(response){

		if(response === "error"){
			return;
		}

		var list = JSON.parse(response);

		renderAttachmentList(list,section);

	});

}

function renderAttachmentList(list,section){

	var container;

	if(section === ATTACHMENT_SECTION_BACKGROUND){
		container = $("#backgroundAttachmentList");
	}else{
		container = $("#remarkAttachmentList");
	}

	container.html("");

	list.forEach(function(file,index){

		var fileName = file.name || file.fileName;

		var html =
		'<div class="mt-1">'+
			'<span class="mr-2">'+fileName+'</span>'+
			'<a href="#" class="deleteAttachment sequence-font-1" data-section="'+section+'" data-index="'+index+'" data-attachmentid="'+(file.taAttachmentId || '')+'">'+
				'<i class="fas fa-times-circle"></i>'+
			'</a>'+
		'</div>';

		container.append(html);
	});
}

function uploadAttachment(file,section){

	var container;

	if(section === ATTACHMENT_SECTION_BACKGROUND){
		container = $("#backgroundAttachmentList");
	}else{
		container = $("#remarkAttachmentList");
	}

	if(tempAttachments[section].length >= ATTACHMENT_LIMIT){
		alert("Maximum 3 attachments allowed per section.");
		return;
	}

	tempAttachments[section].push(file);

	renderAttachmentList(tempAttachments[section],section);
}
function validateSelectField(id, errorId, invalidValue, message){

	var field = el(id);
	var error = el(errorId);

	field.removeClass("is-valid is-invalid");
	error.html("");

	if(field.val() !== invalidValue){
		field.addClass("is-valid");
		return true;
	}

	error.html(message);
	field.addClass("is-invalid");
	return false;

}

function bindSelectValidation(id, errorId, invalidValue, message){

	$("#"+id).change(function(){

		if(validateSelectField(id, errorId, invalidValue, message) == false){
			return;
		}

	});

}

const stepOneFieldConfig = [

	{
		id:"customerName",
		error:"customerNameError",
		message:"Customer Name cannot be empty.",
		type:"alphanumeric"
	},

	{
		id:"projectName",
		error:"projectNameError",
		message:"Project Name cannot be empty."
	},

	{
		id:"tempSopDate",
		error:"tempSopDateError",
		message:"SOP Date is required."
	},

	{
		id:"background",
		error:"backgroundError",
		message:"Background cannot be empty."
	},

	{
		id:"remark",
		error:"remarkError",
		message:"Remark cannot be empty."
	}

];

function validateStepOne(){

	var valid = true;

	stepOneFieldConfig.forEach(function(field){

		if(!validateField(field.id,field.error,field.message,field)){
			valid = false;
		}

	});

	var volume = el("peakAnnualVolume").val();

	el("peakAnnualVolume").removeClass("is-valid is-invalid");
	el("peakAnnualVolumeError").html("");

	if(volume !== "" && Number(volume) > 0){

		el("peakAnnualVolume").addClass("is-valid");

	}else{

		el("peakAnnualVolumeError").html("Peak Annual Volume must be greater than zero.");
		el("peakAnnualVolume").addClass("is-invalid");
		valid=false;

	}

	if(validateSelectField("tempEntityId","tempEntityIdError","","Plant Code is required.") == false) valid = false;
	if(validateSelectField("unit","unitError","-1","Unit is required.") == false) valid = false;
	if(validateSelectField("expenseType","expenseTypeError","","Expense Type is required.") == false) valid = false;
	if(validateSelectField("tempBusinessUnitId","tempBusinessUnitIdError","","Applicable For is required.") == false) valid = false;
	if(validateSelectField("tempCommodityManagerId","tempCommodityManagerIdError","","Commodity Manager is required.") == false) valid = false;

	return valid;

}
stepOneFieldConfig.forEach(function(field){

	el(field.id).focusout(function(){
		validateField(field.id,field.error,field.message,field);
	});

});
$("#peakAnnualVolume").focusout(function(){

	var volume = el("peakAnnualVolume").val();

	el("peakAnnualVolume").removeClass("is-valid is-invalid");
	el("peakAnnualVolumeError").html("");

	if(volume !== "" && Number(volume) > 0){

		el("peakAnnualVolume").addClass("is-valid");

	}else{

		el("peakAnnualVolumeError").html("Peak Annual Volume must be greater than zero.");
		el("peakAnnualVolume").addClass("is-invalid");

	}

});

$("#toolingPaymentRemark").focusout(function(){

	validateField(
		"toolingPaymentRemark",
		"toolingPaymentRemarkError",
		"Tooling Payment Remark cannot be empty."
	);

});

bindSelectValidation(
	"tempEntityId",
	"tempEntityIdError",
	"",
	"Plant Code is required."
);

bindSelectValidation(
	"unit",
	"unitError",
	"-1",
	"Unit is required."
);

bindSelectValidation(
	"expenseType",
	"expenseTypeError",
	"",
	"Expense Type is required."
);

bindSelectValidation(
	"tempBusinessUnitId",
	"tempBusinessUnitIdError",
	"",
	"Applicable For is required."
);

bindSelectValidation(
	"tempCommodityManagerId",
	"tempCommodityManagerIdError",
	"",
	"Commodity Manager is required."
);

$("#addMorePartCost").click(function(){
	addMoreToolCostDetail();
});
$("#uploadBackgroundAttachmentBtn").click(function(){
	$("#backgroundAttachmentFile").trigger("click");
});

$("#uploadRemarkAttachmentBtn").click(function(){
	$("#remarkAttachmentFile").trigger("click");
});
$("#backgroundAttachmentFile").change(function(){
	var file = this.files[0];

	if(file){
		uploadAttachment(file,ATTACHMENT_SECTION_BACKGROUND);
	}

});
$("#remarkAttachmentFile").change(function(){
	var file = this.files[0];

	if(file){
		uploadAttachment(file,ATTACHMENT_SECTION_REMARK);
	}

});
$("#backToToolDetails").click(function(){

	goToToolApprovalDetails();

});
$("#approvalMatrixTable").on("click",".deleteCostRow",function(event){

	event.preventDefault();
	event.stopPropagation();

	var index = $(this).data("index");

	removeCostDetail(event,index);

});
$(document).on("click",".deleteAttachment",function(e){

	e.preventDefault();

	const section = $(this).data("section");
	const index = $(this).data("index");
	const attachmentId = $(this).data("attachmentid");

	if(attachmentId){

		$.ajax({
			url:"ta-attachment-delete",
			type:"POST",
			data:{
				attachmentId:attachmentId
			},
			success:function(){
				loadAttachments(section);
			}
		});

	}else{

		tempAttachments[section].splice(index,1);
		renderAttachmentList(tempAttachments[section],section);

	}

});
$("#nextToolApprovalStep").click(function(){

	if(validateStepOne()){
		goToCostDetails();
	}

});

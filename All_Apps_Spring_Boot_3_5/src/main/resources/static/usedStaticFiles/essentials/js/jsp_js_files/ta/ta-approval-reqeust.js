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
});
function removeCostDetail(toolCostDetailsIndex){
	$("#costActive"+toolCostDetailsIndex).val(0);
	$("#costDetailRow"+toolCostDetailsIndex).hide();
}
function goToCostDetails() {
	$("#cost-details-tab").trigger("click");
}
function goToToolApprovalDetails() {
	$("#tool-approval-details-tab").trigger("click");
}
function addMoreToolCostDetail() {
	var toolCostDetailsIndex = $("#toolCostDetailsIndex").val();
	$("#approvalMatrixTable tbody").append(
		"<tr style='text-align:center' id='costDetailRow"+toolCostDetailsIndex+"'>"+
		                                  "<td>"+
		                                    "<input style='width:10px' type='hidden' value='' id='taToolRequestCostDetailId"+toolCostDetailsIndex+"' name='tempToolRequestCostDetail["+toolCostDetailsIndex+"].taToolRequestCostDetailId' />"+
		                                    "<input style='width:10px' type='hidden' value='1' id='costActive"+toolCostDetailsIndex+"' name='tempToolRequestCostDetail["+toolCostDetailsIndex+"].costActive' />"+
		                                    "<a href='#' onclick='removeCostDetail("+toolCostDetailsIndex+")' class='sequence-font-1' title='Delete Cost Entry'><i class='fas fa-times-circle'></i></a>"+
		                                  "</td>"+
		                                  "<td>"+
		                                    "<input style='width:140px' type='text' name='tempToolRequestCostDetail["+toolCostDetailsIndex+"].toolPartNumber' id='toolPartNumber"+toolCostDetailsIndex+"' class='input-group-sm'/>"+
		                                  "</td>"+
		                                  "<td>"+
		                                    "<input style='width:150px' type='text' name='tempToolRequestCostDetail["+toolCostDetailsIndex+"].partDescription' id='partDescription"+toolCostDetailsIndex+"' class='input-group-sm'/>"+
		                                  "</td>"+
		                                  "<td>"+
		                                    "<select style='width:50px' name='tempToolRequestCostDetail["+toolCostDetailsIndex+"].currency' id='currency"+toolCostDetailsIndex+"' class='input-group-sm'>"+
		                                      "<option value='1'>INR</option>"+
		                                      "<option value='2'>USD</option>"+
		                                      "<option value='3'>EUR</option>"+
		                                      "<option value='4'>YEN</option>"+
		                                    "</select>"+
		                                  "</td>"+
		                                  "<td>"+
		                                    "<input style='width:70px' type='number' step='0.0001' min='0' name='tempToolRequestCostDetail["+toolCostDetailsIndex+"].quotedCost' id='quotedCost"+toolCostDetailsIndex+"' class='input-group-sm' required/>"+
		                                  "</td>"+
		                                  "<td>"+
		                                    "<input style='width:70px' type='number' step='0.0001' min='0' name='tempToolRequestCostDetail["+toolCostDetailsIndex+"].negotiatedCost' id='negotiatedCost"+toolCostDetailsIndex+"' class='input-group-sm' required/>"+
		                                  "</td>"+
		                                  "<td>"+
		                                    "<input style='width:70px' type='number' step='0.0001' min='0' name='tempToolRequestCostDetail["+toolCostDetailsIndex+"].upfrontCost' id='upfrontCost"+toolCostDetailsIndex+"' class='input-group-sm'/>"+
		                                  "</td>"+
		                                  "<td>"+
		                                    "<input style='width:80px' type='number' step='0.0001' min='0' name='tempToolRequestCostDetail["+toolCostDetailsIndex+"].amortizationCost' id='amortizationCost"+toolCostDetailsIndex+"' class='input-group-sm'/>"+
		                                  "</td>"+
		                                  "<td>"+
		                                    "<textarea id='supplierName"+toolCostDetailsIndex+"' rows='2' style='width:145px' name='tempToolRequestCostDetail["+toolCostDetailsIndex+"].supplierName' id='supplierName"+toolCostDetailsIndex+"' class='input-group-sm'>"+
		                                    "</textarea>"+
		                                  "</td>"+
		                                  "<td>"+
		                                    "<input style='width:100px' type='text' name='tempToolRequestCostDetail["+toolCostDetailsIndex+"].developmentLeadTime' id='developmentLeadTime"+toolCostDetailsIndex+"' class='input-group-sm' />"+
		                                  "</td>"+
		                                  "<td>"+
		                                    "<textarea  id='costRemarks"+toolCostDetailsIndex+"' rows='2' style='width:145px' name='tempToolRequestCostDetail["+toolCostDetailsIndex+"].remarks' class='input-group-sm' id='remarks"+toolCostDetailsIndex+"'>"+
		                                    "</textarea>"+
		                                  "</td>"+
		                                "</tr>"
	);
	toolCostDetailsIndex++;
	$("#toolCostDetailsIndex").val(toolCostDetailsIndex);
}
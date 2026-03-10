<!-- ****************************************************************************************
# *******************************************************************************************
# Copyright © 2021 Anand Group India. All rights reserved.									*
# No part of this product may be reproduced in any form by any means without prior			*
# written authorization of Anand Automotive Private Limited and its licensors, if any.		*
# *******************************************************************************************
# Author - Sheshadhri Iyer																	*
# *************************************************************************************** -->
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>APPOINTMENT<%@include file="../includeJSP/company_name_title.jsp"%></title>
    <%@include file="../includeJSP/cssFiles.jsp"%>
    <link rel="stylesheet" href="usedStaticFiles/essentials/daterangepicker/daterangepicker.css">
    <link rel="stylesheet" href="usedStaticFiles/essentials/daterangepicker/bootstrap-colorpicker.min.css">
    <link rel="stylesheet" href="usedStaticFiles/essentials/daterangepicker/tempusdominus-bootstrap-4.min.css">
  </head>
  <body class="sidebar-mini layout-navbar-fixed sidebar-collapse pace-primary">
    <div class="wrapper">
      <%@include file="includeJSP/header.jsp"%>
      <%@include file="includeJSP/leftSideBar.jsp"%>
      <div class="content-wrapper">

        <section class="content-header">
          <div class="container-fluid">
            <div class="row mb-2">
              <div class="col-sm-6">
                <h5 class="font-3 font-weight-bold">VISITORS TIME OUT</h5>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                  <li class="breadcrumb-item font-1"><a href="dashboard" title="Dashboard">Dashboard</a></li>
                  <li class="breadcrumb-item font-3 active">Visitor Time Out</li>
                </ol>
              </div>
            </div>
          </div>
        </section>

        <c:if test="${not empty regMsg }">
          <section class="content content-margin">
            <div class="container-fluid">
              <div class="alert ${css } alert-dismissible">
                <button type="button" title="CLose Alert Box" class="close" data-dismiss="alert" aria-hidden="true"><i class="fas fa-times"></i></button>
                <c:if test="${css eq 'sequence-bg-1'}">
                  <h5><i class="icon fas fa-ban"></i>${regMsg }</h5>
                </c:if>
                <c:if test="${css ne 'sequence-bg-1'}">
                  <h5><i class="icon fas fa-check"></i>${regMsg }</h5>
                </c:if>
              </div>
            </div>
          </section>
        </c:if>


        <input id="vimsAdmin" type="hidden" value="${sessionScope.vimsAdmin}" />
        <input id="vimsReception" type="hidden" value="${sessionScope.vimsAdmin}">
		<input id="itAdmin" type="hidden" value="${sessionScope.itAdmin}">
		<input id="employee" type="hidden" value="${sessionScope.employee}">

		<section class="content content-margin">
		  <div class="container-fluid">
		    <div class="row">
		      <div class="col-md-12">
		        <div class="card card-secondary">
		          <div class="card-header bg-3">
		            <h5 class="card-title font-weight-bold">List of Visitor</h5><h5 style="float: right" class="card-title sequence-font-2 font-weight-bold" id="currTimeLabel"></h5>
		          </div>
		          <div class="card-body">
		            <div class="row">
		              <div class="col-md-12">
		                <div class="card card-primary collapsed-card">
		                  <div class="card-header bg-2" data-card-widget="collapse">
		                    <h5 class="card-title"><i class="fas fa-filter"></i>&emsp;Filters</h5>
		                    <div class="card-tools">
		                      <button type="button" class="btn btn-tool" data-card-widget="collapse">
		                        <i class="fas fa-plus font-color-anand-one"></i>
		                      </button>
		                    </div>
		                  </div>
		                  <div class="card-body" style="display: none;">
		                        <form modelAttribute="visitorInfo" action="visitor-time-out" id="listFilterForm" method="post">
		                        <div class="row">
		                          <div class="col-md-3 form-group">
		                            <label class="font-1">Date</label>
		                            <input style="float: right" class="visitorInformationDetail.meetingStartDateTemp" type="date" id="filterDate" class="form-control form-" min="${today}"/>

		                          </div>
		                          <c:if test="${itAdmin eq 1 || vimsReception eq 1 }">
		                            <div class="col-md-5 form-group">
		                              <label class="font-2">Parent Entity</label>
		                              <select class="visitorInformationDetail.visitingLocationTemp" id="locationFilter" class="form-control">
		                                <option value="-1"> Select Location </option>
		                                <c:forEach items="${userEntityMap}" var="userEntity" varStatus="userEntityLoop">
		                                  <c:if test="${visitorInfo.visitorInformationDetail.visitingLocationTemp eq userEntity.entityInfoForUsers.mEntityId }">
		                                    <option selected="selected" value="${userEntity.entityInfoForUsers.mEntityId}">${userEntity.entityInfoForUsers.locationId.locationName }&ensp;-&ensp;${userEntity.entityInfoForUsers.entityName }</option>
		                                  </c:if>
		                                  <c:if test="${visitorInfo.visitorInformationDetail.visitingLocationTemp ne userEntity.entityInfoForUsers.mEntityId }">
		                                    <option value="${userEntity.entityInfoForUsers.mEntityId}"> ${userEntity.entityInfoForUsers.locationId.locationName }&ensp;-&ensp;${userEntity.entityInfoForUsers.entityName }</option>
		                                  </c:if>
		                                </c:forEach>
		                              </select>
		                            </div>
		                            <div class="col-md-4 form-group">
		                              <label class="font-3">Host Name</label>
		                              <select class="visitorInformationDetail.hostNameTemp" id="hostNameFilter" class="form-control">
		                                <option value="-1"> Select Host </option>
		                                <c:forEach items="${userList}" var="user" varStatus="userLoop">
		                                  <c:if test="${user.mUserId eq visitorInfo.visitorInformationDetail.hostNameTemp }">
		                                    <option selected="selected" value="${user.mUserId }">${user.userFirstName } ${user.userLastName }</option>
		                                  </c:if>
		                                  <c:if test="${user.mUserId ne visitorInfo.visitorInformationDetail.hostNameTemp }">
		                                    <option value="${user.mUserId }">${user.userFirstName } ${user.userLastName }</option>
		                                  </c:if>
		                                </c:forEach>
		                              </select>
		                            </div>
		                          </c:if>
		                        </div>
		                        <!-- <div class="card-tools" align="right">
		                          <button type="submit" title="Filter Cycle Information" class="btn btn-default">Search</button>
		                          &emsp;<button onclick="$(&quot;#auditYearlyPlanId&quot;).val(-1);$(&quot;#parentEntityId&quot;).val(-1);$(&quot;#childEntityId&quot;).val(-1);$(&quot;#cycleId&quot;).val(-1);$(&quot;#scopeId&quot;).val(-1);$(&quot;#ownerId&quot;).val(-1);$(&quot;#approver1&quot;).val(-1);$(&quot;#approver2&quot;).val(-1);$(&quot;#teamLead&quot;).val(-1);$(&quot;#recoStatus&quot;).val(-1);location.href=&quot;recommendation-tracker&quot;" title="Clear Cycle Information" class="btn btn-default">Clear</button>
		                        </div> -->
		                        </form>
		                  </div>
		                </div>
		              </div>
		            </div>
		            <div class="row">
		              <div class="col-md-12 tableOverFlowDiv">
		                <table class="table table-bordered table-striped dataTable" id="visitorTable">
		                  <thead>
		                    <tr class="bg-table-head">
		                      <th>Visitor Info</th>
		                      <th>Location</th>
		                      <th>Host</th>
		                      <th>Meeting Date</th>
		                      <!-- <th>Visit Planned Till</th> -->
		                      <th>Time In</th>
		                      <th>View Image</th>
		                      <th>Punch Out</th>
		                    </tr>
		                  </thead>
		                  <tbody>
	                          <c:forEach items="${visitorInformationList}" var="visitorInformation" varStatus="visitorInformationLoop">

	                          <fmt:parseDate var="todayFormatted" pattern="yyyy-MM-dd" value="${today}"/>
	                          <fmt:formatDate var="meetingDate" pattern = "dd-MMM-yyyy" value = "${visitorInformation.visitorInformationDetail.meetingDate}"/>
		                      <fmt:formatDate var="todayNew" pattern = "dd-MMM-yyyy" value = "${todayFormatted}" />
		                      <fmt:formatDate var = "visitUntil" pattern = "dd-MMM-yyyy HH:mm a" value = "${visitorInformation.visitorInformationDetail.visitorAllowedUntil }" />
		                      <fmt:formatDate var = "timeInVar" pattern = "dd-MMM-yyyy HH:mm a" value = "${visitorInformation.createdOn }" />

		                      <tr class="bg-table-row-${visitorInformationLoop.index %2 }" id="${visitorInformation.visitorInformationId}" data-date="${visitorInformation.visitorInformationDetail.meetingDate}" data-loc="${visitorInformation.visitorInformationDetail.visitingLocation.mEntityId}" data-host="${visitorInformation.visitorInformationDetail.hostName.mUserId}">
		                      <%-- <td><a href="#" class="view-details" data-type ="${visitorInformation.visitorInformationDetail.MVisitorType.visitorTypeName}" data-purpose="${visitorInformation.visitorInformationDetail.MVisitorPurpose.visitorPurposeName}" data-name="${visitorInformation.visitorName }"> </a></td> --%>
		                      <td>${visitorInformation.visitorName }<br>${visitorInformation.visitorInformationDetail.MVisitorType.visitorTypeName}<br>${visitorInformation.visitorInformationDetail.MVisitorPurpose.visitorPurposeName}</td>
		                      <%-- <td><a href="#" class="view-image-link" data-img-src="${visitorInformation.visitorImage}">View ${visitorInformation.visitorName}'s Image</a></td> --%>
		                        <td>${visitorInformation.visitorInformationDetail.visitingLocation.entityAcronym} - ${visitorInformation.visitorInformationDetail.visitingLocation.locationId.locationName}</td>
		                        <td>${visitorInformation.visitorInformationDetail.hostName.userFirstName } ${visitorInformation.visitorInformationDetail.hostName.userLastName }</td>
		                        <td>
		                        <c:choose>
		                        <c:when test="${todayNew eq meetingDate}"><span class="text-success">${meetingDate}</span></c:when>
		                        <c:otherwise><span class="text-danger">${meetingDate}</span></c:otherwise>
		                        </c:choose>
		                        </td>
		                        <%-- <td><span class="text-success">${visitUntil}</span></td> --%>
		                        <td><span class="text-success">${timeInVar }</span></td>
		                        <td><img width="170" height="100" src="${visitorInformation.visitorImage}" /></td>
		                        <td>
		                          <%-- <a font class="sequence-font-1 PunchOutBtn" data-id="${visitorInformation.visitorInformationId}" href="#">
		                            <i class="fas fa-user-check"></i>
		                          </a> --%>
		                        <button type="button" class="btn btn-sm sequence-bg-1 PunchOutBtn" data-id="${visitorInformation.visitorInformationId}"><i class="fas fa-user-check"></i>&ensp;Punch Out</button></td>
		                      </tr>
		                    </c:forEach>
		                  </tbody>
		                  <tfoot>
		                    <tr class="bg-table-foot">
		                      <th>Visitor Info</th>
		                      <th>Location</th>
		                      <th>Host</th>
		                      <th>Meeting Date</th>
		                      <!-- <th>Visit Planned Till</th> -->
		                      <th>Time In</th>
		                      <th>View Image</th>
		                      <th>Punch Out</th>
		                    </tr>
		                  </tfoot>
		                </table>
		              </div>
		              </div>
		            </div>
		          </div>
		        </div>
		      </div>
		    </div>
		</section>

		<!-- Modal -->
<div class="modal fade" id="imageModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <div class="modal-header bg-3">
        <h5 class="modal-title">Image Preview</h5>
        <button type="button" data-dismiss="modal" aria-label="Close"><i class="icon fas fa-times"></i></button>
      </div>
      <div class="modal-body text-center">
        <p id="detailsBox"></p>
        <img id="modalImage" src="" alt="Preview" class="img-fluid" />
      </div>
    </div>
  </div>
</div>
<!-- Details modals -->
<div class="modal fade" id="detailsModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-sm">
    <div class="modal-content">
      <div class="modal-header bg-3">
        <h5 class="modal-title" id="detailsModalTitle"></h5>
        <a type="button" data-dismiss="modal" aria-label="Close"><i class="icon fas fa-times"></i></a>
      </div>
      <div class="modal-body text-center">
        <p id="detailsBox"></p>
      </div>
    </div>
  </div>
</div>


      </div>
      <%@include file="includeJSP/footer.jsp"%>
    </div>
    <%@include file="../includeJSP/jsFiles.jsp"%>
    <%@include file="../includeJSP/dataTablesImport.jsp"%>
  	<script>
		var pagination = true;
		$(function() {
			$("#visitorTable").DataTable({
				"ordering": false,
				"paging": true,
				"info": true,
				"lengthChange": true,
				"searching": true,
				"autoWidth": false,
				"responsive": true,
				"drawCallback": function(settings) {
					if (pagination) {
						$('#visitorTable_paginate').find(".pagination").append('<li class="paginate_button page-item"><a onclick="loadNextSetValues()" id="loadMore_visitorTable" class="fa fa-arrow-right page-link" href="#" title="Load More"></a></li>');
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
					title:"Visitor List",
					orientation: 'portrait',
					customize: function (doc) {
						var now = new Date();
						var jsDate = now.getDate()+'-'+(now.getMonth()+1)+'-'+now.getFullYear();
						var logo = 'data:image/png;base64,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';
						doc['header']=(function() { return {
							columns: [{
								alignment: 'left',
								fontSize: 15,
								text: "ANAND Visitors",
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
			}).buttons().container().appendTo('#visitorTable_wrapper .col-md-6:eq(0)');

			var visitorTable = $("#visitorTable").DataTable();
			var loadAll = window.location.href.split("all").length;
			if(visitorTable.rows().count() < 20 || loadAll > 1) {
				$("#loadMore_visitorTable").hide();
				pagination = false;
			}
		});
		function loadNextSetValues() {
			var visitorTable = $("#visitorTable").DataTable();
			var offsetValue = visitorTable.rows().count();
			$('body').addClass('disableClickBody');
			$(".package-loader").show();
			$.ajax({
				url:'loadMoreVisitor',
				type:'GET',
				data:{'offsetValue':offsetValue},
				dataType : 'json',
				success: function(result) {
					for(var i=0; i<result.length; i++) {
						visitorTable.row.add([
							result[i]["actionForList"],result[i]["visitorName"],
							result[i]["visitorActive"],
							result[i]["visitorCreatedBy"],result[i]["visitorCreatedOn"],
							result[i]["visitorUpdatedBy"],result[i]["visitorUpdatedOn"]
						]);
					}
					visitorTable.draw(false);
					var currentPage = visitorTable.page.info().page;
					var totalPages = visitorTable.page.info().pages;
					console.log(totalPages);
					if(totalPages > 1) {
						if(currentPage != (totalPages-1)) {
							visitorTable.page(currentPage+1).draw(false);
						}
					}
					$("#visitorTable_paginate").scroll();
					$('#visitorTable_paginate').show();
					if(result.length < 20) {
						pagination = false;
						$('#loadMore_visitorTable').hide();
					}
					$('body').removeClass('disableClickBody');
					$(".package-loader").hide();
				},
				error:function() {
					$('#visitorTable_paginate').show();
					$('body').removeClass('disableClickBody');
					$(".package-loader").hide();
					alert("Something went wrong, kindly try again after sometime.");
				}
			});
		}
		$(document).ready(function() {
			function updateCurrTime (){
				var time = new Date().toLocaleTimeString('en-IN', {hour12: false});
				$("#currTimeLabel").text("Current Time: "+time);
				return time;
			}
			updateCurrTime();
			setInterval(updateCurrTime,1000);
			$(".PunchOutBtn").click(function () {
				const button = $(this);
				const visitorId = $(this).data("id");
				const row = $(this).closest("tr");
				$.ajax({
					url: 'visitor-out',
					data: {id: visitorId},
					method: 'GET',
					success: function (response) {
						// Disable the button
						button.prop('disabled', true).text(updateCurrTime);
						row.addClass("table-danger");
                        setTimeout(function () {
                            location.reload(); // This refreshes the entire page
                        }, 2300);
					},
					error: function () {
						alert("Failed to deactivate Visitor.");
					}
				});
			})
			$(document).on("click", ".view-image-link", function (e) {
				e.preventDefault();
				const imageUrl = $(this).data("img-src");
				$("#modalImage").attr("src", imageUrl);
				$("#imageModal").modal('show');
			});
			$(document).on("click", ".view-details", function (e) {
				e.preventDefault();
				const Type = $(this).data("type");
				const Purpose = $(this).data("purpose")
				const Name = $(this).data("name")
				$("#detailsModalTitle").text(Name + "'s Details")
				$("#detailsBox").html("<strong>Visitor Type: </strong>"+"<span class='text-muted'>"+ Type +"</span><br><strong>Visitor Purpose: </strong><span class='text-muted'>"+ Purpose+ "</span>")
				$("#detailsModal").modal('show');
			});
		})
	</script>
    <script>
		document.addEventListener("DOMContentLoaded", function () {
			const vimsAdmin = $("#vimsAdmin").val();
			const vimsReception = $("#vimsReception").val();
			const itAdmin = $("#itAdmin").val();

			console.log("itAdmin:"+itAdmin);
			console.log("vimsAdmin:"+vimsAdmin);
			console.log("vimsReception:"+vimsReception);


			if(itAdmin == 1 || vimsAdmin == 1 || vimsReception == 1){ // Role Checking flags, using abstract equality
				const dateFilter = $("#filterDate");
				const locationFilter = $("#locationFilter");
				const hostNameFilter = $("#hostNameFilter");
				const tableRows = document.querySelectorAll("#visitorTable tbody tr");
				const form = $("#listFilterForm");
				const selectedUser = $("#selectedUser").val();

				dateFilter.removeAttr('min');





				// function filterRowsByHost(host) {
				// 	tableRows.forEach(row => {
				// 		const rowHost = row.getAttribute("data-host")
				// 			if (host == -1 || rowHost === host) { //Will only fire if Host is correct for given entry
				// 				row.style.display = "";
				// 			}
				// 			else {
				// 				row.style.display = "none";
				// 			}
				// 	});
				// }


				// Initial filter on page load (defaults to today and first location mapped to user from user_entity_mapping)


				// Filter again on user input
				dateFilter.on("change", () => {
					form.submit();
				});
				locationFilter.on("change", () => {
					setTimeout(function (){
						form.submit();
						// updateUserOptions(locationFilter.val());
						// hostNameFilter.val(-1);
					},1000);
				});
				hostNameFilter.on("change", () =>{
					form.submit();
				})
			}
			else{
				const dateFilter = $("#filterDate");
				const tableRows = document.querySelectorAll("#visitorTable tbody tr");

				function filterRowsByDate(date) {
					tableRows.forEach(row => {
						const rowDate = row.getAttribute("data-date"); // Get date data from table
						const [datePart, timePart] = rowDate.split(" ");

						if (datePart === date) {
							row.style.display = "";
						}
						else {
							row.style.display = "none";
						}
					});
				}

				// Initial filter on page load (defaults to today)
				filterRowsByDate(dateFilter.val());

				// Filter again on user input
				dateFilter.on("change", () => {
					filterRowsByDate(dateFilter.val());
				});
			}
		});
    </script>

  </body>
</html>
var pagination = true;
var jsBatchName = "";
var jsCoacheeName = "";
var jsCoachName = "";
var jsSupervisorName = "";
$(function() {
	
	jsBatchName = $("#jsBatchName").val();
	jsCoacheeName = $("#jsCoacheeName").val();
	jsCoachName = $("#jsCoachName").val();
	jsSupervisorName = $("#jsSupervisorName").val();
	
	$("#coachingGoalTableActive").DataTable({
		"ordering": false,
		"paging": true,
		"info": true,
		"lengthChange": true,
		"searching": true,
		"autoWidth": false,
		"responsive": true,
		"drawCallback": function(settings) {
			if (pagination) {
				$('#coachingGoalTableActive_paginate').find(".pagination").append('<li class="paginate_button page-item"><a onclick="loadNextSetValues()" id="loadMore_coachingGoalTableActive" class="fa fa-arrow-right page-link" href="#" title="Load More"></a></li>');
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
			title:"Coaching Goals for Batch: "+jsBatchName+" - Coachee: "+jsCoacheeName+"\nCoach: "+jsCoachName+" - Supervisor : "+jsSupervisorName,
			orientation: 'portrait',
			customize: function (doc) {
				var now = new Date();
				var jsDate = now.getDate()+'-'+(now.getMonth()+1)+'-'+now.getFullYear();
				var logo = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOAAAAAhCAMAAAD3R1fCAAAB8lBMVEVHcEwANUkALj8AkcgASmYAb5kApuQAKzsARV4ANUgAre0Aot4Are0AO1EAKDYAWnwApuQAKTgAru8Aq+oAdaAAWXoAre4AsvUAPFIAjMAAe6gApOIAl9EAqekAot8Ag7UAsPEAo98AbJQAot8Am9UATmsAW30AsvQAn9oAfKoAT20Aq+sASmUAS2cAe6gAo+AAqegAkccAPVMAp+YAg7QAMEIAgrIAgbEAjsQAi78ARV8ARmAAibwAbpcAapIAls4AtPcArO0AndcAqOYAcZoAYoYAmtMAMkYAiLwAgLAAkcYAYYUAntkAkcgAd6IAg7MAYocAVHQAX4MAYocAd6MAlc0AkMUARF0Ad6QAhrkAqegAp+YAru8Aq+oAsPIAWXsAcJoAUnEAn9sAXoEAWXkARmEAir0ASmYAGyUAdaAAr/AAM0YAiLsAg7MApOEAnNYAa5MAj8UAfKsAfKoAnNYAb5kATGgApeIAYIQAXH8AksgAfa0Ah7oAsfMAgrMAcZsAot4AsvUAmNEAWXoAm9UAl88AZowAkskAkccAtvoAdqMAjcEAeqcAh7oApuQAhrkAlMsAru8AsPIAr/AAtfkAtPcAsfQAr/EAsPEAs/YAtfgArvAAsvUAtvoAt/sAsvQAru8Auf4At/wAs/UAuP0AvP+lRbl5AAAAkXRSTlMAJgjPAg7kAQUL+d/7LxZe6A/u8xxn/fs1s5nw1PHbPfvXbtPaPEX32Ckw+CcbkOX1vRTfoxmLllmlQSKqeV+//fbO7IJoyB1XOW830spoqz01TkqGyrQWfrfj1eno/RNWSt4rUjeeRiB58ytQnujVZVGJdLF0K91WY8E9kfOzl8jp0CTCuHOro/E1vk+/9GjIA5ZG/gAAB5lJREFUGBnlwHlXE+cCBvAHGk2CIEZbEdpQSgW4rKIgl4Igm9wWryuK112tWq3WfT3dF+1++8w7M5mZZCbHgN/zJu87M0mmes79s5z+8Pf3l7Ln4juB7tb3O5AYPdna2rqh7OTpb6ZSWLtS+1ZzPlOzz/RhodXTKgnSm0hg7Vo+ZTNkv7cRNWdWGPFiFGtYw2yOIX0qiQ+6TEa82IM17GqTxpD7PIZGJ8NqovAEr1VbU/IP3zmUJRoaGrb5kvD9/GHRu0U/x6Bcelc69IG0E2V9d27cuPEv6dc4lJFG6a235rdhubGx8clboQMflZy/hIjbBcGQtxuYKzBCa7qK10gO1fX27uitU5quoGxyr6BPH4CyeFZkS2gMxSFduG5li6gZdtGLSYRixxwtoD+G0vJSV15OYuClXimnmUW5+u/Po9qSk2Ug610DrniMMK9vw6uNFSxN0yyh2PviCNR22yLjM+v7ID23mZWMx5AaNueYLaHk7Eao084ykOtOoKSmTqOU216bHDT5CiKfu/8mqkzoDGXsx0g8dRlh71rAq9z1WCmT7kfgqM0yfRglDW0ZSvlbCZQsPLJZyX6KULPBMnceJS0eFe8B5nW+htNag0q13xsMaV2d2NhtMMKZSeHP2gtZVsl3IjBksEy09aDoS5eKcw0lqX0Oq2izO+G71CZYlm9NAqipsyhp6X7M5OjLFTzPsY0cA8b+JCqNbLAZyp9+iE/P5BjhHa9F1OO9Fqs57fD1tAlWMI4DONwmKFnpfhQlml1WE6IHvhadldw9AFo8KvowOvJZKrljX3311ejnn0/lM/R5e1ClZ7PJkPFoBFe7NEas3kRER5dJRctQMa7AN+GwktA6gQmdijOBkpYClWw+S8VphNK/RWMl87OdWNiiURJaB4Z1KqLtIZQDWwWVle0JVDnSlGFI35fCE08wojCHKn0nc1Ty7w9alHLvxCCNT1ussncKPW0ZSuLsYRSd8LKUhPm8N0tJb4FyQme1whxaPCr291hIa1SMXxC46VCxdvSj2gFHMOQdT2DuBSNEYR4Vdr7nULEfLY8ZlKzecUh3dfpMQck+elOnYvyBokY9QynrLMUumpRy38ZQUrshT0XkKGmzF97WqOhPsOTR5xxF4JAmKImtPYjY7bJsdRQYLjDCarqAUHLIpZKfvYRrOhXjCEpSgyYVrXs6yxLtsy2CijMJ4GqXRqUwDDQblLR0P0puO1REb7NGSewQVMzBZG2rSWXlVgyBN6cFpUzvOCLiwwbLCifitUM5RuS/6EBgzKOiXT8EHLGpuM9Q8qxAJVPXN2ZQ0gQVbdM5oGFzjorXHAMGXEpZaxFFsf05Kk5zcoNJyaLPHcBjnT69HaGerYKStn4dopJnLIYyL7ahpivDCGcGvrseFdF1BMDCtEXJOYii2lsrVJwxXD4rWMW5CyzssqmYUwkARwwqxgEUXbCzlMTZDjzQWcWaHseQQUVLLyPUrlOxh/AnS00sWx2tTTSvMEL74hCUdk9QsedGPvnkk5ruPCXzYi2Aj3UqVm8fcNBlpUz9d0h9bVCx0kcOLy4unq8XlIwxFDU7VPRmIHnRZCWnGYfzgoo+gFDsmE3FnURUuyMYsn+MY3SVEWbXVSiP91oMvP37jh07fq/PUsrUfQfEfzGo6AMALp8VrGA0I9GsM1C/VWSFYCA/EwcOt2UoWXUPATxwWck+ilGdimjrQ+iZQyU/mELE0SaLIe9+As88wWpa23koHV0mQ5ZWwkC+EzhkU9HS/Sj60mUF5yhGCywTEn3a7DlgWKeiX0FRcjDPslx3Ymdao+IcRCD5UZOg4jUiomezyZDzNImPXYvVxMt5KH0nV/hazglgzKDizqHkcluGoZVvcc2lks2EBBVhdmA8rVGypsdRcs9gmd6Odp0+7Z0v/yP99lurKajoBxEx8shmaOXUTmy7brKaMPZA2XjLoZI3tYCpUbF/wHidRcnctAzpoMuQ1/ixnqEkzK1KXV3dVkFFf4ATLhV9AFJyvcmAll5ObM8xYOo+R6PP/jqFaskphyGjdQELu2xGuLuhJKd0KvbMP5U7d+7c2G9SMgdjSzqVQjuk+IdNDGgbJq9rlLLetQalpqamI21R0g8m15uUrPQIlHs2A3oLOm2+nmnfX4eIH12G8psuIbXPYYRxE0psYjVjlWRWWvtRNuoKSavvnLVNybmYhO8HR7OU3MwmO2OVaO4SAnGg281J3rcPCpqyegK+1GeGaUiOfhlDnqaYRoRtr6y/F0fEnMuQ+dNlxCcKjDDux6EsGfV1Uv2uh6hw+4stSrr5bV/6NgKLg5tCs5vWSyc/R6WB1u3Ksafv+fYtI3Dg1P43lGEsz7zv2/9G6N/SseP/PYeoSVcwoE13AncLjHCmkvBta/i0RjmHSrVvhjYGUJZKrfsTVInV+pLJhC+GskQsrgCJRCwQD+G1OrssBqy954F5V7Ba/ut1+P/F8ZfSdybPQMabBy7stVjNPtWPNWvjfoMBYd8DPt1sslp+8DusWYkfXIZe3AVGug1WM79ZxJoVu+IypLcAqT9cWplK+elDWLsO/LTZd/r0N89jiO3+6fSZ9aFdJb/ib+V/NUXzv6YMwMQAAAAASUVORK5CYII=';
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
	}).buttons().container().appendTo('#coachingGoalTableActive_wrapper .col-md-6:eq(0)');

	var coachingGoalTableActive = $("#coachingGoalTableActive").DataTable();
	var loadAll = window.location.href.split("all").length;
	if(coachingGoalTableActive.rows().count() < 20 || loadAll > 1) {
		$("#loadMore_coachingGoalTableActive").hide();
		pagination = false;
	}
	
	
	$("#coachingGoalTableInActive").DataTable({
		"ordering": false,
		"paging": true,
		"info": true,
		"lengthChange": true,
		"searching": true,
		"autoWidth": false,
		"responsive": true,
		"drawCallback": function(settings) {
			if (pagination) {
				$('#coachingGoalTableInActive_paginate').find(".pagination").append('<li class="paginate_button page-item"><a onclick="loadNextSetValues()" id="loadMore_coachingGoalTableInActive" class="fa fa-arrow-right page-link" href="#" title="Load More"></a></li>');
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
			title:"Coaching Goals (In-Active) for Batch: "+jsBatchName+" - Coachee: "+jsCoacheeName+" - Coach: "+jsCoachName+" - Supervisor : "+jsSupervisorName,
			orientation: 'portrait',
			customize: function (doc) {
				var now = new Date();
				var jsDate = now.getDate()+'-'+(now.getMonth()+1)+'-'+now.getFullYear();
				var logo = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOAAAAAhCAMAAAD3R1fCAAAB8lBMVEVHcEwANUkALj8AkcgASmYAb5kApuQAKzsARV4ANUgAre0Aot4Are0AO1EAKDYAWnwApuQAKTgAru8Aq+oAdaAAWXoAre4AsvUAPFIAjMAAe6gApOIAl9EAqekAot8Ag7UAsPEAo98AbJQAot8Am9UATmsAW30AsvQAn9oAfKoAT20Aq+sASmUAS2cAe6gAo+AAqegAkccAPVMAp+YAg7QAMEIAgrIAgbEAjsQAi78ARV8ARmAAibwAbpcAapIAls4AtPcArO0AndcAqOYAcZoAYoYAmtMAMkYAiLwAgLAAkcYAYYUAntkAkcgAd6IAg7MAYocAVHQAX4MAYocAd6MAlc0AkMUARF0Ad6QAhrkAqegAp+YAru8Aq+oAsPIAWXsAcJoAUnEAn9sAXoEAWXkARmEAir0ASmYAGyUAdaAAr/AAM0YAiLsAg7MApOEAnNYAa5MAj8UAfKsAfKoAnNYAb5kATGgApeIAYIQAXH8AksgAfa0Ah7oAsfMAgrMAcZsAot4AsvUAmNEAWXoAm9UAl88AZowAkskAkccAtvoAdqMAjcEAeqcAh7oApuQAhrkAlMsAru8AsPIAr/AAtfkAtPcAsfQAr/EAsPEAs/YAtfgArvAAsvUAtvoAt/sAsvQAru8Auf4At/wAs/UAuP0AvP+lRbl5AAAAkXRSTlMAJgjPAg7kAQUL+d/7LxZe6A/u8xxn/fs1s5nw1PHbPfvXbtPaPEX32Ckw+CcbkOX1vRTfoxmLllmlQSKqeV+//fbO7IJoyB1XOW830spoqz01TkqGyrQWfrfj1eno/RNWSt4rUjeeRiB58ytQnujVZVGJdLF0K91WY8E9kfOzl8jp0CTCuHOro/E1vk+/9GjIA5ZG/gAAB5lJREFUGBnlwHlXE+cCBvAHGk2CIEZbEdpQSgW4rKIgl4Igm9wWryuK112tWq3WfT3dF+1++8w7M5mZZCbHgN/zJu87M0mmes79s5z+8Pf3l7Ln4juB7tb3O5AYPdna2rqh7OTpb6ZSWLtS+1ZzPlOzz/RhodXTKgnSm0hg7Vo+ZTNkv7cRNWdWGPFiFGtYw2yOIX0qiQ+6TEa82IM17GqTxpD7PIZGJ8NqovAEr1VbU/IP3zmUJRoaGrb5kvD9/GHRu0U/x6Bcelc69IG0E2V9d27cuPEv6dc4lJFG6a235rdhubGx8clboQMflZy/hIjbBcGQtxuYKzBCa7qK10gO1fX27uitU5quoGxyr6BPH4CyeFZkS2gMxSFduG5li6gZdtGLSYRixxwtoD+G0vJSV15OYuClXimnmUW5+u/Po9qSk2Ug610DrniMMK9vw6uNFSxN0yyh2PviCNR22yLjM+v7ID23mZWMx5AaNueYLaHk7Eao084ykOtOoKSmTqOU216bHDT5CiKfu/8mqkzoDGXsx0g8dRlh71rAq9z1WCmT7kfgqM0yfRglDW0ZSvlbCZQsPLJZyX6KULPBMnceJS0eFe8B5nW+htNag0q13xsMaV2d2NhtMMKZSeHP2gtZVsl3IjBksEy09aDoS5eKcw0lqX0Oq2izO+G71CZYlm9NAqipsyhp6X7M5OjLFTzPsY0cA8b+JCqNbLAZyp9+iE/P5BjhHa9F1OO9Fqs57fD1tAlWMI4DONwmKFnpfhQlml1WE6IHvhadldw9AFo8KvowOvJZKrljX3311ejnn0/lM/R5e1ClZ7PJkPFoBFe7NEas3kRER5dJRctQMa7AN+GwktA6gQmdijOBkpYClWw+S8VphNK/RWMl87OdWNiiURJaB4Z1KqLtIZQDWwWVle0JVDnSlGFI35fCE08wojCHKn0nc1Ty7w9alHLvxCCNT1ussncKPW0ZSuLsYRSd8LKUhPm8N0tJb4FyQme1whxaPCr291hIa1SMXxC46VCxdvSj2gFHMOQdT2DuBSNEYR4Vdr7nULEfLY8ZlKzecUh3dfpMQck+elOnYvyBokY9QynrLMUumpRy38ZQUrshT0XkKGmzF97WqOhPsOTR5xxF4JAmKImtPYjY7bJsdRQYLjDCarqAUHLIpZKfvYRrOhXjCEpSgyYVrXs6yxLtsy2CijMJ4GqXRqUwDDQblLR0P0puO1REb7NGSewQVMzBZG2rSWXlVgyBN6cFpUzvOCLiwwbLCifitUM5RuS/6EBgzKOiXT8EHLGpuM9Q8qxAJVPXN2ZQ0gQVbdM5oGFzjorXHAMGXEpZaxFFsf05Kk5zcoNJyaLPHcBjnT69HaGerYKStn4dopJnLIYyL7ahpivDCGcGvrseFdF1BMDCtEXJOYii2lsrVJwxXD4rWMW5CyzssqmYUwkARwwqxgEUXbCzlMTZDjzQWcWaHseQQUVLLyPUrlOxh/AnS00sWx2tTTSvMEL74hCUdk9QsedGPvnkk5ruPCXzYi2Aj3UqVm8fcNBlpUz9d0h9bVCx0kcOLy4unq8XlIwxFDU7VPRmIHnRZCWnGYfzgoo+gFDsmE3FnURUuyMYsn+MY3SVEWbXVSiP91oMvP37jh07fq/PUsrUfQfEfzGo6AMALp8VrGA0I9GsM1C/VWSFYCA/EwcOt2UoWXUPATxwWck+ilGdimjrQ+iZQyU/mELE0SaLIe9+As88wWpa23koHV0mQ5ZWwkC+EzhkU9HS/Sj60mUF5yhGCywTEn3a7DlgWKeiX0FRcjDPslx3Ymdao+IcRCD5UZOg4jUiomezyZDzNImPXYvVxMt5KH0nV/hazglgzKDizqHkcluGoZVvcc2lks2EBBVhdmA8rVGypsdRcs9gmd6Odp0+7Z0v/yP99lurKajoBxEx8shmaOXUTmy7brKaMPZA2XjLoZI3tYCpUbF/wHidRcnctAzpoMuQ1/ixnqEkzK1KXV3dVkFFf4ATLhV9AFJyvcmAll5ObM8xYOo+R6PP/jqFaskphyGjdQELu2xGuLuhJKd0KvbMP5U7d+7c2G9SMgdjSzqVQjuk+IdNDGgbJq9rlLLetQalpqamI21R0g8m15uUrPQIlHs2A3oLOm2+nmnfX4eIH12G8psuIbXPYYRxE0psYjVjlWRWWvtRNuoKSavvnLVNybmYhO8HR7OU3MwmO2OVaO4SAnGg281J3rcPCpqyegK+1GeGaUiOfhlDnqaYRoRtr6y/F0fEnMuQ+dNlxCcKjDDux6EsGfV1Uv2uh6hw+4stSrr5bV/6NgKLg5tCs5vWSyc/R6WB1u3Ksafv+fYtI3Dg1P43lGEsz7zv2/9G6N/SseP/PYeoSVcwoE13AncLjHCmkvBta/i0RjmHSrVvhjYGUJZKrfsTVInV+pLJhC+GskQsrgCJRCwQD+G1OrssBqy954F5V7Ba/ut1+P/F8ZfSdybPQMabBy7stVjNPtWPNWvjfoMBYd8DPt1sslp+8DusWYkfXIZe3AVGug1WM79ZxJoVu+IypLcAqT9cWplK+elDWLsO/LTZd/r0N89jiO3+6fSZ9aFdJb/ib+V/NUXzv6YMwMQAAAAASUVORK5CYII=';
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
	}).buttons().container().appendTo('#coachingGoalTableInActive_wrapper .col-md-6:eq(0)');

	var coachingGoalTableInActive = $("#coachingGoalTableInActive").DataTable();
	var loadAll = window.location.href.split("all").length;
	if(coachingGoalTableInActive.rows().count() < 20 || loadAll > 1) {
		$("#loadMore_coachingGoalTableInActive").hide();
		pagination = false;
	}
});
function loadNextSetValues() {
	var coachingGoalTableActive = $("#coachingGoalTableActive").DataTable();
	var offsetValue = coachingGoalTableActive.rows().count();
	$('body').addClass('disableClickBody');
	$(".package-loader").hide();
	$.ajax({
		url:'emc-loadMoreBatch',
		type:'GET',
		data:{'offsetValue':offsetValue},
		dataType : 'json',
		success: function(result) {
			for(var i=0; i<result.length; i++) {
				coachingGoalTableActive.row.add([
					result[i]["batchAction"],result[i]["batchName"],
					result[i]["batchDescription"],result[i]["batchActive"],
					result[i]["batchCreatedBy"],result[i]["batchCreatedOn"],
					result[i]["batchUpdatedBy"],result[i]["batchUpdatedOn"]
				]);
			}
			coachingGoalTableActive.draw(false);
			var currentPage = coachingGoalTableActive.page.info().page;
			var totalPages = coachingGoalTableActive.page.info().pages;
			console.log(totalPages);
			if(totalPages > 1) {
				if(currentPage != (totalPages-1)) {
					coachingGoalTableActive.page(currentPage+1).draw(false);
				}
			}
			$("#coachingGoalTableActive_paginate").scroll();
			$('#coachingGoalTableActive_paginate').show();
			if(result.length < 20) {
				pagination = false;
				$('#loadMore_coachingGoalTableActive').hide();
			}
			$('body').removeClass('disableClickBody');
			$(".anand-loader").hide();
		},
		error:function() {
			$('#coachingGoalTableActive_paginate').show();
			$('body').removeClass('disableClickBody');
			$(".anand-loader").hide();
			alert("Something went wrong, kindly try again after sometime.");
		}
	});
}
function editGoal(actCoacheeGoalsId) {
	$('body').addClass('disableClickBody');
	$(".package-loader").hide();
	$(".editCoachingBatch").hide();
	$.ajax({
		url: 'emc-getCoacheeGoalDetails',
		type: 'GET',
		data: { 'actCoacheeGoalsId': actCoacheeGoalsId },
		dataType: 'json',
		success: function(result) {
			$("#actCoacheeGoalsId").val(actCoacheeGoalsId);
			$("#coachingGoal").val(result["goalName"]);
			$("#coachingGoalDescription").val(result["goalDescription"]);
			if(result["goalActive"] == "1") {
				$("#coachingGoalActive1").prop("checked", true);
			} else {
				$("#coachingGoalActive2").prop("checked", true);
			}
			$('body').removeClass('disableClickBody');
			$(".anand-loader").hide();
			$('html, body').animate({
		        scrollTop: $(".card-footer").offset().top
		    }, 800);
		},
		error: function() {
			alert("Something went wrong, try again later");
		}
	});
}



$("#coachingGoals").submit(function () {

    $("#submitCoachingGoalButton").addClass("disabledButton");
    $('body').addClass('disableClickBody');
    $(".package-loader").hide();

    var submitOrNot = true;

    if (coachingGoalValidation() == false) {
        submitOrNot = false;
    }
    if (coachingGoalDescriptionValidation() == false) {
        submitOrNot = false;
    }
    if (coachingGoalActiveValidation() == false) {
        submitOrNot = false;
    }

    if (submitOrNot) {
        $("#submitCoachingGoalButton").removeClass("disabledButton");
        $('body').removeClass('disableClickBody');
        $(".package-loader").hide();
        return true;
    } else {
        $("#submitCoachingGoalButton").removeClass("disabledButton");
        $('body').removeClass('disableClickBody');
        $(".package-loader").hide();
        return false;
    }
});


$("#coachingGoal").focusout(function () {
    coachingGoalValidation();
});

$("#coachingGoalDescription").focusout(function () {
    coachingGoalDescriptionValidation();
});

$("input[name='coachingGoalActive']").change(function () {
    coachingGoalActiveValidation();
});

function coachingGoalValidation() {

    $("#coachingGoal").removeClass("is-valid is-invalid");
    $("#coachingGoalError").show().html("");

    var goal = $("#coachingGoal").val().trim();

    if (goal !== "") {
        $("#coachingGoal").addClass("is-valid");
        return true;
    } else {
        $("#coachingGoal").addClass("is-invalid");
        $("#coachingGoalError").html("Mentoring Goal is required");
        return false;
    }
}



function coachingGoalDescriptionValidation() {

    $("#coachingGoalDescription").removeClass("is-valid is-invalid");
    $("#coachingGoalDescriptionError").show().html("");

    var desc = $("#coachingGoalDescription").val().trim();

    if (desc !== "") {
        $("#coachingGoalDescription").addClass("is-valid");
        return true;
    } else {
        $("#coachingGoalDescription").addClass("is-invalid");
        $("#coachingGoalDescriptionError").html("Goal Description is required");
        return false;
    }
}



function coachingGoalActiveValidation() {

    $("#isActiveError").show().html("");

    var active = $("input[name='coachingGoalActive']:checked").val();

    if (active) {
        return true;
    } else {
        $("#isActiveError").html("Please select Active or Inactive");
        return false;
    }
}



document.addEventListener("DOMContentLoaded", function () {
    const urlParams = new URLSearchParams(window.location.search);
    const batchId = urlParams.get('batch-id');
    const coacheeId = urlParams.get('coachee-id');

    // Step 1: Check if submitted answers exist
    fetch(`getSubmittedAnswers?batchId=${batchId}&coacheeId=${coacheeId}`)
        .then(response => response.json())
        .then(data => {
            const container = document.getElementById("question-container");
            container.innerHTML = ""; // Clear container
			if (data.length > 0 && data.some(item => item.answer)) {
				let qNo = 1;
				data.forEach(item => {
					const questionHTML = `
						<div class="row mb-4">
							<div class="col-md-6 fw-bold text-dark" style="font-size: 18px;">${qNo++}. ${item.question}</div>
							<div class="col-md-6">
								<div class="submitted-answer-box" style="
									background-color: #f8f9fa;
									padding: 12px 16px;
									border-radius: 8px;
									min-height: 120px;
									white-space: pre-wrap;
									font-size: 16px;
									width: 100%;
									box-sizing: border-box;
									border: 1px solid #ced4da;
								">
									${item.answer || "No answer submitted"}
								</div>
							</div>
						</div>
					`;
					container.insertAdjacentHTML("beforeend", questionHTML);
				});
			}
			 else {
                // If no answers submitted, show input form
                fetch(`emcQuestion?batchId=${batchId}&coacheeId=${coacheeId}`)
                    .then(response => response.json())
                    .then(data => {
                        let questionNumber = 1;
                        data.forEach(question => {
                            const questionHTML = `
                                <div class="question mb-4">
                                    <div class="row align-items-start">
                                        <div class="col-md-6">
                                            <p class="fw-bold text-dark" style="font-size: 18px;">
                                                ${questionNumber++}. ${question.question}
                                            </p>
                                        </div>
                                        <div class="col-md-6">
                                            <textarea class="form-control"
                                                      name="response_${question.questionId}"
                                                      data-question-id="${question.questionId}"
                                                      rows="5"
                                                      placeholder="Your answer...">${question.answer || ''}</textarea>
                                        </div>
                                    </div>
                                </div>
                            `;
                            container.insertAdjacentHTML("beforeend", questionHTML);
                        });

                        document.getElementById("submit-btn").style.display = 'block';
                    });
            }
        })
        .catch(error => {
            console.error("Failed to fetch submitted answers", error);
        });

    // Submit button logic (unchanged)
    document.getElementById("submit-btn").addEventListener("click", function () {
        const answerElements = document.querySelectorAll("textarea[data-question-id]");
        const answers = [];

        answerElements.forEach(el => {
            answers.push({
                questionId: el.getAttribute("data-question-id"),
                answer: el.value.trim(),
                coacheeId: coacheeId
            });
        });

        fetch("submitAnswers", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                batchId: batchId,
                coacheeId: coacheeId,
                answers: answers
            })
        })
        .then(response => {
            if (response.ok) {
                alert("Answers submitted successfully!");
                window.location.reload();
            } else {
                alert("Something went wrong while submitting answers.");
            }
        })
        .catch(error => {
            console.error("Error submitting answers:", error);
            alert("Error submitting answers.");
        });
    });
});


  function openDownloadModal(batchId, coacheeId) {
    const modal = new bootstrap.Modal(document.getElementById('downloadModal'));
    const fileList = document.getElementById('fileList');
    fileList.innerHTML = '<li class="list-group-item">Loading files...</li>';

    console.log("Batch ID:", batchId);
    console.log("Coachee ID:", coacheeId);

    // Use dynamic values
    fetch(`get-documents?batchId=${encodeURIComponent(batchId)}&coacheeId=${encodeURIComponent(coacheeId)}`)
      .then(response => {
        if (!response.ok) throw new Error("Failed to fetch files");
        return response.json();
      })
      .then(files => {
        if (files.length === 0) {
          fileList.innerHTML = '<li class="list-group-item text-danger">No files found.</li>';
        } else {
          fileList.innerHTML = '';
          files.forEach(file => {
            const li = document.createElement('li');
            li.className = 'list-group-item d-flex justify-content-between align-items-center';
            li.innerHTML = `
              <span>${file.fileName}</span>
              <a class="btn btn-sm btn-outline-primary" href="${file.downloadUrl}" download>Download</a>
            `;
            fileList.appendChild(li);
          });
        }
        modal.show();
      })
      .catch(err => {
        fileList.innerHTML = `<li class="list-group-item text-danger">Error loading files: ${err.message}</li>`;
        modal.show();
      });
  }

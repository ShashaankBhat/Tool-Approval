<!-- jQuery -->
	<script src="usedStaticFiles/essentials/js/jQuery/jquery.min.js"></script>
	<!-- Common JS File -->
	<script src="usedStaticFiles/essentials/js/package.js"></script>
	<!-- Bootstrap 4 -->
	<script src="usedStaticFiles/essentials/js/bootstrap/bootstrap.bundle.min.js"></script>
	<script src="usedStaticFiles/essentials/js/select2.full.min.js"></script>
	<!-- AdminLTE App -->
	<script src="usedStaticFiles/essentials/js/adminlte/adminlte.min.js"></script>
	<!-- Dashboard & Internal Page Loader -->
	<script src="usedStaticFiles/essentials/js/pace.min.js"></script>
	<!-- Sweet Alerts -->
	<script src="usedStaticFiles/essentials/sweetalert/sweetalert2.min.js"></script>
	<script>
	/* $("body").addClass("layout-footer-fixed text-sm"); */
	var holidays = [];
	function noSundaysOrHolidays(date) {
			var day = date.getDay();
			if (day != 0) {
				var d = date.getDate();
				var m = date.getMonth();
				var y = date.getFullYear();
				m = m + 1;
				for (i = 0; i < holidays.length; i++) {
					var currDate = d+"/";
					if(m < 10 ) { currDate += "0"+m;} 
					else { currDate += ""+m; }
					currDate += "/"+y;
					if($.inArray(currDate, holidays) != -1) {
						return [false];
					}
				}
				return [true];
			} else {
				return [day != 0, ''];
			}
		}
		function DisableDates(date) {
			return noSundaysOrHolidays(date);
		}
		</script>
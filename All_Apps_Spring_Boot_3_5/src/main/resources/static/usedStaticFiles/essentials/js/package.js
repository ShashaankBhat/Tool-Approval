/**
 * 
 */
var roleNameCheck = /^[a-zA-Z ]*$/;
var centralNumericOnly = /^\d+$/;
var onlyAlphabetCheck = /^[A-ZÁ& ]*$/;
var centralAlphaNumericCheck = /^[ A-Za-z0-9-Á& ]*$/;
var centralAlphaNumericCheckWithHifen = /^[ A-Za-z0-9-Á&-]*$/;
var centralAlphaNumericDescriptionCheck = /^[ A-Za-z0-9-Á.&;:/"',-]*$/;
var centralTextCheck = /^[ A-Za-z0-9.&\r\n;:/"',-]*$/;
var checkPointDescription = /^[ A-Za-z0-9.&\r\n;:/"'+,-]*$/;
var centralEmailFormat = /^[A-Z0-9._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
var centralPasswordValidation = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{6,15}$/;
var urlCheck = /^(https?:\/\/)?([\w-]+\.)+[\w-]+(\/[\w-]*)+([\w-]+\.)*$/;
var width = screen.width;
if(width > 860) {
	/* $(".full-name").show();
	$(".short-name").hide(); */
	$(".full-name").show();
	$(".short-name").hide();
} else {
	$(".full-name").hide();
	$(".short-name").show();
}
/** ************************** */
/* Disable Right Click on Tool */
var url = window.location.href;
if(url.includes("localhost") || url.includes("172.16")) {
	
} else {
	/*document.body.style.zoom = "100%";*/
	$(document).contextmenu(function() {
		return false;
	});
	document.onkeydown = function(e) {
	    if (e.ctrlKey && e.keyCode === 85) {
	        return false;
	    } else {
	        return true;
	    }
	};
    $(window).on("orientationchange", function(event) {
    	//reloadPage();
    });
    $(window).resize(function(){
    	//reloadPage();
    });
}
/** ************************** */
var myVar = setInterval(checkForBodyClass, 300);
function checkForBodyClass() {
	if($('body').attr('class').includes("pace-done")) {
		clearInterval(myVar);
		$(".package-loader").hide();
	}
}
function reloadPage() {
	location.reload();
}
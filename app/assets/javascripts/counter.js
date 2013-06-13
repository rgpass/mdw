// This code is turned off because when combining it with
// preview.js, either the preview code works or the counter
// will work. I believe it's because some of the pages do
// not have .countdown or #user_name
// Until I know more about jQuery, I will just make the
// username popover tell the user how long their name
// can be.
// When trying to get it to work, try adding the
// .countdown class and #user_name id to random div's or
// span's to see if it will work.

function updateCountdown() {
	// 30 is the max message length
	var remaining = 30 - jQuery('#user_name').val().length;
	jQuery('.countdown').text(remaining + ' characters remaining');
}

jQuery(document).ready(function($) {
	updateCountdown();
	$('#user_name').change(updateCountdown);
	$('#user_name').keyup(updateCountdown);
});
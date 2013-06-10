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

$(document).ready(function() {
	$('#usernametip').popover({trigger: 'hover'});
});

$(document).ready(function() {
	$('#passwordtip').popover({trigger: 'hover'});
});

$(document).ready(function() {
	$('#confirmationtip').popover({trigger: 'hover'});
});
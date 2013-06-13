function updateNewPreview() {
	// Works:
	// var textiletext = "Markdown *rocks*.";
	var textiletext = jQuery('#newstuff').val().toString();
	var converter = new Showdown.converter();
	var htmltext = converter.makeHtml(textiletext);
	jQuery('#newpreview').html(htmltext);
}

jQuery(document).ready(function($) {
	updateNewPreview();
	$('#newstuff').change(updateNewPreview);
	$('#newstuff').keyup(updateNewPreview);
});
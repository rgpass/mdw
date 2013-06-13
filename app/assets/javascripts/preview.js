function updatePreview() {
	// Works:
	// var textiletext = "Markdown *rocks*.";
	var textiletext = jQuery('#stuff').val().toString();
	var converter = new Showdown.converter();
	var htmltext = converter.makeHtml(textiletext);
	jQuery('#preview').html(htmltext);
}

jQuery(document).ready(function($) {
	updatePreview();
	$('#stuff').change(updatePreview);
	$('#stuff').keyup(updatePreview);
});
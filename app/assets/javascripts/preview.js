function updatePreview() {
	// Works:
	// var textiletext = "Markdown *rocks*.";
	var title = jQuery('#post_title').val().toString();
	var textiletext = jQuery('#post_content').val().toString();
	var converter = new Showdown.converter();
	var htmltext = converter.makeHtml(textiletext);
	jQuery('#preview').html(htmltext);
	jQuery('#title').text(title);
}

jQuery(document).ready(function($) {
	updatePreview();
	$('#post_title').change(updatePreview);
	$('#post_title').keyup(updatePreview);
	$('#post_content').change(updatePreview);
	$('#post_content').keyup(updatePreview);
});
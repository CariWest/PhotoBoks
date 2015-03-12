var NEW_ALBUM_URL = '/albums/new'
var POST_NEW_ALBUM = '/albums'

var addAlbum = function(event) {
  request = $('.content').on('click', '#new_album_form', function(event) {
    event.preventDefault();
    if($('#new-album-form').length > 0) return

    var request = $.ajax({
      url: NEW_ALBUM_URL,
      type: 'get'
    });

    request.done(function(data) {
      $(data.form).insertAfter('.banner')
      controller = new AlbumCollection('#new-album-form')
    });
  });
}

var addClickEvent = function(listeningEvent, targetURL, callback) {
  request = $('.content').on('click', listeningEvent, function(event) {
    event.preventDefault();

    if ($(listeningEvent).length > 0) return

    var request = $.ajax({
      url: targetURL,
      type: 'get'
    });

    callback(request);
  });
}

var newAlbumEvent = function(request) {
  request.done(function() {
    $(data.form).insertAfter('.banner')
    controller = new AlbumCollection('#new-album-form')
  })
}


$(document).ready(function() {

});
var winning = function() {
  console.log("winning")
}

var NEW_ALBUM_URL = '/albums/new'

var Album = function(title, cover) {
  this.title = title;
  this.cover = cover;
  // removed album tag for now... should add that in asap
}

Album.prototype.buildAlbumElement = function(albumName, albumCover) {
  // removed albumTag from this for now...
  var albumTemplate = $.trim($('#album_template').html());
  var $album = $(albumTemplate);
  $album.find('img').attr('src', albumCover);
  // $album.find('.tag').html(albumTag)
  $album.find('h2').text(albumName);
  return $album;
}

Album.View = function() {

}

$(document).ready(function() {

  $('.new-album').on('click', function(event) {
    event.preventDefault();

    var request = $.ajax({
      url: NEW_ALBUM_URL,
      type: 'get'
    });

    request.done( function(data) {
      $(data.form).insertAfter('.welcome'); // should abstract this away.
    });

    request.fail( function(data) {
      console.log("new album form fails to appear")
    });
  });




});


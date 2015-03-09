var winning = function() {
  console.log("winning")
}

var NEW_ALBUM_URL = '/albums/new'

var Album = function(title, cover) {
  this.title = title;
  this.cover = cover;
  // removed album tag for now... should add that in asap
}

Album.prototype.buildAlbum = function(albumName, albumCover) {
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
    })

    winning();

    request.done( function(data) {
      console.log(data)
      // $(data).insertAfter('.welcome');
    })

    // debugger

    // go to the post route
    // get the form
    // pass the form back as a json object

    // when this default is clicked, I want a form to appear above this div so that a user can create an album.
  })




});


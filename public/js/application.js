var winning = function() {
  console.log("winning")
}

var NEW_ALBUM_URL = '/albums/new'

var Album = function(title, tag, cover) {
  this.title = title;
  this.tag = tag;
  this.cover = cover;
}

Album.prototype.buildAlbumElement = function(albumName, albumTag, albumCover) {
  var albumTemplate = $.trim($('#album_template').html());
  var $album = $(albumTemplate);
  $album.find('img').attr('src', albumCover);
  $album.find('.tag').html(albumTag)
  $album.find('h2').text(albumName);
  return $album;
}

// Album.View = function() {

// }


AlbumCollection = function(formSelector) {
  debugger
  this.view = new AlbumCollection.View(formSelector);
  this.isListening = false;
  this.listenForNewAlbums();
  this.albums = [];
}

AlbumCollection.prototype.listenForNewAlbums = function() {
  if (this.isListening) return;
  this.isListening = true;
  this.view.createNewAlbumListener(this.makeNewAlbum.bind(this));
}

AlbumCollection.prototype.makeNewAlbum = function(event) {
  event.preventDefault();
  var album = Album.create(
    this.view.$elt.find('.title'),
    this.view.$elt.find('.tag'),
    this.view.$elt.find('.cover')
  );

  this.albums.push(album); // still need to do something with the album we've created after this to add it to the page
}

AlbumCollection.View = function(formSelector) {
  this.$elt = $(formSelector);
}

AlbumCollection.View.prototype = createNewAlbumListener = function(callback) {
  $this.getMakeAlbumButton.on('click', callback);
}

AlbumCollection.View.getMakeAlbumButton = function() {
  return this.$elt.find('#create-album')
}

// controller
$(document).ready(function() {

  $('.new-album').on('click', function(event) {
    event.preventDefault();

    var request = $.ajax({
      url: NEW_ALBUM_URL,
      type: 'get'
    });

    request.done( function(data) {
      $(data.form).insertAfter('.welcome'); // should abstract this jquery away...
      var controller = new AlbumCollection('#new-album-form');
    });

    request.fail( function(data) {
      console.log("new album form fails to appear");
    });
  });

});
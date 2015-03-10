var winning = function() {
  console.log("winning")
}

var NEW_ALBUM_URL = '/albums/new'
var POST_NEW_ALBUM = '/albums'

var Album = function(title, tag) {
  this.title = title;
  this.tag = tag;
  this.view = new Album.View(this)
}

Album.create = function(title, tag) {
  var request = $.ajax({
    url: POST_NEW_ALBUM,
    method: 'post',
    data: {
      title: title,
      tag: tag
    }
  });

  request.done( function(serverData) {
    winning();
    var album = {
      albumName: serverData.albumName,
      albumTag: serverData.albumTag,
      albumCover: serverData.albumCover
    }

    debugger
    $album = buildAlbumElement(album);
    $('.all-albums').prepend($album)
  });

  request.fail( function() {
    console.log('creating album fails');
  });
}

Album.View = function() {}

// would love to attach this to the view, but it wasn't working?
var buildAlbumElement = function(albumItem) {
  var albumTemplate = $.trim($('#album-template').html());
  var $album = $(albumTemplate);
  $album.find('img').attr('src', albumItem.albumCover);
  $album.find('.tag').html(albumItem.albumTag)
  $album.find('h2').text(albumItem.albumName);
  return $album
}

AlbumCollection = function(formSelector) {
  this.view = new AlbumCollection.View(formSelector);
  this.isListening = false;
  this.listenForNewAlbums();
  this.albums = [];
}

AlbumCollection.prototype.listenForNewAlbums = function() {
  if (this.isListening) return;
  this.isListening = true;
  this.view.createNewAlbumListener(this.makeNewAlbum.bind(this)); // undefined is not a function...
}

AlbumCollection.prototype.makeNewAlbum = function() {
  var album = Album.create(
    this.view.$elt.find('.title').val(),
    this.view.$elt.find('.tag').val()
  );

  this.albums.push(album); // still need to do something with the album we've created after this to add it to the page
}

AlbumCollection.View = function(formSelector) {
  this.$elt = $(formSelector);
}

AlbumCollection.View.prototype.createNewAlbumListener = function(callback) {
  this.$elt.on('click', '#create-album', function(event) {
    event.preventDefault();
    callback();
  });
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
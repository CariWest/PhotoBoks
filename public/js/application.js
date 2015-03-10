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

  // i would like to refactor this method so it's more straightforward
  // would probably mean refactoring the buildAlbumElement method to be incorporated into the view?
  request.done( function(serverData) {
    console.log(serverData);
    var album = {
      albumName: serverData.albumName,
      albumTag: serverData.albumTag,
      albumCover: serverData.albumCover,
      albumId: serverData.albumId
    }

    $album = buildAlbumElement(album);
    $('.all-albums').prepend($album)

    // remove the add albums from the page
    $('#new-album-form').remove();
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

  var album_url = '/albums/' + albumItem.albumId
  debugger
  $album.attr('href', album_url),
  $album.find('.album').attr('id', albumItem.albumId);
  $album.find('img').attr('src', albumItem.albumCover);
  $album.find('.album-title').text(albumItem.albumName);
  $album.find('.album-title').append('<span> ' + albumItem.albumTag + '</span>')
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
  this.view.createNewAlbumListener(this.makeNewAlbum.bind(this));
}

AlbumCollection.prototype.makeNewAlbum = function() {
  var album = Album.create(
    this.view.$elt.find('.title').val(),
    this.view.$elt.find('.tag').val()
  );

  this.albums.push(album); // still need to do something with the album we've created after this to add it to the page?
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

  var controller;

  // could abstract this away a little better...?... UGH.
  $('.new-album').on('click', function(event) {
    event.preventDefault();

    var request = $.ajax({
      url: NEW_ALBUM_URL,
      type: 'get'
    });

    request.done( function(data) {
      $(data.form).insertAfter('.welcome'); // should abstract this jquery away...
      controller = new AlbumCollection('#new-album-form');
    });

    request.fail( function(data) {
      console.log("new album form fails to appear");
    });
  });

  $('.delete').on('click', function(event) {
    event.preventDefault();

    if (confirm("Are you sure you want to delete?")) {
      var request = $.ajax({
        url: $(this).attr('href'),
        type: 'delete'
      });

      request.done( function(data) {
        location.href="/user";
      });

      request.fail( function(data) {
        console.log("delete fails");
      });
    }
  });


});

// when page loads, should I be creating a collection of albums which already exist?
// it would make sense, so that I would have access to the albums which already exist...
var Album = function(title, tag) {
  this.title = title;
  this.tag = tag
}

Album.View = function() {

}

$(document).ready(function() {

  $('.new-album').on('click', function(event) {
    event.preventDefault();
    console.log("winning");

    // debugger

    $('.create-album-form').insertAfter('.welcome')
    // when this default is clicked, I want a form to appear above this div so that a user can create an album.
  })




});

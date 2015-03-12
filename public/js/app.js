// would love to get this closer to a one page app by not redirecting to a new page when a partial is rendered

var getSingleAlbum = function(targetAlbum) {

}

$(document).ready(function() {

  $('.content').on('click', '.picture', function(){
    var pictures = getAlbumPictures();
    // get rid of current content
    // get the album's pictures
    // render the album partial repeatedly on that page
  });

})
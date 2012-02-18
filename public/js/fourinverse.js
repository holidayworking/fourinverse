(function() {
  var error, success;

  success = function(position) {
    var _this = this;
    return $.get("/photos.json?ll=" + position.coords.latitude + "," + position.coords.longitude, null, function(venues) {
      return $('#thumbnailTemplate').tmpl(venues).appendTo('ul.thumbnails');
    });
  };

  error = function(msg) {
    return alert(msg);
  };

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(success, error);
  } else {
    error('not supported');
  }

}).call(this);

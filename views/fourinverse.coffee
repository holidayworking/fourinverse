success = (position) ->
    $.get("/photos.json?ll=#{position.coords.latitude},#{position.coords.longitude}", null, (venues) =>
        $('#thumbnailTemplate').tmpl(venues).appendTo('ul.thumbnails'))

error = (msg) -> alert(msg)

if navigator.geolocation
    navigator.geolocation.getCurrentPosition(success, error)
else
    error('not supported')

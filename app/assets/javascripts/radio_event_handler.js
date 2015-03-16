//This is an event handler function to test if both radio buttons have been clicked without a submit buttom, hopefully it can be used to trigger our api call to echonest?

$(function(){
   //test if a genre and mood button are clicked
  $('body').on('click', function(e){
  //grab all radio buttons that are checked
  var checkedBoxes = $(':checked')
  //if there is only 1 checked do nothing, otherwise...
  if (checkedBoxes.length === 2){
    //grab the values of the genre and mood radios that are checked
    var genre = $('#genres-list input:checked').val();
    var mood = $('#moods-list input:checked').val();
    console.log(genre, mood);

    $.ajax({
      url:      '/',
      type:     'get',
      dataType: 'json',
      data:     {mood: mood, genre: genre}
    }).done(function(data){
      $('.music-player').children().remove();
      var src = "https://embed.spotify.com/?uri=" + data.songs

      var spotifyPlayer = $('<iframe>');
      spotifyPlayer.attr('src', src).attr('frameborder', 0).attr('allowtransparency', true);
      $('.music-player').append(spotifyPlayer);
    })
  }
 })
})

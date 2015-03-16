//listens for the enter button to be pressed wth a zip code

$(function(){
  $('input#location').on('keydown', function(e){
    //only works if key pressed is enter
    if (e.keyCode === 13){
      //get value of field
      var zipCode = this.value;
      //ajax to our server for validation
      $.ajax({
        method: 'POST',
        url: '/zip_weather',
        dataType: 'json',
        //send data down in params format
        data: {zip_code: zipCode},
        success: function(data){
          console.log(data)
          $('#moods-list').children().remove();
          $('#genres-list').children().remove();
          var weatherData = data;
          weather(weatherData);
          renderMoods(moods);
          renderGenres(genres);
        }
      });
    }
  });
});

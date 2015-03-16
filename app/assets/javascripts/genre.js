var genres = ["Rock", "Pop", "R&B", "Hiphop", "Indie/Alternative", "EDM", "Country", "Jazz", "Classical"]

function renderGenres(ary){
 $(ary).each(function(){

   //create a label element with a button id based on genre
  var label = $('<label for = "'+ this + '_button"> '+ this + '</label>')
  //create a radiobutton  with a button with a value of genre
  var radioBox  = $('<input type= "radio" id = "'+ this + '_button"  name = "genre" value= "'+ this + '">')

   //Add button to list
   $('#genres-list').append(label).append(radioBox);

 });
}




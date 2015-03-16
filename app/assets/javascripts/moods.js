// moods array to create buttons from
var moods = ['Party', 'Lively', 'Passionate', 'Reflective', 'Trippy', 'Happy', 'Sad', 'Soothing'];

function renderMoods(ary){
 $(ary).each(function(){

  //create a label element with a button id based on mood
  var label = $('<label for = "'+ this + '_button"> '+ this + '</label>')
  //create a radiobutton  with a button with a value of genre

  var radioBox  = $('<input type= "radio" class="mood" id = "'+ this + '_button"  name = "mood" value= "'+ this + '">')
  //add button to list
  $('#moods-list').append(label).append(radioBox);

 });
}


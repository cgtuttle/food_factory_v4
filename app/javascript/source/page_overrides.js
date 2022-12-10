const ready = function () {

  // Remove the Back link from any page with an element that includes the class "no-back-link" (usually the top element of the pacge).
  var noBackLink = document.querySelector(".hide-back-link");
  if(noBackLink){
    var backLink = document.getElementById("back-link");
    backLink.remove();
  }

};

$(document).on('turbolinks:load', ready);
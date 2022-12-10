const ready = function() {
     $("#flash-alert").delay(2000).fadeOut(1000);
     return console.log("Ran flash-alert");
   };


$(document).on('turbolinks:load', ready);
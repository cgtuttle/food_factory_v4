const ready = function() {
  $('i.fa-caret-down').on("click", function() {
    $(this).toggleClass("fa-caret-down fa-caret-up")
  });
};

$(document).on('turbolinks:load', ready);
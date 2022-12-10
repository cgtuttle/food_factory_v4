export function accordionMenu() {

  console.log("Running accordion_menu.js")

  $("[id$=logout-confirm-link]").on("click", function () {
    console.log("logout-path-link clicked, removing activeAccordionGroup");
    sessionStorage.removeItem('activeAccordionGroup');
  });

  $("#new-company-session").on("click", function () {
    console.log("new-company-session clicked, removing activeAccordionGroup");
    sessionStorage.removeItem('activeAccordionGroup');
  });

  $("#accordion-menu").on('shown.bs.collapse', function() {
    var active=$("#accordion-menu .show").attr('id');
    console.log("active: "+active)
    sessionStorage.setItem('activeAccordionGroup', active)
  });

  $("#accordion-menu").on('hidden.bs.collapse', function () {
    sessionStorage.removeItem('activeAccordionGroup');
  });

  var last = sessionStorage.getItem('activeAccordionGroup');

  if (last != null) {
    $("#" + last).addClass("show");
  }

};
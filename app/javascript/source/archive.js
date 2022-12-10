function filterItemLotsList(){
  var itemLots = $('#transaction-item-lot').html();
  var locations = $('#transaction-location').html();

  $('#transaction-item').change(function(){
    console.log("Running transaction-item changed function")
    var selectedItem = $('#transaction-item :selected').text();
    var optgroup = "optgroup[label='" + selectedItem + "']";
    var ItemLotOptions = $(itemLots).filter(optgroup).html();
    var LocationOptions = $(locations).filter(optgroup).html();
    var collSelect = $('#transaction-item-lot');
    collSelect.html(ItemLotOptions);
    var promptText = "Please select (if available)"

    if(selectedItem != "Please select"){
      collSelect.prepend($('<option>',{ // Add to the beginning of the list
        value: 999,
        text: promptText
      }));
      collSelect.val('999');
      $("#item-dependent-controls").css("display", "block");
    } else { // Set the options back to the original values if "Please Select" is selected
      collSelect.html(itemLots);
      $("#item-dependent-controls").css("display", "none");
    }

    collSelect = $('#transaction-location')
    collSelect.html(LocationOptions);
  });
}
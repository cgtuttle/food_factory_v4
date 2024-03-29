import { setInputMethod } from '../source/inventory_item_lots'

export function inventoryTransactionDisplay(){

  resetForm();
  selectTransactionItem();
  focusItemTransactionLot();
  changeSelectedItem();
  addNewLot();
  cancelNewLot();
  selectType();
  updateQuantities();
  test();

  function resetForm(){    
    console.log("running resetForm - reseting");
    $("#inventory_transaction_table_form").trigger("reset");
    $("#inv-trans-index-subform").collapse.hide;
  }

  function test(){
  }

  function selectTransactionItem(){
    var itemSelect = $("[id^=inv-trans-form-item-select]");
    var lotSelect = $("[id^=inv-trans-form-item-lot-select]")
    itemSelect.on("change", function(){
      var itemId = itemSelect.val();
      console.log("inv-trans-form-item-select changed to " + itemId);
      lotLookup(itemId, lotSelect);      
    })
  }

  function focusItemTransactionLot(){
    var itemSelect = $("#inv-item-trans-form-item-lot-select")
    itemSelect.on("focus", function(){
      var itemId = gon.item_id;
      console.log("inv-item-trans-form-item-select changed to " + itemId);
      lotLookup(itemId, itemSelect);      
    })
  }

  function lotLookup(itemId, selector){
    var lotSelect = $(selector)
    console.log("Running lotLookup");
    console.log("itemId = " + itemId);
    $.ajax({
      url: "/inventory/items/" + itemId + "/lots_lookups",
      success: function(data){
        lotSelect.children().remove();
        var listItems = [];
        listItems += '<option value="blank">...</option>'
        listItems += '<option value="new">New...</option>'
        $.each(data,function(key, value) {
          listItems += '<option value="' + value.id + '">' + value.lot_code + '</option>';
        }); 
        lotSelect.append(listItems);
        console.log("listItems: " + listItems);
      },
      error: function(data){} 
    })
  }

  function changeSelectedItem(){ // Choose new item in search bar
    var itemSearchSelect = $("#transaction-item-search-select");
    itemSearchSelect.on("change", function(){
      console.log("transaction-item-search-select changed to " + $("#transaction-item-search-select").val());
      var item_id = $("#transaction-item-search-select").val();
      var urlString = '/inventory/items/' + item_id + '/transactions';
      location.href = urlString; // reload page
    })
  }

  function addNewLot(){
    var lotSelect = $("[id^=inv-trans-form-item-lot-select]");
    console.log("Running addNewLot");
    lotSelect.on("change", function(){
      console.log("Running addNewLot on change");
      console.log("lotSelect.val(): " + lotSelect.val());
      var selected = lotSelect.val();
      if(selected == "new"){
        console.log("Lot select New... selected");
        $('[id^=inv-trans-index-subform]').collapse('show');
      } else {
        $('[id^=inv-trans-index-subform]').collapse('hide');
      }
    })
  }

  function cancelNewLot(){
    var cancelButton = $("#inventory-transaction-new-lot-cancel")
    cancelButton.on("click", function(){
      $('[id^=inv-trans-index-subform]').collapse('hide');
      $('[id^=inv-trans-form-item-lot-select]').val('blank');
    })

  }

  function selectType(){
    console.log("Running selectType");
  }

  function updateQuantities(){
    console.log("Running updateQuantities");
    var changeInput = $('.inv-trans-form-change');
    changeInput.on("change", function(){
      var itemId = $("#inv-trans-form-item-select").val();
      var lotId = $("#new-transaction-form-item-lot-select").val();
      var transDate = $('#inv-transaction-date').val();      
      var changeIncrInput = $('#inv-trans-form-incr');
      var changeDecrInput = $('#inv-trans-form-decr');
      var incr = changeIncrInput.val();
      var decr = changeDecrInput.val();
      incr = (incr == "") ? 0 : incr;
      decr = (decr == "") ? 0 : decr;
      $('#inv-trans-form-incr').val(incr);
      $('#inv-trans-form-decr').val(decr);
      var change = incr - decr;
      console.log("change: " + change);
      $('#inv-trans-form-net-change').val(change.toString());
      $.ajax({
        url: "../inventory/transactions/" + itemId + "/" + lotId + "/" + transDate,
        success: function(data){
          console.log("url: ../inventory/transactions/" + itemId + "/" + lotId + "/" + transDate)
          var item_balance = data[0] + change;
          var item_lot_balance = data[1] + change;
          console.log("item balance: " + item_balance);
          console.log("item lot balance: " + item_lot_balance);
          $('#inv-trans-form-lot-balance').val(item_lot_balance);
          $('#inv-trans-form-item-balance').val(item_balance);          
        },
        error: function(data){}
      });
    })
  }

}

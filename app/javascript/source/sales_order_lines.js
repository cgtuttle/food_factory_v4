const ready = function() {  

  $('#order-lines').on('cocoon:after-insert', function(e, added_line) {
    resequence();
  });

  $('#order-lines').on('cocoon:after-remove', function() {
    resequence();
  });

  const resequence = function() {
    console.log("Resequencing...");
    var row = 0
    $('#order-lines').children("tr").each(function(index) {
      if($( this ).is(":visible")){
        row +=  1;
       $( this ).children('th').first().children('input').first().val(row);
      }
    });
  }

  $('#order-lines').on('change', 'select.sales-order-item', function() {
    var myId = $( this ).attr('id')
    var itemList = $('#inv_item_list').data('items')
    var element_id = $( this ).val()
    $.each(itemList, function(i, item){
      if (item.id == element_id) {
        $('#' + myId.replace('_item_id', '_description')).val(item.name);
        return false;
      }
    });
  });

  $('#order-lines').on('change', 'input.order-line-po-qty', function() {
    var myId = $( this ).attr('id')
    var po_price = $('#' + myId.replace('_po_qty', '_po_price')).val()
    var line_total = $( this ).val() * po_price
    $('#' + myId.replace('_po_qty', '_line_total')).val(line_total);
  });

  $('#order-lines').on('change', 'input.order-line-po-price', function() {
    var myId = $( this ).attr('id')
    var po_qty = $('#' + myId.replace('_po_price', '_po_qty')).val()
    var line_total = $( this ).val() * po_qty
    $('#' + myId.replace('_po_price', '_line_total')).val(line_total);
  });

};


$(document).on('turbolinks:load', ready);
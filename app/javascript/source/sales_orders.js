export function orderForm(){
  setSelectOptions();

  function setSelectOptions(){
    var customerSelect = $(".order-customer");
    var shipToSelect = $(".order-ship-to");
    customerSelect.on("change", function(){
      var customerAcctId = customerSelect.val();
      $.ajax({
        url: "../../customers/" + customerAcctId + "/address_lookups",
        success: function(data){
          shipToSelect.children().remove();
          var listItems = [];
          $.each(data,function(key, value) {
            listItems += '<option value="' + value.id + '">' + value.name + '</option>'; 
          }); 
          shipToSelect.append(listItems);
        },
        error: function(data){}
      })
    });
  }
}
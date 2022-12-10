export function setInputMethod(){

  console.log("Running setInputMethod");
  console.log("gon.item_lot_formats: " + gon.item_lot_format);

  var lotFormat = gon.item_lot_format;

  $(".item-lot-text-group").css('display', 'none');
  $(".item-lot-date-group").css('display', 'none');

  switch (lotFormat) {
    case 'Date':
      $(".item-lot-date-group").css('display', 'block');
    break;

    case 'Text':
      $(".item-lot-text-group").css('display', 'block');
    break;
    
  }

}

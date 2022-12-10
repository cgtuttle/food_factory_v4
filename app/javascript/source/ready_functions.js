import { hello } from '../source/test_hello';
import { sideBar } from '../source/sidebar';
import { accordionMenu } from '../source/accordion_menu';
import { inventoryTransactionDisplay } from '../source/inventory_transactions';
import { filterOnField } from '../source/filter';
import { orderForm } from '../source/sales_orders';
import { tooltip } from '../source/tooltips';

const ready = function() {
  console.log("Running ready");
  hello("World");

  accordionMenu();
  inventoryTransactionDisplay();
  sideBar();
  orderForm();
  tooltip();
  // filterOnField();
}


$(document).on('turbolinks:load', ready);
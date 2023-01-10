// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
require("jquery-ui")

import $ from 'jquery'
window.jQuery = $;
window.$ = $;

require("bootstrap")
require("@fortawesome/fontawesome-free")
require("source/ready_functions")
require("source/flash_alert")
require("source/tooltips")
require("source/inventory_transactions")
require("source/inventory_item_lots")
require("source/sales_order_lines")
require("source/sidebar")
require("source/accordion_menu")
require("source/page_overrides")
require("source/test_hello")
require("source/collapse")
require("data-confirm-modal")

require("cocoon")



// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


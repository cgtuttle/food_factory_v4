Rails.application.routes.draw do

  scope path: "inventory", module: "inventory" do
    resources :items, as: "items" do
      resources :item_locations, path: "locations", as: "locations", only: [:index, :new, :create]
      resources :products, path: "products", as: "products", only: [:index, :new, :create]
      resources :item_lots, path: "lots", as: "lots", only: [:index, :new, :create]
      resources :item_transactions, path: "transactions", as: "transactions", only: [:index, :new, :create]
      resources :lots_lookups, only: [:index, :create]
    end
    resources :item_locations, as: "item_locations", only: [:destroy, :edit, :update, :show]
    resources :products, as: "products"
    resources :item_lots, as: "item_lots", only: [:destroy, :edit, :update, :show] do
      resources :item_lot_transactions, path: "transactions", as: "transactions", only: [:index, :new, :create]
    end
    resources :item_classes, as: "item_classes"
    resources :locations, as: "locations"
    resources :receipts, as: "receipts" do
      resources :receipt_items, path: "items", as: "items", only: [:index, :new, :create]
    end
    resources :receipt_items, path: "receipt_items", as: "receipt_items", only: [:show, :edit, :update, :destroy]
    resources :shipments, as: "shipments" do
      resources :shipment_items, path: "items", as: "items", only: [:index, :new, :create]
    end
    resources :shipment_items, path: "shipment_items", only: [:show, :edit, :update, :destroy]
    resources :transactions, path: "transactions", as: "transactions"
    resources :transaction_types, as: "transaction_types"
    get 'transactions/:item_id/:lot_id/:transaction_date', to: 'transactions#balances'
  end

  scope module: "purchases" do
    resources :orders, path: "purchases/orders", as: "purchase_orders" do
      resources :order_lines, path: "lines", as: "lines", only: [:index, :new, :create]
    end
    resources :order_lines, path: "purchases/order_lines", as: "purchase_order_lines", only: [:show, :edit, :update, :destroy]
    resources :vendors, path: "vendors" do
      resources :orders, only: [:index, :new, :create]
    end
  end

  scope module: "sales" do
    resources :orders, path: "sales/orders", as: "sales_orders" do
      resources :order_lines, path: "lines", as: "lines", only: [:index, :new, :create]
    end
    resources :order_lines, path: "sales/order_lines", only: [:show, :edit, :update, :destroy]
    resources :customers do
      resources :orders, only: [:index, :new, :create]
      resources :addresses
      resources :address_lookups, only: [:index]
    end
  end

  scope module: "settings" do
    resources :accounts, path: "settings/accounts"
    resources :units, path: "settings/units"
    resources :addresses, path: "settings/addresses"
    resources :address_types, path: "settings/address_types"
    resources :filters, path: "settings/filters" do
      resources :columns, path: "settings/columns", only: [:index, :new, :create]
    end
    resources :columns, path: "settings/columns", only: [:show, :edit, :update, :destroy]
  end

  scope module: "security" do
    resources :users, path: "security/users" do
      resources :user_companies, path: "companies", as: "companies", only: [:index, :new, :create]
    end
    resources :user_sessions, only: [:new, :create, :destroy]
    resources :company_sessions, only: [:new, :create, :destroy]
    resources :companies, path: "security/companies"
    resources :user_companies, path: "security/user_companies", as: "user_companies", only: [:show, :edit, :update, :destroy]
  end


  delete '/logout', to: 'security/user_sessions#destroy', as: :logout
  get '/login', to: 'portal#welcome', as: :login

  get '/dashboard', to: 'dashboard#show', as: :dashboard
  get 'portal/welcome', as: 'welcome'

  get '/open_company', to: 'security/company_sessions#new', as: :open_company

  root 'portal#welcome'  

end
class DefaultShippingStatusToFalseForOrderitems < ActiveRecord::Migration[5.2]
  def change
    change_column :order_items, :shipping_status, :boolean, :default => false
  end
end

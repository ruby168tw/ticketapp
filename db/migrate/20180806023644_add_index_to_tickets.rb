class AddIndexToTickets < ActiveRecord::Migration[5.2]
  def change
    add_index :tickets, :category_id
    add_index :tickets, :member_id
  end
end

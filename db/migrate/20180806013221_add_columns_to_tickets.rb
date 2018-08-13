class AddColumnsToTickets < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :category, :string
    add_column :tickets, :member_id, :integer
    add_column :tickets, :category_id, :integer
  end
end

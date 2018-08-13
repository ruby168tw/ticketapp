class RemoveColumnInTickets < ActiveRecord::Migration[5.2]
  def change
    remove_column :tickets, :category
  end
end

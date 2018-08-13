class ChangeColumnMemberIdInTickets < ActiveRecord::Migration[5.2]
  def change
    change_column :tickets, :member_id, :integer
  end
end

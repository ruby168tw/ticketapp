class RenameColumnMemberIdInTickets < ActiveRecord::Migration[5.2]
  def change
    rename_column :tickets, :member_id, :m_code
  end
end

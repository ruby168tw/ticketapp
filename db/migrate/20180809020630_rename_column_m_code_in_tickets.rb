class RenameColumnMCodeInTickets < ActiveRecord::Migration[5.2]
  def change
    rename_column :tickets, :m_code, :member_id
  end
end

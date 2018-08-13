class ChangeColumnMCodeInTickets < ActiveRecord::Migration[5.2]
  def change
    change_column :tickets, :m_code, :string
  end
end

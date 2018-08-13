class AddColumnToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :m_code, :string
  end
end

class RemoveColumnMCodeFromMembers < ActiveRecord::Migration[5.2]
  def change
    remove_column :members, :m_code
  end
end

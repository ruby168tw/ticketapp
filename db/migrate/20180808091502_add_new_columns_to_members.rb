class AddNewColumnsToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :account, :string
    add_column :members, :password, :string
    add_column :members, :token, :string
  end
end

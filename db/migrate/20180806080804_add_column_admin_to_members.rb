class AddColumnAdminToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :admin, :string
  end
end

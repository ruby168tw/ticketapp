class ChangeColumnInMembers < ActiveRecord::Migration[5.2]
  def change
    change_column :members, :admin, :boolean, :default => false
  end
end

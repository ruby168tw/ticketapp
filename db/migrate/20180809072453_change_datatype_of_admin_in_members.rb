class ChangeDatatypeOfAdminInMembers < ActiveRecord::Migration[5.2]
  def change
    change_column :members, :admin, :string
  end
end

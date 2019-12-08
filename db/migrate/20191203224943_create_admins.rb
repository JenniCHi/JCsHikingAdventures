class CreateAdmins < ActiveRecord::Migration[5.0]
  def change
    create_table :admins do |t|
      t.integer :admin_id
      t.integer :admin_code

      t.timestamps
    end
  end
end

class AddSecurityFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.datetime :password_changed_at
      t.datetime :last_activity_at
      t.datetime :expired_at
    end
    create_table :old_passwords do |t|
      t.string :encrypted_password, null: false
      t.string :password_archivable_type, null: false
      t.integer :password_archivable_id, null: false
      t.string :password_salt # Optional. bcrypt stores the salt in the encrypted password field so this column may not be necessary.
      t.datetime :created_at
    end
    add_index :old_passwords, [:password_archivable_type, :password_archivable_id], name: 'index_password_archivable'
    add_index :users, :password_changed_at
  end
end

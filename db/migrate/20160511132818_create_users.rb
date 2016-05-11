class CreateUsers < ActiveRecord::Migration
  def change
    create_users_table
    add_user_indexes
  end

  def create_users_table
    create_table 'users', force: true do |t|
      t.string 'first_name',                               null: false
      t.string 'last_name',                                null: false
      t.string 'email',                                    null: false
      t.string 'password_digest',                          null: false
      t.string 'seed',                                     null: false
      t.string 'reset_password_token'
      t.string 'session_token'
      t.string 'signon_token'
      t.datetime 'last_sign_in_at'
      t.string 'last_sign_in_ip'
      t.integer 'sign_in_count',        default: 0,        null: false
      t.timestamps                                         null: false
    end
  end

  def add_user_indexes
    add_index 'users', ['email'], name: 'index_users_on_email', unique: true
    add_index 'users', ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
    add_index 'users', ['session_token'], name: 'index_users_on_session_token', unique: true
    add_index 'users', ['signon_token'], name: 'index_users_on_signon_token', unique: true
  end
end

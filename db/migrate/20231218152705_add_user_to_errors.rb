class AddUserToErrors < ActiveRecord::Migration[6.1]
  def change
    add_reference :errors, :user, null: false, foreign_key: true
  end
end

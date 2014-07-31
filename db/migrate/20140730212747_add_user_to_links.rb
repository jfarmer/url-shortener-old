class AddUserToLinks < ActiveRecord::Migration
  def change
    change_table :links do |t|
      t.references :user, index: true
    end
  end
end

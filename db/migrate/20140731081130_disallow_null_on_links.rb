class DisallowNullOnLinks < ActiveRecord::Migration
  def change
    change_column :links, :url,         :string,   { null: false }
    change_column :links, :short_name,  :string,   { null: false }
    change_column :links, :created_at,  :datetime, { null: false }
    change_column :links, :updated_at,  :datetime, { null: false }
  end
end

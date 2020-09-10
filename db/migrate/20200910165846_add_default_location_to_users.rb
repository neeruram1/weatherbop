class AddDefaultLocationToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :default_location, :string, default: "nil"
  end
end

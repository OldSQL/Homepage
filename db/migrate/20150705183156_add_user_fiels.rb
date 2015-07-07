class AddUserFiels < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :articles, :date, :date
  end
end

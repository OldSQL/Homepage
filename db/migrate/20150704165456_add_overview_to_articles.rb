class AddOverviewToArticles < ActiveRecord::Migration
  def change
  	add_column :articles, :overview, :string
  end
end

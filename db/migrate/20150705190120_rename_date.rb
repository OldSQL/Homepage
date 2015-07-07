class RenameDate < ActiveRecord::Migration
  def change
    change_table :articles do |t|
      t.rename :date, :written_on
    end
  end
end

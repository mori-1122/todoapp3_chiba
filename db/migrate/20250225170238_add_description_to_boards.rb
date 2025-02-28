class AddDescriptionToBoards < ActiveRecord::Migration[7.1]
  def change
    add_column :boards, :description, :text
  end
end

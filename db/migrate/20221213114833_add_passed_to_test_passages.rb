class AddPassedToTestPassages < ActiveRecord::Migration[7.0]
  def change
    add_column :test_passages, :passed, :boolean, default: false
  end
end

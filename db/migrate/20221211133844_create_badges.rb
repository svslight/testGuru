class CreateBadges < ActiveRecord::Migration[7.0]
  def change
    create_table :badges do |t|
      t.string :title, null: false, unique: true
      t.string :image, null: false
      t.string :rule_type, default: ''
      t.string :rule_value, default: ''

      t.timestamps
    end
  end
end

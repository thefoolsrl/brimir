class CreateLabels < ActiveRecord::Migration[4.2]
  def change
    create_table :labels do |t|
      t.string :name

      t.timestamps
    end
  end
end

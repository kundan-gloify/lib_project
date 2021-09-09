class CreateLibraries < ActiveRecord::Migration[5.0]
  def change
    create_table :libraries do |t|
      t.string :name
      t.time :opening_time
      t.time :closing_time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

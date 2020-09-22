class CreateInterviews < ActiveRecord::Migration[5.1]
  def change
    create_table :interviews do |t|
      t.integer :id1
      t.integer :id2
      t.datetime :st_time
      t.datetime :en_time

      t.timestamps
    end
  end
end

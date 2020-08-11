class CreateInterventions < ActiveRecord::Migration[5.2]
  def change
    create_table :interventions do |t|
      t.bigint :author_id, index: true, foreign_key: { to_table: :employees }, :null => false
      t.references :customer, foreign_key: true, :null => false
      t.references :building, foreign_key: true, :null => false
      t.references :battery, foreign_key: true, :null => true
      t.references :column, foreign_key: true, :null => true
      t.references :elevator, foreign_key: true, :null =>true
      t.references :employee, foreign_key: true, :null => true
      t.datetime :start_intervention, :null => true
      t.datetime :end_intervention, :null => true
      t.string :result, :default=>"incomplete",:null => true
      t.string :rapport, :null => true
      t.string :status, :default =>"pending"

      t.timestamps
    end
  end
end

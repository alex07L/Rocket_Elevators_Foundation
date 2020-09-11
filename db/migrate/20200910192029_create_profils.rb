class CreateProfils < ActiveRecord::Migration[5.2]
  def change
    create_table :profils do |t|
      t.string :voice
      t.string :fullName
      t.bool :enrolled, default: false

      t.timestamps
    end
  end
end

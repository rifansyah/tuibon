class CreateTwibbons < ActiveRecord::Migration[5.2]
  def change
    create_table :twibbons do |t|
      t.string :title

      t.timestamps
    end
  end
end

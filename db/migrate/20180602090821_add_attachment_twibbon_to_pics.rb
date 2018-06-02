class AddAttachmentTwibbonToPics < ActiveRecord::Migration[5.2]
  def self.up
    change_table :pics do |t|
      t.attachment :twibbon
    end
  end

  def self.down
    remove_attachment :pics, :twibbon
  end
end

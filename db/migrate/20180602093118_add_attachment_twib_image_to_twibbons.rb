class AddAttachmentTwibImageToTwibbons < ActiveRecord::Migration[5.2]
  def self.up
    change_table :twibbons do |t|
      t.attachment :twib_image
    end
  end

  def self.down
    remove_attachment :twibbons, :twib_image
  end
end

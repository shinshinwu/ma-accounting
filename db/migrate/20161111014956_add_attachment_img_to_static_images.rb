class AddAttachmentImgToStaticImages < ActiveRecord::Migration
  def self.up
    change_table :static_images do |t|
      t.attachment :img
    end
  end

  def self.down
    remove_attachment :static_images, :img
  end
end

class StaticImage < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  validates :imageable_id, :presence => true
  validates :imageable_type, :presence => true

  has_attached_file :img,
  styles: {
    large: "1000x1000>",
    medium:  "500x500>"
  }

  validates_attachment_presence :img
  validates_attachment_content_type :img, :content_type => ['image/gif', 'image/pjpeg', 'image/jpeg', 'image/png']
  validates_attachment_size :img, :less_than => 2.megabytes

end

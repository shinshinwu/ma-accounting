class DocumentFile < ActiveRecord::Base
  belongs_to :documentable, polymorphic: true

  validates :documentable_id, :presence => true
  validates :documentable_type, :presence => true

  has_attached_file :doc

  validates_attachment_presence :doc
  validates_attachment_content_type :doc, :content_type => ["application/pdf"]
  validates_attachment_size :doc, :less_than => 10.megabytes

end

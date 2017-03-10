class SupportingMaterial < ActiveRecord::Base
  belongs_to :course_module, inverse_of: :supporting_materials
  has_one :image, as: :imageable, class_name: 'StaticImage', dependent: :destroy

  has_one :document, as: :documentable, class_name: 'DocumentFile', dependent: :destroy
end

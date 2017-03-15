class ZipCodeDetail < ActiveRecord::Base
  belongs_to :zipcode, class_name: 'ZipCode', primary_key: 'zip_code', foreign_key: 'zip_code'

  after_initialize :readonly!
end

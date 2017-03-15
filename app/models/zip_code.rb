class ZipCode < ActiveRecord::Base
  has_one :zip_code_detail,       -> { readonly(true) }, foreign_key: :zip_code, primary_key: :zip_code
end

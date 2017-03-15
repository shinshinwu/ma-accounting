class Member < ActiveRecord::Base

  def nickname
    if first_name.present? && first_name.size > 1
      first_name
    else
      "there"
    end
  end
end

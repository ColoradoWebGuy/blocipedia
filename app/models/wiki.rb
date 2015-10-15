class Wiki < ActiveRecord::Base
  belongs_to :user

  scope :visible_to, -> (user) {
    if user
      if (user.admin? || user.premium?)
        all
      else
        where(private: false)
      end
    else
      where(private: false)
    end
  }

end

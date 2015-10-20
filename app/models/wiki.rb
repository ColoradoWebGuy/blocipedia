class Wiki < ActiveRecord::Base
  belongs_to :user

  has_many :collaborators
  has_many :users, through: :collaborators


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

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :nom, type: String
  field :email, type: String

  validates :nom, presence: true,
                   length: { maximum: 50 }
  validates :email, presence: true,
                    format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }, 
                    uniqueness: { case_sensitive: false }
  
  index({ email: 1 }, { unique: true })

end

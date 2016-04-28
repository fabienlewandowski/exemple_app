class User
  include Mongoid::Document
  include Mongoid::Timestamps
  devise :database_authenticatable

  ## Database authenticatable
  field :encrypted_password, :type => String, :default => ""

  attr_accessor :password

  field :nom, type: String
  field :email, type: String
  field :salt, type: String

  validates :nom, presence: true,
                   length: { maximum: 50 }
  validates :email, presence: true,
                    format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }, 
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true,
                       confirmation: true,
                       length: { within: 6..40 }
  
  index({ email: 1 }, { unique: true })

  before_save :encrypt_password

  def has_password?(password_soumis)
    encrypted_password == encrypt(password_soumis)
  end

  def self.authenticate(email, submitted_password)
    user = find_by(email: email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  private

    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

end

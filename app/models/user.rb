class User < ApplicationRecord

  has_secure_password

  validates :password, presence: true, on: :create
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password_confirmation, presence: true, if: -> {
    password.present?
  }, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email.downcase.strip)

    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

end

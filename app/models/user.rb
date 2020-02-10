class User < ApplicationRecord
  has_many :articles, dependent: :destroy

  # before data is saved, let's set it so that emails
  # are always saved in lowercase.
  before_save { self.email = email.downcase}

  validates :username, presence: true, uniqueness: { case_sensitive: false},
             length: {minimum: 3, maximum: 25}

  # we validate our email using regex
  VALID_EMAIL_REGEX= /\w*\@\w*\.\w*/
  validates :email, presence: true, length: {maximum: 105},
            uniqueness: {case_sensitive: false},
            format: {with: VALID_EMAIL_REGEX}

  has_secure_password

end

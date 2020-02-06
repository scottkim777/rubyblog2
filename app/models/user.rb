class User < ApplicationRecord
  validates :username, presence: true, uniqueness: { case_sensitive: false},
             length: {minimum: 3, maximum: 25}
             
  # we validate our email using regex
  VALID_EMAIL_REGEX= /\w*\@\w*\.\w*/
  validates :email, presence: true, length: {maximum: 105},
            uniqueness: {case_sensitive: false},
            format: {with: VALID_EMAIL_REGEX}
end


class User < ApplicationRecord
  # -------------------------------
  # Password authentication
  # -------------------------------
  has_secure_password
  # requires 'password_digest' column in users table

  # -------------------------------
  # Active Storage for avatar
  # -------------------------------
  has_one_attached :avatar
  has_many :jobs, foreign_key: :created_by_id, inverse_of: :creator

  # -------------------------------
  # Validations
  # -------------------------------
  # Email presence, uniqueness, format
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  # Password presence on create, minimum length
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?

  # Optional: full name max length
  validates :full_name, length: { maximum: 100 }, allow_blank: true

  # -------------------------------
  # Callbacks
  # -------------------------------
  before_save :downcase_email

  private

  def downcase_email
    self.email = email.downcase.strip
  end

  def password_required?
    # Only require password if creating a new user or updating password
    new_record? || !password.nil?
  end
end

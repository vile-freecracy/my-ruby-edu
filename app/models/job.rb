class Job < ApplicationRecord
  enum  :status, { draft: 0, published: 1 }

  belongs_to :creator, class_name: "User", foreign_key: :created_by_id

  validates :title, presence: true
  validates :salary_from, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :salary_to, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validate  :salary_range_valid

  before_create :ensure_share_link

  private

  def ensure_share_link
    self.share_link ||= SecureRandom.hex(12)
  end

  def salary_range_valid
    return if salary_from.blank? || salary_to.blank?
    if salary_from > salary_to
      errors.add(:base, "Salary from must be less than or equal to salary to")
    end
  end
end

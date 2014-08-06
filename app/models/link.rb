class Link < ActiveRecord::Base
  before_create :set_short_name

  validates :url, presence: true
  validates :clicks_count, numericality: { only_integer: true }

  belongs_to :user

  def to_param
    short_name
  end

  def click!
    update_attributes(clicks_count: clicks_count + 1)
  end

  def editable_by?(user)
    user.present? && self.user == user
  end

  private

  def set_short_name
    return short_name if short_name.present?

    try_short_name = SecureRandom.urlsafe_base64(6)
    while Link.where(short_name: try_short_name).any?
      try_short_name = SecureRandom.urlsafe_base64(6)
    end

    self.short_name = try_short_name
  end
end

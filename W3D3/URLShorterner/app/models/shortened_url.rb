class ShortenedUrl < ApplicationRecord
  validates :short_url, :long_url, presence: true, uniqueness: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
      primary_key: :id,
      foreign_key: :shortened_url_id,
      class_name: :Visit

  has_many :visitors,
    Proc.new { distinct },
      through: :visits,
      source: :users


  def self.random_code
    found = false
    rand_string = SecureRandom::urlsafe_base64
    until self.exists?(rand_string)
      rand_string = SecureRandom.urlsafe_base64
    end
    rand_string
  end

  def self.shortener(url, user)
    ShortenedUrl.create(short_url: ShortenedUrl.random_code, long_url: url, user_id: user.id)
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visits.where({created_at: 10.minutes.ago..Time.now}).select(user_id).distinct.count
    # count
  end

end

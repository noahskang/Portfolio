class ShortenedUrl < ApplicationRecord
  validates :short_url, :long_url, presence: true, uniqueness: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

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

end

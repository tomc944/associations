require 'securerandom'

class ShortenedUrl < ActiveRecord::Base
  include SecureRandom

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :submitter_id,
    class_name: "User"

  has_many :visits,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: "Visit"

  has_many :visitors,
    Proc.new {distinct},
    :through => :visits,
    :source => :visitor

  validates :short_url, :presence => true, :uniqueness => true
  validates :long_url, :presence => true
  validates :submitter_id, :presence => true

  def self.random_code
    possible_code = SecureRandom.urlsafe_base64

    until !ShortenedUrl.exists?(possible_code)
      possible_code = SecureRandom.urlsafe_base64
    end

    possible_code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    create!(submitter_id: user.id, long_url: long_url, short_url: random_code)
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    recent = Time.now
    ten_min_ago = recent - 600
    visits.where(:created_at => (ten_min_ago..recent)).count
  end

end

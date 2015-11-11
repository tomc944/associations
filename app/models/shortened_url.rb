require 'securerandom'

class ShortenedUrl < ActiveRecord::Base
  include SecureRandom

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :submitter_id,
    class_name: "User"

  validates :short_url, :presence => true
  validates :long_url, :uniqueness => true
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


end

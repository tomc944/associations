class User < ActiveRecord::Base

  has_many :short_urls,
    primary_key: :id,
    foreign_key: :submitter_id,
    class_name: "ShortenedUrl"

  validates :email, :presence => true, :uniqueness => true

end

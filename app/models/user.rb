class User < ActiveRecord::Base

  has_many :short_urls,
    primary_key: :id,
    foreign_key: :submitter_id,
    class_name: "ShortenedUrl"

  has_many :visits,
    primary_key: :id,
    foreign_key: :visitor_id,
    class_name: "Visit"

  has_many :visited_urls,
    Proc.new {distinct},
    :through => :visits,
    :source => :visited_url

  validates :email, :presence => true, :uniqueness => true

end

class Visit < ActiveRecord::Base

  validates :short_url_id, :presence => true
  validates :visitor_id, :presence => true

  belongs_to :visitors,
    primary_key: :id,
    foreign_key: :visitor_id,
    class_name: "User"

  belongs_to :visited_urls,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: "ShortenedUrl"

  def self.record_visit!(user, shortened_url)
    create!(visitor_id: user.id, short_url_id: shortened_url.id)
  end

end

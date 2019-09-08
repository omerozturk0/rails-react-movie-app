# == Schema Information
#
# Table name: movies
#
#  id          :bigint           not null, primary key
#  active      :boolean          default(FALSE)
#  image_url   :string           default(""), not null
#  text        :string           default(""), not null
#  title       :string           default(""), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_movies_on_category_id  (category_id)
#  index_movies_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#

class MovieSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :text, :active, :image_url, :avg_ratings, :url, :category, :created_at_short

  has_one :category
  has_one :user
  has_many :ratings

  def avg_ratings
    object.ratings.average(:value)
  end

  def url
    movie_url(object)
  end

  def created_at_short
    object.created_at.strftime('%b %d, %Y')
  end
end

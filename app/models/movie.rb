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

class Movie < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :ratings

  searchkick word_start: %i[title text], settings: {number_of_shards: 1, number_of_replicas: 0}

  def search_data
    attributes.merge(
        category: category,
        user: user,
        ratings: ratings,
        avg_ratings: ratings.average(:value).to_f
    )
  end
end

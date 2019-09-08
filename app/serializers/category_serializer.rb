# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  active      :boolean          default(FALSE)
#  description :text
#  title       :string           default(""), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class CategorySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :active

  has_many :movies
end

module Searchable
  extend ActiveSupport::Concern
  include Kaminari::Helpers::HelperMethods

  module ClassMethods
  end

  module InstanceMethods
    attr_accessor :page
    attr_accessor :order

    def searchable(own_records = false)
      self.page = params[:page].present? ? params[:page] : 1
      self.order = params[:order].present? ? params[:order] : { created_at: :desc }

      model_name = controller_name.classify.constantize
      records = model_name.all

      if params[:search].present?
        records = records.where('movies.title LIKE ?', "%#{params[:search]}%")
      end

      if own_records
        if user_signed_in?
          records = records.where(user_id: current_user.id)
        end
      end

      paginated = records.page(page).per(10).order(order)
      {
          data: ActiveModelSerializers::SerializableResource.new(paginated, adapter: :json),
          aggs: {
              Categories: records.joins(:category).group('categories.title').count,
              Ratings: records.joins(:ratings).group('ratings.value').count
          },
          links: {
              prev: path_to_prev_page(paginated),
              next: path_to_next_page(paginated)
          }
      }
    end
  end

  def self.included(receiver)
    receiver.extend ClassMethods
    receiver.send :include, InstanceMethods
  end
end

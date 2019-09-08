module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
  end

  module InstanceMethods
    attr_accessor :search
    attr_accessor :options
    attr_accessor :conditions

    def searchable(own_records = false)
      self.conditions = {}
      self.search = params[:search].present? ? params[:search] : '*'
      self.options = {
          page: params[:page].present? ? params[:page][:number] : 1,
          per_page: params[:page].present? ? params[:page][:size] : 10,
          aggs: {
              Categories: {
                  field: 'category.title',
                  order: { '_key': 'asc' }
              },
              Ratings: {
                  field: 'ratings.value',
                  order: { '_key': 'asc' }
              }
          },
          order: { avg_ratings: :desc }
      }

      if own_records
        if user_signed_in?
          conditions[:user_id] = current_user.id
        end

        if conditions.any?
          options[:where] = conditions
        end

        options[:order] = { created_at: :desc }
      end

      model_name = controller_name.classify.constantize
      model_name.search(search, options)
    end
  end

  def self.included(receiver)
    receiver.extend ClassMethods
    receiver.send :include, InstanceMethods
  end
end

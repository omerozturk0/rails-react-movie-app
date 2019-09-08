class MovieDecorator < ApplicationDecorator
  delegate_all

  def created_at
  	object.decorate.created_at
  end
  
  def updated_at
  	object.decorate.updated_at
  end
end

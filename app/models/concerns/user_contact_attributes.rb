# User contact values
module UserContactAttributes
  extend ActiveSupport::Concern

  def name
    user_contact&.name
  end

  def email 
    user_contact&.email
  end

  def status
    user_contact&.status
  end
end
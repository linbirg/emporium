class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :book

  validates_numericality_of :cart_id, :only_integer => true
  validates_numericality_of :book_id, :only_integer => true
  validates_numericality_of :amount, :only_integer => true
  validates_numericality_of :price, :greater_than => 0

#   # Validate is called before save
#   def validate
#     unless State.find_by_id(state_id)
#       errors.add(:state_id, 'does not exist')
#     end
#   end # validate

#  def validate
#    begin
#      Order.find(self.order_id)
#    rescue ActiveRecord::RecordNotFound
#      errors.add(:order_id, "invalid foreign key reference")
#    end
#  end

#  class OrderItem
#  belongs_to :order
#
#  def validate
#    errors.add_to_base "Invalid order" unless
#Order.ids.include?(order_id)
#  end
#end

#  hat is probably a better approach. Using Order.exists? will make the
#code a bit shorter:
#
#errors.add_to_base 'Invalid order' unless Order.exists?(order_id)
end

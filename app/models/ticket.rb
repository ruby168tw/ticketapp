class Ticket < ApplicationRecord
    validates_presence_of :name, :member_id, :category_id
    validates_numericality_of :member_id, :only_integer => true, :greater_than => 0
    validates_numericality_of :category_id, :only_integer => true, :greater_than => 0
    belongs_to :member
    belongs_to :category
end

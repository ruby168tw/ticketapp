class Member < ApplicationRecord
    validates_presence_of :name, :age, :account, :password
    validates_numericality_of :age, :only_integer => true
    validates_numericality_of :age, :greater_than => 0
    validates_numericality_of :age, :less_than =>100
    validates_length_of :password, :in => 4..20
    validates_uniqueness_of :account
    validates_format_of :account, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
    has_many :tickets
end

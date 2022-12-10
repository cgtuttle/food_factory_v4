class Security::Company < ApplicationRecord
  has_many :user_companies
  has_many :users, through: :user_companies
  has_many :settings, class_name: "Settings::Company", foreign_key: :company_id

  cattr_accessor :current_id

  def self.current_id=(id)
    Thread.current[:company_id] = id
  end

  def self.current_id
    Thread.current[:company_id]
  end
  
end

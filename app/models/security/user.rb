class Security::User < ApplicationRecord
  acts_as_authentic do |c|
      c.crypto_provider = ::Authlogic::CryptoProviders::SCrypt
    end
  has_many :user_companies
  has_many :companies, through: :user_companies

  validates :email,
    format: {
      with: /@/,
      message: "should look like an email address."
    },
    length: { maximum: 100 },
    uniqueness: {
      case_sensitive: false,
      if: :will_save_change_to_email?
    }

  validates :password,
    confirmation: { if: :require_password? },
    length: {
      minimum: 6,
      if: :require_password?
    }
  validates :password_confirmation,
    length: {
      minimum: 6,
      if: :require_password?
  }

end

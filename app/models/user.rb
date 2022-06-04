# frozen_string_literal: true
class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  before_create :encrypt_password

  has_many :portfolios

  def self.login(options)
    if options[:email] && options[:password]
      find_by(
        email: options[:email],
        password: Digest::SHA1.hexdigest('statementdog' + options[:password])
      )
    end
  end

  private

  def encrypt_password
    self.password = bigbang(self.password)
  end

  def bigbang(string)
    string = 'statementdog' + string
    Digest::SHA1.hexdigest(string)
  end
end

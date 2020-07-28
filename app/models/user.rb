# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable

  validates :email, uniqueness: true, presence: { message: 'Email must be present.' }
  validates :email, length: { minimum: 5 }
  validates :password, presence: true
  validates :password, length: { minimum: 8,
                                 too_short: 'Passwords must be at least %{count} characters long' }
end

class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  has_many  :responses, class_name: "Response", foreign_key: "uploader_id", dependent: :destroy
end

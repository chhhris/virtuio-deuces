class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

	has_secure_password
	validates_presence_of :name, :on => :create
	validates_presence_of :email, :on => :create
	validates_presence_of :password_confirmation, :on => :create
	validates_uniqueness_of :email

	has_many :clients
	has_many :invoices
end

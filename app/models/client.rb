class Client < ActiveRecord::Base
	extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

	belongs_to :user
	has_many :invoices
end

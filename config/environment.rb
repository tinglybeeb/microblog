# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# require the carrierwave file uploader extension
require 'carrierwave/orm/activerecord'
# == Schema Information
#
# Table name: addresses
#
#  id         :bigint           not null, primary key
#  city       :string           not null
#  country    :string           not null
#  line1      :string           not null
#  line2      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_addresses_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Address < ApplicationRecord
  belongs_to :user

  validates :city, :country, :line1, presence: true
end

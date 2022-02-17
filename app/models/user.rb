# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  validates :email, presence: true

  has_many :orders, dependent: :destroy
  has_one :credit_card, dependent: :destroy
  has_one :address, dependent: :destroy

  accepts_nested_attributes_for :credit_card, :address
  validates_associated :credit_card, :address
end

# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :text
#  moderator_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ApplicationRecord

  belongs_to :moderator,
    foreign_key: :moderator_id,
    primary_key: :id,
    class_name: :User

  has_many :post_subs

  has_many :posts, 
  through: :post_subs,
  source: :post
end

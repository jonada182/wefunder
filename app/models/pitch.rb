class Pitch < ApplicationRecord

  has_many :slides
  
  belongs_to :company
end

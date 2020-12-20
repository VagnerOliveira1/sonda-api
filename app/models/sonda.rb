class Sonda < ApplicationRecord
  validates_presence_of :face, :coordinate_x, :coordinate_y
  validates_inclusion_of :coordinate_x, :in => 0..4
  validates_inclusion_of :coordinate_y, :in => 0..4

  def self.move(commands)
  end

end

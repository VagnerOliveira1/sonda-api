class Sonda < ApplicationRecord
  validates_presence_of :face, :coordinate_x, :coordinate_y
  validates_inclusion_of :coordinate_x, :in => 0..4
  validates_inclusion_of :coordinate_y, :in => 0..4

  def self.move(commands)
    commands.each_with_index do |c, index|
      if c == 'GE'
        set_face(c)
      elsif c == 'GD'
        set_face(c)
      else
        set_coordinates
      end
    end
    @sonda
  end

  def self.set_face(c)
    @sonda = Sonda.last
    face = @sonda.face
    case
    when face.include?('E')
      if c.include?('E')
        face = 'C'
        #girou para a esquerda
      elsif c.include?('D')
        face = 'B'
        #girou para a direita
      end
    when face.include?('D')
      if c.include?('D')
        face = 'B'
      elsif c.include?('E')
        face = 'C'
      end
    else
      face = c[1]
    end
    @sonda.face = face
    @sonda.save!
  end

  def self.set_coordinates
    x = y = 0
    face = @sonda.face
    if face == 'D'
       x += 1
    elsif face == 'E'
       x -= 1
    elsif face == 'C'
      y += 1
    elsif face == 'B'
      y -= 1
    end
    @sonda.coordinate_x += x
    @sonda.coordinate_y += y
    @sonda.save!
  end

  def self.validate_commands_params(commands)
    commands = commands.reduce.split(",").map { |co| co.delete("\"").strip}
    if commands.uniq.size == 3
      move(commands)
    end
  end

end

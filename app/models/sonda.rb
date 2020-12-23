class Sonda < ApplicationRecord
  validates_presence_of :face, :coordinate_x, :coordinate_y
  validates_inclusion_of :coordinate_x, :in => 0..4
  validates_inclusion_of :coordinate_y, :in => 0..4

  def self.move(commands)
    mensagem = []
    cont_y = cont_x = 0
    eixo = " "
    commands.each_with_index do |c, index|
      if c!= 'M'
        if c == 'GE'
          cont_x = cont_y = 0
          mensagem << " Girou para Esquerda "
          set_face(c)
        elsif c == 'GD'
          cont_x = cont_y = 0
          mensagem << " girou para Direita"
          set_face(c)
        else
          puts "comando inválido"
        end
      else
        set_coordinates
        if @sonda.face == 'C' || @sonda.face == 'B'
          cont_y += 1
        else
          cont_x += 1
        end
      end
      if c =='M' && commands[index+1] != 'M'
        if cont_x > 0 || cont_y > 0
          maior = cont_y > cont_x ? cont_y : cont_x
          eixo =(@sonda.face.include?('D') || @sonda.face.include?('E')) ? " X " : " Y "
          mensagem << " e andou #{maior} posições no eixo #{eixo}"
        end
      end
    end
    #@sonda.sonda.commands.reduce.to_s.delete("[]")
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
      end
    when face.include?('D')
      if c.include?('D')
        face = 'B'
      elsif c.include?('E')
        face = 'C'
      end
    when face.include?('C')
      if c.include?('D')
        face = 'D'
      elsif c.include?('E')
        face = 'E'
      end
    when face.include?('B')
      if c.include?('D')
        face = 'E'
      elsif c.include?('E')
        face = 'D'
      end
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

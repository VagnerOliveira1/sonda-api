class Sonda < ApplicationRecord
  validates_presence_of :face, :coordinate_x, :coordinate_y
  validates_inclusion_of :coordinate_x, :in => 0..4
  validates_inclusion_of :coordinate_y, :in => 0..4

  def self.move(commands)
    @cont_y = @cont_x = 0
    loop_commands(commands)
    @sonda.message = @message
    @sonda
  end

  def self.loop_commands(commands)
    @message= " "
    commands.each_with_index do |c, index|
      if c!= 'M'
        get_direction(c)
      else
        set_coordinates
        get_axis
      end
      if c =='M' && commands[index+1] != 'M'
        create_message
      end
    end
  end

  def self.set_face(c)
    @sonda = Sonda.last
    face = @sonda.face
    case
    when face.include?('E')
      if c.include?('E')
        face = 'C'
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

  def self.get_direction(c)
    if c == 'GE'
      @cont_x = @cont_y = 0
      @message+= " Girou para Esquerda "
      set_face(c)
    elsif c == 'GD'
      @cont_x = @cont_y = 0
      @message+= " girou para Direita"
      set_face(c)
    else
      puts "comando inválido"
    end
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
    else
      render json: { error: "Um movimento inválido foi detectado, infelizmente a sonda ainda não possui a habilidade de #vvv.", success: false }, status: :unprocessable_entity
    end
  end

  def self.get_axis
    if @sonda.face == 'C' || @sonda.face == 'B'
      @cont_y += 1
    else
      @cont_x += 1
    end
  end

  def self.create_message
    if @cont_x > 0 || @cont_y > 0
      maior = @cont_y > @cont_x ? @cont_y : @cont_x
      axis =(@sonda.face.include?('D') || @sonda.face.include?('E')) ? " X " : " Y "
      @message+=" e andou #{maior} casas no eixo #{axis}"
    end
  end
end

namespace :sonda do
  desc "Cria a Sonda e seta a posição inicial"
  task setup: :environment do
    Sonda.create!(face: "D",coordinate_x:0, coordinate_y:0)
  end
end

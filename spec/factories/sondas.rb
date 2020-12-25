FactoryBot.define do
  factory :sonda do
    coordinate_x {rand(0..4)}
    coordinate_y {rand(0..4)}
    face {["D","E","C","B"].sample}
  end
end

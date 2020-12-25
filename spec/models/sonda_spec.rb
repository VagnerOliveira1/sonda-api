require 'rails_helper'

RSpec.describe Sonda, type: :model do
  it {is_expected.to validate_presence_of(:coordinate_x)}
  it {is_expected.to validate_presence_of(:coordinate_y)}
  it {is_expected.to validate_inclusion_of(:coordinate_x).in_range(0..4) }
  it {is_expected.to validate_inclusion_of(:coordinate_y).in_range(0..4) }
  it {is_expected.to validate_inclusion_of(:face).in_array(%w(E D C B))}
end

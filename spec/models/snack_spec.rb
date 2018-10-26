require 'rails_helper'

RSpec.describe Snack, type: :model do
  it { is_expected.to have_many(:machine_snacks) }
  it { is_expected.to have_many(:machines).through(:machine_snacks) }

end

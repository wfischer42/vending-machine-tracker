require 'rails_helper'

RSpec.describe MachineSnack, type: :model do
  it { is_expected.to belong_to(:machine)}
  it { is_expected.to belong_to(:snack)}
end

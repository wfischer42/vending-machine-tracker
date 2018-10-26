require 'rails_helper'

describe Machine, type: :model do
  describe 'validations' do
    it { should validate_presence_of :location }
    it { should belong_to :owner }
    it { is_expected.to have_many(:machine_snacks) }
    it { is_expected.to have_many(:snacks).through(:machine_snacks) }
  end

  describe '.avg_price' do
    before do
      owner = Owner.create(name: "Sam's Snacks")
      @dons  = owner.machines.create(location: "Don's Mixed Drinks")

      @dons.snacks.create(name: "Gumdrops", price: 1.51)
      @dons.snacks.create(name: "Snackums", price: 2.44)
      @dons.snacks.create(name: "Junkfood", price: 7.12)
    end
    subject { @dons.avg_price }
    it { is_expected.to eq(@dons.snacks.average(:price))}
  end
end

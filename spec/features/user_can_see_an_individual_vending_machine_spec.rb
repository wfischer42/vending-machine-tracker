require 'rails_helper'

feature 'When a user visits a vending machine show page' do
  before do
    owner = Owner.create(name: "Sam's Snacks")
    @dons  = owner.machines.create(location: "Don's Mixed Drinks")

    @dons.snacks.create(name: "Gumdrops", price: 1.51)
    @dons.snacks.create(name: "Snackums", price: 2.44)
    @dons.snacks.create(name: "Junkfood", price: 7.12)
    visit machine_path(@dons)
  end
  scenario 'they see the location of that machine' do
    expect(page).to have_content("Don's Mixed Drinks Vending Machine")
  end

  scenario 'they see all snacks in that machine and prices' do
    @dons.snacks.each do |snack|
      expect(page).to have_content("* #{snack.name}: $#{snack.price}")
    end
  end

  scenario 'they see the average price of snacks for that machine' do
    average_price = @dons.snacks.average(:price)
    expect(page).to have_content("Average Price: $#{average_price}")
  end
end

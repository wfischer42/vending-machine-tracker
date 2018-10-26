require 'rails_helper'

feature 'When a user visits a snack show page' do
  before do
    don  = Owner.create(name: "don")
    drew = Owner.create(name: "drew")
    @mach_1 = don.machines.create(location: "Don's Mixed Drinks")
    @mach_2 = drew.machines.create(location: "Drew's Drinks")
    @mach_3 = drew.machines.create(location: "Drew's Snacks")

    @snack_1 = Snack.create(name: "Gumdrops", price: 1.51)
    @snack_2 = Snack.create(name: "Yum sauce", price: 3.51)
    @snack_3 = Snack.create(name: "Not much", price: 1.93)

    @mach_1.snacks << @snack_1
    @mach_1.snacks << @snack_2
    @mach_1.snacks << @snack_3
    @mach_2.snacks << @snack_1
    @mach_2.snacks << @snack_2
    @mach_3.snacks << @snack_1

    visit snack_path(@snack_1)
  end

  scenario 'they see the name and price of the snack' do
    expect(page).to have_content(@snack_1.name)
    expect(page).to have_content("Price: $#{@snack_1.price}")
  end

  scenario 'they see a list of vending machines that carry it' do
    expect(page).to have_content("* #{@mach_1.location}")
    expect(page).to have_content("* #{@mach_2.location}")
    expect(page).to have_content("* #{@mach_3.location}")
  end

  scenario 'they see the number of snacks and the average price per location' do
    details_1 = "(#{@mach_1.snacks.count} kinds of snacks, average price of #{@mach_1.avg_price})"
    details_2 = "(#{@mach_2.snacks.count} kinds of snacks, average price of #{@mach_2.avg_price})"
    details_3 = "(#{@mach_3.snacks.count} kinds of snacks, average price of #{@mach_3.avg_price})"
    expect(page).to have_content(details_1)
    expect(page).to have_content(details_2)
    expect(page).to have_content(details_3)
  end
end

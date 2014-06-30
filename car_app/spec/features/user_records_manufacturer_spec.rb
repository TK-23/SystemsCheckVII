require 'rails_helper'

feature 'add and view manufacturers', %Q{'As a car salesperson
I want to record a car manufacturer
So that I can keep track of the types of cars found in the lot'
} do

# Acceptance Criteria

# I must specify a manufacturer name and country.
# If I do not specify the required information, I am presented with errors.
# If I specify the required information, the manufacturer is recorded and I am redirected to the index of manufacturers

  scenario 'user specifies manufacturer name and country' do

    Manufacturer.create(name:"Toyota", country: "Japan")
    visit '/manufacturers/new'
    fill_in 'Name', with: "Ford"
    fill_in 'Country', with: "USA"
    click_on 'Create Manufacturer'

    expect(page).to have_content 'Ford'
    expect(page).to have_content 'USA'
    expect(page).to have_content 'Toyota'
    expect(page).to have_content 'Japan'

  end

  scenario 'manufacturer name is required ' do

    visit '/manufacturers/new'
    fill_in 'Country', with: "USA"
    click_on 'Create Manufacturer'

    expect(page).to have_content "can't be blank"
  end

  scenario 'manufacturer country is required ' do

    visit '/manufacturers/new'
    fill_in 'Name', with: "Ford"
    click_on 'Create Manufacturer'

    expect(page).to have_content "can't be blank"
  end
end

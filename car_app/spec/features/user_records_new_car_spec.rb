require 'rails_helper'

feature 'add new car', %Q{'As a car salesperson
I want to record a newly acquired car
So that I can list it in my lot'
} do

# Acceptance Criteria

# I must specify the manufacturer, color, year, and mileage of the car.
# Only years from 1920 and above can be specified.
# I can optionally specify a description of the car.
# If I enter all of the required information in the required formats, the car is recorded and I am presented with a notification of success
# If I do not specify all of the required information in the required formats, the car is not recorded and I am presented with errors.
# Upon successfully creating a car, I am redirected back to the index of cars.
  scenario 'user specifies manufacturer name and country' do

    visit '/cars/new'
    fill_in 'Manufacturer', with: "Ford"
    fill_in 'Color', with: "Red"
    fill_in 'Year', with: 2009
    fill_in 'Mileage', with: 10000
    fill_in 'Description', with: "Cool car"
    click_on 'Create Manufacturer'

    expect(page).to have_content 'Ford'
    expect(page).to have_content 'Red'
    expect(page).to have_content '2009'
    expect(page).to have_content '10000'

  end

  scenario 'manufacturer required' do

    visit '/cars/new'
    fill_in 'Color', with: "Red"
    fill_in 'Year', with: 2009
    fill_in 'Mileage', with: 10000
    click_on 'Create Manufacturer'

    expect(page).to have_content "can't be blank"

  end

  scenario 'color required' do

    visit '/cars/new'
    fill_in 'Manufacturer', with: "Ford"
    fill_in 'Year', with: 2009
    fill_in 'Mileage', with: 10000
    click_on 'Create Manufacturer'

    expect(page).to have_content "can't be blank"

  end

  scenario 'year required' do

    visit '/cars/new'
    fill_in 'Manufacturer', with: "Ford"
    fill_in 'Color', with: "Red"
    fill_in 'Mileage', with: 10000
    click_on 'Create Manufacturer'

    expect(page).to have_content "can't be blank"

  end

  scenario 'mileage required' do

    visit '/cars/new'
    fill_in 'Manufacturer', with: "Ford"
    fill_in 'Color', with: "Red"
    fill_in 'Year', with: 2009
    click_on 'Create Manufacturer'

    expect(page).to have_content "can't be blank"

  end

  scenario 'year cannot be below 1920' do

    visit '/cars/new'
    fill_in 'Manufacturer', with: "Ford"
    fill_in 'Color', with: "Red"
    fill_in 'Year', with: 1919
    fill_in 'Mileage', with: 10000
    click_on 'Create Manufacturer'

    expect(page).to have_content "can't be blank"

  end

  scenario 'successful save of required info provides message' do

    visit '/cars/new'
    fill_in 'Manufacturer', with: "Ford"
    fill_in 'Color', with: "Red"
    fill_in 'Year', with: 2009
    fill_in 'Mileage', with: 10000
    click_on 'Create Manufacturer'

    expect(page).to have_content 'Car Successfully Added'
  end

  scenario 'successful save redirects to index' do

    Car.new( manufacturer: "Mazda", color: "Blue", year: 2005, mileage: 32 )

    visit '/cars/new'
    fill_in 'Manufacturer', with: "Ford"
    fill_in 'Color', with: "Red"
    fill_in 'Year', with: 2009
    fill_in 'Mileage', with: 10000
    click_on 'Create Manufacturer'

    expect(page).to have_content 'Mazda'
    expect(page).to have_content '2005'
    expect(page).to have_content 'Blue'
    expect(page).to have_content '32'
    expect(page).to have_content 'Ford'
    expect(page).to have_content '2009'
    expect(page).to have_content 'Red'
    expect(page).to have_content '10000'

  end
end

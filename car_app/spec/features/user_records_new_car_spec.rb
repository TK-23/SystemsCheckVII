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

    Manufacturer.create(name:"Ford", country: "USA")

    visit '/cars/new'
    select "Ford", from: "Manufacturer"
    fill_in 'Color', with: "Red"
    select "2009", from: "Year"
    fill_in 'Mileage', with: 10000
    fill_in 'Description', with: "Cool car"
    click_on 'Create Car'

    expect(page).to have_content 'Ford'
    expect(page).to have_content 'Red'
    expect(page).to have_content '2009'
    expect(page).to have_content '10000'

  end

  scenario 'manufacturer required' do

    Manufacturer.create(name:"Ford", country: "USA")

    visit '/cars/new'
    fill_in 'Color', with: "Red"
    select "2009", from: "Year"
    fill_in 'Mileage', with: 10000
    click_on 'Create Car'

    expect(page).to have_content "can't be blank"

  end

  scenario 'color required' do

    Manufacturer.create(name:"Ford", country: "USA")

    visit '/cars/new'
    select "Ford", from: "Manufacturer"
    select "2009", from: "Year"
    fill_in 'Mileage', with: 10000
    click_on 'Create Car'

    expect(page).to have_content "can't be blank"

  end

  scenario 'year required' do

    Manufacturer.create(name:"Ford", country: "USA")

    visit '/cars/new'
    select "Ford", from: "Manufacturer"
    fill_in 'Color', with: "Red"
    fill_in 'Mileage', with: 10000
    click_on 'Create Car'

    expect(page).to have_content "can't be blank"

  end

  scenario 'mileage required' do

    Manufacturer.create(name:"Ford", country: "USA")

    visit '/cars/new'
    select "Ford", from: "Manufacturer"
    fill_in 'Color', with: "Red"
    select "2009", from: "Year"
    click_on 'Create Car'

    expect(page).to have_content "can't be blank"

  end

  scenario 'successful save of required info provides message' do

    Manufacturer.create(name:"Ford", country: "USA")

    visit '/cars/new'
    select "Ford", from: "Manufacturer"
    fill_in 'Color', with: "Red"
    select "2009", from: "Year"
    fill_in 'Mileage', with: 10000
    click_on 'Create Car'

    expect(page).to have_content 'Car Successfully Added'
  end

  scenario 'successful save redirects to index' do

    Manufacturer.create(name:"Ford", country: "USA")
    mazda = Manufacturer.create(name:"Mazda", country: "Japan")
    Car.create( manufacturer_id: mazda.id, color: "Blue", year: 2005, mileage: 32 )

    visit '/cars/new'
    select "Ford", from: "Manufacturer"
    fill_in 'Color', with: "Red"
    select "2009", from: "Year"
    fill_in 'Mileage', with: 10000
    click_on 'Create Car'

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

require "application_system_test_case"

class DataSetsTest < ApplicationSystemTestCase
  setup do
    @data_set = data_sets(:one)
  end

  test "visiting the index" do
    visit data_sets_url
    assert_selector "h1", text: "DataSets"
  end

  test "should create data set" do
    visit data_sets_url
    click_on "New data set"

    fill_in "City", with: @data_set.city
    fill_in "End date", with: @data_set.end_date
    fill_in "Filename", with: @data_set.filename
    fill_in "Name", with: @data_set.name
    fill_in "Start date", with: @data_set.start_date
    fill_in "State", with: @data_set.state
    click_on "Create Data set"

    assert_text "Data set was successfully created"
    click_on "Back"
  end

  test "should update Data set" do
    visit data_set_url(@data_set)
    click_on "Edit this data set", match: :first

    fill_in "City", with: @data_set.city
    fill_in "End date", with: @data_set.end_date
    fill_in "Filename", with: @data_set.filename
    fill_in "Name", with: @data_set.name
    fill_in "Start date", with: @data_set.start_date
    fill_in "State", with: @data_set.state
    click_on "Update Data set"

    assert_text "Data set was successfully updated"
    click_on "Back"
  end

  test "should destroy Data set" do
    visit data_set_url(@data_set)
    click_on "Destroy this data set", match: :first

    assert_text "Data set was successfully destroyed"
  end
end

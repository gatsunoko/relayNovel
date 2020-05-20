require "application_system_test_case"

class NovelListsTest < ApplicationSystemTestCase
  setup do
    @novel_list = novel_lists(:one)
  end

  test "visiting the index" do
    visit novel_lists_url
    assert_selector "h1", text: "Novel Lists"
  end

  test "creating a Novel list" do
    visit novel_lists_url
    click_on "New Novel List"

    fill_in "Title", with: @novel_list.title
    click_on "Create Novel list"

    assert_text "Novel list was successfully created"
    click_on "Back"
  end

  test "updating a Novel list" do
    visit novel_lists_url
    click_on "Edit", match: :first

    fill_in "Title", with: @novel_list.title
    click_on "Update Novel list"

    assert_text "Novel list was successfully updated"
    click_on "Back"
  end

  test "destroying a Novel list" do
    visit novel_lists_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Novel list was successfully destroyed"
  end
end

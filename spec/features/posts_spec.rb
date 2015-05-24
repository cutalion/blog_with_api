require 'rails_helper'

RSpec.feature "Posts", type: :feature do
  scenario "Empty blog" do
    visit "/"
    expect(page).to have_text "There are no posts yet"
  end

  scenario "Add post" do
    visit "/"
    click_on "New post"
    fill_in "Title", with: "Depeche mode"
    fill_in "Body", with: "Post about depeche mode"
    click_on "Save"

    expect(page).to have_text "Your post is just awesome!"
  end

  scenario "See all posts" do
    create :post, title: 'How to cook a cake'
    visit "/"
    expect(page).to have_text 'How to cook a cake (draft)'
  end

  scenario "Read a post" do
    create :post, title: 'How to cook a cake', body: 'Ask me'
    visit "/"
    click_on 'How to cook a cake'
    expect(page).to have_text 'How to cook a cake'
    expect(page).to have_text 'Ask me'
  end

  scenario "Edit post" do
    post = create :post, title: 'Nice post'
    visit post_path(post)
    click_on 'Edit'
    fill_in 'Title', with: 'Great post!'
    uncheck 'Draft'
    click_on 'Save'

    expect(page).to have_text 'Great post!'
    expect(page).to have_text 'Your post became even better!'
  end

  scenario "Delete post" do
    post = create :post
    visit post_path(post)
    click_on 'Delete'
    expect(page).to have_content "I didn't like it too!"
  end
end

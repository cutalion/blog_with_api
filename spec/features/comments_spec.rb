require 'rails_helper'

RSpec.feature "Comments", type: :feature do
  let!(:post) { create :post }
  before do
    visit post_path(post)
  end

  scenario "Post without comments" do
    expect(page).to have_text 'There are no comments yet. Be first.'
  end

  scenario "Leave comment" do
    fill_in 'comment[body]', with: 'Good article!'
    click_on 'Comment'

    expect(page).to have_comment('Good article!')
  end

  scenario "Delete comment" do
    create :comment, body: 'Bad comment', post: post
    visit post_path(post)

    within comment('Bad comment') do
      click_on 'delete'
    end

    expect(page).to_not have_comment('Bad comment')
  end

  scenario "Edit comment" do
    create :comment, body: 'Comment with typo', post: post
    visit post_path(post)

    within comment('Comment with typo') do
      click_on 'edit'
    end

    fill_in 'comment[body]', with: 'Corrected comment'
    click_on 'Save'

    expect(page).to have_comment('Corrected comment')
  end




  def have_comment(text)
    have_selector('.comment', text: text)
  end

  def comment(text)
    find('.comment', text: text)
  end
end

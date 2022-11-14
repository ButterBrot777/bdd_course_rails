# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.feature 'Listing Articles' do
  before do
    @john = User.create!(email: 'john@example.com', password: 'password')

    @article1 = Article.create(title: 'The first article',
                               body: 'Lorem ipsum dolor sit amet, consectetur.', user: @john)
    @article2 = Article.create(title: 'The second article',
                               body: 'Pellentesque ac ligula in tellus feugiat.', user: @john)
  end

  scenario 'with articles created and user not signed in' do
    visit '/'
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
    expect(page).not_to have_link('New Article')
  end

  scenario 'with articles created and user signed in' do
    login_as(@john)
    visit '/'
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
    expect(page).to have_link('New Article')
  end
end
# rubocop:enable Metrics/BlockLength

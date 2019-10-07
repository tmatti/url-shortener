describe 'front-end', type: :feature do
  it 'loads the page' do
    visit 'http://localhost:8080'
    expect(page.title).to have_content 'Url Shortener'
  end
end
require 'rails_helper'

RSpec.describe 'Show Page' do
  before(:each)do
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)
    
    @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    @upholstery_tux = @furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")

    @jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    @gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
    @erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)

    ContestantProject.create(contestant_id: @jay.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @upholstery_tux.id)
  end 

  
  describe 'project name, material, and theme' do
    it "displays the project's name and material, and theme of the challenge that this project belongs to" do
      visit ("/projects/#{@upholstery_tux.id}")

      expect(page).to_not have_content(@news_chic.name)
      expect(page).to_not have_content(@news_chic.material)
      expect(page).to_not have_content(@news_chic.challenge.theme)

      expect(page).to have_content(@upholstery_tux.name)
      expect(page).to have_content(@upholstery_tux.material)
      expect(page).to have_content(@upholstery_tux.challenge.theme)
    end
  end

  it "displays the number of contestants on this project" do
    visit ("/projects/#{@upholstery_tux.id}")
    expect(page).to_not have_content("Number of Contestants: 2")
    expect(page).to_not have_content("Number of Contestants: 0")
    expect(page).to_not have_content("Number of Contestants: #{@news_chic.contestant_count}")
save_and_open_page
    expect(page).to have_content("Number of Contestants: #{@upholstery_tux.contestant_count}")
  end

end
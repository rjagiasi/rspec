require 'rails_helper'
require 'spec_helper'
# require 'factory_girl_rails'

RSpec.describe Movie, type: :model do

    describe 'find similar movies' do
        let!(:m1) { FactoryGirl.create(:movie, title: 'Before Sunrise', director: 'Richard Linklater') }
        let!(:m2) { FactoryGirl.create(:movie, title: 'Dazed and Confused', director: 'Richard Linklater') }
        let!(:m3) { FactoryGirl.create(:movie, title: 'Spy Kids', director: 'Robert Rodriguez') }
        let!(:m4) { FactoryGirl.create(:movie, title: 'Stuart Little') }
    
    context 'director exists' do
      it 'finds similar movies correctly' do
        Movie.search_by_director(m1.title).each do |movie|
            expect(movie.director).to eql(m1.director)
            expect(movie.title).to_not eql('Spy Kids')
        end
      end
    end
    
    context 'director does not exist' do
        it 'gives nil' do
            expect(Movie.search_by_director(m4.title)).to eql(nil)
        end
    end
end
end

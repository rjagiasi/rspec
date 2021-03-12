require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
    render_views
    
    describe 'search for similar movie' do
        let!(:m1) { FactoryGirl.create(:movie, title: 'The Terminator', director: 'This guy') }
        let!(:m2) { FactoryGirl.create(:movie, title: 'When Harry Met Sally', director: 'This guy') }
        
        
        it 'calls similar movies' do 
            expect(Movie).to receive(:search_by_director).with('The Terminator')
            get :search, { title: 'The Terminator' } 
        end
        
        it 'gets similar movies' do
            movie_list = [m1, m2]
            movie_names = ["The Terminator", "When Harry Met Sally"]
            Movie.stub(:search_by_director).with('The Terminator').and_return(movie_list)
            # Movie.search_by_director('The Terminator').should be(movie_list)
            # expect(Movie.search_by_director('The Terminator')).to eq(movie_list)
            # movies = Movie.search_by_director('Before Sunrise')
            get :search, { title: 'The Terminator' }
            # assigns(:search_by_director).each do |movie| 
            #     # $stderr.puts("sahdjhd", movie.title)
            #     Rails.logger.debug movie.inspect
            #     expect(movie.title).to match_array(movie_names)
            # end
            # puts("hulu", response.headers)
            movie_names.each do |movie|
                expect(response.body).to have_content(movie)
            end
        end
        
        
        it "redirect to home if nil" do
            Movie.stub(:search_by_director).with('Random Name').and_return(nil)
            get :search, { title: 'Random Name' }
            expect(response).to redirect_to(root_url) 
        end
        # it 'should assign similar movies if director exists' do
        #   movies = ['Seven', 'The Social Network']
        #   Movie.stub(:similar_movies).with('Seven').and_return(movies)
        #   get :search, { title: 'Seven' }
        #   expect(assigns(:similar_movies)).to eql(movies)
        # end
    end
end

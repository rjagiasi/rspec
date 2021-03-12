class Movie < ActiveRecord::Base
    def self.search_by_director title
        director = Movie.find_by(title: title).director
        if director.blank? or director.nil?
            return nil
        end
        # puts("DIr ", director)
        return Movie.where(director: director).to_a
    end
    
    def self.all_ratings
        %w(G PG PG-13 NC-17 R)
    end
end

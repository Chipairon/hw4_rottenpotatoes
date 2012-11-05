require 'spec_helper'

describe MoviesController do
  describe 'find movies with same director' do
    before do
      movie = mock(id: 3, director: 'hum')
      Movie.should_receive(:find).and_return(movie)
      fake_results = [double('Movie', director: 'hum'), 
                      double('Movie', director: 'hum')]
      movie.should_receive(:find_with_same_director).
        and_return(fake_results)
    end

    it 'should render the similar movies template' do
      get :same_director, {id: 3}
      controller.should render_template("same_director")
    end

    it 'should call a model method to search the movies' do
      get :same_director, {id: 3}
    end
  end

  describe 'sad path for movies with same director' do
    before do
      movie = mock(id: 3, director: 'hum', title: 'Title')
      Movie.should_receive(:find).and_return(movie)
      movie.should_receive(:find_with_same_director).
        and_return(nil)
    end

    it 'should redirect to root if no similar movies are found' do
      get :same_director, {id: 3}
      response.should redirect_to(root_path)
    end
  end
end


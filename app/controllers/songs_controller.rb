require 'rack-flash'

class SongsController < ApplicationController
  enable :sessions
  use Rack::Flash
  

  get '/songs' do
    @songs = Song.all
    erb :'songs/index'
  end

  get '/songs/new' do
    @genres = Genre.all
    @artists = Artist.all
    erb :'songs/new'
  end

  post '/songs' do
   
    @song = Song.create(params[:song])
    @song.genres << Genre.find(params[:genre][:genre_id])
    @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
    @song.save
    flash[:message] = "Successfully created song."
    redirect("/songs/#{@song.slug}")
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @artist = @song.artist
    @genres = @song.genres
    erb :'songs/show'
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @genres = Genre.all
    erb :'songs/edit'
  end

  patch '/songs/:slug' do
    song = Song.find_by_slug(params[:slug])
    song.update(params[:song])
    song.genre_ids = params[:genres]
    song.artist = Artist.find_or_create_by(name: params[:artist][:artist_name])
    song.save
    flash[:message] = "Successfully updated song."
    redirect "/songs/#{song.slug}"
  end

end
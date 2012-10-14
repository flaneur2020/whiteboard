#!/usr/bin/env ruby

# http://johanharjono.com/archives/760
# LESS PAINFUL WEB DEVELOPMENT WITH SINATRA, SLIM, SASS, AND COFFEESCRIPT
# save this snippets as demo.rb

require 'rubygems'
require "bundler/setup"

Bundler.require(:default)

configure do
  Compass.configuration do |config|
    config.project_path = File.dirname(__FILE__)
    config.sass_dir = 'sass'
  end
end

class App < Sinatra::Base
  set :public_folder, File.dirname(__FILE__) + '/public'
  set :views, File.dirname(__FILE__) + '/'

  get '/css/:name.css' do
    filename = params[:name]
    sass(:"sass/#{filename}", Compass.sass_engine_options)
  end

  get "/js/:name.js" do
    coffee "coffee/#{params[:name].to_sym}"
  end

  get '*.html' do 
    slim params[:splat].first.to_sym
  end

  # Route Handlers
  get '/' do
    slim :index
  end
end

if __FILE__ == $0
  App.run! :port => 4000
end

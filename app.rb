#!/usr/bin/env ruby

require 'rubygems'
require "bundler/setup"

Bundler.require(:default)

configure do
  Compass.configuration do |config|
    config.project_path = File.dirname(__FILE__)
    config.sass_dir = 'sass'
  end
end

set :public_folder, File.dirname(__FILE__) + '/public'
set :views, File.dirname(__FILE__) + '/views'

get '/css/:name.css' do
  sass(:"sass/#{params[:name]}", Compass.sass_engine_options)
end

get "/js/:name.js" do
  coffee :"coffee/#{params[:name]}"
end

get ':name.html' do 
  slim params[:name].to_sym
end

get '/' do
  slim :index
end

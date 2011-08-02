#!/usr/bin/env ruby

require 'sinatra'
require 'erubis'
Tilt.register :erb, Tilt[:erubis]

configure do
	require 'yaml'
	open("settings.yml") do |f|
		yml = YAML.load(f)
		yml.each do |key,value|
			set key.to_sym, value
		end
	end
	settings.mongo['password'] = ENV['MONGO_PASSWORD']
end

require './helpers'
require './routes'


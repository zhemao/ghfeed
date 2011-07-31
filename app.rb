#!/usr/bin/env ruby

require 'sinatra'
require 'erubis'
Tilt.register :erb, Tilt[:erubis]

configure do
	require 'yaml'
	open("settings.yaml") do |f|
		yml = YAML.load(f)
		yml.each do |key,value|
			set key.to_sym, value
		end
	end
end

require './helpers'
require './routes'


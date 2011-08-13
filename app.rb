#!/usr/bin/env ruby

require 'sinatra'
require 'erubis'
require 'uri'

Tilt.register :erb, Tilt[:erubis]

configure do
	uristr = ENV['MONGOHQ_URL']
	uri = URI.parse(uristr)
	
	mongo = {}
	mongo['host'] = uri.host
	mongo['port'] = uri.port
	mongo['database'] = uri.path[1..-1]
	mongo['username'] = uri.user
	mongo['password'] = uri.password

	set :mongo, mongo
end

require './helpers'
require './routes'


require './models/document'
require 'date'

class Commit < Document
	def initialize(dict)
		if dict.key? 'timestamp' and dict['timestamp'].kind_of? String
			dict['timestamp'] = DateTime.strptime(dict['timestamp'])
		end
		super(dict)
	end
	
	def timestamp
		@dict['timestamp'].strftime('%a, %d %b %H:%M:%S +0000')
	end
	
	def to_h
		dict = @dict.clone
		dict['timestamp'] = dict['timestamp'].strftime
		return dict
	end
end

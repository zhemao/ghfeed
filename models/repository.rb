require './models/document'
require './models/commit'

class Repo < Document
	def initialize(dict)
		if dict.key? 'commits'
			dict['commits'] = dict['commits'].map{|com| Commit.new(com) }
		end
		super(dict)
	end
	
	def end_date
		@dict['commits'][0].timestamp
	end
	
	def start_date
		@dict['commits'][-1].timestamp
	end
	
	def to_h
		dict = @dict.clone
		dict['commits'] = dict['commits'].map{|com| com.to_h }
		return dict
	end
end

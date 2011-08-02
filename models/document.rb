require 'json'

class Document

	def self.from_json(json)
		self.new(JSON.parse(json))
	end

	def initialize(dict)
		@dict = dict.clone
	end
	
	def method_missing(name, value=nil)
		sym = name
		name = name.to_s
		if name[-1] == '='
			name = name[0...-1]
			@dict[name] = value
		elsif @dict.key? name
			return @dict[name] 
		elsif @dict.key? sym
			return @dict[sym]
		end
	end
	
	def [](key)
		return @dict[key]
	end
	
	def []=(key, value)
		@dict[key] = value
	end
	
	def to_h
		@dict.clone
	end
	
	def save(coll)
		if @dict.key? '_id'
			coll.update({'_id'=>@dict['_id']}, self.to_h)
		else
			@dict['_id'] = coll.insert(self.to_h)
		end
	end
end

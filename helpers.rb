require './document'
require 'mongo'

helpers do
	def connect(collname)
		if $db.nil?
			mongo = settings.mongo
			conn = Mongo::Connection.new(mongo['host'], mongo['port'])
			$db = conn.db(mongo['database'])
		end
		return $db[collname]
	end
	
	def get_repo(url)
		coll = connect('repos')
		dict = coll.find_one({'url' => url})
		return nil if dict.nil?
		return Document.new(dict)
	end
	
	def save_repo(repo)
		coll = connect('repos')
		repo.save(coll)
	end
	
	def update_feed(payload)
		url = payload.repository['url']
		commits = payload.commits.find_all do |commit|
			message = commit.message
			message =~ /@rss/i
		end
		repo = get_repo(url)
		if repo.nil?
			repo = Document.new(payload.repository)
			repo.commits = commits
		else
			repo.commits = commits + repo.commits
		end
		save_repo(repo)
	end
end

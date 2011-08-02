require 'json'

get '/' do
	erb :index
end

post '/' do
	payload = Document.from_json(params[:payload])
	update_feed(payload)
	return "Got it, thanks\n"
end

get '/:user/:repo' do
	user = params[:user]
	repo = params[:repo]
	url = "https://github.com/#{user}/#{repo}"
	repo = get_repo(url)
	if repo.nil? 
		return 404 
	end
	
	return 200, {'Content-Type' => 'application/rss+xml'}, 
		(erb :feed, :locals => {:repo => repo})
end

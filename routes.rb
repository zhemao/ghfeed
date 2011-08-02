require 'json'

get '/' do
	redirect to('/index.html')
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
	
	return 200, {'Content-Type' => 'application/xml'}, 
		(erb :feed, :locals => {:repo => repo})
end

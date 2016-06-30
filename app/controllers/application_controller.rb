require_relative '../../config/environment'

class ApplicationController < Sinatra::Base


  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do 
    
  end

  get '/posts/new' do
    erb :new  #rrenders(displays the view) w/o changing the url 
  end

  post '/posts' do
    Post.create(params)
    redirect '/posts' #send a get rquest /posts
  end

  get '/posts' do 
    @allposts = Post.all
    @deleted
    erb :index
  end 

  get '/posts/:id' do
    @post=Post.find(params["id"])
    erb :show 
  end

  get '/posts/:id/edit' do
     @post=Post.find(params["id"])
     erb :edit
  end

  patch '/posts/:id' do
     @post=Post.find(params["id"])
     @post.update(name:params["name"],content:params["content"])
    redirect to "/posts/#{@post.id}"
  end

  delete '/posts/:id/delete' do 

    @post=Post.find(params["id"])
    @deleted=@post
    Post.delete(@post.id)

    erb :deleted 


  end 

end
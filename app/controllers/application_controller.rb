
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end


  get "/" do
    erb :homepage
  end

  get "/articles/new" do
    erb :new
  end

  get "/articles" do
    @articles = Article.all
    erb :index
  end

  post "/articles" do
    title = params[:title]
    content = params[:content]
    article = Article.find_or_create_by(
      title: title,
      content: content
      )
    redirect "/articles/#{article.id}"

  end

  get "/articles/:id" do
    article_id = params[:id]
    @article = Article.find(article_id)
    erb :show
  end

end




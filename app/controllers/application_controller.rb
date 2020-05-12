
require_relative '../../config/environment'


class ApplicationController < Sinatra::Base

  set :views, "app/views"
  set :method_override, true


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

  get "/articles/:id/edit" do
     @article= Article.find(params[:id])
     erb :edit
  end

  patch "/articles/:id" do
     article = Article.find(params[:id])
     article.update(title: params[:title], content: params[:content])
     redirect "/articles/#{article.id}"
  end

  delete "/articles/:id" do
    Article.delete(params[:id])
    redirect "/articles"
  end

#   put "/books/:id" do 
#     book = Book.find(params[:id])
#     book.update(title: params[:title],
#                  author: params[:author],
#                  snippet: params[:snippet])
#     redirect "/books/#{book.id}"
# end


end




class ArticlesController < ApplicationController
  
  
  def index
    @articles = Article.all
  end
  
  # GET request: when the articles/new URL is visited, run this instance method
  # A new Article object is saved inside the instance variable @article
  # This lets us generating the article creator form, as the form inputs are derived from the @article variable
  def new
    @article = Article.new
  end
  
  # POST request: when the article creator form is submitted, run this instance method
  # The form inputs are saved as defined by method "article_params", and used to generate the article object with inputed title & description
  # Article object is then saved as a new database record
  # If article object is successfully saved (passed validations), then show flash message & redirect user to created article's show page
  # If article object failed validations, then render article/new again
  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article successfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end
  
  # Renders show.html.erb
  # The view template uses the instance variable's key-values (e.g. @article.title) for dynamic content
  def show
    @article = Article.find(params[:id])
  end
  
  # GET request: When the articles/:id/edit URL is visited, run this instance method
  # the article object (id according to the URL) is saved into instance variable @articles
  # edit.html.erb is rendered. The form takes the existing values from @article
  def edit
    @article = Article.find(params[:id])
  end
  
  # PATCH request: When the selected article is updated, show flash message & redirect to the article's show page.
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Article successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end
  
  # Tell Rails which attributes are allowed for new article objects – title and description
  private  
    def article_params
      params.require(:article).permit(:title, :description)
    end
  
end
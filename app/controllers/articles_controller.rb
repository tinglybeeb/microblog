class ArticlesController < ApplicationController
  
  # Before selected actions run, run this method:
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  
  # GET request: when the /articles URL is visited, render the index.html.erb view
  # The view uses the @articles object to generate dynamic content. @articles contains all the articles saved in the database
  def index
    # @articles = Article.all
    @articles = Article.paginate(:page => params[:page], :per_page => 5)
  end
  
  # GET request: when the /articles/new URL is visited, run this instance method
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
    @article.user = current_user
    @article.save
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
    set_article
  end
  
  # GET request: When the articles/:id/edit URL is visited, run this instance method
  # the article object (id according to the URL) is saved into instance variable @articles
  # edit.html.erb is rendered. The form takes the existing values from @article
  def edit
    set_article
  end
  
  # PATCH request: When the selected article is updated, show flash message & redirect to the article's show page.
  def update
    set_article
    @article.update(article_params)
    if @article.update(article_params)
      flash[:notice] = "Article successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end
  
  # DELETE request: When the :delete method is called on the selected article (identified with params)...
  # Then destroy that article, show flash message, and redirect to articles list
  def destroy
    set_article
    @article.destroy
    flash[:notice] = "Article successfully deleted"
    redirect_to articles_path
  end
  
  private  
    # sets the article to be engaged with (edited, shown, updated, destroyed)
    # question: how does "params[:id]" work?
    def set_article
      @article = Article.find(params[:id])
    end
    
    # Tell Rails which attributes are allowed for new article objects – title and description
    def article_params
      params.require(:article).permit(:title, :description, :image)
    end
  
end
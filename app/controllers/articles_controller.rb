class ArticlesController < ApplicationController
  
  # GET request: when the articles/new page is visited, run this instance method
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
  
  def show
    @article = Article.find(params[:id])
  end
  
  # Tell Rails which attributes are allowed for new article objects – title and description
  private  
    def article_params
      params.require(:article).permit(:title, :description)
    end
  
end
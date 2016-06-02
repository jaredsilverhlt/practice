class ArticlesController < ApplicationController
	
	# http_basic_authenticate_with name: "hlt", password: "HLTMastery", except: [:index, :show]

	before_action :authenticate_user!, except: [:index, :show]

	def index
		@articles = Article.all
	end

	def api
		iDontKnowWhatImDoing = []
		articles = Article.all.order(created_at: :desc).each do |a|
			iDontKnowWhatImDoing.push({
				id: a.id,
				title: a.title,
				text: a.text,
				created_at: a.created_at,
				updated_at: a.updated_at,
				comments: a.comment_ids
			})
		end

		respond_to do |format|
			format.json { render :json => iDontKnowWhatImDoing.to_json }
		end

	end

	def show
		@article = Article.find(params[:id])
	end

	def new
		@article = Article.new
	end

	def edit
		@article = Article.find(params[:id])
	end

	def create
		@article = Article.new(article_params)
		
		if @article.save
			redirect_to @article
		else
			render 'new'
		end
	end

	def update
		@article = Article.find(params[:id])

		if @article.update(article_params)
			redirect_to @article
		else
			render 'edit'
		end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy

		redirect_to articles_path
	end

	private
		def article_params
			params.require(:article).permit(:title, :text)
		end
end
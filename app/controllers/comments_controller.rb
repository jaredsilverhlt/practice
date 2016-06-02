class CommentsController < ApplicationController

	# http_basic_authenticate_with name: "hlt", password: "HLTMastery", only: [:destroy, :all]

	before_action :authenticate_user!, only: [:destroy, :all]

	def all
		params.permit(:page)
		@page = params[:page].to_i > 0 ? params[:page].to_i : 1
		@pages = Comment.count / 10 + 1
		@comments = Comment.order(created_at: :desc).limit(10).offset((@page - 1) * 10)
	end

	def api
		comments = Comment.all.order(created_at: :desc)
		respond_to do |format|
			format.json { render :json => comments.to_json }
		end
	end

	def create
		article = Article.find(params[:article_id])
		comment = article.comments.create(comment_params)
		redirect_to article_path(article)
	end

	def destroy
		article = Article.find(params[:article_id])
		comment = article.comments.find(params[:id])
		comment.destroy
		if(params[:admin])
			redirect_to '/admin/comments'
		else
			redirect_to article_path(article)
		end
	end

	private
		def comment_params
			params.require(:comment).permit(:commenter, :body)
		end
end

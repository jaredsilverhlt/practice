require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

	test "should not save article without title" do
		article = Article.new
		assert_not article.save
	end

	test "should not save article with title less than 5 characters" do
		article = Article.new
		article.title = "test"
		assert_not article.save
	end

end

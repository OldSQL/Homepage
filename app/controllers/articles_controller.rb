# Copyright 2015 Unicode4all
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License. 

require('date')
class ArticlesController < ApplicationController
  
  def show
    @article = Article.find(params[:id])
    @page_title = @article.title
  end

  def new
    authorize! :create, @article
    @page_title = "Create Article"
    @article = Article.new
  end

  def index
    @page_title = "Blog"
    @articles = Article.paginate(:per_page => 3, :page => params[:page]).order("written_on DESC")
  end

  def edit
    authorize! :edit, @article
    @article = Article.find(params[:id])
  end

  def destroy
    authorize! :destroy, @article
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def create
    #	uploaded_io = params[:article][:image]
    #	File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
    #	file.write(uploaded_io.read)

    #end

  	@article = Article.new(article_params)
    @article.image = "deprecated"
    
    @article.save
    redirect_to @article
  end
end

private
def article_params
  params.require(:article).permit(:title, :image, :overview, :text)
end

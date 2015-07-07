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

class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    if verify_recaptcha(:model => @comment, :message => "Oh! It's error with reCAPTCHA!")
    @article = Article.find(params[:article_id])
    p = comment_params
    p[:commenter] = current_user.name
    @comment = @article.comments.create(p)
    flash[:notice] = "Comment created successfully"
    redirect_to article_path(@article)
    else    
      @article = Article.find(params[:article_id])
      flash[:alert] = "Failed to verify captcha"
      redirect_to article_path(@article)
    end
  end

  def destroy
    authorize! :destroy, @comment
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    flash[:notice] = "Comment deleted successfully"
    redirect_to article_path(@article)
  end
 
  private
  def comment_params
    params.require(:comment).permit(:commenter , :body)
  end
end

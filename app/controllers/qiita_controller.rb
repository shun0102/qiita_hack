class QiitaController < ApplicationController

  def update
    @user = User.find(:first)
    @user.auth_qiita
    # @user.pull_or_clone_from_github
    @user.publish_qiita
  end

end

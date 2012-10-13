class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :qiita_update_at, :repo_name, :token, :url_name, :new_flag, :password
  before_create :set_qiita_token

  def set_qiita_token
    @qiita = Qiita.new({ :url_name => self.url_name, :password => self.password })
    self.token = @qiita.token
  end

  def auth_qiita
    @qiita = Qiita.new({ :token => self.token})
    @repo="git://github.com/#{self.url_name}/#{self.repo_name}"
    @basedir="#{Rails.public_path}/users/#{self.url_name}"
  end

  def upload_contents(contents)
    title = contents[0]
    body = contents[1..-1].join("").strip.chomp
    item = { :title => title, :body => body, :tags => [{ :name => 'default'}], :private => false}
    @qiita.post_item item
  end

  def pull_or_clone_from_github
    if self.new_flag
      `mkdir -p #{@basedir}`
      `git clone #{@repo} #{@basedir}`
      self.new_flag = false
      self.save
    else
    end
  end

  def publish_qiita
    Dir.glob("#{@basedir}/*.md") do |f|
      contents = open(f).readlines
      upload_contents(contents)
    end
  end

  def qiita
    @qiita
  end

end

EDITOR_CMD = "open -a \"/Applications/iA Writer.app\""

task :commit_content do
  `git checkout main`
  `git add content/`
  `git commit -m "Add content #{Time.now}"`
end

task publish: :commit_content do
  `git push origin main`
end

namespace :posts do
  task :new, [:file_name] do |t, args|
    post = Posts.from_slug(args[:file_name])
    post.create!
    post.edit
  end
end

namespace :weeknotes do
  task :new do
    edit_file Weeknotes.new.create_next!
  end
end

# ---------

class Weeknotes
  def initialize(weeknote_dir)
    @weeknote_dir = weeknote_dir
  end

  def create!(file_name)
    mkdir_p current_dir unless Dir.exists? current_dir
    `hugo new #{File.join @weeknote_dir, file_name} -k posts`
  end

  def create_next!
    file_name = next_file @weeknote_dir
    Post.new(file_name).create!
    File.join current_dir, file_name
  end

  def current_dir
    File.join "content/posts/weeknotes", Time.now.year.to_s
  end

  def all
    Dir.glob(File.join(@weeknote_dir, "*.md"))
  end

  def next_file
    weeknotes = all
    return "01.md" if weeknotes.empty?

    weeknotes.map do |w|
      File.basename(w, ".md").to_i
    end.max.next.to_s.rjust(2, "0").concat(".md")
  end
end

class Posts
  def initialize(file_name)
    @file_name = file_name
  end

  def self.from_slug(slug)
    Posts.new "#{slug}.md"
  end

  def create!
    `hugo new posts/#{@file_name}`
  end

  def edit
    edit_file("content/posts/#{@file_name}")
  end
end

def edit_file(file_name)
  `#{EDITOR_CMD} content/posts/#{@file_name}`
end
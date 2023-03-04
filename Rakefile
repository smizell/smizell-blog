require "fileutils"
require "yaml"

EDITOR_CMD = "open -a \"/Applications/iA Writer.app\""
SCHEDULE_FILE = "schedule.txt"

task default: [:commit_content]

desc "Commit files in the content directory"
task :commit_content do
  `git checkout main`
  `git add language-oriented-approach/ content/ static/ config.toml schedule.txt`
  `git commit -S -m "Updated #{Time.now}"`
end

desc "Deploy site"
task deploy: :commit_content do
  `git push origin main`
end

desc "Push, same as deploy"
task push: :deploy

desc "Publish, same as deploy"
task publish: :deploy

namespace :load do
  task :serve do
    `mdbook serve language-oriented-approach --open`
  end

  task :build do
    `rm -rf static/language-oriented-approach`
    `mdbook build language-oriented-approach -d ../static/language-oriented-approach`
  end
end

namespace :posts do
  desc "Create a new post and open editor"
  task :new, [:slug] do |t, args|
    post = Content.new_post(args[:slug])
    post.create!
    post.edit
  end

  desc "Count posts"
  task :count do
    post_count = `find ./content/posts -type f -name "*.md" | wc -l`.strip
    puts "You've written #{post_count} posts!"
  end
end

namespace :weeknotes do
  desc "Create a new weeknote and open editor"
  task :new do
    weeknote = Content.new_weeknote
    weeknote.create!
    weeknote.edit
  end
end

namespace :schedule do
  desc "Publish the top post in the schedule"
  task :publish do
    schedule = File.readlines SCHEDULE_FILE
    top = schedule.shift
    if top.nil?
      puts "Nothing scheduled"
      next
    end
    top.strip!
    file_name = File.join("content", top)
    text = File.read file_name
    _, frontmatter_yaml, body = text.split("---").map(&:strip)
    frontmatter = YAML.safe_load frontmatter_yaml
    frontmatter.delete "draft" if frontmatter.key? "draft"
    frontmatter["date"] = Time.now.strftime("%FT%T%:z")
    new_text = <<~TXT
      #{YAML.dump(frontmatter).strip}
      ---

      #{body}
    TXT
    File.write file_name, new_text
    File.write SCHEDULE_FILE, schedule.join("\n")
  end

  desc "Schedule a new post"
  task :new, [:slug] do |t, args|
    post = Content.new_post(args[:slug])
    if post.exists?
      puts "File #{post.file_path} already exists."
      next
    end
    post.create!
    schedule = File.readlines SCHEDULE_FILE
    schedule.push post.file_path
    File.write SCHEDULE_FILE, schedule.join("\n").concat("\n")
    post.edit
  end

  desc "Schedule an existing post"
  task :existing, [:file_path] do |t, args|
    schedule = File.readlines SCHEDULE_FILE
    schedule.push args[:file_path]
    File.write SCHEDULE_FILE, schedule.join("\n").concat("\n")
  end
end

# ---------

class Content
  attr_reader :file_path

  def initialize(file_path, kind = "posts")
    @file_path = file_path
    @kind = kind
  end

  def self.new_post(slug)
    Content.new File.join("posts", slug.concat(".md"))
  end

  def self.new_weeknote
    dir = File.join "posts/weeknotes", Time.now.year.to_s
    weeknotes = Dir.glob(File.join("content", dir, "*.md"))
    return Content.new(File.join(dir, "01.md"), "weeknotes") if weeknotes.empty?
    file_name = weeknotes.map do |w|
      File.basename(w, ".md").to_i
    end.max.next.to_s.rjust(2, "0").concat(".md")
    Content.new File.join(dir, file_name), "weeknotes"
  end

  def create!
    FileUtils.mkdir_p content_path unless Dir.exist? directory
    `hugo new #{content_path} -k #{@kind}`
  end

  def edit
    `#{EDITOR_CMD} #{content_path}`
  end

  def exists?
    File.exist? content_path
  end

  def content_path
    File.join("content", @file_path)
  end

  def directory
    File.join("content", File.dirname(@file_path))
  end
end

require "yaml"

EDITOR_CMD = "open -a \"/Applications/iA Writer.app\""

task :default => [:commit_content]

desc "Commit files in the content directory"
task :commit_content do
  `git checkout main`
  `git add content/`
  `git commit -m "Add content #{Time.now}"`
end

desc "Deploy site"
task deploy: :commit_content do
  `git push origin main`
end

namespace :posts do
  desc "Create a new post and open editor"
  task :new, [:slug] do |t, args|
    post = Content.new_post(args[:slug])
    post.create!
    post.edit
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
    schedule = File.readlines "schedule.txt"
    top = schedule.shift.strip
    file_name = File.join("content", top)
    text = File.read file_name
    _, frontmatter_yaml, body = text.split("---").map(&:strip)
    frontmatter = YAML.load frontmatter_yaml
    frontmatter.delete "draft" if frontmatter.key? "draft"
    frontmatter["date"] = Time.now.strftime('%FT%T%:z')
    new_text = <<~TXT
      #{YAML.dump(frontmatter).strip}
      ---

      #{body}
    TXT
    File.write file_name, new_text
    File.write "schedule.txt", schedule.join("\n")
  end
end

# ---------

class Content
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
    return Content.new File.join(dir, "01.md"), weeknotes if weeknotes.empty?
    file_name = weeknotes.map do |w|
      File.basename(w, ".md").to_i
    end.max.next.to_s.rjust(2, "0").concat(".md")
    Content.new File.join(dir, file_name), "weeknotes"
  end

  def create!
    mkdir_p current_dir unless Dir.exists? File.join("content", File.dirname(@file_path))
    `hugo new #{@file_path} -k #{@kind}`
  end

  def edit
    `#{EDITOR_CMD} #{File.join("content", @file_path)}`
  end
end

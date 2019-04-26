# Fix for error: `no such file to load -- rspec/core/rake_task`

# Heroku builds apps without the Gemfile's development/test groups, which is where we have rspec installed 
# So when Heroku runs the Rakefile it expects rspec even though it doesn't exist in production
# That's why we need to add an unless to make sure we only run rspec outside of production

unless Rails.env.production?
  begin
    require 'rspec/core/rake_task'

    task :default => :spec

    RSpec::Core::RakeTask.new("spec:acceptance") do |t|
      t.rspec_opts = "--tag acceptance"
    end
  end
end
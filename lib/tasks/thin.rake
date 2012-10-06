namespace :thin do
  namespace :cluster do
    desc 'Start thin cluster'
    task :start =&gt; :environment do
      `cd #{RAILS_ROOT}`
      port_range = RAILS_ENV == 'development' ? 3 : 8
      (ENV['SIZE'] ? ENV['SIZE'].to_i : 4).times do |i|
        Thread.new do
          port = ENV['PORT'] ? ENV['PORT'].to_i + i : ("#{port_range}%03d" % i)
          str  = "thin start -d -p#{port} -Ptmp/pids/thin-#{port}.pid"
          str += " -e#{RAILS_ENV}"
          puts str
          puts "Starting server on port #{port}..."
          `#{str}`
        end
      end
    end
desc 'Stop all thin clusters'
    task :stop =&gt; :environment do
      `cd #{RAILS_ROOT}`
      Dir.new("#{RAILS_ROOT}/tmp/pids").each do |file|
        Thread.new do
          if file.starts_with?("thin-")
            str  = "thin stop -Ptmp/pids/#{file}"
            puts "Stopping server on port #{file[/d+/]}..."
            `#{str}`
          end
        end
      end
    end
  end
end
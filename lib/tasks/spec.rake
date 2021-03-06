Rake::Task["spec"].clear if Rake::Task.task_defined?('spec')

namespace :spec do
  desc 'GITLAB | Run feature specs'
  task :api do
    cmds = [
      %W(rake gitlab:setup),
      %W(rspec spec --tag @api)
    ]
    run_commands(cmds)
  end

  desc 'GITLAB | Run other specs'
  task :other do
    cmds = [
      %W(rake gitlab:setup),
      %W(rspec spec --tag ~@api)
    ]
    run_commands(cmds)
  end
end

desc "GITLAB | Run specs"
task :spec do
  cmds = [
    %W(rake gitlab:setup),
    %W(rspec spec),
  ]
  run_commands(cmds)
end

def run_commands(cmds)
  cmds.each do |cmd|
    system({'RAILS_ENV' => 'test', 'force' => 'yes'}, *cmd)
    raise "#{cmd} failed!" unless $?.exitstatus.zero?
  end
end

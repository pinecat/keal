# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "standard/rake"
require "rake/extensiontask"

Rake::ExtensionTask.new "gsettings" do |ext|
  ext.lib_dir = "lib/gsettings"
end

namespace :install do
  task :service do
    FileUtils.cp("./dist/keald.local.service", "/usr/lib/systemd/system/keald.service")
    system("systemctl daemon-reload")
  end
end

namespace :uninstall do
  task :service do
    FileUtils.rm("/usr/lib/systemd/system/keald.service")
    system("systemctl daemon-reload")
  end
end

task default: %i[compile spec standard]

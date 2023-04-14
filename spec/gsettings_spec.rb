# frozen_string_literal: true

require "etc"

RSpec.describe GSettings do
  it "has a version number" do
    expect(GSettings::VERSION).not_to be nil
  end

  gsettings = GSettings.new
  idle = -1
  lock = nil

  it "can read an 'org.gnome.desktop.session idle-delay' value" do
    idle = gsettings.idle_delay
    expect(idle).not_to be(-1)
  end

  it "can write an 'org.gnome.desktop.session idle-delay' value" do
    success = gsettings.idle_delay idle
    expect(success).to be 0
  end

  it "can read an 'org.gnome.desktop.lockdown disable-lock-screen' value" do
    lock = gsettings.disable_lock_screen
    expect(lock).not_to be nil
  end

  it "can write an 'org.gnome.desktop.lockdown disable-lock-screen' value" do
    success = gsettings.disable_lock_screen lock
    expect(success).to be 0
  end

  it "can get the current user's UID" do
    user = Etc.getpwnam(Etc.getlogin)
    uid = gsettings.get_env_uid
    expect(uid).to eq(user.uid)
  end

  it "can get the current user's HOME environment variable" do
    user = Etc.getpwnam(Etc.getlogin)
    home = gsettings.get_env_home
    expect(home).to eq(user.dir)
  end
end

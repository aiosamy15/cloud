require 'calabash-android/management/adb'
require 'calabash-android/operations'
include Calabash::Android::Operations

Before do |scenario|
  #start_test_server_in_background
   # $startTime = Time.now.to_f
end

After do |scenario|
  if scenario.failed?
    screenshot_embed
  end
  shutdown_test_server
end

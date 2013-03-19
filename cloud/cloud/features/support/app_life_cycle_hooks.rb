require 'calabash-android/management/adb'
require 'calabash-android/operations'
include Calabash::Android::Operations

Before do |scenario|
      #$startTime = Time.now.to_f
  #start_test_server_in_background

end

After do |scenario|
  if scenario.failed?
  screenshot_embed
  
     begin
  shutdown_test_server
rescue Exception => e
end

else
end

   begin
  shutdown_test_server
rescue Exception => e
#  puts "Shutting down the test server"
end
end

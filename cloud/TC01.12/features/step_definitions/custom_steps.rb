#require 'watir-webdriver' 
require 'test/unit'
include Test::Unit::Assertions

Given /^I login to cloud app$/ do
  start_test_server_in_background
    $startTime = Time.now.to_f
view='gridview'
id='latest_items_preview'
if waittillviewisshown(view,id)
elapsedTime = Time.now.to_f - $startTime
   puts "KPI-For-Nagios: cloud;startup|OOBE startup time for cloud app;time="+elapsedTime.to_s+"s"
else
       
        puts 'Cloud main page with recently uploaded photos was not shown in time'
        views = performAction('dump_view_hierarchy')
puts views['bonusInformation']
        performAction('exit_wait_for_view_by_id', 'expectedview')
        end
end


When /^I open cloud picture menu$/ do
performAction('wait_for_view_by_id','menu_button')
performAction('click_on_view_by_id','menu_button')
performAction('wait_for_view_by_id','sliding_menu_item_photos')
performAction('click_on_view_by_id','sliding_menu_item_photos')
end

Then /^I see the uploaded pictures in grid view$/ do
view='imageview'
id='media_griditem_thumbnail'
if waittillviewisshown(view,id)
else
       
        puts 'Cloud picture menus was not shown in time'
        views = performAction('dump_view_hierarchy')
puts views['bonusInformation']
        performAction('exit_wait_for_view_by_id', 'expectedview')
        end
end

When /^I open one of the pictures$/ do
view='imageview'
id='media_griditem_thumbnail'
if waittillviewisshown(view,id)
else
       
        puts 'Cloud picture menus was not shown in time'
        views = performAction('dump_view_hierarchy')
puts views['bonusInformation']
        performAction('exit_wait_for_view_by_id', 'expectedview')
        end
performAction('wait_for_view_by_id','media_griditem_thumbnail')
sleep 2
performAction('click_on_view_by_id','media_griditem_thumbnail')
sleep 3
end

Then /^I can see the pictures are opened in the image viewer$/ do
performAction('wait_for_view_by_id','photos_view_pager_item_imageview')
#performAction('click_on_view_by_id','media_griditem_thumbnail'
end

Then /^I swipe right to see the next picture$/ do 
performAction('wait_for_view_by_id','photos_view_pager_item_imageview')
performAction('swipe','right')
sleep 3
end

When /^I touch the opened picture$/ do
performAction('wait_for_view_by_id','photos_view_pager')
performAction('click_on_view_by_id','photos_view_pager')
end

Then /^I see the contextual menu$/ do
#performAction('wait_for_view_by_id','photos_view_pager')
#performAction('click_on_view_by_id','photos_view_pager')
#performAction('press_menu')
end

Then /^I can zoom in$/ do
performAction("doubletouch_coordinate", 315.5,363.5)
#performAction('click_on_view_by_id','photos_view_pager')
end 

Then /^I can zoon out$/ do
performAction("doubletouch_coordinate", 315.5,363.5)
#performAction('click_on_view_by_id','photos_view_pager')
end

Then /^I go back and see the pictures in grid view$/ do
performAction('go_back')
#performAction('go_back')
#sleep 4
#view='imageview'
#id='media_griditem_thumbnail'
#if waittillviewisshown(view,id)
#else
       
#        puts 'Cloud picture menus was not shown in time'
#        performAction('exit_wait_for_view_by_id', 'expectedview')
#        end

#performAction('wait_for_view_by_id','media_griditem_thumbnail')
end



When /^I open cloud video menu$/ do
performAction('wait_for_view_by_id','menu_button')
performAction('click_on_view_by_id','menu_button')
performAction('wait_for_view_by_id','sliding_menu_item_videos')
performAction('click_on_view_by_id','sliding_menu_item_videos')
end

Then /^I see the uploaded videos in grid view$/ do
view='imageview'
id='media_griditem_thumbnail'
if waittillviewisshown(view,id)
else
       
        puts 'Cloud video menu was not shown in time'
        views = performAction('dump_view_hierarchy')
puts views['bonusInformation']
        performAction('exit_wait_for_view_by_id', 'expectedview')
        end
end

When /^I open one of the videos$/ do
system 'adb -s $ADB_DEVICE_ARG logcat -b events -c' # clearing the logs
view='imageview'
id='media_griditem_thumbnail'
if waittillviewisshown(view,id)
else
       
        puts 'Cloud videos list were not shown in time'
        performAction('exit_wait_for_view_by_id', 'expectedview')
        end
performAction('wait_for_view_by_id','media_griditem_thumbnail')
sleep 2
performAction('click_on_view_by_id','media_griditem_thumbnail')
end

Then /^I can see the video is opened by the media player$/ do
count = 1
value =""
while  (value == "")
value=`adb -s $ADB_DEVICE_ARG logcat -b events -d | grep android.intent.action.VIEW`
sleep(1.0/5.0)
if count == 100
puts 'Media player was not opened in time'
views = performAction('dump_view_hierarchy')
puts views['bonusInformation']
   performAction('exit_wait_for_view_by_id', 'expectedview')
else
count = count + 1
end 
end
sleep 12
end


Then /^I watch the full video$/ do

end

When /^the video is finished$/ do
count = 1  
while (count <=1200)
#queryparam = "\""+view+ " id:'" + id + "'"
sleep 0.2
if (query("imageview").to_s.include? 'media_griditem_thumbnail') == true
break
else
count = count + 1
end
end
end

Then /^I see the video menu again$/ do
view='imageview'
id='media_griditem_thumbnail'
if waittillviewisshown(view,id)
else
       
        puts 'Cloud video menu was not shown in time'
        views = performAction('dump_view_hierarchy')
puts views['bonusInformation']
        performAction('exit_wait_for_view_by_id', 'expectedview')
        end
end


When /^I open cloud music menu$/ do
performAction('wait_for_view_by_id','menu_button')
performAction('click_on_view_by_id','menu_button')
performAction('wait_for_view_by_id','sliding_menu_item_music')
performAction('click_on_view_by_id','sliding_menu_item_music')
end

Then /^I see the uploaded music in list view$/ do
view='imageview'
id='media_listitem_thumbnail'
if waittillviewisshown(view,id)
else
       
        puts 'Cloud music menu was not shown in time'
        views = performAction('dump_view_hierarchy')
puts views['bonusInformation']
        performAction('exit_wait_for_view_by_id', 'expectedview')
        end
end

When /^I open one of the music$/ do
system 'adb -s $ADB_DEVICE_ARG logcat -b events -c' # clearing the logs
view='imageview'
id='media_listitem_thumbnail'
if waittillviewisshown(view,id)
else
       
        puts 'Cloud music list was not shown in time'
        views = performAction('dump_view_hierarchy')
puts views['bonusInformation']
        performAction('exit_wait_for_view_by_id', 'expectedview')
        end
performAction('wait_for_view_by_id','media_listitem_thumbnail')
sleep 2
performAction('click_on_view_by_id','media_listitem_thumbnail')
end

Then /^I can see the music is opened by the audio player$/ do
count = 1
value =""
while  (value == "")
value=`adb -s $ADB_DEVICE_ARG logcat -b events -d | grep android.intent.action.VIEW`
sleep(1.0/5.0)
if count == 100
puts 'Music player was not opened in time'
   performAction('exit_wait_for_view_by_id', 'expectedview')
else
count = count + 1
end 
end
sleep 15
end

Then /^I listen to the full music$/ do

end

When /^the music is fully played$/ do

count = 1  
while (count <=1200)
#queryparam = "\""+view+ " id:'" + id + "'"
sleep 0.2
if (query("imageview").to_s.include? 'media_listitem_thumbnail') == true
break
else
count = count + 1
end
end
end


Then /^I see the music menu again$/ do
view='imageview'
id='media_listitem_thumbnail'
if waittillviewisshown(view,id)
else
       
        puts 'Cloud music menu was not shown in time'
        views = performAction('dump_view_hierarchy')
puts views['bonusInformation']
        performAction('exit_wait_for_view_by_id', 'expectedview')
        end
end

def waittillviewisshown(view,id)
count = 1  
while (count <=100)
queryparam = "\""+view+ " id:'" + id + "'"
sleep 0.2
if (query(queryparam).to_s.include? id) == true
return true
else
count = count + 1
 if ((query(queryparam).to_s.include? id) == false && count >= 100) then
return false
else end 
end
end
end

Given /^cloud app is running on the device$/ do

system 'adb -s $ADB_DEVICE_ARG shell  pm clear com.vodafone.cloud2'
start_test_server_in_background
performAction('wait_for_view_by_id', 'buttonnext_safestorage_splashscreen')
performAction('click_on_view_by_id', 'buttonnext_safestorage_splashscreen')
view='textview'
id ='textView_automatic_upload_splashscreen_descr'
if waittillviewisshown(view,id)
        #comment due to issue in galaxy 2
        performAction('wait_for_view_by_id', 'buttonnext_safestorage_splashscreen')
        performAction('click_on_view_by_id', 'buttonnext_safestorage_splashscreen')
         #performAction('press_button_with_text','Next')
         $startTime = Time.now.to_f
else
        #macro 'I take a screenshot'
        puts 'Automatic upload details view was not able to show up in time'
        performAction('exit_wait_for_view_by_id', 'expectedview')
        #exit
        end
        
 view='textview'
id='login_userid_info'
if waittillviewisshown(view,id)
 performAction('press_button_with_text', 'Log in')
else
        #macro 'I take a screenshot'
        puts 'Account status was not able to show up in time'
        views = performAction('dump_view_hierarchy')
puts views['bonusInformation']
performAction('exit_wait_for_view_by_id', 'expectedview')
#exit
 end       
        
        view='textview'
id = 'textview_backup_media_type_choices_descr'
if waittillviewisshown(view,id)

else
       #macro 'I take a screenshot'
        puts 'Not able signup in time'
        views = performAction('dump_view_hierarchy')
puts views['bonusInformation']
performAction('exit_wait_for_view_by_id', 'expectedview')
#exit
end
performAction('wait_for_view_by_id', 'button_next_step')
performAction('click_on_view_by_id', 'button_next_step')
performAction('wait_for_view_by_id', 'radio_button_choice_turnoff_autobackup')
performAction('click_on_view_by_id', 'radio_button_choice_turnoff_autobackup')
performAction('wait_for_view_by_id', 'button_backup_later')
performAction('click_on_view_by_id', 'button_backup_later')
#sleep 5
view='gridview'
id='latest_items_preview'
if waittillviewisshown(view,id)
else
       
        puts 'Cloud main page with recently uploaded photos was not shown in time'
        views = performAction('dump_view_hierarchy')
        puts views['bonusInformation']
        performAction('exit_wait_for_view_by_id', 'expectedview')
        end
shutdown_test_server
sleep 5
end

Then /^I logout$/ do
performAction('wait_for_view_by_id','menu_button')
performAction('click_on_view_by_id','menu_button')
performAction('wait_for_view_by_id','sliding_menu_item_settings')
performAction('click_on_view_by_id','sliding_menu_item_settings')
 view='textview'
id='storage_info_details'
if waittillviewisshown(view,id)
performAction('wait_for_view_by_id','logout_command')
else
        puts 'Settings menus was not show up in time'
        views = performAction('dump_view_hierarchy')
puts views['bonusInformation']
performAction('exit_wait_for_view_by_id', 'expectedview')
 end     
sleep 5
performAction('drag', 50, 50, 80,20,50 )
performAction('wait_for_view_by_id','logout_command')
performAction('click_on_view_by_id','logout_command')
performAction('wait_for_view_by_id','logout_confirm_button')
performAction('click_on_view_by_id' , 'logout_confirm_button')
performAction('wait_for_view_by_id', 'buttonnext_safestorage_splashscreen')
end

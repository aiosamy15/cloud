
require 'test/unit'
include Test::Unit::Assertions

Given /^I login to cloud app$/ do
  start_test_server_in_background
    $startTime = Time.now.to_f
performAction('wait_for_view_by_id','menu_button')
elapsedTime = Time.now.to_f - $startTime
   puts "KPI-For-Nagios: cloud;startup|OOBE startup time for cloud app;time="+elapsedTime.to_s+"s"
end



Then /^I select all the files to upload in cloud$/ do
system 'adb -s $ADB_DEVICE_ARG logcat -b events -c' # clearing the logs
performAction('wait_for_view_by_id','menu_button')
performAction('click_on_view_by_id','menu_button')
performAction('wait_for_view_by_id','backup_status_progress_synced_text')
performAction('click_on_view_by_id','backup_status_progress_synced_text')
performAction('wait_for_view_by_id','backup_info_title')
performAction('click_on_view_by_id','backup_info_title')
performAction('wait_for_view_by_id','backup_history_activity_button_new_upload')
performAction('click_on_view_by_id','backup_history_activity_button_new_upload')
performAction('wait_for_view_by_id','backup_selection_select_all_button')
performAction('click_on_view_by_id','backup_selection_select_all_button')
end

#V/Cloud2  ( 1631): Set upload for file id  4 to done
#V/Cloud2  ( 1631): Deleted alls file uploads

Then /^I upload all the available files$/ do
performAction('wait_for_view_by_id','backup_selection_backup_button')
performAction('click_on_view_by_id','backup_selection_backup_button')
end

Then /^I wait till the files are uploaded$/ do
count = 1
value =""
while  (value == "")
value=`adb -s $ADB_DEVICE_ARG logcat -b events -d | grep com.vodafone.cloud2/.ui.backup.BackupSelectionActivity,finish-imm`
sleep(1.0/5.0)
if count >= 3500
puts 'upload files was not finished in 10 miniutes'
views = performAction('dump_view_hierarchy')
puts views['bonusInformation']
   performAction('exit_wait_for_view_by_id', 'expectedview')
else
count = count + 1
end 
end
sleep 4
end

When /^I go to cloud main page$/ do
performAction('go_back')
sleep 4
end


Then /^I should see the last uploaded files$/ do
view='gridview'
id='latest_items_preview'
if waittillviewisshown(view,id) 
else
       
        puts 'Cloud main page with recently uploaded photos was not shown in time'
        views = performAction('dump_view_hierarchy')
         puts views['bonusInformation']
        performAction('exit_wait_for_view_by_id', 'expectedview')
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
performAction('wait_for_view_by_id','menu_button')
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






When /^I open cloud picture menu$/ do
performAction('wait_for_view_by_id','menu_button')
performAction('click_on_view_by_id','menu_button')
performAction('wait_for_view_by_id','sliding_menu_item_photos')
performAction('click_on_view_by_id','sliding_menu_item_photos')
end

Then /^I see the uploaded picture in grid view$/ do
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

When /^I open the uploaded the picture$/ do
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

Then /^I can see the picture is opened in the image viewer$/ do
performAction('wait_for_view_by_id','photos_view_pager_item_imageview')
end

Then /^I delete the picture$/ do
performAction('select_from_menu', 'Delete')
performAction('wait_for_view_by_id' , 'delete_file_ok_button')
performAction('click_on_view_by_id' , 'delete_file_ok_button')
view='button'
id='delete_file_done_button'
if waittillviewisshown(view,id)
performAction('click_on_view_by_id' , 'delete_file_done_button')
performAction('wait_for_view_by_id','menu_button')



else
   
        puts 'Picture deletion was not done in time'
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

Feature: Upload files

  Scenario: Upload files
    Given cloud app is running on the device
    Given I login to cloud app
    Then I select all the files to upload in cloud
    Then I take a screenshot
    Then I upload all the available files
    Then I take a screenshot
    Then I wait till the files are uploaded
    Then I take a screenshot
    When I go to cloud main page
    Then I should see the last uploaded files
    Then I take a screenshot
    Then I logout

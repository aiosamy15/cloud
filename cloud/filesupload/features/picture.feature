Feature: View and delete uploaded pictures in the device

  Scenario: View and delete uploaded pictures in the device
    Given cloud app is running on the device
    Given I login to cloud app
    When I open cloud picture menu
    Then I see the uploaded picture in grid view
    Then I take a screenshot
    When I open the uploaded the picture
    Then I can see the picture is opened in the image viewer
    Then I take a screenshot
    Then I delete the picture
    Then I take a screenshot
    Then I logout
    Then I take a screenshot

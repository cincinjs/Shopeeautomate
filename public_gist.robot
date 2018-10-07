*** Settings ***
Library             Selenium2Library
Suite Setup         Go to homepage
Suite Teardown       Close All Browsers

*** Variables ***
${HOMEPAGE}         https://gist.github.com/
${BROWSER}          chrome

#User Settings
${USERNAME}         change with your github account
${PASSWORD}         change with your password

#Text CONFIG
${DESCRIPTION}      Create public gist
${FILENAME}         publicgist.robot
${CONTENT}          Content public gist
${EDIT_CONTENT}          Content public gist

*** Test Cases ***
Create public gist
  Login
  Go to create gist page
  Input gist description
  Input filename
  Input content
  Save

Edit existing gist
   Login
   Click existing gist
   Click edit button

Delete existing gist
   Login
   Click existing gist
   Click delete button

Show list gist
   Login
   Go to list


*** Keywords ***
Go to homepage
  Open Browser        ${HOMEPAGE}             ${BROWSER}

Login
  Wait Until Element Is Visible       xpath=/html/body/div[1]/div[2]/div/div/div[2]/a[2]
  Click Element                       xpath=/html/body/div[1]/div[2]/div/div/div[2]/a[2]
  Wait Until Element Is Visible       id=login_field
  Input Text                          id=login_field    text=${USERNAME}
  Input Text                          id=password       text=${PASSWORD}
  Click Element                       xpath=//*[@id="login"]/form/div[2]/input[3]

Go to create gist page
  Wait Until Element Is Visible       xpath=//*[@id="user-links"]/li[1]/a
  Click Element                       xpath=//*[@id="user-links"]/li[1]/a

Input gist description
  Wait Until Element Is Visible       xpath=//*[@id="gists"]/input
  Input Text                          xpath=//*[@id="gists"]/input    text=${DESCRIPTION}

Input filename
  Input Text                          xpath=//*[@id="gists"]/div[2]/div/div[1]/div[2]/input[2]    text=${FILENAME}

Input content
  Click Element                       xpath=//*[@id="gists"]/div[2]/div/div[2]/div/div[5]/div[1]/div/div/div/div[5]/div/pre
  Click Element                       xpath=//*[@id="gists"]/div[2]/div/div[2]/div/div[5]/div[1]/div/div/div/div[5]/div/pre
  Input Text                          xpath=//*[@id="gists"]/div[2]/div/div[2]/div/div[5]/div[1]/div/div/div/div[5]/div/pre    text=${CONTENT}

Save
  Click Element                       xpath=//*[@id="new_gist"]/div/div[2]/button[1]

# Step 2
Click existing gist
  Click Element                       xpath=//*[@id="user-links"]/li[2]/details/summary/img
  Click Element                       xpath=//*[@id="user-links"]/li[2]/details/details-menu/ul/li[3]/a
  Click Element                       xpath=//*[contains(text(), "${FILENAME}")]

Click edit button
  Click Element                       xpath=//*[@id="gist-pjax-container"]/div[1]/div/div[1]/ul/li[1]/a


# Step 3
Click delete button
  # Click Element                       xpath=//*[contains(text(), "${FILENAME}")]
  Click element                       xpath=//*[@id="gist-pjax-container"]/div[1]/div/div[1]/ul/li[2]/form/button
  Handle Alert                        action=ACCEPT     timeout=None

# Step 4
Go to list
  Click Element                       xpath=//*[@id="user-links"]/li[2]/details/summary/img
  Click Element                       xpath=//*[@id="user-links"]/li[2]/details/details-menu/ul/li[3]/a

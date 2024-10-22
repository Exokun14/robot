*** Settings ***
Library  SeleniumLibrary
Library  ../venv/lib/python3.12/site-packages/robot/libraries/Telnet.py
Library  ../venv/lib/python3.12/site-packages/robot/libraries/Collections.py
Library  ../Libraries/Users.py
Variables  ../Variables/variable.py

Suite Teardown  Close Browser

*** Variables ***
${var_name}  Magnus
${USERS}

*** Test Cases ***
My First Test Case
    Launch Browser  https://marmelab.com/react-admin-demo
    Login User
    Go To Link  Customers
    Fetch Data
    Open Add Identity Model
    Fill Up Form

*** Keywords ***
Login User
    [Arguments]  ${username}=demo  ${password}=demo
    Wait Until Element Is Visible  //button
    Input Text  name:username  ${username}
    Input Text  name:password  ${password}
    Click Button  //button
    Go To Link  Customers

Go To Link
    [Arguments]  ${text}
    Click Element  //a[text()="${text}"]

Launch Browser
    [Arguments]  ${url}=https://google.com
    ${options}=  Set Variable  add_argument("--start-maximized")
    Open Browser  ${url}  chrome  remote_url=192.168.49.1:4444  options=${options}

Fetch Data
    ${users}=  Get Users As Dict
    Set Suite Variable  ${USERS}  ${users}

Open Add Identity Model
    Click Element  //a[@aria-label="Create"]
    Wait Until Element Is Visible  //input[@name="first_name"]
    Sleep  5s

Fill Up Form
    ${user_count}=  Get Length  ${USERS}
    FOR  ${index}  IN RANGE  1  ${user_count + 1}
        Input Details  ${USERS[${index}]}
        
        Go To Link  Customers
        Wait Until Element Is Visible  ${create_btn}
        Open Add Identity Model
    END

Input Details
  [Arguments]  ${user}
    ${firstName}  Evaluate    " ".join("${user["Name"]}".split()[:-1]).strip()
    ${lastName}  Evaluate    " ".join("${user["Name"]}".split()[-1:]).strip()

    Input Text    ${identity_txt_firstName}  ${firstName}
    Input Text    ${identity_txt_lastName}  ${lastName}
    Input Text    ${identity_txt_email}  ${user['Email']}
    Input Text    ${identity_txt_address}  ${user['Address']['Street']}
    Input Text    ${identity_txt_city}  ${user['Address']['City']}
    Input Text    ${identity_txt_stateAbbr}  ${user['Address']['City']}
    Input Text    ${identity_txt_zipcode}  ${user['Address']['Zipcode']}
    Input Text    ${identity_txt_password}  password_${user['Username']}
    Input Text    ${identity_txt_confirm_password}  password_${user['Username']}
    Click Button  ${identity_btn_save}

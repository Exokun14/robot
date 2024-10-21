*** Settings ***
Library  SeleniumLibrary
Library    ../venv/lib/python3.12/site-packages/robot/libraries/Telnet.py
Resource  ../Resources/SampleResource.resource
Variables  ../Variables/variable.py

#Suite Setup  Launch Browser
Suite Teardown  Close Browser  #whole robot file
#Test Teardown  Close Browser

*** Variables ***
${var_name}  Magnus

*** Test Cases ***
# Test Name
My First Test Case
    #${local_var}  Set Variable  CookiesAreMine
    #[Documentation]  My Sample Test Case
    # Log To Console  ${var_name}
    # Log To Console  ${my_nickname}
    # Add Two Numbers  6  9
    # Concatinate Two Strings  Hello
    # Display List
    # For Loop In Range
    #If Else Sample  2
    #Try Else If    La
    Launch Browser
    Input Text  id:APjFqb  Angas

*** Keywords ***
Launch Browser
    [Arguments]  ${url}="https://google.com"
    ${options}  Set Variable  add_argument("--start-maximized")
    Open Browser  ${url}  chrome  remote_url=192.168.49.1:4444  options=${options}
If Else Sample
  [Arguments]  ${number}

  ${is_even}  Evaluate  ${number} % 2 == 0
  IF  ${is_even}
      Log To Console  Number is even
  ELSE
      Log To Console  Number is odd
  END

Display List
  ${my_list}  Create List  1  2  3  4

  FOR  ${i}  IN  @{my_list}
      Log To Console  ${i}
  END

For Loop In Range
  FOR  ${counter}  IN RANGE  1  10  1
      Log To Console  ${counter}
  END
Add Two Numbers
  [Arguments]  ${num_1}  ${num_2}
  ${sum}  Evaluate  ${num_1} + ${num_2}
  Log To Console  ${sum}

Concatinate Two Strings
  [Arguments]  ${string_1}  ${string_2}=Mundo
  ${concatinated}  Set Variable  ${string_1} ${string_2}\
  Log To Console  ${concatinated}

Try Else If
  [Arguments]  ${string}
    ${is_hello}=  Evaluate  '${string}' == 'Hello'
    ${is_world}=  Evaluate  '${string}' == 'World'
    
  IF  ${is_hello}
    Log To Console    "Hello"
  ELSE IF    ${is_world}
    Log To Console    "World"
  ELSE
    Log To Console    "Ahri"
  END

Input Text
  [Arguments]  ${locator}  ${text}


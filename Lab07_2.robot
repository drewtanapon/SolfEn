*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${SERVER}    localhost:7272
${DELAY}    0
${FORMURL}    http://${SERVER}/Form.html
${CHROME_BROWSER_PATH}    ${EXECDIR}${/}Chrome${/}chrome.exe
${CHROME_DRIVER_PATH}    ${EXECDIR}${/}Chrome${/}chromedriver.exe
${fname}    Somsong
${lname}    Sandee
${destination}    Europe
${contact}    Sodsai Sandee
${relationship}    Mother
${email}    somsong@gmail.com
${phone}    081-111-1234

*** Keywords ***
Open Browser To Form Page
    Set Selenium Speed    ${DELAY}
    ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    ${chrome_options.binary_location}    Set Variable    ${CHROME_BROWSER_PATH}
    ${service}=    Evaluate    sys.modules["selenium.webdriver.chrome.service"].Service(executable_path=r"${CHROME_DRIVER_PATH}")
    Create Webdriver    Chrome    options=${chrome_options}    service=${service}
    Go To    ${FORMURL}
    Form Page Should Be Open

Form Page Should Be Open
    Title Should Be    Customer Inquiry

Complete Page Should Be Open
    Title Should Be    Completed

Input Fname
    [Arguments]    ${fname}
    Input Text    firstname    ${fname}

Input Lname
    [Arguments]    ${lname}
    Input Text    lastname    ${lname}

Input Destination
    [Arguments]    ${destination}
    Input Text    destination    ${destination}

Input Contact
    [Arguments]    ${contact}
    Input Text    contactperson    ${contact}

Input Relationship
    [Arguments]    ${relationship}
    Input Text    relationship    ${relationship}

Input Email
    [Arguments]    ${email}
    Input Text    email    ${email}

Input Phone
    [Arguments]    ${phone}
    Input Text    phone    ${phone}

Submit Form
    Click Button    submitButton

*** Test Cases ***
UAT-Lab7-001: กรอกข้อมูลครบถ้วน
        Open Browser To Form Page
        Input Fname    ${fname}
        Input Lname    ${lname}
        Input Destination    ${destination}
        Input Contact    ${contact}
        Input Relationship    ${relationship}
        Input Email    ${email}
        Input Phone    ${phone}
        Submit Form
        Complete Page Should Be Open

UAT-Lab7-002: กรอกข้อมูลไม่ครบถ้วน
        Open Browser To Form Page
        Input Fname    ${fname}
        Input Lname    ${lname}
        Input Contact    ${contact}
        Input Relationship    ${relationship}
        Input Email    ${email}
        Input Phone    ${phone}
        Submit Form
        Wait Until Element Is Visible    xpath=//p[@id="errors"]    timeout=1
        Element Text Should Be    xpath=//p[@id="errors"]    Please enter your destination.
        Close Browser

UAT-Lab7-0021: กรอกข้อมูลไม่ครบถ้วน
        Open Browser To Form Page
        Input Fname    ${fname}
        Input Lname    ${lname}
        Input Destination    ${destination}
        Input Contact    ${contact}
        Input Relationship    ${relationship}
        Input Phone    ${phone}
        Submit Form
        Wait Until Element Is Visible    xpath=//p[@id="errors"]    timeout=1
        Element Text Should Be    xpath=//p[@id="errors"]    Please enter a valid email address.
        Close Browser

UAT-Lab7-0022: กรอกข้อมูลไม่ครบถ้วน
        Open Browser To Form Page
        Input Fname    ${fname}
        Input Lname    ${lname}
        Input Destination    ${destination}
        Input Contact    ${contact}
        Input Relationship    ${relationship}
        Input Email    somsong@
        Input Phone    ${phone}
        Submit Form
        Wait Until Element Is Visible    xpath=//p[@id="errors"]    timeout=1
        Element Text Should Be    xpath=//p[@id="errors"]    Please enter a valid email address.
        Close Browser

UAT-Lab7-0023: กรอกข้อมูลไม่ครบถ้วน
        Open Browser To Form Page
        Input Fname    ${fname}
        Input Lname    ${lname}
        Input Destination    ${destination}
        Input Contact    ${contact}
        Input Relationship    ${relationship}
        Input Email    ${email}
        Submit Form
        Wait Until Element Is Visible    xpath=//p[@id="errors"]    timeout=1
        Element Text Should Be    xpath=//p[@id="errors"]    Please enter a phone number.
        Close Browser

UAT-Lab7-0024: กรอกข้อมูลไม่ครบถ้วน
        Open Browser To Form Page
        Input Fname    ${fname}
        Input Lname    ${lname}
        Input Destination    ${destination}
        Input Contact    ${contact}
        Input Relationship    ${relationship}
        Input Email    ${email}
        Input Phone    191
        Submit Form
        Wait Until Element Is Visible    xpath=//p[@id="errors"]    timeout=1
        Element Text Should Be    xpath=//p[@id="errors"]    Please enter a valid phone number, e.g., 081-234-5678, 081 234 5678, or 081.234.5678)
        Close Browser
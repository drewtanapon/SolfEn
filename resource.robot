*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${SERVER}         localhost:7272
${BROWSER}        Chrome
${DELAY}          0
${VALID USER}     demo
${VALID PASSWORD}    mode
${LOGIN URL}      http://${SERVER}/
${WELCOME URL}    http://${SERVER}/welcome.html
${ERROR URL}      http://${SERVER}/error.html
${CHROME_BROWSER_PATH}  ${EXECDIR}${/}ChromeForTesting${/}chrome.exe
${CHROME_DRIVER_PATH}   ${EXECDIR}${/}ChromeForTesting${/}chromedriver.exe
${KKUURL}   https://www.kku.ac.th


*** Keywords ***
Open Browser To Login Page
    ${chrome_options}   Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()  sys
    ${chrome_options.binary_location}   Set Variable    ${CHROME_BROWSER_PATH}
    ${service}  Evaluate    sys.modules["selenium.webdriver.chrome.service"].Service(executable_path=r"${CHROME_DRIVER_PATH}")
    #[selenium >= 4.10] `chrome_options` change to `options`
    Create Webdriver    Chrome  options=${chrome_options}   service=${service}
    Go To   ${LOGIN URL}
    Login Page Should Be Open


Login Page Should Be Open
    Title Should Be    Login Page

Go To Login Page
    Go To    ${LOGIN URL}
    Login Page Should Be Open

Input Username
    [Arguments]    ${username}
    Input Text    username_field    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    password_field    ${password}

Submit Credentials
    Click Button    login_button

Welcome Page Should Be Open
    Location Should Be    ${WELCOME URL}
    Title Should Be    Welcome Page
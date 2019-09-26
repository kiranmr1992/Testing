*** Settings ***
Library  Process
Library  String
Library  Collections
Library  DateTime
Library  OperatingSystem
Library  SeleniumLibrary


*** Variables ***
${LOGIN URL}      https://go.discovery.com/
${BROWSER}        Chrome
${search}         Apollo

*** Test Cases ***
Task1
    open browser  ${LOGIN URL}  ${BROWSER}
    Maximize Browser Window
    Select Shows
    See all shows
    Select Search option
    input text  xpath:/html/body/div[6]/div/div/div[1]/div/div/div/div/input  ${search}
    View all ressults
    Select 1st result
    Make favourite
    ${state}  Get Window Titles
    BuiltIn.Sleep  3
    ${fav}=  create list
    Append To List    ${fav}  ${state}
    log to console  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@${fav}
    Go back
    Select 2nd result
    Make favourite
    ${state1}  Get Window Titles
    Append To List    ${fav}  ${state1}
    Go back
    log to console  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@${fav}
    ${111}  get element count  xpath://*[@id="react-root"]/div/div[1]/main/div/div/div[2]/div/div/div[3]/div/a/div
    ${state2}  run keyword if  "${111}" == "1"  select 3rd result
    Append To List    ${fav}  ${state2}
    Go back
    log to console  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@${fav}
    BuiltIn.Sleep  3
    My videos
    Verify Favourites

*** Keywords ***

Select Shows
    BuiltIn.Sleep  2
    click element  xpath: //*[@id="react-root"]/div/div[1]/div[2]/header/div[2]/div/nav/ul/li[2]

See all shows
    BuiltIn.Sleep  3
    click element  xpath://*[@id="show-drop-desktop"]/ul/li[13]/div/a

Select Search option
    BuiltIn.Sleep  3
    click element  xpath://*[@id="react-root"]/div/div[1]/div[2]/header/div[2]/div/nav/ul/li[4]/div

View all ressults
    BuiltIn.Sleep  3
    click element  xpath:/html/body/div[6]/div/div/div[1]/div/div/div[2]/div/ul/li[1]/a

Select 1st result
    BuiltIn.Sleep  3
    click element  xpath://*[@id="react-root"]/div/div[1]/main/div/div/div[2]/div/div/div[1]/div/a/div/img

Select 2nd result
    BuiltIn.Sleep  2
    click element  xpath://*[@id="react-root"]/div/div[1]/main/div/div/div[2]/div/div/div[2]/div/a/div

Make favourite
    BuiltIn.Sleep  5
    click element  xpath://*[@id="react-root"]/div/div[1]/main/section[1]/div/div[1]/div[2]/div[1]/span/i

get status
    ${temp}=  get element attribute  xpath:/html/body/div[1]/div/div[1]/main/section[1]/div/div[1]/div[2]/div[1]/span/i  class
    [return]  ${temp}

Select 3rd result
    BuiltIn.Sleep  3
    click element  xpath://*[@id="react-root"]/div/div[1]/main/div/div/div[2]/div/div/div[3]/div/a/div
    Make favourite
    ${state2}  Get Window Titles
    [return]  ${state2}

My videos
     BuiltIn.Sleep  6
     click element  xpath://*[@class='dscHeaderMain__iconMenu']
     BuiltIn.Sleep  5
     click element  xpath://*[@id="react-root"]/div/div[1]/div[2]/header/nav/div[2]/div/div/div[1]/ul/li[4]/a/span

Verify Favourites
    ${present}=  Run Keyword And Return Status    Element Should Be Visible  xpath://*[@class='localStorageCarousel__heading']
    should be true  ${present}

*** Settings ***
Resource          ../Common/Include.robot

*** Keywords ***
Launch Application
    [Documentation]    This keyword starts the Sikuli Process and Open Application
    Initiate Sikuli Server    ${ImageLocationPath}    ${CaptureLocationPath}
    Open New Application    ${ApplicationPath}    ${ApplicationTittle}
    Add device    ${DeviceName}    ${DeviceIP}

Initiate Sikuli Server
    [Arguments]    ${ImageLocation}    ${CaptureLocation}
    [Documentation]    Starting Sikuli Library and initiating image path and capture folder for Sikuli Library
    ${ServerStatus}    Run Keyword And Ignore Error    Stop Remote Server
    Run Keyword If    "${ServerStatus}[0]" == "FAIL"    Log    No Instance of Sikuli Process is avaliable; user need to start one
    Start Sikuli Process
    Set Slow Motion Delay    5
    Add Image Path    ${ImageLocation}
    Set Capture Folder    ${CaptureLocation}
    Set Screenshot Directory    ${ImageLocation}

Open New Application
    [Arguments]    ${ApplicationPath}    ${ApplicationTittle}    ${timeOut}=10
    [Documentation]    Allow user to open new application for a given path and application titile.
    Open Application    ${ApplicationPath}
    Win Activate    ${ApplicationTittle}
    ${isDeviceActive}    Run Keyword And Ignore Error    Wait For Active Window    ${ApplicationTittle}    ${EMPTY}    ${timeOut}
    Run Keyword If    "${isDeviceActive}[0]"=="FAIL"    Critical Step    Cant Open Application : ${ApplicationTittle}

Close the Application
    [Documentation]    close the application
    Close Application    ${ApplicationTittle}
    Stop Remote Server

Emd Input Text
    [Arguments]    ${InputTextFieldImage}    ${InputText}
    [Documentation]    It Waits for a text field is visible within the given time limit, then it enters text.
    ${inputStatus}    Run Keyword And Return Status    Wait Until Screen Contain    ${InputTextFieldImage}    ${MAXTIME}
    Run Keyword And Return Status    Run Keyword If    ${InputStatus}    Input Text    ${InputTextFieldImage}    ${InputText}

Emd Clear Text And Enter Data
    [Arguments]    ${inputTextFieldImage}    ${inputText}
    [Documentation]    based on image it clears text in the given input field and enter new data
    ${inputFieldStatus}    Run Keyword And Return Status    Wait Until Screen Contain    ${inputTextFieldImage}    ${MAXTIME}
    Run Keyword If    ${inputFieldStatus}    Double Click    ${inputTextFieldImage}    #Click    ${inputTextFieldImage}
    Type with modifiers    ${inputText}
    Press Special Key    ENTER

Emd Clear Text and Enter Data Based on Position
    [Arguments]    ${inputTextFieldImage}    ${inputText}    ${direction}    ${repeats}
    [Documentation]    Based on Position it will clear data and enter new data
    ${RequiredPosition}    Get Extended Region From Image    ${inputTextFieldImage}    ${direction}    ${repeats}
    #    Highlight Region    ${RequiredPosition}    ${MINTIME}
    Double Click On Region    ${RequiredPosition}
    Press Special Key    BACKSPACE
    Type with modifiers    ${inputText}
    Press Special Key    ENTER

Emd Click
    [Arguments]    ${clickableButtonImage}
    [Documentation]    It Waits for element within the given time limit, then it clicks.
    ${clickableStatus}    Run Keyword And Return Status    Wait Until Screen Contain    ${clickableButtonImage}    ${MAXTIME}
    Run Keyword If    ${clickableStatus}    Click    ${clickableButtonImage}
    #    Run Keyword And Return Status    Run Keyword If    ${clickableStatus}    Click    ${clickableButtonImage}
    [Return]    ${clickableStatus}

Emd Drag And Drop
    [Arguments]    ${sectionName}    ${sourceImage}
    [Documentation]    This keyword is used to drag and drop the elements
    ${sourceImageStatus}    Run Keyword And Return Status    Wait Until Screen Contain    ${sourceImage}    ${MAXTIME}
    Run Keyword And Return If    ${sourceImageStatus}    Drag And Drop By Offset    ${sourceImage}    ${xOffset}    ${yOffset}

Get Capture From VIP Device Using FTP
    [Arguments]    ${outputNumber}    ${deviceIp}    ${ftpPort}
    Run Process    ${ftpBatchFIle}    ${outputNumber}    ${deviceIp}    ${ftpPort}
    Sleep    5
    Ftp Connect    ${deviceIp}    -    -    ${ftpPort}
    Download File    cap_000.bmp
    Ftp Close
    Move File    cap_000.bmp    ${ImageLocationPath}

Pass Step
    [Arguments]    ${Step}
    [Documentation]    print Pass message
    ${Status}    Run Keyword And Ignore Error    Log    ${TEST NAME} --> ${Step}
    Run Keyword If    "${Status}[0]"== "FAIL"    Log    ${Step}    level=INFO    console=True
    ...    ELSE    Log    ${TEST NAME} --> ${Step}    level=INFO    console=True

Fail Step
    [Arguments]    ${Step}
    [Documentation]    Allow user to trigger a Fail method
    ${Status}    Run Keyword And Ignore Error    Log    ${TEST NAME} --> ${Step}
    Run Keyword If    "${Status}[0]"== "FAIL"    Log    ${Step}    level=ERROR    console=True
    ...    ELSE    Log    ${TEST NAME} --> ${Step}    level=ERROR    console=True
    Run Keyword If    "${Status}[0]"== "FAIL"    Fail    ${Step}
    ...    ELSE    Fail    ${TEST NAME} --> ${Step}

Send Image Video UMD
    [Arguments]    ${deviceIp}    ${devicePort}    ${umdColor}    ${umdText}
    [Documentation]    Function allow user to send image video message to send to a specific device usind device IP and Port Numbe. Also allow user to control the color and Text on the UMD
    ImageVideoUmd    ${deviceIp}    ${devicePort}    ${umdColor}    ${umdText}

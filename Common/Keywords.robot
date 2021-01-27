*** Settings ***
Resource          ./Include.robot

*** Keywords ***
Add Device
    [Arguments]    ${DeviceName}    ${DeviceIP}
    [Documentation]    Allow user to add device using device IP address and Device Name
    ${ScreenStatus}    Run Keyword And Return Status    Wait Until Screen Contain    ${Previous Added Device}    ${MINTIME}    #PreviousAddedDevice
    Run Keyword If    ${ScreenStatus}    Remove Old Device
    Emd Clear Text and Enter Data Based on Position    Name    ${DeviceName}    right    1
    #    Emd Input Text    ${Name Input}    ${DeviceName}    # not working in windows7
    Emd Input Text    ${IpInput}    ${DeviceIP}    #IpInput
    Emd Click    ${Add Button}    #AddButton
    Unable To Connect Retry

Remove Old Device
    [Documentation]    By Using this Keyword User can Remove the existing device
    Emd Click    ${Close Mark}
    ${Screenval}    Run Keyword And Return Status    Wait Until Screen Contain    ${Cancel Ok PopUp}    ${MAXTIME}
    Run Keyword If    ${Screenval}    Emd Click    ${Ok Button}

Unable To Connect Retry
    [Documentation]    This keyword verifies page is having click to retry
    FOR    ${i}    IN RANGE    5
        ${Status}    Run Keyword And Return Status    Wait Until Screen Contain    ${Successful Connected Display List}    ${MINTIME}
        Run Keyword And Return If    ${Status}    EXIT FOR LOOP
        Run Keyword And Ignore Error    Click    ${Unable To Connect Click To Retry Window}
    END

Go To Multiviewer Display
    [Arguments]    ${Display}
    [Documentation]    Based on Input it will select Display    #eg: Display1 image
    emd click    ${Display}

Go To Section
    [Arguments]    ${SectionName}
    [Documentation]    It Selects The Widgets Section
    emd click    ${SectionName}

Clear Layout Display
    [Documentation]    It clears the Multiviewer window
    Go To Section    ${Layouts}
    ${NoLayoutStatus}    Run Keyword And Return Status    Wait Until Screen Contain    ${NoLayout}    ${MAXTIME}
    Run Keyword If    ${NoLayoutStatus}    Drag And Drop By Offset    ${NoLayout}    -890    350
    ${ClearMultiViewerWindowStatus}    Run Keyword And Return Status    Wait Until Screen Contain    ${Clear MultiViewer Window}    ${MAXTIME}
    Run Keyword Unless    ${ClearMultiViewerWindowStatus}    Drag And Drop By Offset    ${NoLayout}    -890    350

Connect From One Widget To Another Widget
    [Arguments]    ${SelectedWidget}    ${FromLocationImage}    ${TargetImage}    ${MouseOption}=RIGHT    #LEFT    ${xOffset}    ${yOffset}
    [Documentation]    By using this keyword we can establish connection from one widget to another Widget.
    Wait Until Screen Contain    ${SelectedWidget}    ${MAXTIME}
    SikuliLibrary.Mouse Move    ${SelectedWidget}
    SikuliLibrary.Mouse Move    ${FromLocationImage}
    SikuliLibrary.Mouse Down    ${MouseOption}
    Drag And Drop    ${FromLocationImage}    ${TargetImage}
    #    Drag And Drop By Offset    ${FromLocationImage}    ${xOffset}    ${yOffset}
    SikuliLibrary.Mouse Up    ${MouseOption}
    Sleep    ${MINTIME}

Go To Section Drag And Drop
    [Arguments]    ${SectionName}    ${Item}    @{Offsetvalues}    #${mouseButton}=LEFT
    [Documentation]    Select the section and darg and drop specific item
    Go To Section    ${SectionName}
    Drag And Drop By Offset    ${Item}    ${Offsetvalues}[0]    ${Offsetvalues}[1]

Go To Section Drag And Drop Wait Until It Loads On Display
    [Arguments]    ${SectionName}    ${Item}    ${WindowTypeLabelImage}    @{Offsetvalues}    #${mouseButton}=LEFT
    [Documentation]    Select the section and darg and drop specific Widget and wait until its loaded on Display
    Go To Section    ${SectionName}
    Drag And Drop By Offset    ${Item}    ${Offsetvalues}[0]    ${Offsetvalues}[1]
    Wait Until Screen Contain    ${WindowTypeLabelImage}    ${MAXTIME}

Save Template
    [Arguments]    ${TemplateName}
    [Documentation]    It saves the existing Layout
    Run Keyword And Ignore Error    Click    ${Entire Screen}
    Emd Click    ${Select All}
    Go To Section    ${Templates}
    Emd Click    ${Save Template}
    Wait Until Screen Contain    ${Save Widget As Template}    ${MAXTIME}
    ${TemplateNameLocation}    Get Extended Region From Image    ${Save Template Input Field}    below    1
    Emd Input Text    ${Save Template Input Field}    ${TemplateName}
    ${TemplateNameImage}    Capture Region    ${TemplateNameLocation}
    Click region    ${TemplateNameLocation}
    #    SikuliLibrary.Mouse Move    CreateNewOption
    #    Run Keyword And Ignore Error    Click Text    ${templateName}
    #    Click    CreateNewOption
    [Return]    ${TemplateName}

Open Saved Template and Drag -Drop the Saved Template
    [Arguments]    ${TemplateName}    ${TargetImage}    #@{OffsetValues}
    [Documentation]    it opens saved template
    Clear Layout Display
    Go To Section    ${Templates}
    Run Keyword And Ignore Error    Click    ${Clear Filter}
    Emd Input Text    ${Filter Searching}    ${TemplateName}
    ${result}    Get Extended Region From Image    ${Checked Total Text}    below    2
    Click    ${Checked Total Text}
    ${SavedTemplateRegionImg}    Capture Region    ${result}
    Highlight Region    ${result}    ${MINTIME}
    Drag And Drop    ${SavedTemplateRegionImg}    ${TargetImage}
    #    Drag And Drop By Offset    ${SavedTemplateRegionImg}    ${OffsetValues}[0]    ${OffsetValues}[1]

Set Position Of Widget
    [Arguments]    ${xOffset}    ${yOffset}    # ${xAxisImage}    ${yAxisImage}    ${direction}    ${repeats}
    [Documentation]    Based on user inputs it will set the position of widget on Display.
    Wait Until Screen Contain    ${Dimensions}    ${MAXTIME}    #${CONFIG.WindowsProperties.Dimensions}
    SikuliLibrary.Mouse Move    ${Position X}
    Emd Clear Text and Enter Data Based on Position    ${Position X}    ${xOffset}    right    1    #${xAxisImage}    ${direction}    ${repeats}
    SikuliLibrary.Mouse Move    ${Position Y}
    Emd Clear Text and Enter Data Based on Position    ${Position Y}    ${yOffset}    right    1    #${yAxisImage}    ${direction}    ${repeats}
    Sleep    ${MINTIME}

Set Dimensition Of Widget
    [Arguments]    ${widthVal}    ${heightVal}    # ${widthImage}    ${heightImage}    ${direction}    ${repeats}
    [Documentation]    Based on user inputs it will set the size of the Widget.
    Wait Until Screen Contain    ${Dimensions}    ${MAXTIME}    #${CONFIG.WindowsProperties.Dimensions}
    Emd Clear Text and Enter Data Based on Position    ${Position W}    ${widthVal}    right    1    # ${xAxisImage}    ${direction}    ${repeats}
    Emd Clear Text and Enter Data Based on Position    ${Position H}    ${heightVal}    right    1    # ${yAxisImage}    ${direction}    ${repeats}

Go To Back
    [Documentation]    it allows user to perform Back from Display window to Home
    Emd Click    ${Back Button}
    ${BackToHomeStatus}    Run Keyword And Return Status    Wait Until Screen Contain    ${Previous Added Device}    ${MAXTIME}
    [Return]    ${BackToHomeStatus}

Close Evertz Offline Application
    [Documentation]    close the application
    Close Application    ${ApplicationTittle}
    ${PopUpStatus}    Run Keyword And Return Status    Wait Until Screen Contain    ${Quit Confirm PopuP}    ${MINTIME}
    Run Keyword If    ${PopUpStatus}    Click    ${Yes Button}
    Stop Remote Server

Select ShowMeter Checkbox
    [Documentation]    Enables user to scroll down enable show meter functionality.
    Emd Click    ${AudioBar}
    Wheel Down    4    ${ScrollBar}
    Wait Until Screen Contain    ${ShowMeterText}    ${MAXTIME}
    ${RequiredPosition}    Get Extended Region From Image    ${ShowMeterText}    right    1
    Click region    ${RequiredPosition}

Select Right Top Status Label and Delete
    [Documentation]    It select the right side top Status Label and Delete
    Sleep    5
    ${NewRegion}    Get Extended Region From Image    ${Template Actions}    left    1    #DeleteWidget    below    7
    #    Highlight Region    ${NewRegion}    ${MINTIME}
    ${TargetStatusLabel}    Get Extended Region From Region    ${newRegion}    below    1
    Highlight Region    ${TargetStatusLabel}    3
    Click region    ${TargetStatusLabel}
    Emd Click    ${Delete Widget}

Delete Layout
    [Arguments]    ${TemplateName}
    [Documentation]    It will delete the template based on TemplateName
    Go To Section    ${Templates}
    Run Keyword And Ignore Error    Click    ${Clear Filter}
    Emd Input Text    ${Filter Searching}    ${TemplateName}
    ${result}    Get Extended Region From Image    ${Checked Total Text}    below    2
    Click    ${Checked Total Text}
    ${SavedTemplateRegionImg}    Capture Region    ${result}
    Highlight Region    ${result}    ${MINTIME}
    #    Click    ${SavedTemplateRegionImg}
    Emd Click    ${Template Delete Button}
    #    Wait Until Screen Contain    ${Delete Warning Popup}    ${MAXTIME}
    Emd Click    ${Delete Button On Popup}

Create Grid
    [Arguments]    ${AspectRatio}    @{NumberOfRowsAndColumns}
    [Documentation]    Based on user inputs it will crate a Grid
    Emd Clear Text And Enter Data    ${Grid Number Of Rows}    ${NumberOfRowsAndColumns}[0]
    Emd Clear Text And Enter Data    ${Grid Number Of Columns}    ${NumberOfRowsAndColumns}[1]
    Run Keyword And Ignore Error    Run Keyword If    "${AspectRatio}"=="4:3 Widget"    Emd Click    ${4:3 Aspect Ratio}
    Emd Click    ${Grid OK Button}
    ${TotalWidgets}    Evaluate    ${NumberOfRowsAndColumns}[0]*${NumberOfRowsAndColumns}[1]
    Sleep    5
    [Return]    ${TotalWidgets}

Assign Inputs To Grid
    [Arguments]    ${TotalWidgets}
    [Documentation]    It will assign Inputs to Unassigned images based on Number of inputs.
    ${ScreenStatus}    Run Keyword And Return Status    Wait Until Screen Contain    ${Delete Widget}    ${MAXTIME}
    ${NewRegion}    Get Extended Region From Image    ${Delete Widget}    below    9
    ${TargetRegion}    Get Extended Region From Region    ${NewRegion}    left    1
    #    Highlight Region    ${TargetRegion}    ${MINTIME}
    Click region    ${TargetRegion}
    FOR    ${index}    IN RANGE    1    ${TotalWidgets}+1
        Type with modifiers    INPUT-${index}
        Sleep    5
        Press Special Key    ENTER
        Sleep    2
        Press Special Key    TAB
        Sleep    2
    END

Set Test Message
    Set Test Variable    ${PassMessge}    ${TEST NAME} Passed
    Set Test Variable    ${FailedMessge}    ${TEST NAME} Failed

Verify Whether Output is same as Expected
    [Arguments]    ${actualImage}    ${expectedImage}
    ${Status}    Compare Image    ${actualImage}    ${expectedImage}    ${ImageLocationPath}
    Run Keyword If    "${Status}" == "True"    Pass Step    ${PassMessge}
    Run Keyword If    "${Status}" == "False"    Fail Step    ${FailedMessge}
    Run Keyword If    "${Status}" == "False"    Capture Screen
    [Return]    ${Status}

Asset Import
    [Arguments]    ${GraphicImagePath}
    [Documentation]    This method will import images from local machine to Asset Library.
    Emd Click    ${Asset Editor Import Button}
    sleep    2
    Send    ${GraphicImagePath}    5
    ${AssetImportStatus}    Press Special Key    ENTER
    Run Keyword If    "${AssetImportStatus}" == "FAIL"    Press Special Key    ESC
    Emd Click    ${Asset Editor Done Button}

Asset Import Verification
    [Arguments]    ${ImportSucessImageVerification}    ${timeOut}=10
    [Documentation]    This method will verify imported image is expected or not.
    ${status}    Exists    ${ImportSucessImageVerification}    ${timeOut}
    Run Keyword If    "${status}" == "False"    Fail Step    Cant Find image ${ImportSucessImageVerification}
    Run Keyword If    "${status}" == "True"    Pass Step    Sucessfully Uploaded ${ImportSucessImageVerification}
    Emd Click    ${Asset Editor Done Button}

Verify Imported Asset is Present in Manage Asset In VIP
    [Arguments]    ${ManageAssetVerification}    ${timeOut}=10
    [Documentation]    This method is used to verify the imported assets from "Asset library" \ are present in the "Manage assets on VIP".
    Emd Click    ${ManageAssetsonVIPButton}
    sleep    2
    Emd Click    ${ManageAssetsGraphicTab}
    sleep    2
    ${ManageAssetsStatus}    Exists    ${ManageAssetVerification}    ${timeOut}
    Run Keyword If    "${ManageAssetsStatus}" == "False"    Emd Click    ${Asset Editor Done Button}
    Run Keyword If    "${ManageAssetsStatus}" == "False"    Fail Step    Imported Asset is not present under Manage Assets on VIP Section
    Run Keyword If    "${ManageAssetsStatus}" == "True"    Pass Step    Asset Library Imported Image is present in Manage Assets on VIP Section
    Comment    Run Keyword If    "${ManageAssetsStatus}" == "True"    Emd Click    ${Asset Editor Done Button}

Upload Asset To VIP
    [Arguments]    ${SelectedImage}    ${timeOut}=10
    [Documentation]    This method is used to "upload assets" to VIP and it verify the Image successfully uploaded to VIP.
    Emd Click    ${SelectedImage}
    Emd Click    ${UploadToVIP}
    sleep    2
    ${UploadStatus}    Exists    ${UploadSuccessMessage}    ${timeOut}
    ${UploadToVIPStatus}    Exists    ${UploadToVIPVerfication}    ${timeOut}
    Run Keyword If    "${UploadToVIPStatus}" == "False"    Fail Step    Cant Upload image to VIP
    Run Keyword If    "${UploadToVIPStatus}" == "True"    Pass Step    Succesfully Uploaded to VIP
    Emd Click    ${Asset Editor Done Button}
    [Teardown]

Maximize Widget Size
    [Arguments]    ${MaximizeButton}
    [Documentation]    Help user to click on the maximize button on the offline design tool for a selected widget
    Emd Click    ${Maximize Widget Icon}

Go to Asset Library and Click On Tab
    [Arguments]    ${AssetLibraryTab}
    [Documentation]    This method is used to click on assets editor such as (fonts,Background images,graphics,video loss images) into asset library.
    Emd Click    ${Asset Library Button}
    sleep    2
    ${AssetLibraryStatus}    Emd Click    ${AssetLibraryTab}
    sleep    3
    Run Keyword If    "${AssetLibraryStatus}" == "FAIL"    Emd Click    ${Asset Editor Done Button}

Select Images From Windows Properties Tab
    [Arguments]    ${Image}
    [Documentation]    Allow user to select images from windows properties window , can be used to graphics and background images
    emd Click    ${Windows Type}
    emd Click    ${Image}

Remove Asset From Asset Library and VIP
    [Arguments]    ${AssetTabName}    ${ImageToBeRemoved}    ${timeout}=10
    Go To Back
    Emd Click    ${ManageAssetsonVIPButton}
    sleep    2
    Emd Click    ${AssetTabName}
    sleep    2
    ${ManageAssetsStatus}    Exists    ${ImageToBeRemoved}    ${timeOut}
    Emd Click    ${ImageToBeRemoved}
    Emd Click    ${Remove From VIP}
    Emd Click    ${ImageToBeRemoved}
    Emd Click    ${Remove Button}
    Emd Click    ${Delete Confirm Message}
    Sleep    10
    Emd Click    ${Asset Editor Done Button}

Go To Display And Clear Layout
    Go To Multiviewer Display    ${Display}
    Clear Layout Display

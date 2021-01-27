*** Settings ***
Test Setup
Resource          ../Common/Include.robot

*** Test Cases ***
TC01: Modified Template
    [Documentation]    Steps:
    ...
    ...    Add Device
    ...    Go to Multiviewer Display1
    ...    Go to widgets section.
    ...    Add source to it (Go to Sources section,Drag and drop Input-1)
    ...    Go to widgets section.
    ...    Drag and Drop "Status label" on Display
    ...    Connect "Status Label" to 4:3 widget.
    ...    Drag and Drop another 3 status lables on display
    ...    connect 3 ->"Status Label's" to 4:3 widget.
    ...    Place 4:3 widget at centre of display and status lables are at four corners of display.
    ...    Then click on "Select All" Option
    ...    Then go to "Templates" section Click on save button.
    ...    Save as new name such @1 and select "Create new" drop down value
    ...    Then go to "Layouts" section and click on "no layout" option.
    ...    Then go to "Templates" section and enter @1 on filter field.
    ...    Then drag and drop @1 template on display.
    ...    Go to VLC Player and verify the @1 template displayed correctly or not.
    ...    Then select one of the status label on right hand side corner and click on delete button
    ...    Then click on "Select All" Option
    ...    Then go to "Templates" section Click on save button.
    ...    Then save the template with same name such as @1.
    ...    Then go to "Layouts" section and click on "no layout" option.
    ...    Then go to "Templates" section and enter @1 on filter field.
    ...    Then drag and drop @1 template on display.
    ...    Go to VLC Player and verify the @1 Edited template displayed correctly or not.
    ...    Then go to "Layouts" section and click on "no layout" option.
    ...    Then Click on "Arrow" Button on Left hand side top corner of Display 1
    [Tags]    Smoke    Regression    ModifiedTemplate
    Set Test Message
    Go To Display And Clear Layout
    Go To Section Drag And Drop Wait Until It Loads On Display    ${Widgets}    ${4:3 Widget}    ${Window Type Video}    @{Center}
    Set Position Of Widget    816    432
    Go To Section Drag And Drop    ${Sources}    ${Input-1}    @{CenterInput}
    Go To Section Drag And Drop Wait Until It Loads On Display    ${Widgets}    ${Status Label Widget}    ${Window Type Status Label}    @{RightTop}
    Set Position Of Widget    1536    0
    Connect From One Widget To Another Widget    ${Status Label Highlight}    ${Status Label Link Button}    ${4:3 Widget Input1}
    Go To Section Drag And Drop Wait Until It Loads On Display    ${Widgets}    ${Status Label Widget}    ${Window Type Status Label}    @{LeftTop}
    Set Position Of Widget    0    0
    Connect From One Widget To Another Widget    ${Status Label Highlight}    ${Status Label Link Button}    ${4:3 Widget Input1}
    Go To Section Drag And Drop Wait Until It Loads On Display    ${Widgets}    ${Status Label Widget}    ${Window Type Status Label}    @{LeftBottom}
    Set Position Of Widget    0    1026
    Connect From One Widget To Another Widget    ${Status Label Highlight}    ${Status Label Link Button}    ${4:3 Widget Input1}
    Go To Section Drag And Drop Wait Until It Loads On Display    ${Widgets}    ${Status Label Widget}    ${Window Type Status Label}    @{RightBottom}
    Set Position Of Widget    1536    1026
    Connect From One Widget To Another Widget    ${Status Label Highlight}    ${Status Label Link Button}    ${4:3 Widget Input1}
    ${SavedTemplateName}    Save Template    ${TemplateName}
    Open Saved Template and Drag -Drop the Saved Template    ${SavedTemplateName}    ${Blank Display}
    Sleep    10
    ${ExpectedImagebefore}    Capture Screen
    Move File    ${ExpectedImagebefore}    ${TemplateImage1}
    copy file    ${TemplateImage1}    ${ImageLocationPath}
    Select Right Top Status Label and Delete
    ${SavedTemplateName}    Save Template    ${TemplateName}
    Open Saved Template and Drag -Drop the Saved Template    ${SavedTemplateName}    ${Blank Display}
    Sleep    10
    ${ExpectedImageAfterDelete}    Capture Screen
    Move File    ${ExpectedImageAfterDelete}    ${TemplateImage2}
    copy file    ${TemplateImage2}    ${ImageLocationPath}
    Comment    ${ExpectedImageAfterDelete}    Capture Region    ${Displaysize}
    Keywords.Verify Whether Output Is Same As Expected    ${TemplateImage1}    ${TemplateImage2}
    Clear Layout Display
    Delete Layout    ${SavedTemplateName}
    [Teardown]    Go To Back

TC02: Audio Bar-Show Meter Displaying on the Output
    [Documentation]    Test Audio Bar-Show Meter functionality
    ...    Steps:
    ...    Add Device
    ...    Go to Multiviewer Display1
    ...    Go to widgets section.
    ...    Drag and drop 4:3 widget
    ...    Add source to it (Go to Sources section,Drag and drop Input-1)
    ...    Go to widgets section.
    ...    Drag and Drop audio bar widget on display
    ...    Expand width and height of audio bar widget
    ...    Enable all channels
    ...    Connect audio bar to 4:3 widget
    ...    Scroll down till show meter under window properties
    ...    Enable show meter
    [Tags]    Smoke    Audiobar
    Set Test Message
    Go To Display And Clear Layout
    Go To Section Drag And Drop Wait Until It Loads On Display    Widgets    43Widget    Window Type Video    @{4:3position}
    Set Position Of Widget    764    112
    Go To Section Drag And Drop    ${Sources}    ${Input-1}    @{4:3positionInput}
    Go To Section Drag And Drop Wait Until It Loads On Display    ${Widgets}    ${Audiobar Widget}    ${WindowType Audiobar}    @{Audiobarposition}
    Set Dimensition Of Widget    900    300
    Set Position Of Widget    460    492
    Emd Click    ${All Channels}
    Connect From One Widget To Another Widget    ${Audio Bar Highlight}    ${Audio Bar Link Button}    ${4:3 Widget Input1}
    Select ShowMeter Checkbox
    Get Capture From VIP Device Using FTP    ${DisplayOutput}    ${DeviceIP}    ${ftpPort}
    Keywords.Verify Whether Output Is Same As Expected    ${Show Meter Verification}    ${Expected Output}
    [Teardown]    Go To Back

TC03:Grid Functionality Verification:Minium,Random, Maxium Values for 16:9 Widget
    [Documentation]    Based on User inputs it test the Grid Functionality
    ...
    ...    steps:
    ...
    ...    1. Go to any display and add grid widget to display
    ...    2. First we will verify with Minium Values such as Number of Rows as 2 and Number of Columns as 2.
    ...    3) After entering the above values in Number of Rows and Number of columns Click on Ok button.
    ...    4) Then assign inputs to Unassigned widgets.
    ...    5) \ Then verify the expected image with FTP Capture image (Actual Image).
    ...    6) Then Clear the layout.
    ...    7) Second we will verify with Random values such as Number of Rows as 3 and Number of Columns as 3.
    ...    8)After entering the above values in Number of Rows and Number of columns Click on Ok button.
    ...    9)Then assign inputs to Unassigned widgets.
    ...    10)Then verify the expected image with FTP Capture image (Actual Image).
    ...    11)Then Clear the layout.
    ...    12)Thrid we will verify with Maxium values such as Number of Rows as 6 and Number of Columns as 6.
    ...    13)After entering the above values in Number of Rows and Number of columns Click on Ok button.
    ...    14)Then assign inputs to Unassigned widgets.
    ...    15)Then verify the expected image with FTP Capture image (Actual Image).
    ...    16)Then Clear the layout and go to Home Page.
    [Tags]    Regression    Grid
    Set Test Message
    Go To Display And Clear Layout
    Go To Section Drag And Drop    ${Widgets}    ${Grid Image}    @{center}
    ${TotalWidgets}    Create Grid    ${AspectRatio}    @{NumberOfRowsAndColumns}    #by default 16:9 is selected if want 4:3 pass arg as: 4:3 Widget
    Assign Inputs To Grid    ${TotalWidgets}
    Get Capture From VIP Device Using FTP    ${DisplayOutput}    ${DeviceIP}    ${ftpPort}
    Keywords.Verify Whether Output Is Same As Expected    ${Expected Image Grid Functionality}    ${Expected Output}
    [Teardown]    Go To Back

TC04:UMD Basic Functionality : Expected Color : YELLOW : Expected Text: POC Demo
    [Documentation]    To test the basic functionality of UMD widget
    ...
    ...    steps
    ...
    ...    1. user add UMD widget to display
    ...    2. send UMD message from external script
    ...    3.verify the correct color and text is showing on output
    ...    4.change the text orientation on widget and change to vertical under windows property for UMD widget
    ...    5. Verify that UMD widget is vertical.
    [Tags]    UMD
    Set Test Message
    Go To Display And Clear Layout
    Go To Section Drag And Drop    Widgets    UMDWidgets    @{Center}
    Set Position Of Widget    816    432
    coreKeywords.Send Image Video UMD    ${DeviceIP}    ${UMDPortNumber}    YELLOW    POC Demo
    sleep    5
    Get Capture From VIP Device Using FTP    ${DisplayOutput}    ${DeviceIP}    ${ftpPort}
    Keywords.Verify Whether Output Is Same As Expected    ${Basis UMD Widget Verification}    ${Expected Output}
    [Teardown]    Go To Back

TC05:Basic Graphics Functionality : Upload Image to VIP : Maximize the Widget Size
    [Documentation]    To test the basic Graphics widget functionality
    ...
    ...    steps:
    ...
    ...    1. Import image to Asset library
    ...    2. Upload the image to vip by clicking upload to image button
    ...    3. Go to any display and add graphics widget to display
    ...    4. Select graphics image from windows property
    ...    5. Verify correct image is showing on output
    ...    6. now click on the maximize button
    [Tags]    Graphics
    Set Test Message
    Go To Display And Clear Layout
    Go To Back
    Go to Asset Library and Click On Tab    ${Graphics Label}
    Asset Import    ${GraphicImagePath}
    Verify Imported Asset is Present in Manage Asset In VIP    ${Manage Assets Image Verification}
    Upload Asset To VIP    ${ManageAssetsImageVerification}
    Go To Multiviewer Display    ${Display}
    Go To Section Drag And Drop    ${Widgets}    ${Graphic Widget}    @{Center}
    Select Images From Windows Properties Tab    ${Image Under Windows Properties}
    Maximize Widget Size    ${Maximize Widget Icon}
    Get Capture From VIP Device Using FTP    ${DisplayOutput}    ${DeviceIP}    ${ftpPort}
    Keywords.Verify Whether Output Is Same As Expected    ${Graphics TC Verification}    ${Expected Output}
    [Teardown]    Remove Asset From Asset Library and VIP    ${ManageAssetsGraphicTab}    ${ManageAssetsImageVerification}

*** Variables ***
${ApplicationTittle}    Evertz Multiviewer Designer
${DeviceName}     SMPTE2022-6
${DeviceIP}       172.17.174.12
${Display}        Display${DisplayOutput}
${ftpPort}        2121
${TemplateName}    pocdemo
${OUTPUT DIR}     ${CURDIR}/../Reports    #from command    -d
# User specified positions
@{Center}         -900    350
@{CenterTop}      -900    250
@{CenterInput}    -850    300
@{RightTop}       -650    5
@{LeftTop}        -1700    5
@{LeftBottom}     -1700    600
@{RightBottom}    -650    600
@{4:3position}    -900    100
@{4:3positionInput}    -850    100
@{Audiobarposition}    -1150    250
${DimensionsWidth}    900
${DimensionsHeight}    300
${DisplayRegion}    [35,143,1456,827]
# Grid
@{NumberOfRowsAndColumns}    2    2    #2 | 2 | #8 | 8 | #
${AspectRatio}    None    #by default 16:9 selected if you want 4:3 pass value as;    4:3 Widget
${UMDPortNumber}    9000
${GridVerification3}    ExpectedGrid6x6.bmp
${TemplateImage1}    TemplateImage1.png
${TemplateImage2}    TemplateImage2.png

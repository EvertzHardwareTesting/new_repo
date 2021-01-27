*** Settings ***
Documentation     This file contains all importing statements
Library           SikuliLibrary    mode=NEW
Library           AutoItLibrary
Library           DateTime
Library           Collections
Library           String
Library           ../Utilities/UserdefinedLibraries.py
Resource          ./Keywords.robot
Resource          ./Variables.robot
Resource          ../Utilities/coreKeywords.robot
Resource          ../Utilities/coreVariables.robot
Variables         ../Utilities/ConfigVariables.py    ${configFIleLocation}
Library           FtpLibrary
Library           Process
Library           OperatingSystem
Library           Screenshot

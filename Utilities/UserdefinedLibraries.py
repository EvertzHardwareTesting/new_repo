import sys
import socket
import time
# # import openpyxl
# # import autoit
from PIL import Image
from PIL import ImageChops
import os


from RobotExceptions import FatalError
#
#
def ImageVideoUmd(deviceIP, umdPort, color, text):
    try:
        connectToDevice = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        connectToDevice.connect((deviceIP, int(umdPort)))
    except Exception as error:
        raise FatalError("Cant Connect to the Device %s with port %d because of the following error :%s" % (deviceIP, int(umdPort), error))

    if color == "RED":
        umdColor = "%85C"
    elif color == "YELLOW":
        umdColor = "%255C"
    elif color == "GREEN":
        umdColor = "%170C"
    else:
        umdColor = "%85C"
    UMD = '%1D%' + 'S%1J' + umdColor + text + '%Z'
    print(UMD)
    connectToDevice.send(bytes(UMD, 'utf-8'))


def GetForLoopRange(Number):
    ConvertedNumber = str(Number)
    try:
        if ConvertedNumber == '1':
            return 37
        elif ConvertedNumber == '2':
            return 10
        elif ConvertedNumber == '3':
            return 5
    except:
        print("Given Range Number is not valid")
        # raise FatalError("Given Range Number is not valid")

def compareImage(image1,image2,imageLocation):
    imageOne = os.path.join(imageLocation,image1)
    imageTwo = os.path.join(imageLocation,image2)


    image_one = Image.open(imageOne)

    image_two = Image.open(imageTwo)

    diff = ImageChops.difference(image_one, image_two)

    if diff.getbbox():
        print (diff.getbbox())
        print("images are different")
        return False
    else:
        print("images are the same")
        return True 

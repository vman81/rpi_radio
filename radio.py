from BitWizard.bw import *
from BitWizard.ui import *
from subprocess import *
from time import sleep, strftime
from smbus import SMBus
from threading import Thread
from Queue import Queue
import struct
import datetime

RPi_Ui_16x2.DefaultAddress = 148
lcd = RPi_Ui_16x2(I2C(0))
i2c = SMBus(0)
address = 0x4a
quitLoop = False

#Display queue
DISPLAY_QUEUE = Queue()

#play/pause status
playpause = "play"

#define buttons
LEFT		= 32
RIGHT		= 16
UP		= 8
DOWN		= 4
PLAYPAUSE	= 2
OPTIONS		= 1

#display queue thread
def update_display(q):
    while True:
        msg = q.get()
        while not q.empty():
            q.task_done()
            msg = q.get()
        lcd.Cls()
        lcd.SetCursor(0,1)
        lcd.Print(msg)
        #print "worker msg"
        q.task_done()
    return

def externalCommand(command):
    cmd = Popen(command, shell=True, stdout=PIPE, stderr=STDOUT)
    output = cmd.communicate()[0] 
    return output
    
def clearAndSet():
    lcd.Contrast(128)
    lcd.Cls()
    lcd.Print("TestCearSet")
    lcd.Backlight(100)

def displayLCD(text):
    lcd.Cls()
    lcd.Print(text)
    
print "Velkommen til radio debug"

# i2c bus read with 50 retries
def readButtons(read=3):
    for attempt in range(0,50):
        try:
            btnRead = i2c.read_i2c_block_data(address,0x31)[0]
        except IOError as err:
#            print "({0}) read_i2c_block_data I/O error({1}): {2}".format(attempt, err.errno, err.strerror)
            continue
        return btnRead
#    return 0,None

def startup():
    #init radio for 1st play
    externalCommand("mpc stop")
    externalCommand("mpc clear")
    #clear LCD and reset cursor
    lcd.Cls()
    lcd.Contrast(128)
    lcd.Backlight(128)

    #totally borrowed code:
    worker = Thread(target=update_display, args=(DISPLAY_QUEUE,))
    worker.setDaemon(True)
    worker.start()
    
    #Welcome message
    #DISPLAY_QUEUE.put("Temp welcome msg")
    
    # fill radio playlist
    populateRadio()
    
    #start radio
    externalCommand("mpc play")
    
    radioPlayer()
    
def populateRadio():
        externalCommand("mpc clear")
        externalCommand("mpc load P1")
        externalCommand("mpc load P2")
        externalCommand("mpc load P3")


#    lines = [line.strip() for line in open('urls.txt')]
#    for line in lines:
#        externalCommand("mpc add "+ line)

#switch between pause and play mode
def playPause():
    global playpause
    if (playpause=="play"):
	playpause="pause"
    else:
	playpause="play"
    return playpause

def radioPlayer():
   global playpause
   while True:
    sleep(0.05)
    entry = readButtons()
    while entry == 32:
	print "Previous"
        externalCommand("mpc prev")
        DISPLAY_QUEUE.put("Previous")
	break
    while entry == 16:
    	print "Next"
        externalCommand("mpc next")
        DISPLAY_QUEUE.put("Next")
        break
    while entry == 8:
    	print "Up"
        externalCommand("mpc volume +5")
        DISPLAY_QUEUE.put("Up")
        break
    while entry == 4:
    	print "Down"
        externalCommand("mpc volume -5")
        DISPLAY_QUEUE.put("Down")
	break
    while entry == 2:
	playPause()
	if playpause=="play":
            print "Play"
            DISPLAY_QUEUE.put("Play")
        else:
   	    print "Pause"
            DISPLAY_QUEUE.put("Pause")
        externalCommand("mpc "+playpause)
	break
	
    while entry == 1:
	print "Options"
        #externalCommand("mpc clear")
        DISPLAY_QUEUE.put("Options")
	break	        
startup()
i2c.close()

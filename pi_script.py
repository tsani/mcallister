import RPi.GPIO as GP
import requests as r
import time

try:
    # Pin numbers
    INPUT = 12
    RED_OUT = 10
    GREEN_OUT = 8

    # Setup board
    GP.setmode(GP.BOARD)

    # Setup pins
    GP.setup(INPUT, GP.IN)
    GP.setup(RED_OUT, GP.OUT)
    GP.setup(GREEN_OUT, GP.OUT)

    # Global state
    status = False
    red = True
    green = False

    # Initialize LEDs
    GP.output(RED_OUT, int(red))
    GP.output(GREEN_OUT, int(green))

    def toggleLED():
        red = not red
        green = not green
        GP.output(RED_OUT, int(red))
        GP.output(GREEN_OUT, int(green))

    while True:
        i = bool(GP.input(INPUT))
        # Send request
        if i:
            payload = { "status" : not status }
            resp = r.post(
                    "http://b21.jerrington.me/api/status",
                    data = payload
                    )
            if resp.status_code != 200:
                print("ERROR: Please email the developers of this button.")
                continue
            else:
                status = not status
                toggleLED()
            time.sleep(0.2)
finally:
    GP.cleanup()

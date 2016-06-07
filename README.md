# Xojo-pigpio
A Xojo library for pigpio features in Raspberry Pi projects

Sorry there is no documentation yet. Please see the demo console app and the method descriptions.

###Currently included
(Besides a lot of fairly untested pigpio declares):
* LCD Display class with rough Umlaut translation
* Button class with interrupts enabling background responses
* Interrupt-driven IRMotionDetector class

### No events!
> Yes, it would be the highest Xojo level of comfort to have events firing when the level of a sensor changes. This is, if possible, complicated at least, because the events are returned on a background thread and it would be very difficult to get onto the virtual sensor instance.  
Instead, interrupt-driven controls feature a shared method that is exectued on the background thread. Therefore you must create any Xojo objects, but it is safe to use the external methods. Please see the DemoButton class for an example.
If you need to use Xojo methods that lock to an object, it is safe to store the interrupt parameters into Xojo properties. Have a timer look for changes in these. See https://einhugur.com/blog/index.php/xojo-gpio/hc-sr501-sensor/ for an example of combined uses.

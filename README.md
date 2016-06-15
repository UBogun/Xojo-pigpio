# Xojo-pigpio
A Xojo library for pigpio features in Raspberry Pi projects

Sorry there is no documentation yet. Please see the demo console app and the method descriptions.

###Currently included
(Besides a lot of fairly untested pigpio declares):
* LCD Display class with rough Umlaut translation
* Button class with interrupts enabling background responses
* Interrupt-driven IRMotionDetector class
* Ultrasonic sensor class
* Demo console app to make use of a few of these features. It informs you about wiring when you select a demo.  
  
### Basic use
Copy the pigpio module and the bitwise extension from the project into your own Raspberry Pi project.  
I tried to create virtual properties and convenience methods around the library.  
If you want to use it in a form closest to the original, you find the declare as external methods in the module. Just change their scope and maybe unhide them.
Look into the classes in the module that demonstrate how to use the library.
A gpioWrite for example is pigpio.DigitalValue(GPIOPin) = True or False, while you can get the value via pigpio.DigitalValue(gpioPin).  
All public methods and properties are documented. Look into the descrition tags or consult the pigpio documentation at http://abyz.co.uk/rpi/pigpio/cif.html.

### No events!
> Yes, it would be the highest Xojo level of comfort to have events firing when the level of a sensor changes. This is, if possible, complicated at least, because the events are returned on a background thread and it would be very difficult to get onto the virtual sensor instance.  
Instead, interrupt-driven controls feature a shared method that is exectued on the background thread. Therefore you must not use or create any Xojo objects, but it is safe to use  external methods and datatypes. Please see the DemoButton class for an example.  
If you need to use Xojo methods that lock to an object, it is safe to store the interrupt parameters into Xojo properties. Have a timer look for changes in these. See https://einhugur.com/blog/index.php/xojo-gpio/hc-sr501-sensor/ for an example of combined uses.

###Credits
To Paul Lefebvre for Xojo-gpio and Björn Eiríksson for his brilliant Einhugur Tech blog.
And of course to whoever stands behind the pgio team. Great work!

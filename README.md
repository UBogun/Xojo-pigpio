# Xojo-pigpio
A Xojo library for pigpio features in Raspberry Pi projects

Sorry there is no documentation yet. Please see the demo console app and the method descriptions.

###Currently included
(Besides a lot of fairly untested pigpio declares):
* almost every pigpio method and property, including exception messages for easier debugging. Basically only the scripts section and two or three bulk methods are missing where I am unsure about the structure being used.
* LCD Display class with rough Umlaut translation
* Button class with interrupts enabling background responses
* Interrupt-driven IRMotionDetector class
* Ultrasonic sensor class
* RGBLED class that can be addressed with Xojo color and an additional brightness value and uses 12 bit color per channel internally.
* Servo class using the pigpio servo methods and an optional Double parameter for fractions of the maximum left and right deflection.
* Demo console app to make use of a few of these features, including pigpio timers and interrupts. It informs you about wiring when you select a demo.  
  
### Basic use
Copy the pigpio module and the bitwise extension from the project into your own Raspberry Pi project.  
I tried to create virtual properties and convenience methods around the library.  
If you want to use it in a form closest to the original, you find the declare as external methods in the module. Just change their scope and maybe unhide them.
Look into the classes in the module that demonstrate how to use the library.
A gpioWrite for example is pigpio.DigitalValue(GPIOPin) = True or False, while you can get the value via pigpio.DigitalValue(gpioPin).  
All public methods and properties are documented. Look into the description tags or consult the pigpio documentation at http://abyz.co.uk/rpi/pigpio/cif.html.
  
### Differences to pigpio original implementation
Whereby pigpio returns you an integer for as good as method call, I have only done so if this return value needs to be remembered, like a handle. To prepare this library better for the new Xojo framework, I fire exceptions intead when the result is below 0, adding the exception message according to pigpio‘ error list.  
Keep your method calls in try/catch causes therefore if you want to handle errors.  
  
As stated above, whereever a getter and a setter to a property exists, I have synthesized methods behaving like computed properties. You set the PWM dutycycle of a Pin by pigpio.AnalogValue(Pin) = value and get it by Dim value as Integer = pigpio.AnalogValue(Pin).  
  

### No events!
> Yes, it would be the highest Xojo level of comfort to have events firing when the level of a sensor changes. This is, if possible, complicated at least, because the events are returned on a background thread and it would be very difficult to get onto the virtual sensor instance.  
>  
> Instead, interrupt-driven controls feature a shared method that is exectued on the background thread. Therefore you must not use or create any Xojo objects, but it is safe to use  external methods and datatypes. Please see the DemoButton class for an example.  
If you need to use Xojo methods that lock to an object, it is safe to store the interrupt parameters into Xojo properties. Have a timer look for changes in these. See https://einhugur.com/blog/index.php/xojo-gpio/hc-sr501-sensor/ for an example of combined uses.  
>  
> Please note that the use of pigpio timers, interrupts and other callbacks is subject to discussion on the Xojo forums and not supported by Xojo officially. Therefore, it may stop working one day. In extensive tests and conversations with other developers, I have found the current solution to be stable as long as you do not access Xojo instances and instance properties and methods. Instead, you have to hardcode results and properties into shared or otherwise safe properties and use the shared pigpio external declares.   
See https://forum.xojo.com/32985-pigpio-library-for-xojo (especially Joe’s post where he explains what is supposed to work in the current Xojo release, though not officially supported)

###Credits
To Paul Lefebvre for Xojo-gpio and Björn Eiríksson for his brilliant Einhugur Tech blog.
And of course to whoever stands behind the pigpio library. Great work!

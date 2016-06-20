#tag Class
Protected Class App
Inherits ConsoleApplication
	#tag Event
		Function Run(args() as String) As Integer
		  #if TargetARM and TargetLinux then
		    // Just a few test values:
		    
		    print "pigpio initialized, version "+pigpio.Initialise.ToText  // Initalise returns the pigpio version
		    Print "Hardware revision: "+pigpio.HardwareRevision.totext
		    print "Bit states 0-31 as integer: "+pigpio.Bits_0_31.ToText // The values of the GPIO pins
		    print "Bit states 32-53 as integer: " +pigpio.Bits_32_53.ToText
		    dim secs, micros as uinteger
		    pigpio.SecondsSince1970(secs, micros) // How late is it?
		    print "Seconds/µseconds since 1970: "+secs.totext+":"+micros.totext
		    pigpio.SecondsSinceInit(secs, micros) // and how long since init?
		    print "Seconds/µseconds since initialization: "+ secs.totext+":"+micros.totext
		    print ""
		     
		    do
		      print "Select a demo"
		      print "1 – Button with LED"
		      print "2 – LCD Display"
		      print "3 – IR Motion Detector"
		      print "4 – Ultrasonic Sensor"
		      print "5 – RGB LED with Xojo timer pulse"
		      print "6 – RGB LED with pigpio timer pulse"
		      print "q to quit"
		      print"?"
		      dim result as string = Input
		      print""
		      select case result
		      case "1"
		        print "Button with LED"
		        print "You should have a button at GPIOPin 6 and an LED at Pin 19, both connected with resistors to ground."
		        print "The button will trigger the LED via interrupt on a background thread"
		        print "Ok to continue? (Y/N)"
		        result = Input
		        if result <> "y" then exit
		        dim b as new DemoButton(6)
		        
		        #pragma unused b
		      case "2"
		        print "LCD Display"
		        print "Connect an LCD display the following way: (like in the gpio example)"
		        print "RS to Pin 25"
		        print "Enable to pin 24"
		        print "D4 to pin 23"
		        print "D5 to pin 17"
		        print "D6 to pin 21"
		        print "D7 to pin 22"
		        print "Ok to continue? (Y/N)"
		        result = Input
		        if result <> "y" then exit
		        
		        Const kRSPin = 25
		        Const kEPin = 24
		        Const kD4Pin = 23
		        Const kD5Pin = 17
		        Const kD6Pin = 21
		        Const kD7Pin = 22
		        
		        dim Display as New pigpio.LCDDisplay_HD44780(kRSPin, kEPin, kD4Pin, kD5Pin, _
		        kD6Pin, kD7Pin, 2)
		        Display.Clear
		        Display.SetMessage("Displaytest!")
		        Display.SetMessage("Umläütö", 2)
		        Display.Display = true
		        pigpio.Sleep 3
		        for q as integer = 0 to 15
		          Display.ScrollDisplayRight
		          pigpio.Sleep 0, 100000
		        next
		        for q as integer = 0 to 51
		          Display.ScrollDisplayLeft
		          pigpio.Sleep 0, 100000
		        next
		        Display.blink = true
		        pigpio.Sleep 3
		        Display.Display = false
		        
		      case "3"
		        print "IR Motion Detector"
		        print "This demo assumes you have a PIR Motion detector attached to GPIOPin 5."
		        print "It will print into the console whenever it detects a motion"
		        print "Ok to continue? (Y/N)"
		        result = Input
		        if result <> "y" then exit
		        dim ir as new pigpio.IRMotionDetector(5)
		        #pragma unused ir
		        
		      case "4"
		        print "Ultrasonic Sensor"
		        print "This demo triggers an ultrasonic sensor at TriggerPin 16 and EchoPin 26 and prints the result (distance in cm)"
		        print "for setup, please refer to Einugur’s Tech blog."
		        print "Ok to continue?"
		        result = Input
		        if result <> "y" then exit
		        if ultrasonic = nil then UltraSonic = new pigpio.UltrasonicSensor(16, 26)
		        print "Distance: "+UltraSonic.MeasureDistance.ToText+" cm"
		        
		      case "5"
		        print "RGB LED with Xojo timer"
		        print "You should have an RGB LED connected to Pins 12, 16 and 18 (RGB) (and resistors if necessary)"
		        print "This demo will install a Xojo timer to pulse the brightness of the LED"
		        print "It will deinstall the timer once you hit x on the keyboard"
		        print "Note: The cancel keycode is not working yet. You have to cancel the app hitting CMD-C."
		        print "Ok to continue?"
		        result = Input
		        if result <> "y" then exit
		        RGBLED = new pigpio.RGBLED(12, 16, 18)
		        RGBLED.LEDColor = &c75D2FE00
		        app.OrigRed = RGBLed.LEDColor.Red
		        app.OrigBlue = RGBLed.LEDColor.Blue
		        app.OrigGreen = RGBLed.LEDColor.Green
		        pulsetimer = new timer
		        AddHandler PulseTimer.action, Addressof PulseLED
		        PulseTimer.Period = 10
		        PulseTimer.mode = timer.ModeMultiple
		        PulseTimer.Enabled = true
		        result =""
		        do
		          app.DoEvents
		          result = result + stdin.ReadAll
		        loop until result.Right(1) = "x"
		        
		        PulseTimer.Mode = timer.ModeOff
		        RemoveHandler PulseTimer.action, Addressof PulseLED
		        
		      case "6"
		        print "RGB LED with pigpio timer"
		        print "You should have an RGB LED connected to Pins 12, 16 and 18 (RGB) (and resistors if necessary)"
		        print "This demo will install a pigpio timer to pulse the brightness of the LED"
		        print "This timer will work until you quit the demo app"
		        print "Ok to continue?"
		        result = Input
		        if result <> "y" then exit
		        RGBLED = new pigpio.RGBLED(12, 16, 18)
		        RGBLED.LEDColor = &c8B12FD00
		        app.OrigRed = RGBLed.LEDColor.Red
		        app.OrigBlue = RGBLed.LEDColor.Blue
		        app.OrigGreen = RGBLed.LEDColor.Green
		        
		        pigpio.TimerFunction (1, 10) = Addressof PulseLEDpgigioTimer
		      case "testpin"
		        print "enter pin to check in a tight loop"
		        result = input
		        dim pin as integer = integer.Parse(result.ToText)
		        while true
		          print pigpio.gpioread(pin).totext
		        wend
		      case "q"
		        exit do
		      end select
		    loop until false
		    
		    
		    pigpio.Terminate 
		  #endif
		  #pragma unused args
		End Function
	#tag EndEvent

	#tag Event
		Function UnhandledException(error As RuntimeException) As Boolean
		  try
		    pigpio.Terminate
		  end try
		  print "The app must quit because of an exception "+error.ErrorNumber.ToText+EndOfLine+error.Message
		  print error.Reason
		  quit
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub PulseLED(t as timer)
		  //This is the pulse/rainbow color method that is run on a Xojo timer.
		  // I use the shared app properties here for a comparison to the pigpio timer method, but as you can see I can safely change the LEDColor property of the RGBLED.
		  // The drawback is the doevents loop you have to install to keep the timer working in a console app.
		  
		  #pragma StackOverflowChecking false
		  #pragma BackgroundTasks false
		  // print "timer fired "+app.LEDBrightness.ToText
		  app.LEDBrightness = app.LEDBrightness + app.LEDBrightnessStep
		  // print "new value "+app.LEDBrightness.ToText
		  if app.LEDBrightness > 0.9 or app.LEDBrightness < 0.03 then
		    app.LEDBrightnessStep = app.LEDBrightnessStep * -1
		    // print "revsersed order"
		  end if
		  app.LEDHue = app.LEDHue + 0.0001
		  if app.LEDHue > 1 then app.LEDHue = 0
		  RGBLed.LEDColor = HSV(app.LEDHue, 1.0, app.LEDBrightness)
		  #Pragma unused t
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Sub PulseLEDpgigioTimer()
		  // this code will run on a background thread.
		  // therefore, it is unsure to address objects and instance properties and methods.
		  // we have to do the color calculation with shared propertes and hardcore the pigpio calls.
		  #if TargetARM and TargetLinux
		    
		    #pragma StackOverflowChecking false
		    #pragma BackgroundTasks false
		    // print "timer fired "+app.LEDBrightness.ToText
		    app.LEDBrightness = app.LEDBrightness + app.LEDBrightnessStep
		    // print "new value "+app.LEDBrightness.ToText
		    if app.LEDBrightness > 0.9 or app.LEDBrightness < 0.03 then
		      app.LEDBrightnessStep = app.LEDBrightnessStep * -1
		      // print "revsersed order"
		    end if
		    app.LEDHue = app.LEDHue + 0.0001
		    if app.LEDHue > 1 then app.LEDHue = 0
		    dim newcol as color = hsv(app.LEDHue, 1.0, app.LEDBrightness)
		    
		    // Calculate multiplier
		    
		    dim maxval as integer = 4080 * app.LEDBrightness
		    dim maxRGB as Integer = max(newcol.Red, newcol.Blue, newcol.green)
		    dim factor as Double = maxval / maxrgb
		    // print "New brightness factor: "+factor.ToText
		    
		    //Set RGB values and remember Brightness value.
		    dim RedValue as integer = newcol.red* factor
		    // print "new red:"+RedValue.ToText
		    dim GreenValue as integer =newcol.Green * factor
		    dim BlueValue as integer = newcol.Blue * factor
		    call pigpio.gpioPWM(12, RedValue)
		    call pigpio.gpioPWM(16, GreenValue)
		    call pigpio.gpioPWM(18, BlueValue)
		  #endif
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Shared LEDBrightness As Double = .5
	#tag EndProperty

	#tag Property, Flags = &h0
		Shared LEDBrightnessStep As Double = 0.005
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4C4544487565
		Shared LEDHue As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		Shared OrigBlue As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Shared OrigGreen As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Shared OrigRed As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		PulseTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h0
		RGBLed As pigpio.RGBLED
	#tag EndProperty

	#tag Property, Flags = &h0
		UltraSonic As pigpio.UltrasonicSensor
	#tag EndProperty


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass

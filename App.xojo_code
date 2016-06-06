#tag Class
Protected Class App
Inherits ConsoleApplication
	#tag Event
		Function Run(args() as String) As Integer
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
		  print "see the App run event for a few test cases you can uncomment"
		  
		  
		  // Some test cases:
		  
		  // // LED
		  // pigpio.Mode(19)= pigpio.PigpioMode.Output // Place a LED with a resitor on pin 19
		  // pigpio.DigitalValue(19) =true // … and it was light!
		  
		  
		  
		  // //LCD Display
		  // 
		  // 
		  // Const kRSPin = 25
		  // Const kEPin = 24
		  // Const kD4Pin = 23
		  // Const kD5Pin = 17
		  // Const kD6Pin = 21
		  // Const kD7Pin = 22
		  // 
		  // Display = New pigpio.LCDDisplay_HD44780(kRSPin, kEPin, kD4Pin, kD5Pin, _
		  // kD6Pin, kD7Pin, 2)
		  // Display.Clear
		  // Display.Home
		  // Display.AutoScroll = true
		  // Display.SetMessage("Displaytest!äöü too longß")
		  // Display.SetMessage("2. Zeile auchÖ^°", 2)
		  // Display.Display = true
		  // Display.blink = true
		  
		  
		  pigpio.Terminate 
		End Function
	#tag EndEvent


	#tag Property, Flags = &h0
		Display As pigpio.LCDDisplay_HD44780
	#tag EndProperty


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass

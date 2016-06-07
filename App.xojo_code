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
		  print ""
		  
		  do
		    print "Select a demo"
		    print "1  – Button with LED"
		    print "2 – LCD Display"
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
		      print "The interrupt will stay active until you quit the program"
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
		      
		      Display = New pigpio.LCDDisplay_HD44780(kRSPin, kEPin, kD4Pin, kD5Pin, _
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
		      
		    case "q"
		      exit do
		    end select
		  loop until false
		  
		  
		  pigpio.Terminate 
		End Function
	#tag EndEvent

	#tag Event
		Function UnhandledException(error As RuntimeException) As Boolean
		  try
		    pigpio.Terminate
		  end try
		  print "The app must quit because of an exception "+error.ErrorNumber.ToText
		  print error.Reason
		  quit
		End Function
	#tag EndEvent


	#tag Property, Flags = &h0
		Display As pigpio.LCDDisplay_HD44780
	#tag EndProperty


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass

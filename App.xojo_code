#tag Class
Protected Class App
Inherits ConsoleApplication
	#tag Event
		Function Run(args() as String) As Integer
		  // Just a few test values:
		  
		  print pigpio.Initialise.ToText  // Initalise returns the pigpio version
		  Print pigpio.HardwareRevision.totext
		  print pigpio.Version.totext
		  print pigpio.Bits_0_31.ToText // The values of the GPIO pins
		  print pigpio.Bits_32_53.ToText
		  dim secs, micros as uinteger
		  pigpio.SecondsSince1970(secs, micros) // How late is it?
		  print secs.totext+":"+micros.totext
		  pigpio.SecondsSinceInit(secs, micros) // and how long since init?
		  print secs.totext+":"+micros.totext
		  pigpio.Mode(19)= pigpio.PigpioMode.Output // Place a LED with a resitor on pin 19
		  pigpio.DigitalValue(19) =true // … and it was light!
		  pigpio.Terminate 
		End Function
	#tag EndEvent


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass

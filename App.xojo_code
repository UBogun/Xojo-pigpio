#tag Class
Protected Class App
Inherits ConsoleApplication
	#tag Event
		Function Run(args() as String) As Integer
		  print pigpio.Initialise.ToText
		  Print pigpio.HardwareRevision.totext
		  print pigpio.Version.totext
		  print pigpio.Bits_0_31.ToText
		  print pigpio.Bits_32_53.ToText
		  pigpio.Terminate
		End Function
	#tag EndEvent


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass

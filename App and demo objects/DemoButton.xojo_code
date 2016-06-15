#tag Class
Protected Class DemoButton
Inherits pigpio.Button
	#tag Method, Flags = &h0
		Sub Constructor(GpioPin as Integer)
		  super.Constructor(GpioPin)
		  pigpio.InterruptFunction (GpioPin, PigpioEdge.Either, 0) = addressof DemoPressReceiver
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Sub DemoPressReceiver(GPIO As Integer, Level as Integer, Tick as Uint32)
		  #pragma StackOverflowChecking false
		  #pragma BackgroundTasks False
		  #if TargetLinux and TargetARM 
		    if GPIO = 6 then call pigpio.gpiowrite(19, abs(level-1))
		  #else
		    #pragma unused GPIO
		    #pragma unused Level
		    #pragma unused tick
		  #endif
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="GpioPin"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass

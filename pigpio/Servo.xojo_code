#tag Class
Protected Class Servo
	#tag Method, Flags = &h0, Description = 4D6F7665732074686520536572766F20746F206974732063656E74657220706F736974696F6E2E
		Sub Center()
		  pulsewidth = CenterValue
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(PWMPin as Integer)
		  me.mPWMPin = PWMPin
		  pigpio.Mode(PWMPin) =pigpio.PigpioMode.Output
		  pigpio.DigitalValue(PWMPin) = False
		  center
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D6F7665732074686520536572766F20746F20746865204C6566742E
		Sub Left(Deflection As Double = 1)
		  PulseWidth = CenterValue - ((CenterValue - LeftValue) * Deflection)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365747320616C6C2070756C736573206F66662E
		Sub Off()
		  pigpio.ServoPulsewidth(PWMPin) = 0
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D6F7665732074686520536572766F20746F207468652052696768742E
		Sub Right(Deflection As Double = 1)
		  PulseWidth = CenterValue + ((RightValue - CenterValue ) * Deflection) 
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = ReadMe
		
		This is a wrapper class for easier servo control.
		It features no Unsupported code, so it should be safe to use in any case.
		Basically,  you just define the gpio port the sensor is attached to and then use one of the instance methods to control it.
		You might want to change LeftValue and RightValue accourding to the maximum pulse length of your sensor. Look into its data sheet.
		
		Left and right methods can be addressed with an optional double between 0.0 and 1.0 meaning the percentage of maximum deflection.
	#tag EndNote


	#tag Property, Flags = &h0, Description = 5468652070756C7365206C656E67746820666F722074686520736572766FE28099732063656E74657220706F736974696F6E2E
		CenterValue As Integer = 1500
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652070756C7365206C656E67746820666F722074686520736572766FE2809973206C6566746D6F737420706F736974696F6E2E
		LeftValue As Integer = 500
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPWMPin As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return pigpio.ServoPulsewidth(mPWMPin)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  pigpio.ServoPulsewidth(mPWMPin) = value
			End Set
		#tag EndSetter
		PulseWidth As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520636F6E74726F6C206770696F2070696E206F662074686520736572766F2E
		#tag Getter
			Get
			  return mPWMPin
			End Get
		#tag EndGetter
		PWMPin As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 5468652070756C7365206C656E67746820666F722074686520736572766FE28099732072696768746D6F737420706F736974696F6E2E
		RightValue As Integer = 2500
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="CenterValue"
			Group="Behavior"
			InitialValue="1500"
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
			Name="LeftValue"
			Group="Behavior"
			InitialValue="500"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PulseWidth"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PWMPin"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RightValue"
			Group="Behavior"
			InitialValue="2500"
			Type="Integer"
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

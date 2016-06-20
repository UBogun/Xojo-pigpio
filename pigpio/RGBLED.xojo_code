#tag Class
Protected Class RGBLED
	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(RedPin As Integer, BluePin As Integer, GreenPin As Integer)
		  mRedPin = RedPin
		  mBluePin = BluePin
		  mGreenPin = GreenPin
		  
		  Print "Setting output"
		  pigpio.Mode(RedPin) = pigpio.PigpioMode.Output
		  pigpio.Mode(GreenPin) = pigpio.PigpioMode.Output
		  pigpio.Mode(BluePin) = pigpio.PigpioMode.Output
		  
		  Print "Setting RGB to 0"
		  
		  pigpio.DigitalValue(RedPin) = False
		  pigpio.DigitalValue(GreenPin) = False
		  pigpio.DigitalValue(BluePin) = False
		  
		  Print "Setting maxvalue"
		  
		  pigpio.AnalogRange(RedPin) = MaxValue
		  pigpio.AnalogRange(GreenPin) = MaxValue
		  pigpio.AnalogRange(BluePin) = MaxValue
		  
		  Print "Real max "+pigpio.AnalogRealRange(RedPin).totext
		  Print "max "+pigpio.AnalogRange(RedPin).totext
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Off()
		  pigpio.AnalogValue(mRedPin) = 0
		  pigpio.AnalogValue(mBluePin) = 0
		  pigpio.AnalogValue(mGreenPin) = 0
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetColor()
		  #if TargetARM and TargetLinux
		    call pigpio.gpioPWM(RedPin, RedValue)
		    call pigpio.gpioPWM(GreenPin, GreenValue)
		    call pigpio.gpioPWM(BluePin, BlueValue)
		  #endif
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #pragma StackOverflowChecking false
			  #Pragma BackgroundTasks false
			  return mBluePin
			End Get
		#tag EndGetter
		BluePin As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		BlueValue As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652063757272656E7420636F6C6F72206F6620746865204C45442C2074616B696E67206272696768746E65737320696E746F206163636F756E742028726561642D6F6E6C7929
		#tag Getter
			Get
			  #pragma StackOverflowChecking false
			  #Pragma BackgroundTasks false
			  
			  return rgb(Round(RedValue / ColorMultiplier * LEDBrightness), round(GreenValue / ColorMultiplier * LEDBrightness), round(BlueValue / ColorMultiplier * LEDBrightness))
			End Get
		#tag EndGetter
		CurrentLEDColor As Color
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #pragma StackOverflowChecking false
			  #Pragma BackgroundTasks false
			  return mGreenPin
			End Get
		#tag EndGetter
		GreenPin As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		GreenValue As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #pragma StackOverflowChecking false
			  #Pragma BackgroundTasks false
			  return max(RedValue, BlueValue, GreenValue) / MaxValue
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  #pragma StackOverflowChecking false
			  #Pragma BackgroundTasks false
			  // print "new brightness received"
			  // LEDColor = LEDColor
			  // print "new brightness "+value.ToText
			  
			  #pragma StackOverflowChecking false
			  #Pragma BackgroundTasks false
			  // Clip value to possible data range
			  value = min (value, 1.0)
			  value = max (value, 0.0)
			  
			  // Calculate multiplier
			  
			  dim maxval as integer = MaxValue * value
			  dim maxRGB as Integer = max(OrigRed, OrigBlue, OrigGreen)
			  dim factor as Double = maxval / maxrgb
			  // print "New brightness factor: "+factor.ToText
			  
			  //Set RGB values and remember Brightness value.
			  RedValue = Origred* factor
			  // print "new red:"+RedValue.ToText
			  GreenValue = OrigGreen * factor
			  BlueValue = OrigBlue * factor
			  SetColor
			  
			End Set
		#tag EndSetter
		LEDBrightness As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206F726967696E616C20636F6C6F72206F6620746865204C45442E
		#tag Getter
			Get
			  #pragma StackOverflowChecking false
			  #Pragma BackgroundTasks false
			  
			  return rgb(OrigRed, OrigGreen, OrigBlue)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  // Print "Setting new RGB value"
			  // print "Red: "+value.RedValue.ToText
			  // print "Green: "+value.GreenValue.ToText
			  // print "Blue: "+value.BlueValue.ToText
			  #pragma StackOverflowChecking false
			  #Pragma BackgroundTasks false
			  OrigRed = value.Red
			  OrigGreen = value.Green
			  OrigBlue = value.Blue
			  RedValue = value.Red * ColorMultiplier
			  GreenValue = value.Green * ColorMultiplier
			  BlueValue = value.Blue * ColorMultiplier
			  
			  
			  SetColor
			  // print "values set"
			  // mLEDColor = value
			End Set
		#tag EndSetter
		LEDColor As Color
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206F726967696E616C20687565206F6620746865204C45442E
		#tag Getter
			Get
			  #pragma StackOverflowChecking false
			  #Pragma BackgroundTasks false
			  
			  return LEDColor.Hue
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  LEDColor = HSV(value, me.LEDSaturation, me.LEDBrightness)
			End Set
		#tag EndSetter
		LEDHue As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206F726967696E616C2073617475726174696F6E206F6620746865204C45442E
		#tag Getter
			Get
			  #pragma StackOverflowChecking false
			  #Pragma BackgroundTasks false
			  
			  return LEDColor.Saturation
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  LEDColor = HSV(me.LEDHue, value, me.LEDBrightness)
			End Set
		#tag EndSetter
		LEDSaturation As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206F726967696E616C2076616C756520286272696768746E65737329206F6620746865204C454420206173204853562076616C75652E
		#tag Getter
			Get
			  #pragma StackOverflowChecking false
			  #Pragma BackgroundTasks false
			  
			  return LEDColor.Value
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  LEDColor = HSV(me.LEDHue, me.LEDSaturation, value)
			End Set
		#tag EndSetter
		LEDValue As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mBluePin As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGreenPin As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRedPin As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		OrigBlue As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		OrigGreen As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		OrigRed As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #pragma StackOverflowChecking false
			  #Pragma BackgroundTasks false
			  return mRedPin
			End Get
		#tag EndGetter
		RedPin As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		RedValue As Integer
	#tag EndProperty


	#tag Constant, Name = ColorMultiplier, Type = Double, Dynamic = False, Default = \"16", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MaxValue, Type = Double, Dynamic = False, Default = \"4080", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="BluePin"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BlueValue"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CurrentLEDColor"
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="GreenPin"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="GreenValue"
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
			Name="LEDBrightness"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LEDColor"
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LEDHue"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LEDSaturation"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LEDValue"
			Group="Behavior"
			Type="Double"
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
			Name="OrigBlue"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="OrigGreen"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="OrigRed"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RedPin"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RedValue"
			Group="Behavior"
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

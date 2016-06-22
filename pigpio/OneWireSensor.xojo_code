#tag Class
Protected Class OneWireSensor
	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target32Bit or Target64Bit))
		 Shared Sub ListDevices()
		  #if TargetARM and TargetLinux then
		    Dim f as   FolderItem = DevicePaths
		    if f <> nil and f.exists then
		      for q as Integer = 1 to f.Count 
		        dim p as FolderItem = f.Item(q)
		        #if TargetConsole then
		          print p.NativePath
		        #else
		          System.DebugLog p.NativePath
		        #endif
		      next
		    else
		      #if TargetConsole then
		        print NoOneWirePathFound
		      #else
		        System.DebugLog NoOneWirePathFound
		      #endif
		    end if
		  #endif
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0, Description = 54686520466F6C6465724974656D20636F6E7461696E696E6720616C6C20636F6E6E6563746564204F6E655769726544657669636573
		#tag Getter
			Get
			  #if TargetARM and TargetLinux then
			    Dim f as new  FolderItem (OneWirePath, FolderItem.PathTypeShell)
			    if f <> nil and f.exists then return f
			  #endif
			End Get
		#tag EndGetter
		Shared DevicePaths As FolderItem
	#tag EndComputedProperty


	#tag Constant, Name = kYes, Type = Text, Dynamic = False, Default = \"YES", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NoOneWirePathFound, Type = Text, Dynamic = False, Default = \"No one wire path found. Are you sure you enabled oneWire support on this RasPi\?", Scope = Public
	#tag EndConstant

	#tag Constant, Name = noValidValue, Type = Double, Dynamic = False, Default = \"-999999", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = OneWirePath, Type = Text, Dynamic = False, Default = \"/sys/bus/w1/devices", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SlaveExtension, Type = Text, Dynamic = False, Default = \"/w1_slave", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
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

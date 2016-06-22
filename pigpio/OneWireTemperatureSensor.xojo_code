#tag Class
Protected Class OneWireTemperatureSensor
Inherits pigpio.OneWireSensor
	#tag Method, Flags = &h0
		 Shared Function AutoConnect() As pigpio.OneWireTemperatureSensor
		  Dim f as   FolderItem = DevicePaths
		  for q as Integer = 1 to f.Count 
		    dim p as FolderItem = f.Item(q)
		    if instr(p.Name,"28-") > 0 then
		      print "connected with path "+p.Name
		      return new pigpio.OneWireTemperatureSensor(p)
		    end if
		  next
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 437265617465732061206E6577204F6E65576972652054656D70657261747572652053656E736F72
		Sub Constructor(F as FolderItem)
		  Path = f
		  PollThread = new Thread
		  AddHandler PollThread.Run, Addressof ThreadedPoll
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  if PollThread <> Nil and not PollThread.State = thread.NotRunning then PollThread.Kill
		  RemoveHandler PollThread.Run, Addressof ThreadedPoll
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652063757272656E742074656D706572617475726520696E20C2B043206F72202D3120696620616E206572726F72206F636375727265642E
		Function PollData() As Double
		  if path <> nil  then
		    try
		      dim FString as text =  OneWirePath + "/" + path.Name.ToText  + slaveextension
		      dim vf as FolderItem = GetFolderItem(FString)
		      dim t as TextInputStream = TextInputStream.Open(vf)
		      dim s as text = t.ReadAll.ToText
		      if s.IndexOf(kYes) > -1 then
		        dim pos as integer = s.IndexOf (kTemp)
		        if pos > -1 then
		          dim temptext as text = s.mid(pos +2)
		          mTemperature = Double.FromText(temptext) / 1000
		          mErrorCount = 0
		          return mTemperature
		        end if
		      end if
		    catch
		      mErrorCount = mErrorCount +1
		      return noValidValue
		    end try
		  else
		    mErrorCount = mErrorCount +1
		    return noValidValue
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5573652074686973207468726561646564206D6574686F6420746F20757064617465207468652072656164696E67206175746F6D61746963616C6C79206576657279203130207365636F6E64732E
		Private Sub ThreadedPoll(thr as thread)
		  if path <> nil  then
		    try
		      print "path exists"
		      dim FString as text =  OneWirePath + "/" + path.Name.ToText  + slaveextension
		      dim vf as FolderItem = GetFolderItem(FString)
		      dim t as TextInputStream = TextInputStream.Open(vf)
		      while thr.State <> thread.NotRunning
		        Try
		          dim s as text = t.ReadAll.ToText
		          print "data read"
		          if s.IndexOf(kYes) > -1 then
		            print "CRC ok"
		            dim pos as integer = s.IndexOf (kTemp)
		            if pos > -1 then
		              dim temptext as text = s.mid(pos +2)
		              mTemperature = Double.FromText(temptext) / 1000
		              mErrorCount = 0
		            end if
		          end if
		        catch
		          print "OneWire read error"
		          mErrorCount = mErrorCount + 1
		        End Try
		        thr.Sleep(10000)
		      wend
		    catch
		      print "OneWire read error"
		      mErrorCount = mErrorCount + 1
		    end try
		  else
		    print "OneWire Path is nil"
		    mErrorCount = mErrorCount + 1
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = ReadMe
		
		This class is forr reading oneWire Temperature sensors. I tested it with a Keyes DB18B20.
		The important thing is to enable OneWire Support and connect the sensor to any free GPIO pin (and the voltage pins of course).
		It will update about avery 10 seconds. You can theoretically use the threaded Method I attached but will have to keep a DoEvents loop running inf you are inside a console project.
		Or use any other means to poll it, preferably not more often than every 10 seconds.
		Keep in mind the accuracy is misleading; these sensors are rarely more precise than ± .5 degrees Celsius.
		
		The autoconnect method tries to connect to the first OneWire Sensor that writes a file beghinning with "28-". 
		Different, but similar working sensors may use another identifier. Feel free to change this or to cast the appropriate FolderItem retrieved from the OneWireSensor.DevicePaths shared property.
		
		Returns -999999 if the data could not be read.
	#tag EndNote


	#tag ComputedProperty, Flags = &h0, Description = 54686520636F756E74206F6620726570656174656420706F6C6C206572726F72732028726561642D6F6E6C7929
		#tag Getter
			Get
			  return mErrorCount
			End Get
		#tag EndGetter
		ErrorCount As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mErrorCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTemperature As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Path As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4C65742074686973207468726561642072756E20696620796F752061726520696E7369646520616E206576656E74206C6F6F702028646F6576656E7473206F722061206465736B746F70206170702920746F20706F6C6C207468652073656E736F72206576657279203130207365636F6E64732E
		PollThread As Thread
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652074656D706572617475726520696E20646567726565732043656C73697573207265616420647572696E6720746865206C61737420706F6C6C2E2028726561642D6F6E6C7929
		#tag Getter
			Get
			  return mTemperature
			End Get
		#tag EndGetter
		Temperature As Double
	#tag EndComputedProperty


	#tag Constant, Name = kTemp, Type = Text, Dynamic = False, Default = \"t\x3D", Scope = Protected
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
			Name="Temperature"
			Group="Behavior"
			Type="Double"
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

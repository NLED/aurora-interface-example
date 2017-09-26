/*
MIT License

Copyright (c) 2017 Jeffrey Nygaard

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
 
=================================================================================

 Original Author: Jeffrey Nygaard
 Company: Northern Lights Electronic Design, LLC
 Date: September 25, 2017
 Contact: JNygaard@NLEDshop.com
 Written in Processing v3.3.6
 NLED Aurora Control Software Version: 2c
 Copyright© 2017 by Northern Lights Electronic Design, LLC. All Rights Reserved
 
 Want a customized device that runs NLED Auora? We are avaialable for custom design work, please contact!
 

 This software app is written in Processing but can easily be ported to other languages, any language that supports serial
 ports can be used to interface with NLED controllers. All NLED controllers are seen as serial ports but are commonly USB
 devices. This software can interface with both native USB devices and USB to serial adapters.
 
 This software app is simple, it allows the user to input the command ID# and the data bytes then parse the command to the
 device.
 
Instructions:
 1. Start software
 2. Select your device's COM port from the drop down.
 3. Click Open Port button to open the selected port, if it turns green it sucessfully connected to the port.
 4. Use either slot#1 or slot#2 to fill in what command you want to parse. See the command sheet PDF for details on commands.
  Note: Slot#1 and slot#2 are only used for the user to fill in commands, and are not otherwise anything specific. Either one does the same thing.
  
Live Control Instructions: For example device with 30 channels
 1. Run as above but at instruction #4 go to next step
 2. Set command to #60, bulk live control, set data#1 to 1 for enable, set data#2 to 0 for 8-bit, set data#3 to 0 for MSB, set data#4 to 30 for channel LSB
 3. Run or click button to run FillLiveControlPacket() with whatever data the user wants.
 4. Run or click SendLiveControlPacket() to send the data to the controller.
 5. Keep updating the LiveControlArray array with updated user data, then run SendLiveControlPacket() to send the new data to the controller
 6. When finished sending data the controller can be powered off or, send 60 -> 0 -> 0 -> 0 -> 0, to disable live control mode
 
 
 
 ;=============          www.NLEDShop.com/nledaurora           ============
 ;=============     www.NorthernLightsElectronicDesign.com       ============
 */

import processing.serial.*;
import g4p_controls.*; //uses version 4.0.5, and GUI builder 4.2

Serial myPort;      // The serial port, can be a NLED USB device or an USB to serial adapter

int cmdByte = 0;
int cmdData[] = new int[4];
int RXByte1, RXByte2, RXByte3, RXByte4, RXByte5;

int CommandStateMachine = 0;
int ReceiveCounter = 0;
int AuthCMDID = 0;
boolean UploadInProgress = false; //monitors serial reception for ack message

int[] LiveControlArray = new int[4]; //the quantity should be set the the device's channel size

void setup() 
{
  size(400, 400); //size the window  
  createGUI(); //for G4P GUI
  customGUI(); //for G4P GUI
  surface.setTitle("NLED Aurora Interface Sample App v.1a - Northern Lights Electronic Design, LLC");
  surface.setResizable(false);

  printArray(Serial.list());   // List all the available serial ports:
  dropList1.setItems(Serial.list(), 0); //list available COM ports to the drop down
}

void draw() {
  background(65);
}

//required for G4P
public void customGUI() {
}

//Serial Reception event, where everything happens
void serialEvent(Serial myPort) 
{
  //Roll Buffer
  RXByte5 = RXByte4;
  RXByte4 = RXByte3;
  RXByte3 = RXByte2;
  RXByte2 = RXByte1;
  RXByte1 = myPort.read();

  println("Received: "+RXByte1+"  Char: "+char(RXByte1));

  //Detects if device has acknowledged the previously sent packet
  //    Devices need time to save received data to local flash memory, wait to send more data.
  if (UploadInProgress == true)
  {
    if (RXByte4 == 'z' && RXByte3 == 'A' && RXByte2 == 'c' && RXByte1 == 'k')  
    {
      //Device has acknowledged packet
      //SendNextPacket()
      return; //received byte is handled, leave function
    }
  }

  switch(CommandStateMachine)
  {
  case 0:
    //Received data is not expected, ignore it
    println("Received byte not expected");
    break;
  case 1: //Command request sent
    if (RXByte2 == 'a' && RXByte1 == '9')
    {
      //myPort.write("nled99"); 
      myPort.write('n'); 
      myPort.write('l');  
      myPort.write('e');
      myPort.write('d');  
      myPort.write('9');   
      myPort.write('9');
      CommandStateMachine = 2; //increment state machine
      println("State 1 Acknowledged");
    }
    break;
  case 2:
    if (RXByte2 == 'f' && RXByte1 == '0')
    {
      //Command Request has been acknowledged by device, now send command and data bytes
      println("Command Request Acknowledged, Sending - CmdByte: "+cmdByte+" : "+cmdData[0]+" : "+cmdData[1]+" : "+cmdData[2]+" : "+cmdData[3]);
      myPort.write(cmdByte); //should be open connection
      myPort.write(cmdData[0]);  
      myPort.write(cmdData[1]);   
      myPort.write(cmdData[2]);  
      myPort.write(cmdData[3]); 
      CommandStateMachine = 3; //increment state machine
    }
    break;
  case 3: //Wait for command authentication
    if (RXByte5 == 'c' && RXByte4 == 'm' && RXByte3 == 'd' && RXByte2 == 0)  
    {
      if (cmdByte != RXByte1)
      {
        //The Command ID that was sent does not match what was authenticated, there was an error 
        println("COMMAND #"+RXByte1+" does not match the sent command ID of "+cmdByte);
        //command failed handle it, this should never happen
        return;
      }

      println("COMMAND #"+RXByte1+" AUTHENTICATED");
      AuthCMDID = RXByte1; //store the authenticated command ID for later
      CommandStateMachine = 0; //clear state machine variable, will set it again if needed

      //this executes the actual command software side once ACKed
      //Note most commands have no function here as the command usage is current proprietary but may change in the future
      switch(AuthCMDID)
      {
      case 4: //Request Connection
        ReceiveCounter = 0;
        //Device will respond with 6 bytes of data about itself, note version 1 firmware sends 4 bytes
        CommandStateMachine = 4; //set for next state, as the device will start sending data right away
        break;
      case 60:  //Enter USB Live Control
        //Device now in Live Control mode, send packets of data
        //  each packet will receive an ACK
        break;  
      case 99: //Hardware Preview Upload
        UploadInProgress = true;
        //SendHardwarePreview()
        UploadInProgress = false;  
        break;    
      case 100: //Full Upload
        UploadInProgress = true;        
        //SendFullUpload()
        UploadInProgress = false;     
        break;
      case 101:  //Upload Configurations
        UploadInProgress = true;  
        //SendConfigurations();  
        UploadInProgress = false;
        break;  
      case 102:  //Upload Gamma Table
        UploadInProgress = true;  
        //SendGammaTable(); //either 256 bytes or 384 bytes  
        UploadInProgress = false;
        break;  
      case 120: //Request Configurations
        ReceiveCounter = 0;
        //Device will respond with 2 bytes to form a single 16-bit number, MSB first
        CommandStateMachine = 4;
        break;
      }  //end switch
    } //end if
    break;
  case 4:  //If the command returns data it will call this
    //check if the sent command was "Connect Device" on ID#4
    if (AuthCMDID == 4)
    {
      println("Counter: "+ReceiveCounter);
      switch(ReceiveCounter)
      {
      case 0: //hardware ID
        //device.HardwareID = RXByte1;
        break;      
      case 1: //hardware version ID, not really used
        //device.HardwareVersion = RXByte1;
        break;
      case 2: //Firmware Version
        //device.FirmwareVersion = RXByte1;
        break;
      case 3: //Firmware Revision
        //device.FirmwareRevision = RXByte1;
        break;
      case 4:  //Bootloader Target Hardware ID
        //This should match the hardware ID in case #0, or bootloader is mismatched
        break;      
      case 5:  //Bootloader Version Number
        //device.BootloaderVersion = RXByte1;
        break;      
      case 6:  //UserID Number Configuration
        //device.UserConfiguredIDNum = RXByte1;
        println("Received all 6 bytes of the Device Identification information");
        break;
      } //end ReceiveCounter switch()
      ReceiveCounter++;
    } //end if
    else if (AuthCMDID == 120)
    {
      //Device responded with it's configuration bytes
      println("Counter: "+ReceiveCounter);
      switch(ReceiveCounter)
      {
      case 0: //Configuration Flags MSB
        //Do something with it
        break;      
      case 1:  //Configuration Flags LSB
        //Do something with it
        break;
      }
    } //end ID 120 if()
    break;    
  default: //shouldn't get here, reset state machine if it did
    CommandStateMachine = 0;
    break;
  } //end switch
}  //end serialEvent()

//==========================================================================================

void RequestCommand()
{
  //called from a button press or other method, have to fill the command and data bytes before running this function
  println("RequestCommand() - Requesting to Send a Command to Device");
  try {
    //myPort.write("NLED11"); //if communicating with a USB device can send as a single packet
    myPort.write('N');         //otherwise if a serial device is connected there needs to be a small delay between bytes
    myPort.write('L');  
    myPort.write('E');   
    myPort.write('D');  
    myPort.write('1');   
    myPort.write('1');
    CommandStateMachine = 1; //set to 1, a command request was sent to the controller
  }
  catch(Exception e)
  {
    println("Port Not Open, Or Unable to Send");
  }
} //end func()

//==========================================================================================

//Called to open the serial port that is selected on the drop down
void OpenSerialPort()
{
  try
  {
    String portName = Serial.list()[dropList1.getSelectedIndex()];
    myPort = new Serial(this, portName, 19200);
    println("User Connected to Serial port "+portName);
    button3.setLocalColorScheme(1); //set button to color green
  }
  catch(Exception e) 
  {
    println("Could not Open Port, May Be In Use");
    button3.setLocalColorScheme(0); //set button to red
  }
} //end func

//==========================================================================================

//A few sample functions that the user can fill to do what they need done

//==========================================================================================

void SendLiveControlPacket()
{
  println("SendLiveControlPacket() - Sending "+LiveControlArray.length+" bytes");
  //Used to send bulk live control data
  //First the Live Control Command must be issued and enabled with the correct number of channels
  //64 - 1=Enable - 0=8-bit mode - ChanSizeMSB - ChanSizeLSB
  //Example for 30 Channel Controller, CMD: 60 -> 1 -> 0 -> 0 -> 30
  //      then is set to LiveControlArray[30], then fill it with data, then send 30 bytes per packet
  //If LiveControlArray is type casted as an byte it would transmit much quicker in Processing

  try
  {
    //Only typecasted as a byte since that is what .write() expects, other languages may vary
    myPort.write(byte(LiveControlArray)); // send only the 8 LSBs, making an 8-bit number, 0 - 255
  }
  catch(Exception e) 
  {
    println("Port not open or otherwise not available");
  }
}

//==========================================================================================

void FillLiveControlPacket()
{
  println("FillLiveControlPacket()");
  for (int i = 0; i != LiveControlArray.length; i++)
  {
    LiveControlArray[i] = i; //fill with dummy data, but user can fill with their own values, 0 - 255
    //USER FILL WITH YOUR OWN DATA
  }
}

//==========================================================================================

void ClearLiveControlPacket()
{
  println("ClearLiveControlPacket()");
  for (int i = 0; i != LiveControlArray.length; i++)
  {
    LiveControlArray[i] = 0; //fill with dummy data, but user can fill with their own values, 0 - 255
    //USER FILL WITH YOUR OWN DATA
  }
}

//==========================================================================================
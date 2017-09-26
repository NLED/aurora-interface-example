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
 
 =================================================================================
 
 This software app is written in Processing but can easily be ported to other languages, any language that supports serial
 ports can be used to interface with NLED controllers. All NLED controllers are seen as serial ports but are commonly USB
 devices. This software can interface with both native USB devices and USB to serial adapters.
 
 This software app is simple, it allows the user to input the command ID# and the data bytes then parse the command to the device.
 
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
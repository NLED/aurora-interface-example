/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void button1_click1(GButton source, GEvent event) { //_CODE_:button1:622556:
  println("button1 - GButton >> GEvent." + event + " @ " + millis());
    myPort.write('N'); 
    myPort.write('L');  
    myPort.write('E');   
    myPort.write('D');  
    myPort.write('1');   
    myPort.write('1');
    
} //_CODE_:button1:622556:

public void button2_click1(GButton source, GEvent event) { //_CODE_:button2:296832:
  println("button2 - GButton >> GEvent." + event + " @ " + millis());
    myPort.write('n'); 
    myPort.write('l');  
    myPort.write('e');
    myPort.write('d');  
    myPort.write('9');   
    myPort.write('9');
} //_CODE_:button2:296832:

public void button4_click1(GButton source, GEvent event) { //_CODE_:button4:442710:
  println("button4 - GButton >> GEvent." + event + " @ " + millis());
  //Fill command and data bytes from text fields
  cmdByte = int(textfield1.getText());
  cmdData[0] = int(textfield2.getText());
  cmdData[1] = int(textfield3.getText());
  cmdData[2] = int(textfield4.getText()); 
  cmdData[3] = int(textfield5.getText()); 
  RequestCommand();
} //_CODE_:button4:442710:

public void textfield1_change1(GTextField source, GEvent event) { //_CODE_:textfield1:751585:
  //println("textfield1 - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:textfield1:751585:

public void textfield2_change1(GTextField source, GEvent event) { //_CODE_:textfield2:352972:
 // println("textfield2 - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:textfield2:352972:

public void textfield3_change1(GTextField source, GEvent event) { //_CODE_:textfield3:457997:
  //println("textfield3 - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:textfield3:457997:

public void textfield4_change1(GTextField source, GEvent event) { //_CODE_:textfield4:906290:
  //println("textfield4 - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:textfield4:906290:

public void textfield5_change1(GTextField source, GEvent event) { //_CODE_:textfield5:407902:
  //println("textfield5 - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:textfield5:407902:

public void button5_click1(GButton source, GEvent event) { //_CODE_:button5:624002:
  println("button5 - GButton >> GEvent." + event + " @ " + millis());
  //Fill command and data bytes from text fields
   cmdByte = int(textfield6.getText());
  cmdData[0] = int(textfield7.getText());
  cmdData[1] = int(textfield8.getText());
  cmdData[2] = int(textfield9.getText()); 
  cmdData[3] = int(textfield10.getText()); 
  RequestCommand();
} //_CODE_:button5:624002:

public void textfield6_change1(GTextField source, GEvent event) { //_CODE_:textfield6:355604:
  //println("textfield6 - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:textfield6:355604:

public void textfield8_change1(GTextField source, GEvent event) { //_CODE_:textfield8:255134:
  //println("textfield8 - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:textfield8:255134:

public void textfield9_change1(GTextField source, GEvent event) { //_CODE_:textfield9:368172:
  //println("textfield9 - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:textfield9:368172:

public void textfield10_change1(GTextField source, GEvent event) { //_CODE_:textfield10:815270:
  //println("textfield10 - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:textfield10:815270:

public void dropList1_click1(GDropList source, GEvent event) { //_CODE_:dropList1:204052:
  println("dropList1 - GDropList >> GEvent." + event + " @ " + millis());
} //_CODE_:dropList1:204052:

public void button3_click1(GButton source, GEvent event) { //_CODE_:button3:220367:
  println("button3 - GButton >> GEvent." + event + " @ " + millis());
  //Open Port Button
  OpenSerialPort();
} //_CODE_:button3:220367:

public void button6_click1(GButton source, GEvent event) { //_CODE_:button6:964089:
  println("button6 - GButton >> GEvent." + event + " @ " + millis());
  FillLiveControlPacket();
} //_CODE_:button6:964089:

public void button7_click1(GButton source, GEvent event) { //_CODE_:button7:788224:
  println("button7 - GButton >> GEvent." + event + " @ " + millis());
  SendLiveControlPacket();
} //_CODE_:button7:788224:

public void button8_click1(GButton source, GEvent event) { //_CODE_:button8:635555:
  println("button8 - GButton >> GEvent." + event + " @ " + millis());
  ClearLiveControlPacket();
} //_CODE_:button8:635555:

public void textfield7_change1(GTextField source, GEvent event) { //_CODE_:textfield7:928958:
  println("textfield7 - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:textfield7:928958:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Sketch Window");
  button1 = new GButton(this, 290, 280, 80, 30);
  button1.setText("NLED11");
  button1.addEventHandler(this, "button1_click1");
  button2 = new GButton(this, 290, 320, 80, 30);
  button2.setText("nled99");
  button2.addEventHandler(this, "button2_click1");
  button4 = new GButton(this, 70, 110, 70, 30);
  button4.setText("Parse Command");
  button4.addEventHandler(this, "button4_click1");
  textfield1 = new GTextField(this, 70, 160, 70, 20, G4P.SCROLLBARS_NONE);
  textfield1.setText("4");
  textfield1.setOpaque(true);
  textfield1.addEventHandler(this, "textfield1_change1");
  textfield2 = new GTextField(this, 70, 200, 70, 20, G4P.SCROLLBARS_NONE);
  textfield2.setText("0");
  textfield2.setOpaque(true);
  textfield2.addEventHandler(this, "textfield2_change1");
  textfield3 = new GTextField(this, 70, 240, 70, 20, G4P.SCROLLBARS_NONE);
  textfield3.setText("0");
  textfield3.setOpaque(true);
  textfield3.addEventHandler(this, "textfield3_change1");
  textfield4 = new GTextField(this, 70, 280, 70, 20, G4P.SCROLLBARS_NONE);
  textfield4.setText("0");
  textfield4.setOpaque(true);
  textfield4.addEventHandler(this, "textfield4_change1");
  textfield5 = new GTextField(this, 70, 320, 70, 20, G4P.SCROLLBARS_NONE);
  textfield5.setText("0");
  textfield5.setOpaque(true);
  textfield5.addEventHandler(this, "textfield5_change1");
  button5 = new GButton(this, 150, 110, 70, 30);
  button5.setText("Parse Command");
  button5.addEventHandler(this, "button5_click1");
  textfield6 = new GTextField(this, 150, 160, 70, 20, G4P.SCROLLBARS_NONE);
  textfield6.setText("60");
  textfield6.setOpaque(true);
  textfield6.addEventHandler(this, "textfield6_change1");
  textfield8 = new GTextField(this, 150, 240, 70, 20, G4P.SCROLLBARS_NONE);
  textfield8.setText("0");
  textfield8.setOpaque(true);
  textfield8.addEventHandler(this, "textfield8_change1");
  textfield9 = new GTextField(this, 150, 280, 70, 20, G4P.SCROLLBARS_NONE);
  textfield9.setText("0");
  textfield9.setOpaque(true);
  textfield9.addEventHandler(this, "textfield9_change1");
  textfield10 = new GTextField(this, 150, 320, 70, 20, G4P.SCROLLBARS_NONE);
  textfield10.setText("4");
  textfield10.setOpaque(true);
  textfield10.addEventHandler(this, "textfield10_change1");
  dropList1 = new GDropList(this, 130, 30, 90, 80, 3);
  dropList1.setItems(loadStrings("list_204052"), 0);
  dropList1.addEventHandler(this, "dropList1_click1");
  label2 = new GLabel(this, 0, 30, 130, 20);
  label2.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label2.setText("Select Serial Port:");
  label2.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  label2.setOpaque(false);
  button3 = new GButton(this, 230, 30, 80, 20);
  button3.setText("Open Port");
  button3.setLocalColorScheme(GCScheme.RED_SCHEME);
  button3.addEventHandler(this, "button3_click1");
  label3 = new GLabel(this, 0, 0, 300, 20);
  label3.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label3.setText("NLED Aurora Sample Interface - v.1a");
  label3.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  label3.setOpaque(false);
  label1 = new GLabel(this, 70, 90, 70, 20);
  label1.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label1.setText("Slot 1");
  label1.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  label1.setOpaque(false);
  label4 = new GLabel(this, 150, 90, 70, 20);
  label4.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label4.setText("Slot 2");
  label4.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  label4.setOpaque(false);
  label5 = new GLabel(this, 290, 250, 80, 20);
  label5.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label5.setText("Test Buttons");
  label5.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  label5.setOpaque(false);
  button6 = new GButton(this, 270, 120, 120, 30);
  button6.setText("FillLiveControl()");
  button6.addEventHandler(this, "button6_click1");
  button7 = new GButton(this, 270, 200, 120, 30);
  button7.setText("SendLiveControl()");
  button7.addEventHandler(this, "button7_click1");
  label6 = new GLabel(this, 250, 70, 150, 40);
  label6.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label6.setText("Requires Setup in Code. Live Control Sample");
  label6.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  label6.setOpaque(false);
  button8 = new GButton(this, 270, 160, 120, 30);
  button8.setText("ClearLiveControl()");
  button8.addEventHandler(this, "button8_click1");
  label7 = new GLabel(this, 0, 160, 70, 20);
  label7.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label7.setText("Command:");
  label7.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  label7.setOpaque(false);
  label9 = new GLabel(this, -10, 200, 80, 20);
  label9.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label9.setText("Data#1:");
  label9.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  label9.setOpaque(false);
  label10 = new GLabel(this, -10, 240, 80, 20);
  label10.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label10.setText("Data#2:");
  label10.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  label10.setOpaque(false);
  label11 = new GLabel(this, -10, 280, 80, 20);
  label11.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label11.setText("Data#3:");
  label11.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  label11.setOpaque(false);
  label12 = new GLabel(this, -10, 320, 80, 20);
  label12.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label12.setText("Data#4:");
  label12.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  label12.setOpaque(false);
  textfield7 = new GTextField(this, 150, 200, 70, 20, G4P.SCROLLBARS_NONE);
  textfield7.setText("1");
  textfield7.setOpaque(true);
  textfield7.addEventHandler(this, "textfield7_change1");
}

// Variable declarations 
// autogenerated do not edit
GButton button1; 
GButton button2; 
GButton button4; 
GTextField textfield1; 
GTextField textfield2; 
GTextField textfield3; 
GTextField textfield4; 
GTextField textfield5; 
GButton button5; 
GTextField textfield6; 
GTextField textfield8; 
GTextField textfield9; 
GTextField textfield10; 
GDropList dropList1; 
GLabel label2; 
GButton button3; 
GLabel label3; 
GLabel label1; 
GLabel label4; 
GLabel label5; 
GButton button6; 
GButton button7; 
GLabel label6; 
GButton button8; 
GLabel label7; 
GLabel label9; 
GLabel label10; 
GLabel label11; 
GLabel label12; 
GTextField textfield7; 
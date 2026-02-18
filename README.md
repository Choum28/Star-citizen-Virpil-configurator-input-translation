# Star-citizen-Virpil-configurator-input-translation
a Powershell Script that will convert starcitizen input xml file created with old virpil mapping from VPC Software to new mapping set by VPC configurator Alpha.

## Configuration :   
you need to edit the ps1 file to correctly set different path.
you need to edit the mapping.csv file to your need.  

The mapping.csv file provided with the script has been set for the following setup :   
&nbsp;&nbsp;&nbsp;&nbsp; MongoosT-50CM2 Throttle in 5 mode conf (master) + vpc control panel 2 (slave) set as  js2 in star citizen.  
&nbsp;&nbsp;&nbsp;&nbsp; Virpil Alpha prime joystick set as js1 in star citizen. 

You will need to adapt input all value if using different device.

## launch the script  
Open cmd terminal and launch following command:

powershell.exe -ep bypass -file "x:\xxx\virpil_sc_conversion.ps1"
